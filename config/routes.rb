Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, contraints: { subdomains: 'api' }, path: '/' do
  end
end
