class AddWatchlistColumns < ActiveRecord::Migration
  def change
    add_column :watched_symbols, :high, :float
    add_column :watched_symbols, :low, :float
    add_column :watched_symbols, :open, :float
  end
end
