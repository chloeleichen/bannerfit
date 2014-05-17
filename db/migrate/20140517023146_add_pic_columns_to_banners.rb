class AddPicColumnsToBanners < ActiveRecord::Migration
 def self.up
    add_attachment :banners, :pic
  end

  def self.down
    remove_attachment :banners, :pic
  end


end
