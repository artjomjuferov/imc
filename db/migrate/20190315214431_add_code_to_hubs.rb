class AddCodeToHubs < ActiveRecord::Migration[5.1]
  def change
    add_column :hubs, :code, :string
  end
end
