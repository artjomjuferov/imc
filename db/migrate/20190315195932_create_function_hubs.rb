class CreateFunctionHubs < ActiveRecord::Migration[5.1]
  def change
    create_table :function_hubs do |t|
      t.references :hub, foreign_key: true
      t.string :code

      t.timestamps
    end
  end
end
