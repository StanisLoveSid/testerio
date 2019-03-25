class AddTestGroupToTest < ActiveRecord::Migration[5.2]
  def change
    add_reference :tests, :test_group, foreign_key: true
  end
end
