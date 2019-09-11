class PlansController < ApplicationController

  def index
    @user = User.find_by(id: current_user.id)
  end

  def plans
    @plans = Plan.all
  end
  
  def show
    @plan = Plan.find(params[:id])
  end

  def new
    @plan = Plan.new
    @plan.contents.build
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to plan_path(@plan)
    else
      render :new
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:destination, :title, contents_attributes: [:id, :place_name, :description, :image, :price, :time, :access, :_destroy]).merge(user_id: current_user.id)
  end

end
