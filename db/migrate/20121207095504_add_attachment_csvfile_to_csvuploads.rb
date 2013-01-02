class AddAttachmentCsvfileToCsvuploads < ActiveRecord::Migration
  def self.up
    change_table :csvuploads do |t|
      t.has_attached_file :csvfile
    end
  end

  def self.down
    drop_attached_file :csvuploads, :csvfile
  end
end
