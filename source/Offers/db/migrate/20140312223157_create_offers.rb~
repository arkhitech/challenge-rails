class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :merchant_id
      t.string :title
      t.text :description
      t.string :url
      t.datetime :expires_at

      t.timestamps
    end
  end
end
