ActiveAdmin.register Banner do

  permit_params :path,
    images_attributes: [:id, :attachment]

  form partial: 'form'

  show do |banner|
    panel 'Info' do
      attributes_table_for banner do
        row :path
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
