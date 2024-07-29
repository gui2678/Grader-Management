class DropGraderApplications < ActiveRecord::Migration[7.0]
  def up
    drop_table :grader_applications
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
