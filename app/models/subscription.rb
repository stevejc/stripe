# == Schema Information
#
# Table name: subscriptions
#
#  id                     :integer          not null, primary key
#  user_id                :integer          not null
#  billing_email          :string(255)      not null
#  card_last4             :string(255)
#  card_type              :string(255)
#  card_expiration        :date
#  stripe_id              :string(255)
#  free_trial_expiration  :date
#  plan_id                :integer          not null
#  created_at             :datetime
#  updated_at             :datetime
#  subscription_status_id :integer
#

class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan
  belongs_to :subscription_status
  delegate :name, to: :plan
  delegate :status, to: :subscription_status
  
  attr_accessor :stripe_card_token, :email
  
  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: email, plan: "1", card: stripe_card_token)
      self.stripe_token = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
  
end
