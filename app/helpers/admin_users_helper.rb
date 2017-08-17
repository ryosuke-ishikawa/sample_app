module AdminUsersHelper
    
  # 該当ユーザーのメールアドレスに対応するGravatarの画像URLを返す
  def gravatar_for(admin_user)
    gravatar_id = Digest::MD5::hexdigest(admin_user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: admin_user.name, class: "gravatar")
  end
end    
