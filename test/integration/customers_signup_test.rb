require 'test_helper'

class CustomersSignupTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @user.save
  end

  test "invalid customer signup information" do
    log_in_as(@user)
    get customers_new_path
    assert_no_difference 'Customer.count' do
      post customers_path, params: { customer: { company: ""} }
    end
    assert_template 'customers/new'
  end

  test "valid customer signup information" do
    log_in_as(@user)
    get customers_new_path
    assert_difference 'Customer.count', 1 do
      post customers_path, params: { customer: { 
        company:  "Example Company",
        address:  "3579 Prime Street",
        city: "Imaginationland", 
        state: "Ofmind", 
        zip: "1311"} }
    end
    follow_redirect!
    assert_template 'customers/show'
  end
end