Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/auth/login", to: "users#login"
  post "/auth/sign_up", to: "users#sign_up"
  post "/goal", to: "users#add_new_goals"
  put "/goal/:id", to: "users#update_user_goal"
  get "/user_info", to: "users#get_user_information"
end
