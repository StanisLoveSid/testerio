class AddPassLinkAndUnpassedLinkToTest < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :pass_link, :text
    add_column :tests, :unpassed_link, :text
  end
end
