class SetupGraderApplicationSchema < ActiveRecord::Migration[7.0]
  def change
    # Remove the line below to avoid creating the sections table again
    # create_table :sections do |t|
    #   t.string :class_number
    #   t.string :component
    #   t.time :start_time
    #   t.time :end_time
    #   t.string :days
    #   t.references :course, foreign_key: true
    #   t.timestamps
    # end

    # Make sure to add the necessary columns if they are not already in the sections table
  end
end
