module Admin::AdminUsersHelper
    
  def gravatar_for(admin_user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: admin_user.name, class: "gravatar")
  end
  

end