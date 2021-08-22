ActiveAdmin.register UserRequestTag do

  # 全てのカラムの操作を許可
  controller do
    def permitted_params
      params.permit!
    end
  end

end
