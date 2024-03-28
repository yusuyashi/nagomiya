class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  before_action :set_review, only: [:edit, :update, :destroy]

  def index
    @reviews = Review.order(created_at: :desc).page(params[:page]).per(4)
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to admin_reviews_path, notice: 'Review was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to admin_reviews_path, notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to admin_reviews_path, notice: 'Review was successfully destroyed.'
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :anonymous_name, :admin_comment)
  end

end

