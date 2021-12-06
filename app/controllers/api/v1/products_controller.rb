module Api
  module V1

    class ProductsController < ApplicationController::API
      def index
        @products = Product.all
        render json: @products
      end

      def new
        @product = Product.new
      end

      def create
        @product = Product.new(product_params)

        if @product.save
          render json: @product
        else
          render json: { error: @product.errors.full_messaages.to_sentence }
        end
      end

      private

      def product_params
        params.permit(:title, :description, :price, :status, :category_id, :coupon_id, main_images: [])
      end
    end
  end
end
