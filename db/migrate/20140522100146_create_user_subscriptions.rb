class CreateUserSubscriptions < ActiveRecord::Migration
  def change
    create_table :user_subscriptions do |t|

    	t.integer :user_id 
    	t.integer :subscriber_id 
      	t.timestamps
    end

    add_index :user_subscriptions, [:user_id, :subscriber_id]

  end
end
