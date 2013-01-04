class CreateFavourates < ActiveRecord::Migration
  def change
    create_table :favourates do |t|
      t.string :user_fav
	  t.string :file_fav
	  t.string :type_fav
      t.timestamps
    end
  end
end
