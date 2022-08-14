class Event
    attr_accessor(:id, :desc, :pos, :comp_desc, :outcomes)
    def initialize(comp_desc, comp_pos, json)
        self.id= json["id"]
        self.pos= comp_pos
        self.comp_desc = comp_desc
        self.desc = json["desc"]
        self.outcomes = []
    end
    

    def self.init_events_array(json)
        events = []
        json.each do |event|
            comp_desc = event["desc"]
            comp_pos = event["pos"]
            event["events"].each do |ev|
                event_obj = Event.new(comp_desc, comp_pos, ev)
                ev["markets"].each do |m|
                    #market = Market.new(m)
                    m["o"].each do |outcome|
                        event_obj.outcomes.push Outcome.new(outcome)
                    end
                end
                events.push event_obj
            end
        end
        events
    end
end