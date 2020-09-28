require 'rails_helper'

RSpec.describe CustomerOrder, type: :model do
  subject {
    described_class.new(
        customer: Customer.new(first_name: "John", last_name: "Doe"),
        merchant: Merchant.new(name: "Merchant Co", address: "123 Main St"),
        customer_order_items: [
            CustomerOrderItem.new(
                item: Item.new(description: "Crowbar", price: 14.99),
                quantity: 1
            )
        ]
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a customer" do
    subject.customer = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a merchant" do
    subject.merchant = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without at least one order item" do
    subject.customer_order_items = []
    expect(subject).to_not be_valid
  end
end
