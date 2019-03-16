class AddUnlocodeToHubs < ActiveRecord::Migration[5.1]
  def change
    add_column :hubs, :unlocode, :string
  end
end
