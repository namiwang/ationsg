# due to an issue of turbolinks, inline style background image dont show up in chrome if comes in another link(or say, without ctrl+f5)
# https://www.google.com/search?q=turbolink+background+image
module BackgroundImageHelper
  def background_image_url url
    "#{request.protocol}#{request.host_with_port}#{url}"
  end
end