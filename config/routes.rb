Rails.application.routes.draw do
  
  root 'statics#index'
  post 'run', to: 'statics#create'

end
