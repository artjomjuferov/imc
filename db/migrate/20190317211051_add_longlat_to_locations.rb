class AddLonglatToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :longlat, :st_point, geographic: true
    add_index :locations, :longlat, using: :gist
  end
end
