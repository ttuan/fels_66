module UsersHelper

  def gravatar_for user, options = {size: Settings.image_size}
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    
    gravatar_url = if user.picture? 
      user.picture.url
    else 
      "https://secure.gravatar.com/avatar/#{gravatar_id}" 
    end
    image_tag(gravatar_url, alt: user.name, class: "gravatar", size: "#{size}x#{size}")
  end
  
end