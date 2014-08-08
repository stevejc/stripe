class RegistrationsController < Devise::RegistrationsController
  
  def new
    @plan = params[:plan]
    super
  end
  
  def after_sign_up_path_for(resource)
    customer = Stripe::Customer.create(description: "user_id #{current_user.id}", email: current_user.email, plan: params[:user][:plan])
    Subscription.create(user_id: current_user.id, billing_email: current_user.email, plan: params[:user][:plan], stripe_id: customer.id, free_trial_expiration: (Date.current + 31))
    root_path
  end
  
  
end