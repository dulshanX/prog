class AddUserToActs < ActiveRecord::Migration[5.1]
  def change
    add_reference :acts, :user, foreign_key: true
  end
end
