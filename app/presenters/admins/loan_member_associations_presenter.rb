class Admins::LoanMemberAssociationsPresenter
  def initialize(loan_members_associations)
    @loan_members_associations = loan_members_associations
  end

  def show
    @loan_members_associations.includes(loan_member: :user).as_json(json_options)
  end

  private

  def json_options
    {
      include: {
        loan_member: {
          include: {
            user: {
              only: [ :email ],
              methods: [ :to_s , :avatar_url]
            }
          }
        }
      },
      methods: [ :pretty_title ]
    }
  end
end