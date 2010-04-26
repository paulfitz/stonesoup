require 'test_helper'

class MemberOrgsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:member_orgs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member_org" do
    assert_difference('MemberOrg.count') do
      post :create, :member_org => { }
    end

    assert_redirected_to member_org_path(assigns(:member_org))
  end

  test "should show member_org" do
    get :show, :id => member_orgs(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => member_orgs(:one).id
    assert_response :success
  end

  test "should update member_org" do
    put :update, :id => member_orgs(:one).id, :member_org => { }
    assert_redirected_to member_org_path(assigns(:member_org))
  end

  test "should destroy member_org" do
    assert_difference('MemberOrg.count', -1) do
      delete :destroy, :id => member_orgs(:one).id
    end

    assert_redirected_to member_orgs_path
  end
end
