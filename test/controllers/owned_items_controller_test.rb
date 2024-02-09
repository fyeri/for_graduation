require "test_helper"

class OwnedItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owned_item = owned_items(:one)
  end

  test "should get index" do
    get owned_items_url
    assert_response :success
  end

  test "should get new" do
    get new_owned_item_url
    assert_response :success
  end

  test "should create owned_item" do
    assert_difference('OwnedItem.count') do
      post owned_items_url, params: { owned_item: { quantity: @owned_item.quantity, remark: @owned_item.remark } }
    end

    assert_redirected_to owned_item_url(OwnedItem.last)
  end

  test "should show owned_item" do
    get owned_item_url(@owned_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_owned_item_url(@owned_item)
    assert_response :success
  end

  test "should update owned_item" do
    patch owned_item_url(@owned_item), params: { owned_item: { quantity: @owned_item.quantity, remark: @owned_item.remark } }
    assert_redirected_to owned_item_url(@owned_item)
  end

  test "should destroy owned_item" do
    assert_difference('OwnedItem.count', -1) do
      delete owned_item_url(@owned_item)
    end

    assert_redirected_to owned_items_url
  end
end
