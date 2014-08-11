class StripeMailer < ActionMailer::Base
  default from: 'you@example.com'
  
  def admin_dispute_created(charge)
    @charge = charge
    @subscription = Subscription.find_by(stripe_id: @charge.id)
    if @sale
      mail(to: 'you@example.com', subject: "Dispute created on charge #{@charge.id} for customer #{@subscription.billing_email}").deliver
    end
  end
  
  def new_customer_added
    mail(to: 'you@example.com', subject: "New Customer Added").deliver
  end
end