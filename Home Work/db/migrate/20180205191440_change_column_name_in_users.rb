class ChangeColumnNameInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :name, :string, null: false, default: "<unknown_user>"
  end
end
