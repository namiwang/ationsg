ActiveAdmin.register Product do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  permit_params :name, :description, images_attributes: [:_destroy, :id, :attachment]

  form partial: 'form'

  # form do |f|
  #   f.inputs "Info" do
  #     f.input :name
  #     f.input :description
  #   end
  #   f.inputs "Associations" do
  #     # category
  #   end
  #   f.inputs do
  #     f.has_many :images, allow_destroy: true, heading: 'Images' do |image|
  #       if image.object.new_record?
  #         image.input :attachment, as: :file
  #       else
  #         binding.pry
  #         image.input :_destroy, as: :boolean, label: 'Delete?', required: false
  #         # TODO, this boolean input checkbox wont show in html, dont konw why
  #         image_tag image.object.attachment.url
  #       end
  #     end
  #   end
  #   f.actions
  # end

end
