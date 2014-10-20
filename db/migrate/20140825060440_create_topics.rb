class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
    	t.references :user, index: true, default: 0
      t.references :category
      t.text :title

      t.timestamps
    end
  end
end
