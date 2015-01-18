class AddAttachmentImageToMovies < ActiveRecord::Migration
  def self.up
    change_table :movies do |t|
      t.attachment :image
      t.attachment :remote_image
    end
  end

  def self.down
    remove_attachment :movies, :image , :remote_image
  end
end
