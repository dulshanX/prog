class CreateLab11Results < ActiveRecord::Migration[5.1]
  def change
    create_table :lab11_results do |t|
      t.float :a
      t.text :result

      t.timestamps
    end
  end
end
