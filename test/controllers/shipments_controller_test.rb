require 'test_helper'

class ShipmentsControllerTest < ActionController::TestCase
  setup do
    @shipment = shipments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shipments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shipment" do
    assert_difference('Shipment.count') do
      post :create, shipment: { address1: @shipment.address1, address2: @shipment.address2, city: @shipment.city, company: @shipment.company, expected_delivery_date: @shipment.expected_delivery_date, notification: @shipment.notification, packages: @shipment.packages, recipient: @shipment.recipient, refrence: @shipment.refrence, ship_date: @shipment.ship_date, signature: @shipment.signature, state: @shipment.state, tmx: @shipment.tmx, tracking: @shipment.tracking, zipcode: @shipment.zipcode }
    end

    assert_redirected_to shipment_path(assigns(:shipment))
  end

  test "should show shipment" do
    get :show, id: @shipment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shipment
    assert_response :success
  end

  test "should update shipment" do
    patch :update, id: @shipment, shipment: { address1: @shipment.address1, address2: @shipment.address2, city: @shipment.city, company: @shipment.company, expected_delivery_date: @shipment.expected_delivery_date, notification: @shipment.notification, packages: @shipment.packages, recipient: @shipment.recipient, refrence: @shipment.refrence, ship_date: @shipment.ship_date, signature: @shipment.signature, state: @shipment.state, tmx: @shipment.tmx, tracking: @shipment.tracking, zipcode: @shipment.zipcode }
    assert_redirected_to shipment_path(assigns(:shipment))
  end

  test "should destroy shipment" do
    assert_difference('Shipment.count', -1) do
      delete :destroy, id: @shipment
    end

    assert_redirected_to shipments_path
  end
end
