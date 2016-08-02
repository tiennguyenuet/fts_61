class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.supper?
      can :manage, :all
    elsif user.admin?
      can :read, :all
      can [:update, :show, :edit], Examination
      can [:create, :edit, :update, :delete], Question
      can [:create, :edit, :update, :delete], Subject
    else
      can :read, :all
      can [:create, :update, :show], Examination
      can [:create, :edit, :update], Question
    end
  end
end
