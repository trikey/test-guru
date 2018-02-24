class AddTimeToTests < ActiveRecord::Migration[5.1]
  def change
    add_column :tests, :time, :integer, default: 15
  end
end
