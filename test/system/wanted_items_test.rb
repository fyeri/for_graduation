require "application_system_test_case"

class WantedItemsTest < ApplicationSystemTestCase
  setup do
    @wanted_item = wanted_items(:one)
  end

  test "visiting the index" do
    visit wanted_items_url
    assert_selector "h1", text: "Wanted Items"
  end

  test "creating a Wanted item" do
    visit wanted_items_url
    click_on "New Wanted Item"

    fill_in "Quantity", with: @wanted_item.quantity
    fill_in "Remark", with: @wanted_item.remark
    click_on "Create Wanted item"

    assert_text "Wanted item was successfully created"
    click_on "Back"
  end

  test "updating a Wanted item" do
    visit wanted_items_url
    click_on "Edit", match: :first

    fill_in "Quantity", with: @wanted_item.quantity
    fill_in "Remark", with: @wanted_item.remark
    click_on "Update Wanted item"

    assert_text "Wanted item was successfully updated"
    click_on "Back"
  end

  test "destroying a Wanted item" do
    visit wanted_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Wanted item was successfully destroyed"
  end
end
