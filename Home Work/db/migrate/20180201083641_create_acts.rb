class CreateActs < ActiveRecord::Migration[5.1]
  def change
    create_table :acts do |t|
      t.date :date
      t.decimal :value, :precision => 4, :scale => 2
      t.string :name
      t.text :desc
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
