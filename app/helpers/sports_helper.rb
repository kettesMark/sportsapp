module SportsHelper
    require './lib/api_data.rb'
    def self.get_sports_data
        Rails.cache.fetch("api_data", expires_in: 1.minute) do
            resp = ApiData.new.get_data
            data = [].tap do |e| 
                resp["sports"].each do |sport_el|
                    sport = Sport.new(sport_el)
                    #markets_map = Market.create_markets_map(sport_el["marketTypes"])
                    sport.events = Event.init_events_array(sport_el["comp"])
                    e << sport
                end
                e
            end
        end
    end

end
