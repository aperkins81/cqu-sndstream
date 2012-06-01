module UsersHelper
  
  # Display gravatar?
  # TODO: make this a menu option, store pref in db.
  def display_gravatar?
    #Rails.env.production?
    #false
    true
  end
  
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 100 })
    return nil unless display_gravatar?
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar", size: size)
  end
  
  
end
