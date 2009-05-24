class ResponseObserver < ActiveRecord::Observer

  def after_create(response)
    response.facebook_user.set_profile_info("TV Addict", info_fields(response.facebook_user), :text)
  end

  def after_destroy(response)
    response.facebook_user.set_profile_info("TV Addict", info_fields(response.facebook_user), :text)
  end

  def info_fields(user)
    [{:field => "What I'm Watching", 
      :items => watching_list(Response.alphabetized_responses(user.id))}]
  end

  def watching_list(responses) 
    list = []
    for response in responses
      if response.status == "watching"
        if response.show.imdb_url && response.show.imdb_url.length > 0
          list << {:label => response.show.name,
                   :link => response.show.imdb_url.to_s}
        else
          list << {:label => response.show.name, 
                   :link => "http://www.google.com/search?q=#{response.show.name}"}
        end
      end
    end
    list
  end

  def watched_list(responses) 
    list = []
    for response in responses
      if response.status == "watched"
        if response.show.hulu_url.length > 0
          list << {:label => response.show.name, :link => "http://www.hulu.com/#{response.show.hulu_url}"}  
        else
          list << {:label => response.show.name, :link => "http://www.google.com/search?q=#{response.show.name}"}
        end
      end
    end
    list
  end

end
