class InputController < ApplicationController
  def index
    render layout: false
  end

  def answer
    res=params[:n].to_i
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
    respond_to do |format|
      format.html
      format.json do
        render json:
                   { value: @number, value1: @sqr_number }
      end
    end
  end
end
