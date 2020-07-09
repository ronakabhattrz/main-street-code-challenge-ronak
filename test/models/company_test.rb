require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test 'getmainstreet.com email be valid' do
    assert companies(:hometown_painting).valid?
  end

  test 'Email must be from the getmainstreet' do
    refute companies(:brown_painting).valid?
    assert_includes companies(:brown_painting).errors.full_messages, 'Email must be from the getmainstreet'
  end

  test 'Blank email should be allowed' do
    assert companies(:marcus_painting).valid?
  end
end 