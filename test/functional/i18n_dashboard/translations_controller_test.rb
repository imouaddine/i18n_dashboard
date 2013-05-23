require 'test_helper'

module I18nDashboard
  class TranslationsControllerTest < ActionController::TestCase

    test "should get index" do
      get :index, use_route: :i18n_dashboard
      assert_response :success
      assert_not_nil assigns(:translations)
    end

    test "should post create as HTML" do
      post :create, key: 'test.lol', value: 'lol', locale: 'es', use_route: :i18n_dashboard, format: :html
      assert_redirected_to i18n_dashboard_root_path
    end

    test "should post create as JS" do
      post :create, key: 'test.lol', value: 'lol', locale: 'es', use_route: :i18n_dashboard, format: :js
      assert_not_nil assigns(:digest)
      assert_response :success
    end

    test "should delete destroy as HTML" do
      delete :destroy, use_route: :i18n_dashboard, format: :html
      assert_redirected_to i18n_dashboard_root_path

    end

    test "should delete destroy as JS" do
      delete :destroy, use_route: :i18n_dashboard, format: :js
      assert_response :success
    end

  end
end
