Rails.application.routes.draw do
  get '/' => 'index#index'

  post 'v1/login' =>  'polarion_interface#login'
  get 'v1/search' => 'polarion_interface#search'
  get 'v1/progettodemand/:repo/*uri' => 'polarion_interface#details', constraints: { uri: /.*/ } #*uri per matchare gli slash nel parametro, constraints per matchare anche i punti
  delete 'v1/favorites/:repo/*uri' => 'polarion_interface#deleteFavorite', constraints: { uri: /.*/ } #*uri per matchare gli slash nel parametro, constraints per matchare anche i punti
  post 'v1/favorites' => 'polarion_interface#addFavorite'
  get 'v1/favorites' => 'polarion_interface#getFavorites'
  post 'v1/logout' => 'polarion_interface#logout'

  get 'v1/test' => 'polarion_interface#test'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
