require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  
    def setup
        @customer = customers(:one)
        @project = projects(:one)
    end

    test "customer should be valid" do 
        assert @customer.valid?
    end
    #field should be present
    test "company is present" do
        @customer.company = " " 
        assert_not @customer.valid?
    end
    test "address is present" do
        @customer.address = " " 
        assert_not @customer.valid?
    end
    test "city is present" do
        @customer.city = " " 
        assert_not @customer.valid?
    end
    test "state is present" do
        @customer.state = " " 
        assert_not @customer.valid?
    end
    test "zip is present" do
        @customer.zip = " " 
        assert_not @customer.valid?
    end
    # field length validation
    test "company should not be too long" do
        @customer.company = "a" * 51
        assert_not @customer.valid?
    end
    test "address should not be too long" do
        @customer.address = "a" * 51
        assert_not @customer.valid?
    end
    test "city should not be too long" do
        @customer.city = "a" * 51
        assert_not @customer.valid?
    end
    test "state should not be too long" do
        @customer.state = "a" * 51
        assert_not @customer.valid?
    end
    test "zip should not be too long" do
        @customer.zip = "a" * 51
        assert_not @customer.valid?
    end
    # field should be unique
    test "company should be unique" do
        duplicate_customer = @customer.dup
        duplicate_customer.company = @customer.company.upcase
        @customer.save
        assert_not duplicate_customer.valid?
    end
    # field should be saved as lower-case 
    test "company should be saved as lower-case" do
        mixed_case_company = "FoO"
        @customer.company = mixed_case_company
        @customer.save
        assert_equal mixed_case_company.downcase, @customer.reload.company
    end
    # has_many destroy
    test "associated projects should be destroyed" do
        @customer.projects.create!(
        project_name: @project.project_name
        )
        assert_difference 'Customer.count', -1 do 
        @customer.destroy
        end
    end
end
