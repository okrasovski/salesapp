class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    # [:index, :new, :create, :show, :edit, :update, :destroy]
    if user
	    can :create, :sales
	    if user.is_manager
	      can [:access], :all   
	      can [:index, :new, :create, :show, :edit, :update, :destroy], :all
	    end
	    
    end
  end
end

