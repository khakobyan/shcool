class CreateClassrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :classrooms do |t|
      t.string :name
      t.references :school, null: false, foreign_key: true
    end
  end
end
