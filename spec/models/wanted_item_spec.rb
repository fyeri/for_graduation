require 'rails_helper'

RSpec.describe WantedItem, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:item) }
end
