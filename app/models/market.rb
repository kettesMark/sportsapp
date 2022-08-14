class Market
    attr_accessor :id, :pos, :desc, :outcome_keys, :outcomes
    def initialize(json, markets_map)
        self.id= json["mtid"]
        self.pos= markets_map[json["mtid"]]["pos"]
        self.outcome_keys = markets_map[json["mtid"]]["outcome_keys"]
        self.desc = json["desc"]
        self.outcomes = []
    end

    def self.create_markets_map(json)
        markets_map = {}
        json.each do |m_type|
            markets_map[m_type["mtId"]] = {"pos"=> m_type["pos"], "outcome_keys"=> m_type["outcome_keys"]}
        end
        markets_map
    end
end