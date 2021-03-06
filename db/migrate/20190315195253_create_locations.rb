class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.float :lat
      t.float :long
      t.references :hub, foreign_key: true

      t.timestamps
    end
  end
end
