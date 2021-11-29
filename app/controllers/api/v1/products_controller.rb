module Api
  module V1

    class ProductsController < ApplicationController 
      skip_before_action :verify_authenticity_token, :authenticate_user!

      def index
        @products = Product.all 
        render json: @products
      end

      def new
        @product= Product.new
      end
     
      def create
        @product= Product.new(product_params)

        if @product.save
          render json: @product 
        else
          render json: {'task': 'task failed'}
        end
      end
    
      private 

      def product_params
        params.permit(:title, :description, :price, :status, :category_id, :coupon_id, main_images: [])
      end
    end
  end
end
