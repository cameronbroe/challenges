require 'rails_helper'

RSpec.describe Merchant, type: :model do
  subject {
    described_class.new(
        name: "John Doe Co",
        address: "123 Main St"
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an address" do
    subject.address = nil
    expect(subject).to_not be_valid
  end

  it "should have many orders" do
    should have_many(:customer_orders)
  end
end
