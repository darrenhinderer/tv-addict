class Show < ActiveRecord::Base
  has_many :responses

  validates_presence_of :name 

  def self.find_random_with_no_response_from_user(user_id)
    shows = find(:all)
     
    list = []
  
    for show in shows
      found_response = false

      for response in show.responses
        if response.facebook_user_id == user_id
          found_response = true  
        end
      end

      if !found_response
        list << show
      end
    end

    return random(list)
  end

  def self.random(list)
    if list.empty?
      return nil
    end 

    return list[rand(list.size)]
  end
end
