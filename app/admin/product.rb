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

  permit_params :name, :description, :price, :ribbon,
    :category_id, 
    images_attributes: [:_destroy, :id, :attachment]

  # form
  form partial: 'form'

  # show 
  show do |product|
    panel 'Info' do
      attributes_table_for product do
        row :name
        row :price
        row :ribbon
        row :description do
          pre do
            raw product.description
          end
        end
      end
    end

    panel 'Association' do
      attributes_table_for product do
        row :category
      end
    end

    panel 'Images' do
      if product.images.size > 0
        table_for product.images do
          column 'Image' do |image|
            image_tag image.url
          end
        end
      end
    end
  end

  # index
  index do
    column :name
    column :price
    column :category
    column :ribbon
    actions
  end

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
