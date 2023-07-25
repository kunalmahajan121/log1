class UsersController < ApplicationController

	before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]
  skip_before_action :verify_authenticity_token, raise: false


	def index
	  @users = User.all
	  render json: @users
	end
	
	def create 
    @user = User.new(user_params)
    @user.generate_otp
    if @user.save
      SendOtpJob.perform_later(@user.id) # Queue the background job to send the email with OTP
      render json: { message: "User created successfully. OTP sent to email." }, status: :created
      #render json: { message: 'User created successfully', user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

	def show 
    @user = User.find(params[:id])
    render json: @user
  end

  def update 
	  @user = User.find(params[:id])
	  @user.update(username: params[:username])
    render json: @user
  end

  def destroy
    @user.destroy
  end
	

  private
  def find_user
    @user = User.find_by_username!(params[:username])
    rescue ActiveRecord::RecordNotFound
    render json: { errors: 'user not found' }, status: :not_found
	end

	def user_params
    params.permit(:username, :email, :password)
  end

  # def user_params
  #   params.require(:user).permit(:email, :password) 
  # end
end
