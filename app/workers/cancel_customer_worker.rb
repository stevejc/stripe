class CancelCustomerWorker
  include Sidekiq::Worker
  attr_accessor :subscription, :customer

  def perform(subscription_id)
    @subscription = Subscription.find(subscription_id)
    retrieve_stripe_customer
    cancel_stripe_customer
    update_subscription
  end
  
  def retrieve_stripe_customer
    @customer = Stripe::Customer.retrieve(@subscription.stripe_id)
  end
  
  def cancel_stripe_customer
    @customer.subscriptions.retrieve(@customer.subscription.id).delete
  end
  
  def update_subscription
    @subscription.update_attributes(card_last4: nil, card_type: nil, card_expiration: nil)
  end
      
end