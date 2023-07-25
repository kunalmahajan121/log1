class ExpertsController < ApplicationController

	def create 
    @expert = Expert.new(expert_params) 
    if @expert.save
      render json: { message: 'expert created successfully', expert: @expert }, status: :created
    else
      render json: { errors: @expert.errors.full_messages }, status: :unprocessable_entity
    end
  end

	def show 
    @expert = Expert.find(params[:id])
    render json: @expert
  end

  def update 
	  @expert = Expert.find(params[:id])
	  @expert.update(expert_name: params[:expert_name])
    render json: @expert
  end

  def destroy
    @expert.destroy
  end
	

  private
  def find_expert
    @expert = Expert.find_by_expert_name!(params[:expert_name])
    rescue ActiveRecord::RecordNotFound
    render json: { errors: 'expert not found' }, status: :not_found
	end

	def expert_params
    params.permit(:expert_name, :expert_skill, :description)
  end
end
