class AddIndexesToFunctions < ActiveRecord::Migration[5.1]
  def change
    add_index :hubs, :code
  end
end
