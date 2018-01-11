class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :package_name
      t.datetime :event_time
      t.text :notification_params
      t.text :purchase_token
      t.integer :notification_code
      t.string :sku
      t.string :processor
      t.timestamps
    end
  end
end
