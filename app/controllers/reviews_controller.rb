class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    @reviews = Review.all
  end

  def show
    @user = current_user
  end

  def new
    # @review = Review.new
    @types = Review.select(:LOVE).distinct
    @product = Product.find(params[:product_id])
    @user = current_user
    @review = @user.reviews.build
  end

  def edit
  end

  def create
    # @review = Review.new(review_params)
    @user = current_user
    @review = @user.reviews.create(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to product_url(@review.product), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:rating, :comment, :user_id, :product_id)
    end
end
