Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/api/v1/sites/create', to: 'sites#create'

  post '/api/v1/sites/:site_id/rsscreate', to: 'rss_feeds#create'

  get '/api/v1/medias', to: 'medias#list'
  get '/api/v1/medias/filters', to: 'medias#filters'

  get '/api/v1/subscriptions', to: 'subscriptions#list'
  post '/api/v1/subscriptions/create', to: 'subscriptions#create'
  post '/api/v1/subscriptions/:id/update', to: 'subscriptions#update'
  post '/api/v1/subscriptions/:id/delete', to: 'subscriptions#delete'

  # Dev only
  post '/api/v1/rss/update', to: 'rss_feeds#update_all'
  get '/api/v1/torrents', to: 'torrents#list'
  post '/api/v1/torrents/:id/scrape', to: 'torrents#scrape'
  get '/api/v1/subscriptions/:id', to: 'subscriptions#show'
end
