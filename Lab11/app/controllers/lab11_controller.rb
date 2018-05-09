class Lab11Controller < ApplicationController
  #before_action :, only: :result_in_xml
  def input
  end

  def view
    @@a = params[:a].to_i
    @a=@@a
    @result = []
    @number = []
    if res = Lab11Result.find_by_a(@@a)
      @result = ActiveSupport::JSON::decode(res.result)
    elsif @@a > 11
      num=10
      loop { 
        num+=1
        sqr_num=num*num
        if sqr_num.to_s == sqr_num.to_s.reverse
          @number<<num
          @result<<sqr_num
        end
        break if num==@@a
      }
      res = Lab11Result.create :a => @@a, :result => ActiveSupport::JSON::encode(@result)
      res.save
    end
  end

  def result_in_xml
    @result = Lab11Result.find_by_a(@@a)
    render xml: eval(@result.result).to_xml
  end
end