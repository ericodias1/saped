class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :name, null: false
      t.string :order_number, null: false
      t.string :state, null: false

      t.timestamps null: false
    end
  end
end
