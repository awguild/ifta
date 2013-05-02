class Ability
  include CanCan::Ability

  def initialize(user) 
    user ||= User.new #guest user (not logged in)
    
    if user.role == "admin"
      # admin permissions
      can :manage, :all
    elsif user.role == "reviewer"
      can :update, User, :id => user.id
      can :update, Itinerary, :user => {:id => user.id}
      can :create, LineItem, :user => {:id => user.id} 
      can :destroy, LineItem, :user => {:id => user.id}
      can :create, Transaction, :user => {:id => user.id}
      can :create, Review, :reviewer_id => user.id
      can :manage, Proposal
      # reviewer permissions
    else
      #attendee permissions
      can :update, User, :id => user.id
      can :update, Itinerary, :user => {:id => user.id}
      can :create, LineItem, :user => {:id => user.id} 
      can :destroy, LineItem, :user => {:id => user.id}
      can :create, Transaction, :user => {:id => user.id}
      can :destroy, Transaction, :paid => false, :user => {:id => user.id}
      can :create, Proposal, :user => {:id => user.id}
      can :update, Proposal, :locked => false, :user => {:id => user.id}
    end
    
    #everyone permissions
    can :list, ConferenceItem
  end
  
end

