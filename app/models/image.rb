class Image < ActiveRecord::Base
  # associations
  belongs_to :imageable, polymorphic: true

  # paperclip
  has_attached_file :attachment, styles: { large: '800x800', thumb: '100x100>' }, default_url: '/images/missing.png'
  delegate :path, :url, :content_type, :to => :attachment
  
  # validations
  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/

end
