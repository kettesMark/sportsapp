module Deserialization extend ActiveSupport::Concern

    def deserialize(json_elem)
        self.attribs.each do |aname|
            self.send "#{aname}=", json_elem["#{aname}"]
        end
    end
end
