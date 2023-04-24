class CreateToDo < ActiveRecord::Migration[7.0]
  def change
    create_table :to_dos do |t|
      t.string :title
      t.string :body
      t.date :end_date

      t.timestamps
    end
  end
end
