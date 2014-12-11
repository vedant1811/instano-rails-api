ActiveAdmin.register V1::CategoryName do
  permit_params :name, :variants => [], brand_names: [ :name ]

  index do
    column :name
    column :variants
    column :brands do |b|
      # print brand names, maybe comma separated
    end
    actions
  end

#   show do |cs|
#     attributes_table do
#       row :brand_names do |c|
#         c.has_many :brand_names do |b|
#           b.name
#         end
#       end
#     end
#   end
#
#   form do |f|
#     f.inputs "Brands" do
#       f.has_many :brand_names, heading: false, allow_destroy: true do |b|
#         b.input :name
#       end
#     end
#     f.actions
#   end
end
