class RenameFunctionHubsToFunctions < ActiveRecord::Migration[5.1]
  def change
    rename_table :function_hubs, :functions
  end
end
