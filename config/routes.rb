Rails.application.routes.draw do
 root 'posts#index'

 get "/posts" => "posts#index"
 get "/posts/:id" => "posts#show"
 get "/posts/new" => "posts#new"
 post "/posts" => "posts#create"
 get "/posts/:id/edit" => "posts#edit"
 put "/posts/:id" => "posts#update"
 delete "/posts/:id" => "posts#destroy"

end
