class Sport 
    attr_accessor(:id, :desc, :pos, :events)

    def initialize(json)
        self.id= json["id"]
        self.pos= json["pos"]
        self.desc = json["desc"]
        self.events = []
    end
end