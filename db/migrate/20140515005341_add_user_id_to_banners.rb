class AddUserIdTobanners < ActiveRecord::Migration
  def change

  	add_column :banners, :user_id, :integer 
  	add_index :banners, :user_id 
  end
end
