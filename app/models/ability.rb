class Ability
  include CanCan::Ability

  def initialize(user)

    if user
      can :create, Annotation
      can :update, Annotation do |annotation|
        annotation.try(:user) == user
      end

      can :create, Document
      can :update, Document do |document|
        document.try(:user) == user
      end

      can :upvote, Annotation
      can :upvote, Annotation do |annotation|
        annotation.try(:user) != user
      end

      can :downvote, Annotation
      can :downvote, Annotation do |annotation|
        annotation.try(:user) != user
      end
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
