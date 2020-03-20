# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'best_news#index'
  get 'best_news', to: 'best_news#news'
  get 'preview', to: 'best_news#preview'
  get 'detail', to: 'best_news#detail'
end
