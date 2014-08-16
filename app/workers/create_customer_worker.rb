class CreateCustomerWorker
  include Sidekiq::Worker
  attr_accessor :user, :customer, :subscription

  def perform(user_id, plan)
    @user = User.find(user_id)
    create_subscription(plan)
    create_stripe_customer(plan)
    update_subscription
  end
  
  def create_subscription(plan)
    @subscription = Subscription.create(user_id: @user.id, billing_email: @user.email, plan_id: plan, subscription_status_id: 1, free_trial_expiration: (Date.current + 31))
  end
  
  def create_stripe_customer(plan)
    @customer = Stripe::Customer.create(description: @user.id, email: @user.email, plan: plan)
  end
   
  def update_subscription
    @subscription.update_attributes(stripe_id: @customer.id)
  end
    
end