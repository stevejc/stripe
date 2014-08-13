# == Schema Information
#
# Table name: subscription_statuses
#
#  id         :integer          not null, primary key
#  status     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class SubscriptionStatus < ActiveRecord::Base
end
