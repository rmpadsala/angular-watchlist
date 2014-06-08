namespace :markit_api do
  desc "Query quotes for all watched symbols"
  task :quote => :environment do
    puts "Query quotes for all watched symbols"
    WatchedSymbol.send_watched_symbols_quote
  end
end
