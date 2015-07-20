class VegetablesController < ApplicationController

  def index
    @vegetables = Vegetables.all
  end

  def show
    @vegetable = Vegetable.find(params[:id])
  end

  def new
    @vegetable = Vegetable.new
  end

  def create
    @vegetable = Vegetable.new(whitelisted_vegetable_params)
    if @vegetable.save
      flash[:success] = "That sounds like a tasty vegetable!"
      redirect_to @vegetable
    end
    redirect_to :new
  end

  def edit
    @vegetable = Vegetable.find(whitelisted_vegetable_params)
  end

  def update
    @vegetable = Vegetable.new(whitelisted_vegetable_params)
    if @vegetable.update
      flash[:success] = "A new twist on an old favorite!"
      redirect_to @vegetable
    else
      flash[:error] = "Something is rotten here..."
      render :edit
    end
  end

  def delete
    @vegetable = Vegetable.find(params[:id])
    @vegetable.destroy
    flash[:success] = "That veggie is trashed."
    redirect_to @vegetable
  end

  private

  def whitelisted_vegetable_params
    require(:vegetable).permit(:name, :color, :rating, :latin_name)
  end

end
