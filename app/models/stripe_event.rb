class StripeEvent < ActiveRecord::Base
  validates :stripe_id, presence: true, uniqueness: true
  
  def event_object 
    event = Stripe::Event.retrieve(stripe_id) 
    event.data.object
  end
  
end
