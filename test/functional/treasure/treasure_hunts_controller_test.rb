require 'test_helper'

class Treasure::TreasureHuntsControllerTest < ActionController::TestCase
  setup do
    @treasure_treasure_hunt = treasure_treasure_hunts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:treasure_treasure_hunts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create treasure_treasure_hunt" do
    assert_difference('Treasure::TreasureHunt.count') do
      post :create, treasure_treasure_hunt: @treasure_treasure_hunt.attributes
    end

    assert_redirected_to treasure_treasure_hunt_path(assigns(:treasure_treasure_hunt))
  end

  test "should show treasure_treasure_hunt" do
    get :show, id: @treasure_treasure_hunt.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @treasure_treasure_hunt.to_param
    assert_response :success
  end

  test "should update treasure_treasure_hunt" do
    put :update, id: @treasure_treasure_hunt.to_param, treasure_treasure_hunt: @treasure_treasure_hunt.attributes
    assert_redirected_to treasure_treasure_hunt_path(assigns(:treasure_treasure_hunt))
  end

  test "should destroy treasure_treasure_hunt" do
    assert_difference('Treasure::TreasureHunt.count', -1) do
      delete :destroy, id: @treasure_treasure_hunt.to_param
    end

    assert_redirected_to treasure_treasure_hunts_path
  end
end
