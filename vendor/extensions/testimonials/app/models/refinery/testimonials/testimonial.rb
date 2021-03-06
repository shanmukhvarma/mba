module Refinery
  module Testimonials
    class Testimonial < Refinery::Core::BaseModel
      self.table_name = 'refinery_testimonials'


      validates :name, :presence => true, :uniqueness => true

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

    end
  end
end
