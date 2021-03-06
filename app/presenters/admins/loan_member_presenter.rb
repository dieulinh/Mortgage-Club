class Admins::LoanMemberPresenter
  def initialize(loan_member)
    @loan_member = loan_member
  end

  def show
    @loan_member.as_json(json_options)
  end

  private

  def json_options
    {
      only: [:id, :nmls_id, :phone_number, :company_name, :company_address, :company_phone_number, :company_nmls, :email_signature],
      include: {
        user: {
          only: [:email, :first_name, :last_name],
          methods: [:avatar_url]
        }
      }
    }
  end
end
