class Createbanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
