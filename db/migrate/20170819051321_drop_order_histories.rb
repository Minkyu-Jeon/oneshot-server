class DropOrderHistories < ActiveRecord::Migration[5.0]
  def change
    drop_table :order_histories
  end
end
