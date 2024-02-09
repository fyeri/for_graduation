require "test_helper"

class WantedItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wanted_item = wanted_items(:one)
  end

  test "should get index" do
    get wanted_items_url
    assert_response :success
  end

  test "should get new" do
    get new_wanted_item_url
    assert_response :success
  end

  test "should create wanted_item" do
    assert_difference('WantedItem.count') do
      post wanted_items_url, params: { wanted_item: { quantity: @wanted_item.quantity, remark: @wanted_item.remark } }
    end

    assert_redirected_to wanted_item_url(WantedItem.last)
  end

  test "should show wanted_item" do
    get wanted_item_url(@wanted_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_wanted_item_url(@wanted_item)
    assert_response :success
  end

  test "should update wanted_item" do
    patch wanted_item_url(@wanted_item), params: { wanted_item: { quantity: @wanted_item.quantity, remark: @wanted_item.remark } }
    assert_redirected_to wanted_item_url(@wanted_item)
  end

  test "should destroy wanted_item" do
    assert_difference('WantedItem.count', -1) do
      delete wanted_item_url(@wanted_item)
    end

    assert_redirected_to wanted_items_url
  end
end
