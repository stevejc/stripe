class UpdateCustomerWorker
  include Sidekiq::Worker
  attr_accessor :subscription, :customer
  
  def perform(subscription_id, stripe_card_token)
    @subscription = Subscription.find(subscription_id)
    retrieve_stripe_customer
    update_stripe_customer(stripe_card_token)
    update_subscription
  end
  
  def retrieve_stripe_customer
    @customer = Stripe::Customer.retrieve(@subscription.stripe_id)
  end
  
  def update_stripe_customer(stripe_card_token)
    @customer.card = stripe_card_token
    @customer.save
  end
  
  def update_subscription
    @subscription.update_attributes(card_last4: @customer.active_card.last4, card_type: @customer.active_card.brand, card_expiration: Date.new(@customer.active_card.exp_year, @customer.active_card.exp_month, -1).strftime("%Y-%m-%d"))
  end
end
