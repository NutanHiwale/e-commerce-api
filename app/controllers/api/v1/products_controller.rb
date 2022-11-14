class Api::V1::ProductsController < ApplicationController
  before_action :set_article, only: [:show]
  before_action :authenticate_user!
  def index
    product = Product.all 
    render json: product, status: 200
  end

  def show 
    product = Product.find_by(id: params[:id])
    if product 
      render json: product, status:200
    else
      render json: {error: "Not Found"}, status: 404
    end 
  end 

  def create
    byebug 
    product = Product.new(product_params)
    if product.save
      render json: {product_details: product,
                    message: "Product saved successfully"},
             status: 200
    else
      render json: {error: product.errors.full_messages.join(',')}, status: 422
    end     
  end

  private 

  def product_params
    params.required(:product).permit([
      :name, :desc, :category, :price, :quantity
    ])
  end 
end