ActiveAdmin.register Card do
  # index
  index do
    column :id
    column :user
    column :balance do |card|
      to_sg_dollar card.balance
    end
  end
end
