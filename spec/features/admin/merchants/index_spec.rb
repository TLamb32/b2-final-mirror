require 'rails_helper'

RSpec.describe "As a visitor when I visit 'admin/merchants'" do
  before :each do
    load_test_data
  end

  #user story 24
  it "I see the name of each merchant in the system" do
    visit 'admin/merchants'

    within("#merchant-#{@merchant_1.id}") do
      expect(page).to have_content(@merchant_1.name)
    end

    within("#merchant-#{@merchant_2.id}") do
      expect(page).to have_content(@merchant_2.name)
    end

    within("#merchant-#{@merchant_3.id}") do
      expect(page).to have_content(@merchant_3.name)
    end
  end

  #user story 25
  it "each name is a link to the merchant's show page" do
    visit 'admin/merchants'

    within("#merchant-#{@merchant_1.id}") do
      click_link "#{@merchant_1.name}"
    end

    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    expect(page).to have_content(@merchant_1.name)
  end

    # user story 27
    it "I see a button to disable or enable a merchant" do
      visit "/admin/merchants"
  
      within("#merchant-#{@merchant_1.id}") do
        expect(page).to have_content("Status: Disabled")
        expect(page).to have_button("Enable")
        click_button "Enable"
      end

      expect(current_path).to eq("/admin/merchants")
      
      within("#merchant-#{@merchant_1.id}") do
        expect(page).to have_content("Status: Enabled")
        expect(page).to have_button("Disable")
        click_button "Disable"
      end

      expect(current_path).to eq("/admin/merchants")
    end
end