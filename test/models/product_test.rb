require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'should have positive price' do
    product = product(:one)
    product.price = -1
    assert_not product.valid?
  end
end
