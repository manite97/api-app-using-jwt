class UsersController < ApplicationController
  before_action :authenticate_api_token, except: [:login, :sign_up]

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = JsonWebToken.encode({user: user.id})
      resposne = generate_out_resposne(token,user)
      render json: resposne,  status: 200
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end 
  end

  def sign_up
    new_user = User.new(name: params[:name],email: params[:email], password: params[:password])
    if new_user.valid?
      new_user.save
      token = JsonWebToken.encode({user: new_user.id})
      resposne = generate_out_resposne(token,new_user)
      render json: resposne,  status: 200
    else
      render json: new_user.errors.full_messages, status: 422
    end
  end

  def get_user_information
    if @current_api_user.present?
      @goals = @current_api_user.goals
      render template: '/users/user.json.jbuilder', status: 200
    else
      render json: {success: 'Goal added success fully'}, status: :ok
    end
  end

  def add_new_goals
    if @current_api_user.present?
      goal = Goal.create(user: @current_api_user, milestone: params[:milestone], description: params[:description])
      if goal.valid?
        goal.save
        render json: {success: 'Goal added success fully'}, status: :ok
      end
    else
      render json: {errors: ['login to add goals']}, status: :unauthorized
    end  
  end

  def update_user_goal
    goal = Goal.find_by(id: params[:id])
    if goal && goal.update(milestone: params[:milestone],description: params[:description])
      render json: { message: 'goal updated successfully' }
    else
      render json: {erro: 'failed to update'}, status: 422
    end
  end

  private
  def generate_out_resposne(token,user)
    {
      auth_token: token,
      user: {id: user.id, email: user.email}
    }
  end
end