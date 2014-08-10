class CreateCustomerWorker
  include Sidekiq::Worker
  attr_accessor :user, :customer

  def perform(user_id, plan)
    @user = User.find(user_id)
    create_stripe_customer(plan)
    create_subscription(plan)
  end
  
  def create_stripe_customer(plan)
    @customer = Stripe::Customer.create(description: @user.id, email: @user.email, plan: plan)
  end
  
  def create_subscription(plan)
    Subscription.create(user_id: @user.id, billing_email: @user.email, plan_id: plan, stripe_id: @customer.id, free_trial_expiration: (Date.current + 31))
  end
    
end



