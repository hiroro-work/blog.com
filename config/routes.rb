Rails.application.routes.draw do
  root 'blogs#index'
  get '/blogs/:blog_id/entries/:entry_id/comments' => redirect('/blogs/:blog_id/entries/:entry_id')
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
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
