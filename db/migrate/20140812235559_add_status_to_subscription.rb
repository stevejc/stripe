class AddStatusToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :subscription_status_id, :integer
  end
end
