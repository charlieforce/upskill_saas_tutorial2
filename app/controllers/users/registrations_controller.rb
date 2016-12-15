class Users::RegistrationsController < Devise::RegistrationsController
    #This code goes with the code below the private section (at the bottom)
    before_action :select_plan, only: :new
    # Extend default Devise gem behavior so that users signing up with
    # the Pro account (plan ID 2) are saved with a special Stripe 
    # Subscription function. Other wise, Devise signs up as usual.
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end

#We can not use this function outside this file.
private
  def select_plan
    unless (params[:plan] == '1' || params[:plan] == '2')
      flash[:notice] = "Please select a membership plan to sign up."
      redirect_to root_url
    end
  end
end
 