require 'test_helper'

class Lab11ResultTest < ActiveSupport::TestCase

  test 'should input' do
    i = rand(100 ) + 11
    result = []
    number = []
    if res = Lab11Result.find_by_a(i)
      result = ActiveSupport::JSON::decode(res.result)
    elsif i > 11
      num=10
        loop { 
          num+=1
          sqr_num=num*num
          if sqr_num.to_s == sqr_num.to_s.reverse
            number<<num
            result<<sqr_num
          end
          break if num==i
        }
      end
      res = Lab11Result.create :a => i, :result => ActiveSupport::JSON::encode(result)
      res.save
    end
    res = Lab11Result.find_by_a(i)
    assert_not_equal(nil, res)
    assert_equal(false,Lab11Result.create(:a => i, :result => ActiveSupport::JSON::encode(result)).valid?)
  end
end
