class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, [Test, TestGroup], user_id: user.id
  end
end
