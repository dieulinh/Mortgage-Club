class LoanMembers::DashboardController < LoanMembers::BaseController
  before_action :set_loan, only: [:show]

  def show
    loan_activities = LoanActivity.get_latest_by_loan(@loan)
    ActiveRecord::Associations::Preloader.new.preload(loan_activities, loan_member: :user)

    @loan.closing ||= Closing.create(name: 'Closing', loan_id: @loan.id)

    subject_property = @loan.properties.includes(:documents).find { |p| p.is_subject == true }

    host_name = ENV.fetch("HOST_NAME", "localhost:4000")
    url = edit_user_password_url(host: host_name)

    bootstrap(
      loan: LoanMembers::LoanPresenter.new(@loan).show,
      first_activity: first_activity(@loan),
      activity_types: LoanMembers::ActivityTypesPresenter.new(ActivityType.all.order(order_number: :asc)).show,
      loan_activities: loan_activities,
      borrower: LoanMembers::BorrowerPresenter.new(@loan.borrower).show,
      property: LoanMembers::PropertyPresenter.new(subject_property).show,
      closing: LoanMembers::ClosingPresenter.new(@loan.closing).show,
      templates: LoanMembers::TemplatesPresenter.new(Template.all).show,
      checklists: LoanMembers::ChecklistsPresenter.new(@loan.checklists.order(due_date: :desc, name: :asc)).show,
      email_templates: get_email_templates,
      loan_member: current_user,
      url: url
    )

    respond_to do |format|
      format.html { render template: 'loan_member_app' }
    end
  end

  def send_email
    LoanMemberDashboardMailer.remind_checklists(params).deliver_now

    render json: {}
  end

  private

  def get_email_templates
    @first_name = @loan.borrower.user.first_name
    @closing_date = @loan.closing_date
    @checklists = @loan.checklists.where(status: "pending").order(created_at: :asc)

    remind_checklists = render_to_string "email_templates/remind_checklists", layout: false

    {remind_checklists: remind_checklists}
  end

  def get_all_rates_down_payment(percent)
    @loan.rate_comparisons.where(down_payment_percentage: percent)
  end

  def get_lender_templates
    return [] unless @loan.lender
    LoanMembers::LenderTemplatesPresenter.new(@loan.lender.lender_templates.where(is_other: false)).show
  end

  def get_other_template
    return [] unless @loan.lender
    LoanMembers::LenderTemplatePresenter.new(@loan.lender.lender_templates.where(is_other: true).last).show
  end

  def first_activity(loan)
    # TODO: refactor it
    # activity_status: -1 => not existed yet
    first_activity_type = ActivityType.order(order_number: :asc).first
    LoanActivity.where(name: first_activity_type.activity_names.first.name, loan_id: loan.id).order(created_at: :desc).limit(1).first || {activity_status: -1}
  end
end
