class WatchedSymbolsController < ApplicationController
  before_action :set_watched_symbol, only: [:show, :edit, :update, :destroy]

  # GET /watched_symbols
  # GET /watched_symbols.json
  def index
    @watched_symbols = WatchedSymbol.all
  end

  # GET /watched_symbols/1
  # GET /watched_symbols/1.json
  def show
  end

  # GET /watched_symbols/new
  def new
    @watched_symbol = WatchedSymbol.new
  end

  # GET /watched_symbols/1/edit
  def edit
  end

  # POST /watched_symbols
  # POST /watched_symbols.json
  def create
    @watched_symbol = WatchedSymbol.new(watched_symbol_params)

    respond_to do |format|
      if @watched_symbol.save
        format.html { redirect_to @watched_symbol, notice: 'Watched symbol was successfully created.' }
        format.json { render action: 'show', status: :created, location: @watched_symbol }
      else
        format.html { render action: 'new' }
        format.json { render json: @watched_symbol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /watched_symbols/1
  # PATCH/PUT /watched_symbols/1.json
  def update
    respond_to do |format|
      if @watched_symbol.update(watched_symbol_params)
        format.html { redirect_to @watched_symbol, notice: 'Watched symbol was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @watched_symbol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /watched_symbols/1
  # DELETE /watched_symbols/1.json
  def destroy
    @watched_symbol.destroy
    respond_to do |format|
      format.html { redirect_to watched_symbols_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_watched_symbol
      @watched_symbol = WatchedSymbol.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def watched_symbol_params
      params.require(:watched_symbol).permit(:symbol, :last_price, :change, :user_id)
    end
end
