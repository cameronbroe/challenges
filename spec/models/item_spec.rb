require 'rails_helper'

RSpec.describe Item, type: :model do
  subject {
    described_class.new(
        description: "Crowbar",
        price: 19.99
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a price" do
    subject.price = nil
    expect(subject).to_not be_valid
  end

  it "should have a price that is money" do
    should validate_numericality_of(:price)
  end
end
