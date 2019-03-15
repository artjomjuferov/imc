class CreateHubs < ActiveRecord::Migration[5.1]
  def change
    create_table :hubs do |t|
      t.references :country, foreign_key: true
      t.string :status
      t.string :name
      t.string :name_wo_diacritics
      t.date :uploaded_date
      t.string :iata
      t.string :remark
      t.string :change_code
      t.string :subdiv

      t.timestamps
    end
  end
end
