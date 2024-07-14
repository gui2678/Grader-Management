class GraderApplication < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :section
end
