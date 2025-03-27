# frozen_string_literal: true

require "test_helper"

# this controller for home page related test cases
class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end
end
