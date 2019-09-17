Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :user
  resources :product
  resources :charges
  resources :orders
  
get 'carts/:id' => "carts#show", as: "cart"
delete 'carts/:id' => "carts#destroy"
post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
post 'line_items' => "line_items#create"
get 'line_items/:id' => "line_items#show", as: "line_item"
get 'thanks', to: 'charges#thanks', as: 'thanks'
delete 'line_items/:id' => "line_items#destroy"
root to: "home#home"
end
