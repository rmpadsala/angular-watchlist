class WatchedSymbol < ActiveRecord::Base
  belongs_to :user

  after_initialize :init_default_params
  before_create :validate_symbol_and_query_quote

  validates :symbol, uniqueness: true

  attr_accessor :skip_callback

  def self.send_watched_symbols_quote
    watched_symbols = WatchedSymbol.all
    watched_symbols.each do |watched_symbol|
      response = watched_symbol.send_quote
      Rails.logger.debug("Quote Response: #{response.inspect}")
      if (response[:success])
        watched_symbol.last_price = response[:response]["LastPrice"]
        watched_symbol.change = response[:response]["Change"]
        watched_symbol.high = response[:response]["High"]
        watched_symbol.low = response[:response]["Low"]
        watched_symbol.open = response[:response]["Open"]
        watched_symbol.skip_callback = true;
        watched_symbol.save!

        # send pusher message...
        event = "#{watched_symbol.user_id}_#{watched_symbol.symbol}"
        puts "sending message w/ subject #{event}"
        Pusher.trigger('quotes_channel', event, watched_symbol.to_json)
      end
    end
  end

  def send_quote
    query_params = "symbol=#{self.symbol}"
    attributes_hash = {
      request_type: 'GET',
      method: 'Quote',
      query_params: query_params
    }
    MarkitApi.get_response(attributes_hash)
  end

  private
    def init_default_params
      self.skip_callback = false
    end

    def validate_symbol_and_query_quote
      return true if self.skip_callback
      response = send_quote

      Rails.logger.debug("Quote Response: #{response.inspect}")

      if (response[:success])
        self.last_price = response[:response]["LastPrice"]
        self.change = response[:response]["Change"]
        self.high = response[:response]["High"]
        self.low = response[:response]["Low"]
        self.open = response[:response]["Open"]
      end
      response[:success]
    end
end
