class VegetablesController < ApplicationController

  def index
    # The vegetagle model is always singular
    @vegetables = Vegetable.all
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
    else
    # A glash message should be used to indicate failure as well.
    flash[:error] = "There was a problem creating the new vegetable!"
    redirect_to :new
  end
  end

  def edit
    @vegetable = Vegetable.find(whitelisted_vegetable_params)
  end

  def update
    # Use the find method to find an existing object
    @vegetable = Vegetable.find(whitelisted_vegetable_params)
    if @vegetable.update
      flash[:success] = "A new twist on an old favorite!"
      redirect_to @vegetable
    else
      flash[:error] = "Something is rotten here..."
      render :edit
    end
  end

  # Method is destroy
  def destroy
    @vegetable = Vegetable.find(params[:id])
    # This should be included in an if logic to accomodate for potential failure
    if @vegetable.destroy
      flash[:success] = "That veggie is trashed."
      # Redirects to the index
      redirect_to vegetables_path
    else
      # Flash error if fails, redirects back to destroy
      flash[:error] = "There was a problem trashing that veggie."
      render :destroy
    end
  end

  private

  def whitelisted_vegetable_params
    # Must pass params as an argument
    params.require(:vegetable).permit(:name, :color, :rating, :latin_name)
  end

end
