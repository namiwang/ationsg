ActiveAdmin.register Banner do

  permit_params :path,
    image_attributes: [:attachment]

  form partial: 'form'

end
