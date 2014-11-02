class StripeMailer < ActionMailer::Base
  default from: 'you@example.com'
  
  def admin_dispute_created(charge)
    @charge = charge
    @subscription = Subscription.find_by(stripe_id: @charge.customer)
    mail(to: 'you@example.com', subject: "Dispute created on charge for customer - #{@subscription.billing_email}").deliver
  end
  
  def new_customer_added(charge)
    @charge = charge
    @subscription = Subscription.find_by(stripe_id: @charge.customer)
    mail(to: 'you@example.com', subject: "New Customer Added - #{@subscription.billing_email}").deliver
  end
  
  def invoice_stuff(charge)
    @charge = charge
    @subscription = Subscription.find_by(stripe_id: @charge.customer)
    mail(to: 'you@example.com', subject: "Invoice stuff for customer - #{@subscription.billing_email}").deliver
  end
end