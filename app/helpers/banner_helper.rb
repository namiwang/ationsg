module BannerHelper
  def banner_path(banner)
    url_for(controller: 'products', action: 'show', id: banner.product)
  end
end