module ShareHelper
  def product_share_url(product, sns_type)
    product_share_link = product_url @product
    case sns_type
    when 'googleplus'
      "https://plus.google.com/share?url=" + product_share_link
    when 'facebook'
      "https://www.facebook.com/sharer/sharer.php?u=" + product_share_link
    end
  end

  def popup_script
    "javascript:(function(ele) { window.open(ele.href, ele.title,'width=800,height=600,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes')})(this); return false;"
  end
end