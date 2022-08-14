require "test_helper"

class SportsHelperTest < ActionDispatch::IntegrationTest
  test "get_sports_data returns an array" do
    ret = SportsHelper.get_sports_data
    assert ((ret.respond_to? :push) && (ret.respond_to? :unshift))
  end

  test "if return value of get_sports_data is not empty, it's an array of Sport objects" do
    ret = SportsHelper.get_sports_data
    assert ((ret.size == 0) || (ret[0].instance_of? Sport))
  end

  test "get_sports_data returns a well defined structured data" do
    ret = SportsHelper.get_sports_data
    assert ((ret.size == 0) || ((ret[0].instance_of? Sport) && (ret[0].events[0].instance_of? Event) && (ret[0].events[0].outcomes[0].instance_of? Outcome)))
  end
end