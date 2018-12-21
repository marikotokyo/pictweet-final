class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  # deviseは初期状態でサインアップ時にメールアドレスとパスワードのみを受け取るようにストロングパラメータが設定されているので、追加のパラメータを許可したい場合は、before_actionにconfigure_permitted_parametersメソッドを設定する。
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  #sign_upアクションに対してnicknameというキーのパラメータを追加で許可する

end
