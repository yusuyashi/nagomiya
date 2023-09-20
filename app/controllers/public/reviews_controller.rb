class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :create]

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_customer.reviews.new(review_params)
  if @review.save
    redirect_to public_reviews_path, notice: 'Review was successfully created.'
  else
    render :new
  end
  end


  private

  def review_params
    params.require(:review).permit(:rating, :comment, :anonymous_name)
  end
  
end
