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
      include: {
        user: {
          only: [:email, :first_name, :last_name],
          methods: [:to_s, :avatar_url, :role_name]
        }
      }
    }
  end
end