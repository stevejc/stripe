class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end
  
  def edit
    @subscription = current_user.subscription
  end
  
  def update
    @subscription = current_user.subscription
    customer = Stripe::Customer.retrieve(@subscription.stripe_id)
    customer.card = params[:subscription][:stripe_card_token]
    customer.save
    @subscription.update_attributes(card_last4: customer.active_card.last4, card_type: customer.active_card.brand, card_expiration: Date.new(customer.active_card.exp_year, customer.active_card.exp_month, -1).strftime("%Y-%m-%d"))
    redirect_to subscriptions_path, :notice => "You credit card information has been updated!"
  end
  
  def cancel_subscription
    @subscription = current_user.subscription
    customer = Stripe::Customer.retrieve(@subscription.stripe_id)
    customer.subscriptions.retrieve(customer.subscription.id).delete(at_period_end: true)
    # Time.at(customer.subscription.current_period_end).strftime("%m/%d/%Y")
    # do we need to track plan status and date plan is cancelled
    redirect_to subscriptions_path, :notice => "Your account has been cancelled."
  end
  
end