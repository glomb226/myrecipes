require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "john", email: "john@email.com",)
  end
  
  test "Chefname should be vaild" do
    assert @chef.valid?
  end
  
  test "Chefname should be present" do
     @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "chefname length should not be too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end
  
  test "chefname length should not be too short" do
    @chef.chefname = "a" * 2
    assert_not @chef.valid?
  end
  
  test "chef email should be present" do
     @chef.email = " "
    assert_not @chef.valid?
  end  
  
  test "email length should be within bounds" do
   @chef.email = "a" * 101 + "@example.com"
   assert_not @chef.valid?
  end
  
  test "email uniqueness" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email is valid accept" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura+joe@yahoo.cm]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end
  
    test "email is invalid reject" do
    invalid_addresses = %w[user@eee,com R_TDD-DSateee.hello.org user@example. foo@yo+yahoo.cm]
    invalid_addresses.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, '#{ia.inspect} should be invalid'
    end
  end
  
end


  
