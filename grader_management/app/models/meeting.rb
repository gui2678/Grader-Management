class Meeting < ApplicationRecord
  belongs_to :section
  belongs_to :instructor
end
