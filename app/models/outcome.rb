class Outcome
    attr_accessor :desc, :pr, :pos, :prd

    def initialize(json)
        self.pr= json["pr"]
        self.prd = json["prd"]
        self.desc = json["d"]
        self.pos = json["po"]
    end
end