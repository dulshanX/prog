require 'selenium-webdriver'
require 'rspec'
include RSpec::Expectations
describe 'l9' do
  @driver = Selenium::WebDriver.for :firefox
  @base_url = 'http://localhost:3000'
  @driver.manage.timeouts.implicit_wait = 30
  @verification_errors = []

  it 'test_calc' do
    @driver.get(@base_url + '/input/index')
    @driver.find_element(:id, 'n').clear
    @driver.find_element(:id, 'n').send_keys '21'
    @driver.find_element(:name, 'commit').click
    verify { @driver.find_element(:xpath, '//*[@id="result"]').text.should == '4' }
  end
end
