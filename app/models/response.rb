class Response < ActiveRecord::Base
  belongs_to :facebook_user
  belongs_to :show

  WATCHING = "watching"
  WATCHED = "watched" #deprecated sorta
  NEVER_WATCH = "never watch"

  def self.alphabetized_responses(user_id)
    responses = find_all_by_facebook_user_id(user_id, :include => "show")
    responses.sort! { |a,b| a.show.name.downcase <=> b.show.name.downcase }
  end

  def self.find_watching_friends(friends, show)
    responses = find(:all, :conditions => {:status => WATCHING, :show_id => show.id}, :include => :facebook_user)

    watchers = []

    for response in responses
      for friend in friends
        if response.facebook_user.uid == friend.id
          watchers << friend 
        end
      end
    end 
    watchers
  end

  def self.create_watching_response(show_id, user_id)
    response = Response.new
    response.show_id = show_id
    response.facebook_user_id = user_id
    response.status = WATCHING
    response.save
  end

  def self.create_never_watch_response(show_id, user_id)
    response = Response.new
    response.show_id = show_id
    response.facebook_user_id = user_id
    response.status = NEVER_WATCH
    response.save
  end
end
