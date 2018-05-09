require 'test_helper'

class XmlControllerTest < ActionDispatch::IntegrationTest
  test 'should get input' do
    get root_url params: { v: '100', format: 'xml' }
    assert_response :success
  end
end
