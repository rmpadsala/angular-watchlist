class CreateWatchedSymbols < ActiveRecord::Migration
  def change
    create_table :watched_symbols do |t|
      t.string :symbol
      t.float :last_price
      t.float :change
      t.integer :user_id

      t.timestamps
    end
  end
end
