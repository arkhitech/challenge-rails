class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name
      t.integer :advertiser_id, unique: true
      t.timestamps
    end
  end
end
