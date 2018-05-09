class ActsController < ApplicationController
  before_action :set_act, only: [:show, :edit, :update, :destroy]

  # GET /acts
  # GET /acts.json
  def index
    @acts = Act.order(date: :desc).paginate(:page => params[:page], :per_page => 20)
  end

  # GET /acts/1
  # GET /acts/1.json
  def show
  end

  # GET /acts/new
  def new
    if !user_signed_in?
      redirect_to new_user_session_url
      return
    end

    @act = Act.new
  end

  # GET /acts/1/edit
  def edit
    all_rights?
  end

  # POST /acts
  # POST /acts.json
  def create
    if !user_signed_in?
      redirect_to new_user_session_url
      return
    end

    @act = Act.new(act_params)
    @act.user = current_user

    respond_to do |format|
      if @act.save
        format.html { redirect_to @act, notice: 'Act was successfully created.' }
        format.json { render :show, status: :created, location: @act }
      else
        format.html { render :new }
        format.json { render json: @act.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acts/1
  # PATCH/PUT /acts/1.json
  def update
    return if !all_rights?
    respond_to do |format|
      if @act.update(act_params)
        format.html { redirect_to @act, notice: 'Act was successfully updated.' }
        format.json { render :show, status: :ok, location: @act }
      else
        format.html { render :edit }
        format.json { render json: @act.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acts/1
  # DELETE /acts/1.json
  def destroy
    return if !all_rights?
    @act.destroy
    respond_to do |format|
      format.html { redirect_to acts_url, notice: 'Act was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_act
      @act = Act.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def act_params
      params.require(:act).permit(:date, :value, :name, :desc, :category_id)
    end

    def all_rights?
      if (current_user != @act.user) && (!current_user.try(:admin?))
        redirect_to root_url
        return false
      end
      return true
    end
end
