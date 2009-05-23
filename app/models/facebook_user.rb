class FacebookUser < ActiveRecord::Base
  has_many :responses

  def self.friends_with_this_app(friends)
    list = []
    for friend in friends
      for user in FacebookUser.find(:all)
        if user.uid == friend.id
          list << friend  
        end
      end
    end
    list
  end

  attr_accessor :facebooker_user

  def facebooker_user
    @facebooker_user ||= facebooker_session.user
  end

  attr_accessor :facebooker_session

  def facebooker_session
    unless(@facebooker_session)
      @facebooker_session = Facebooker::Session.create(ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_SECRET_KEY'])
      @facebooker_session.secure_with!(self.session_key,self.uid,0)
      @facebooker_session.user.uid = self.uid
    end
    @facebooker_session
  end

  def self.ensure_create_user(uid)
    user = nil
    begin
      user = self.find_or_initialize_by_uid(uid)
      if(user.new_record?)
        user.save!
      end
    rescue
      user = self.find_or_initialize_by_uid(uid)
      if(user.new_record?)
        user.save!
      end
    end
    raise "DidntCreateFBUser" unless user
    return user
  end

  def method_missing(symbol , *args)
    begin
      value = super
    rescue NoMethodError => err
      if(facebooker_user.respond_to?(symbol))
        value = facebooker_user.send(symbol,*args)
        return value
      else
        throw err
      end
    end
  end

end
