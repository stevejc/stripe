class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name, :null => false
      t.integer :rate, :null => false, :default => 0
    end
  end
end
