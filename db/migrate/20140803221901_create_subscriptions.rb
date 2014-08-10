class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id, :null => false
      t.string :billing_email, :null => false
      t.string :card_last4
      t.string :card_type
      t.date :card_expiration
      t.string :stripe_id
      t.date :free_trial_expiration
      t.integer :plan_id, :null => false
      
      t.timestamps
    end
    add_index :subscriptions, [:user_id]
  end
end