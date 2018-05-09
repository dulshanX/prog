require 'test_helper'
include Math

class Lab11ControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get lab11_input_url
    assert_response :success
  end

  test "should get view" do
    get lab11_view_url
    assert_response :success
  end

  test "should get" do
    i = rand(10000 ) + 1
    get lab11_view_url, params: { a: i }
    assert_in_delta(assigns[:result].last, sqrt(i), 0.001)
  end
end
