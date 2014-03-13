class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :merchant
      t.string :title
      t.text :description
      t.string :url
      t.datetime :expires_at
      
      t.integer :link_id, unique: true

      t.timestamps
    end
  end
end
