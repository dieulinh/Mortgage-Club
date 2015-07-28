require 'rails_helper'

describe Role, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:role)).to be_valid
  end
end
