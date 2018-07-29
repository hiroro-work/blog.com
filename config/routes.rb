Rails.application.routes.draw do
  resources :blogs do
    resources :entries, expect: [:index] do
        resources :comments, expect: [:index, :show, :edit, :update] do
          member do
            patch 'approve'
          end
        end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
