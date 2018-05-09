class LabController < ApplicationController
  def input; end

  def output
    res=params[:v1].to_i
    num=10
    numbers=Array.new
    sqr_number=Array.new
    loop { 
      num+=1
      sqr_num=num*num
      if sqr_num.to_s == sqr_num.to_s.reverse
        numbers<<num
        sqr_number<<sqr_num
      end
      break if num==res.to_i
    }
    @number=numbers
    @sqr_number=sqr_number
  end
end