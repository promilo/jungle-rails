require 'rails_helper'

RSpec.feature "adds_to_carts", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see product details" do
    # ACT
    visit root_path
    # page.find('#navbar').find_link(’Sign Up’).click
    first('.actions').find_link('Add').click

    expect(page).to have_text 'My Cart (1)', count: 1

    # DEBUG
    save_screenshot
    puts page.html

    # VERIFY

  end

end
