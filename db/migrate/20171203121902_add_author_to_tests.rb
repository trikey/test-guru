class AddAuthorToTests < ActiveRecord::Migration[5.1]
  def change
    add_reference :tests, :author, references: :users, foreign_key: { to_table: :users }
  end
end
