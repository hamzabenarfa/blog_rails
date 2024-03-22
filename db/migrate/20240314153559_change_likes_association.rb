class ChangeLikesAssociation < ActiveRecord::Migration[7.1]
  def change
    remove_index :likes, name: "index_likes_on_record"
    remove_column :likes, :record_type
    remove_column :likes, :record_id

    add_column :likes, :post_id, :integer
    add_index :likes, :post_id
  end
end
