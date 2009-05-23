class ResponsesController < ApplicationController
  before_filter ensure_application_is_installed_by_facebook_user
  before_filter :setup_db_facebook_user

  # random show
  def index
    @current_user = current_user
    @random_show = Show.find_random_with_no_response_from_user(current_user.id)
    unless @random_show.nil?
      @watching_friends = Response.find_watching_friends(facebook_session.user.friends, @random_show)
    end
  end

  def my_shows
    @responses = Response.alphabetized_responses(current_user.id)
  end

  def invite_friends
    friends = FacebookUser.friends_with_this_app(facebook_session.user.friends)
    @exclude_ids = friends.map(&:id).join(",") 
  end

  def change_response_to_watched
    response = Response.find(params[:id])
    show_id = response.show.id
    response.destroy

    Response.create_watched_response(show_id, current_user.id)

    redirect_to my_shows_path
  end

  # stop watching or delete from watched list
  def remove_response
    Response.find(params[:id]).destroy

    redirect_to my_shows_path
  end

  def add_to_watching
    Response.create_watching_response(params[:show_id], current_user.id)

    redirect_to random_show_path
  end

  def add_to_watched
    Response.create_watched_response(params[:show_id], current_user.id)

    redirect_to random_show_path
  end

  def add_to_never_watch
    Response.create_never_watch_response(params[:show_id], current_user.id)

    redirect_to random_show_path
  end


  protected

  def setup_db_facebook_user
      unless( @fb_user || facebook_params.empty? )

      user_id = facebook_params["user"]
      session_key = facebook_params["session_key"]
      expires = facebook_params["expires"]

      fb_user = FacebookUser.ensure_create_user(user_id)

      if( fb_user.session_key != session_key || fb_user.last_access.nil? || fb_user.last_access < (Date.today.to_time - 1 ))
        fb_user.session_key = session_key
        fb_user.session_expires = expires
        @previous_access = fb_user.last_access
        fb_user.last_access = Date.today
        fb_user.save!
      end
      @fb_user = fb_user
    end
    session[:current_user] = @fb_user
    @fb_user.facebooker_session = (@facebook_session || session[:facebook_session])
    return @fb_user
  end

  def current_user
    @fb_user ||= FacebookUser.find(facebook_session.user.id)
  end
end
