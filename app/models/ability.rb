class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if false # Stubbed for admin permissions
      can :manage, :all
    elsif user.persisted?
      can :create, Question
      can :create, Answer
      can :index, User
      can :show, User, id: user.id
    end
  end
end
