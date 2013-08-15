require 'test_helper'

class Fundamental::DailyPositionStatsControllerTest < ActionController::TestCase
  setup do
    @fundamental_daily_position_stat = fundamental_daily_position_stats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundamental_daily_position_stats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fundamental_daily_position_stat" do
    assert_difference('Fundamental::DailyPositionStat.count') do
      post :create, fundamental_daily_position_stat: @fundamental_daily_position_stat.attributes
    end

    assert_redirected_to fundamental_daily_position_stat_path(assigns(:fundamental_daily_position_stat))
  end

  test "should show fundamental_daily_position_stat" do
    get :show, id: @fundamental_daily_position_stat.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fundamental_daily_position_stat.to_param
    assert_response :success
  end

  test "should update fundamental_daily_position_stat" do
    put :update, id: @fundamental_daily_position_stat.to_param, fundamental_daily_position_stat: @fundamental_daily_position_stat.attributes
    assert_redirected_to fundamental_daily_position_stat_path(assigns(:fundamental_daily_position_stat))
  end

  test "should destroy fundamental_daily_position_stat" do
    assert_difference('Fundamental::DailyPositionStat.count', -1) do
      delete :destroy, id: @fundamental_daily_position_stat.to_param
    end

    assert_redirected_to fundamental_daily_position_stats_path
  end
end
