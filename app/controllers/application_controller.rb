class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  attr_reader :current_api_user
  def authenticate_api_token
    token = request.headers["HTTP_TOKEN"]
    begin
      decoded           = JsonWebToken.decode(token)
      user_id           =  decoded["user"] if decoded.present?
      @current_api_user = User.find_by(id: user_id)
      @api_token        = token
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end
end
