require 'test_helper'

class WatchedSymbolsControllerTest < ActionController::TestCase
  setup do
    @watched_symbol = watched_symbols(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:watched_symbols)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create watched_symbol" do
    assert_difference('WatchedSymbol.count') do
      post :create, watched_symbol: { change: @watched_symbol.change, last_price: @watched_symbol.last_price, symbol: @watched_symbol.symbol, user_id: @watched_symbol.user_id }
    end

    assert_redirected_to watched_symbol_path(assigns(:watched_symbol))
  end

  test "should show watched_symbol" do
    get :show, id: @watched_symbol
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @watched_symbol
    assert_response :success
  end

  test "should update watched_symbol" do
    patch :update, id: @watched_symbol, watched_symbol: { change: @watched_symbol.change, last_price: @watched_symbol.last_price, symbol: @watched_symbol.symbol, user_id: @watched_symbol.user_id }
    assert_redirected_to watched_symbol_path(assigns(:watched_symbol))
  end

  test "should destroy watched_symbol" do
    assert_difference('WatchedSymbol.count', -1) do
      delete :destroy, id: @watched_symbol
    end

    assert_redirected_to watched_symbols_path
  end
end
