Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'hubs/index', as: :hubs
  get 'hubs/closets', to: 'hubs#closest'
  
  get 'hubs/autocomplete_address', to: 'hubs#autocomplete_address'

  root to: "hubs#index"
end
