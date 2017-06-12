require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before :each do
      @category = Category.create(name:"Music")
    end

    it 'the valid product should be passed' do
      @product = Product.new(
        name: "LinkinPark",
        price: 3424.00,
        quantity: 32,
        category_id: @category.id
        )
      @product.save!
      expect(@product).to be_present
    end

    it 'NAme is missing' do
      @product = Product.new(
        price: 3424.00,
        quantity: 32,
        category_id: @category.id
        )
        @product.save

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'price is missing' do
      @product = Product.new(
        name: "LinkinPark1",
        quantity: 32,
        category_id: @category.id
        )

        @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'quantity is missing' do
      @product = Product.new(
        name: "LinkinPark2",
        price: 3424.00,
        category_id: @category.id
        )
        @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'category is missing' do
      @product = Product.new(
        name: "LinkinPark3",
        price: 3424.00,
        quantity: 32,
        )
        @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
