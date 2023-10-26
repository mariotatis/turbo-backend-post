ActiveAdmin.register User do
  # Specify the columns to display in the index page
  index do
    selectable_column
    id_column
    column :email
    column :name
    column :created_at
    column :updated_at
    actions
  end

  # Specify the filters for the index page
  filter :name, as: :string, label: 'Name'
  filter :email, as: :string, label: 'Email'

  # Other configurations and actions...
end