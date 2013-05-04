class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :price_in_paise

      t.timestamps
    end
  end
end
