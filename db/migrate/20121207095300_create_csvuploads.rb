class CreateCsvuploads < ActiveRecord::Migration
  def change
    create_table :csvuploads do |t|
      
      t.timestamps
    end
  end
end
