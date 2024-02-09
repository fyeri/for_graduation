require "application_system_test_case"

class OwnedItemsTest < ApplicationSystemTestCase
  setup do
    @owned_item = owned_items(:one)
  end

  test "visiting the index" do
    visit owned_items_url
    assert_selector "h1", text: "Owned Items"
  end

  test "creating a Owned item" do
    visit owned_items_url
    click_on "New Owned Item"

    fill_in "Quantity", with: @owned_item.quantity
    fill_in "Remark", with: @owned_item.remark
    click_on "Create Owned item"

    assert_text "Owned item was successfully created"
    click_on "Back"
  end

  test "updating a Owned item" do
    visit owned_items_url
    click_on "Edit", match: :first

    fill_in "Quantity", with: @owned_item.quantity
    fill_in "Remark", with: @owned_item.remark
    click_on "Update Owned item"

    assert_text "Owned item was successfully updated"
    click_on "Back"
  end

  test "destroying a Owned item" do
    visit owned_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Owned item was successfully destroyed"
  end
end
