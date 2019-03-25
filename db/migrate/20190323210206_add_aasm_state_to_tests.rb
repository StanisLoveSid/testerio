class AddAasmStateToTests < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :aasm_state, :string
  end
end
