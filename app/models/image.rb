class Image < ActiveRecord::Base
  # associations
  belongs_to :imageable, polymorphic: true

  # paperclip
  has_attached_file :attachment, default_url: '/images/missing.png'
  delegate :path, :url, :content_type, :to => :attachment
  
  # validations
  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/

end
