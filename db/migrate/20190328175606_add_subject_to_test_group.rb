class AddSubjectToTestGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :test_groups, :subject_id, :integer
  end
end
