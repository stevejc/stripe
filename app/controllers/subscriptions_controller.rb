class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end
  
  def edit
    @subscription = current_user.subscription
  end
  
  def update
    subscription = current_user.subscription
    UpdateCustomerWorker.perform_async(subscription.id, params[:subscription][:stripe_card_token])
    redirect_to subscriptions_path, :notice => "You credit card information has been updated!"
  end
  
  def cancel_subscription
    @subscription = current_user.subscription
    CancelCustomerWorker.perform_async(@subscription.id)
    # Time.at(customer.subscription.current_period_end).strftime("%m/%d/%Y")
    # do we need to track plan status and date plan is cancelled
    redirect_to subscriptions_path, :notice => "Your account has been cancelled."
  end
  
end