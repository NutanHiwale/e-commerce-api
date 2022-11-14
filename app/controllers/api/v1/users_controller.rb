class Api::V1::UsersController < ApplicationController
  def index
    user = User.all 
    render json: user, status:200
  end 

  def show 
    user = User.find_by(id: params[:id])
    if user 
      render json: user, status: 200
    else
      render json:{error: "Not Found"}, status: 404
    end 
  end 

  def create 
    byebug
    user = User.new(user_params)
    if user.save
      render json: {user_details: user,
                    message: "User saved successfully"},
              status: 200
    else
      render json: {error: user.errors.full_messages.join(',')}, status: 422
    end
  end 

  private

  def user_params 
    params.require(:user).permit([
      :first_name, :last_name, :email, :password, :address, :pincode, :city, :mobile_no  
    ])
  end
end