require 'test_helper'

class Fundamental::CharacterPositionsControllerTest < ActionController::TestCase
  setup do
    @fundamental_character_position = fundamental_character_positions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundamental_character_positions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fundamental_character_position" do
    assert_difference('Fundamental::CharacterPosition.count') do
      post :create, fundamental_character_position: @fundamental_character_position.attributes
    end

    assert_redirected_to fundamental_character_position_path(assigns(:fundamental_character_position))
  end

  test "should show fundamental_character_position" do
    get :show, id: @fundamental_character_position.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fundamental_character_position.to_param
    assert_response :success
  end

  test "should update fundamental_character_position" do
    put :update, id: @fundamental_character_position.to_param, fundamental_character_position: @fundamental_character_position.attributes
    assert_redirected_to fundamental_character_position_path(assigns(:fundamental_character_position))
  end

  test "should destroy fundamental_character_position" do
    assert_difference('Fundamental::CharacterPosition.count', -1) do
      delete :destroy, id: @fundamental_character_position.to_param
    end

    assert_redirected_to fundamental_character_positions_path
  end
end
