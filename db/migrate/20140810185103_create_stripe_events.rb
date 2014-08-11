class CreateStripeEvents < ActiveRecord::Migration
  def change
    create_table :stripe_events do |t|
      t.string :stripe_id, null: false
      t.string :stripe_type, null: false

      t.timestamps
    end
    add_index :stripe_events, :stripe_id, unique: true
  end
end
