class CreateResources < ActiveRecord::Migration[7.1]
  def change
    create_table :resources do |t|
      t.references :post, null: false, foreign_key: true
      t.string :cover

      t.timestamps
    end
  end
end
