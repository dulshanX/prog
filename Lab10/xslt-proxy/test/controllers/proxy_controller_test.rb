require 'test_helper'
class ProxyControllerTest < ActionDispatch::IntegrationTest

  test "should get output" do
    get proxy_output_url params: { v: "100", side: 'client_with_xslt'}
    assert_response :success
  end

  test "should return various results" do
    get proxy_output_url params: { v:'100', side: 'client_with_xslt' }
    result1 = response.parsed_body

    get proxy_output_url params: { v: '50', side: 'client_with_xslt' }
    result2 = response.parsed_body

    assert_not_equal result1, result2
  end
  test "temp1" do
    get proxy_output_url params: { v: "100", side: 'server'}
    assert_response :success
    assert_equal('application/html', @response.content_type)
  end

  test "temp2" do
    get proxy_output_url params: { v: "100", side: 'client'}
    assert_response :success
    assert_equal('application/xml', @response.content_type)
  end

  test "temp3" do
    get proxy_output_url params: { v: "100", side: 'client-with-xslt'}
    assert_response :success
    assert_equal('application/xml', @response.content_type)
  end



end
