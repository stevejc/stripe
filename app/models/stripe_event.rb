# == Schema Information
#
# Table name: stripe_events
#
#  id          :integer          not null, primary key
#  stripe_id   :string(255)      not null
#  stripe_type :string(255)      not null
#  created_at  :datetime
#  updated_at  :datetime
#

class StripeEvent < ActiveRecord::Base
  validates :stripe_id, presence: true, uniqueness: true
  
  def event_object 
    event = Stripe::Event.retrieve(stripe_id) 
    event.data.object
  end
  
end
