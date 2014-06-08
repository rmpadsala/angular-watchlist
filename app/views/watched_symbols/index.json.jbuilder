json.array!(@watched_symbols) do |watched_symbol|
  json.extract! watched_symbol, :id, :symbol, :last_price, :change, :high, :low, :open, :user_id, :updated_at
  json.url watched_symbol_url(watched_symbol, format: :json)
end
