require 'test_helper'

class ShowsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:shows)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_show
    assert_difference('Show.count') do
      post :create, :show => { }
    end

    assert_redirected_to show_path(assigns(:show))
  end

  def test_should_show_show
    get :show, :id => shows(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => shows(:one).id
    assert_response :success
  end

  def test_should_update_show
    put :update, :id => shows(:one).id, :show => { }
    assert_redirected_to show_path(assigns(:show))
  end

  def test_should_destroy_show
    assert_difference('Show.count', -1) do
      delete :destroy, :id => shows(:one).id
    end

    assert_redirected_to shows_path
  end
end
