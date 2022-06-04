require "test_helper"

class Public::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get follow" do
    get public_relationships_follow_url
    assert_response :success
  end

  test "should get unfollow" do
    get public_relationships_unfollow_url
    assert_response :success
  end
end
