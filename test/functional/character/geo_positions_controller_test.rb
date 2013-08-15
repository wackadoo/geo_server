require 'test_helper'

class Character::GeoPositionsControllerTest < ActionController::TestCase
  setup do
    @character_geo_position = character_geo_positions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:character_geo_positions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create character_geo_position" do
    assert_difference('Character::GeoPosition.count') do
      post :create, character_geo_position: @character_geo_position.attributes
    end

    assert_redirected_to character_geo_position_path(assigns(:character_geo_position))
  end

  test "should show character_geo_position" do
    get :show, id: @character_geo_position.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @character_geo_position.to_param
    assert_response :success
  end

  test "should update character_geo_position" do
    put :update, id: @character_geo_position.to_param, character_geo_position: @character_geo_position.attributes
    assert_redirected_to character_geo_position_path(assigns(:character_geo_position))
  end

  test "should destroy character_geo_position" do
    assert_difference('Character::GeoPosition.count', -1) do
      delete :destroy, id: @character_geo_position.to_param
    end

    assert_redirected_to character_geo_positions_path
  end
end
