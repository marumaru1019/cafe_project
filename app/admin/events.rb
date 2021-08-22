ActiveAdmin.register Event do
  permit_params :name, :date, :time_id, :recommend_menu,
  :recommend_menu_price, :place,:adress, :max_num, :comment, :store_url,
  :image, :quote

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :name
      f.input :date
      f.input :time_id,  as: :select, collection: TimeTable.all.map { |c| [c.id, {"data-category" => c}]}
      f.input :recommend_menu
      f.input :recommend_menu_price
      f.input :place
      f.input :adress
      f.input :max_num
      f.input :image, as: :file
      f.input :comment
      f.input :store_url
      f.input :quote
      f.actions
    end
  end

  show do
    attributes_table do
      row :name
      row :date
      row :time_id
      row :recommend_menu
      row :recommend_menu_price
      row :place
      row :adress
      row :max_num
      row :comment
      row :store_url
      row :image do |ad|
        image_tag url_for(ad.image)
      end
      row :quote
      active_admin_comments
    end
  end
end