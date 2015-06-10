module Refinery
  module Announces
    class Announce < Refinery::Core::BaseModel
      self.table_name = 'refinery_announces'


      validates :title, :presence => true, :uniqueness => true

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

    end
  end
end
