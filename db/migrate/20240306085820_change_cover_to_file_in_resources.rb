class ChangeCoverToFileInResources < ActiveRecord::Migration[7.1]
  def change
    rename_column :resources, :cover, :file
  end
end
