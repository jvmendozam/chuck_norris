Rails.application.routes.draw do
  scope ":locale", locale: /es|en/ do
    resources :searches, :except => [:edit, :show, :destroy] do
      get :categories, on: :collection, as: :categories
      get :index_categories, on: :collection, as: :index_categories
      get :random, on: :collection, as: :random
      post :send_mail, on: :collection
    end
    root to: "pages#dashboard"
    resources :quotes
  end
  root 'pages#detect_locale'

  # Catch all requests without a available locale and redirect to the PL default...
  # The constraint is made to not redirect a 404 of an existing locale on itself
  get '*path', to: redirect("/#{I18n.default_locale}/%{path}"),
      constraints: { path: %r{(?!(#{I18n.available_locales.join('|')})\/).*} }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
