class ApplicationController < ActionController::Base

    # ログインに成功しないとtopページ以外へのアクセスができないようにする
    # before_action :authenticate_user!,except: [:top]


    before_action :configure_permitted_parameters, if: :devise_controller?

    # protect_from_forgery
    protected
    # protect_from_forgery with: :null_session

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :university, :grade])
    end

    def move_to_signed_in
        # userがサインインしているかチェック
        unless user_signed_in?
            flash[:notice] = t("must_login")
            #サインインしていないユーザーはログインページが表示される
            redirect_to  new_user_session_path
        end
    end
end
