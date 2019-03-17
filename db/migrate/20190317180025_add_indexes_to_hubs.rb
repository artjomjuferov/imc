class AddIndexesToHubs < ActiveRecord::Migration[5.1]
  def change
    add_index :hubs, :change_code
    add_index :hubs, :status
    add_index :hubs, :unlocode
    add_index :hubs, :name_wo_diacritics

    execute('CREATE INDEX hubs_name_wo_diacritics_idx  ON hubs USING gin (name_wo_diacritics gin_trgm_ops);')
  end
end
