ActionController::Routing::Routes.draw do |map|
  map.resources :shows

  map.root :controller => "responses", :conditions => { :canvas => true }
  map.root :controller => "welcome"
  map.search_series "search_series", :controller => "shows", :action => "search"

  map.random_show "random_show", :controller => "responses", :conditions => { :canvas => true }
  map.my_shows "my_shows", :controller => "responses", :action => "my_shows", :conditions => { :canvas => true }
  map.add_to_watching "add_to_watching", :controller => "responses", :action => "add_to_watching", :conditions => { :canvas => true }
  map.add_to_watched "add_to_watched", :controller => "responses", :action => "add_to_watched", :conditions => { :canvas => true }
  map.add_to_never_watch "add_to_never_watch", :controller => "responses", :action => "add_to_never_watch", :conditions => { :canvas => true }

  map.invite_friends( "invite_friends", :controller => "responses", :action => "invite_friends", :conditions => {:canvas => true})

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
