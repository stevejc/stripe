class UpdatePlanWorker
  include Sidekiq::Worker
  attr_accessor :subscription, :customer
  
  def perform(subscription_id, plan)
    @subscription = Subscription.find(subscription_id)
    retrieve_stripe_customer
    update_stripe_customer(plan)
  end
  
  def retrieve_stripe_customer
    @customer = Stripe::Customer.retrieve(@subscription.stripe_id)
  end
  
  def update_stripe_customer(plan)
    @customer.plan = plan
    @customer.save
  end

end