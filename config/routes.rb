Rails.application.routes.draw do
 
  resources :flights, only: [:index]

  resources :flight_passengers, only: [:destroy]

  resources :airlines, only: [:show]

  delete "/flights/:flight_id/passengers/:passenger_id/", to: "flight_passengers#destroy"
end
