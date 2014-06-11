ActiveAdmin.register Banner do

  permit_params :product_id,
    images_attributes: [:id, :attachment]

  form partial: 'form'

  index do
    column :id
    column :product
    actions
  end

  show do |banner|
    panel 'Info' do
      attributes_table_for banner do
        row :product
      end
    end

    panel 'Image' do
      if banner.images.size > 0
        table_for banner.images do
          column 'Image' do |image|
            image_tag image.url
          end
        end
      end
    end
  end


end
