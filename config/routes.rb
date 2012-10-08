RailsTemplate::Application.routes.draw do
  resources :services, :only => %w[ show update index ], :constraints => { :id => /.+/ }
end
