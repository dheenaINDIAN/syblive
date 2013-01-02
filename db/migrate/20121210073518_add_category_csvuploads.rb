class AddCategoryCsvuploads < ActiveRecord::Migration
  def up
  add_column :csvuploads, :category, :string
  end

  def down
  remove_column :csvuploads, :category, :string
  end
end
