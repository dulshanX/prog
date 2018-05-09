
class XmlController < ApplicationController

  before_action :parse_params, only: :index


  def index

    sq = find_sqr(@v)


    data = if sq.nil?
             { message: "Неверные параметры запроса (input value = #{@v}" }
           else
             sq.map { |elem| {elem: elem, sqr:elem**2 }}
           end


    respond_to do |format|
      format.xml { render xml: data.to_xml }
      format.rss { render xml: data.to_xml }
    end
  end

  protected

  def parse_params
    @v = params[:v].to_i
  end

  private

  def find_sqr(res)
    num=10
    numbers=Array.new
    loop do 
      num+=1
      sqr_num=num*num
      if sqr_num.to_s == sqr_num.to_s.reverse
        numbers<<num
      end
      break if num==res.to_i
    end
    numbers
  end
end
