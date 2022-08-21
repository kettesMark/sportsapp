class Outcome
    attr_accessor :desc, :pr, :pos, :prd, :id

    def initialize(json)
        self.id = json["cpid"]
        self.pr= json["pr"]
        self.prd = json["prd"]
        self.desc = json["d"]
        self.pos = json["po"]
    end
end