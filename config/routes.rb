Rails.application.routes.draw do
  get '/', to: 'sports#index', as: 'sports_index'
  get '/sports', to: 'sports#all_sports'
  get '/sports/:sport_id', to: 'sports#all_events_for_sport'
  get '/sports/:sport_id/events/:event_id', to: 'sports#all_outcomes_for_event'
  match "*path", to: redirect('/'), via: :all
end
