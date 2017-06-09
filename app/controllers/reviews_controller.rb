  class ReviewsController < ApplicationController
    before_filter :not_authorized


    def create
      @product = Product.find params[:product_id]
      @review = @product.reviews.new(review_params)
      @review.user = current_user


      if @review.save!
        redirect_to '/products/' + @product.id.to_s
      else
        redirect_to '/products/' + @product.id.to_s
      end
    end

    def destroy
      Review.find(params[:id]).destroy
      redirect_to '/products/' + params[:product_id].to_s
    end

    private

    def review_params
      params.require(:review).permit(:description, :rating)
    end

    def not_authorized
      unless current_user
        redirect_to '/login'
    end
  end
end
