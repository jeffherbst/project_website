Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/hello_world' => 'application#hello_world'
  get '/hello/:name' => 'application#hello_world'
end
