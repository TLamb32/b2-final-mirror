require "rails_helper"

RSpec.describe "admin dashboard" do
  before(:each) do
    load_test_data
  end

# US19
  it "displays a header indicating that I am on the admin dashboard" do
    # visit "/admin"
    visit admin_path
    
    expect(page).to have_content("Welcome to the admin dashboard!")
  end

# US20
  it "displays a link to the admin merchants index" do
    # visit "/admin"
    visit admin_path

    expect(page).to have_link("Merchants")
    click_link("Merchants")
    # expect(page).to have_current_path("/admin/merchants")
    expect(page).to have_current_path(admin_merchants_path)
  end

# US20
  it "displays a link to the admin invoices index" do
    # visit "/admin"
    visit admin_path

    expect(page).to have_link("Invoices")
    click_link("Invoices")
    # expect(page).to have_current_path("/admin/invoices")
    expect(page).to have_current_path(admin_invoices_path)
  end
# US21
  it "displays the names of the top 5 customers who have conducted the largest number of successful transactions" do 
    # visit "/admin"
    visit admin_path

    expect(@customer_3.first_name).to appear_before(@customer_5.first_name)
    expect(@customer_5.first_name).to appear_before(@customer_6.first_name)
    expect(@customer_6.first_name).to appear_before(@customer_2.first_name)
    expect(@customer_2.first_name).to appear_before(@customer_1.first_name)
    expect(page).to have_content(@customer_3.first_name)
    expect(page).not_to have_content(@customer_4.first_name)
  end

#US 22
  it "I see a section for 'Incompleted Invoices' - in that section I see a list of the ids of all invoices that have not yet shipped" do
    # visit "/admin"
    visit admin_path

    expect(page).to have_content("Incompleted Invoices")
    expect(page).to_not have_content("Invoice ID: #{@invoice_4_c1.id}")
    expect(page).to have_content("Invoice ID: #{@invoice_1_c1.id}")
  end

  # US22
  it "And each invoice id links to that invoice's admin show page" do
    # visit "/admin"
    visit admin_path

    click_link("#{@invoice_1_c1.id}")
    # expect(current_path).to eq("/admin/invoices/#{@invoice_1_c1.id}")
    expect(current_path).to eq(admin_invoice_path(@invoice_1_c1))
  end
end