class StatsController < ApplicationController
  def index
    @cats = Category.all
  end

  def filter
    d1s = (params[:date1] && !params[:date1].empty?) ? params[:date1] : '01-01-2001'
    d2s = (params[:date2] && !params[:date2].empty?) ? params[:date2] : '01-01-2100'
    d1 = Date.parse(d1s)
    d2 = Date.parse(d2s)
    cat_id = (params[:cat_id] && !params[:cat_id].empty?) ? params[:cat_id].to_i : 0
    act_name = (params[:name] && !params[:name].empty?) ? params[:name] : ''
    user_name = (params[:username] && !params[:username].empty?) ? params[:username] : ''

    @acts = Act.where(date: d1..d2).order(date: :desc)
    @acts = @acts.where('category_id = ?', cat_id) if (cat_id > 0)
    @acts = @acts.where('name LIKE ?', act_name) if (act_name != '')

    if (user_name != '')
      user_id = User.where('name LIKE ?', user_name)
      user_id = !user_id.empty? ? user_id[0].id : 0
      @acts = @acts.where('user_id = ?', user_id)
    end

    # render :json => params
    # render :json => @acts
  end

  private

end
