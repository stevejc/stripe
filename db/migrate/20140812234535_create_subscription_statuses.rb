class CreateSubscriptionStatuses < ActiveRecord::Migration
  def change
    create_table :subscription_statuses do |t|
      t.string :status, :null => false
      t.timestamps
    end
  end
end
