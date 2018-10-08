require 'rails_helper'

RSpec.describe Cart, type: :model do
 it "includes products into carts" do
     cart = FactoryGirl.create(:cart)
     product = FactoryGirl.create(:product)
     cart.cartships.create(product: product, quantity: 1)
     expect(cart.products.length).to eq(1)
 end
 
 it "calculates the total price for a cart" do
     cart = FactoryGirl.create(:cart)
     product1 = FactoryGirl.create(:product, price: 250)
     product2 = FactoryGirl.create(:product, price: 100)
     cart.cartships.create(product: product1, quantity: 2)
     cart.cartships.create(product: product2, quantity: 1)
     expect(cart.total_price).to eq(600)
 end

end
