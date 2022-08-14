require "test_helper"

class SportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sports_index_path
    assert_response :success
  end

  test "get sports index returns structured response" do
    get sports_index_path
    response.parsed_body
    assert ((response.parsed_body[0].has_key? "events") && (response.parsed_body[0]["events"][0].has_key? "outcomes"))
  end

  test "all_sports url" do
    get '/sports'
    assert_response :success
  end

  test "all_events_for_sport url" do
    get '/sports'
    sport_id = response.parsed_body[0]["id"]
    get "/sports/#{sport_id}"
    assert_response :success
  end

  test "all_outcomes_for_event url" do
    get '/sports/100'
    event_id = response.parsed_body[0]["id"]
    get "/sports/100/events/#{event_id}"
    assert_response :success
  end
end
