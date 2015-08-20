ActiveAdmin.register V1::Buyer do
  permit_params :name, :phone

  form do |f|
    f.inputs "Buyer Details" do
      f.input :name
      f.input :phone
    end
    f.actions
  end
end
