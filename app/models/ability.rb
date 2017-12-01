class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user.present? #permissions for logged in users
      can :manage, Post, user_id: user.id
      if user.moderator? #additional permissions for moderators
        can [:edit, :update], Topic
        can [:create, :post, :edit, :update], Post
        if user.admin? #additional permissions for admins
          can :manage, :all
        end
      end
    end
  end
end
