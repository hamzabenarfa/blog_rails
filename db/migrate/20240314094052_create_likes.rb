class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.references :record, polymorphic: true, null: false
      

      t.timestamps
    end
  end
end
