require 'rails_helper'

RSpec.describe CustomerOrderItem, type: :model do
  subject {
    described_class.new(
        item: Item.new(description: "Crowbar", price: 19.99),
        customer_order: CustomerOrder.new(
          customer: Customer.new(first_name: "John", last_name: "Doe"),
          merchant: Merchant.new(name: "Merchant Co", address: "123 Main St")
        ),
        quantity: 1
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without an item" do
    subject.item = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a quantity" do
    subject.quantity = nil
    expect(subject).to_not be_valid
  end

  it "should have a quantity with numericality" do
    should validate_numericality_of(:quantity)
  end
end
