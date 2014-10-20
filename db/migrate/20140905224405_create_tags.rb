class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
    	t.string :name
      t.text :description
      t.integer :timeline_tags_count, default: 0, null: false
      
      t.timestamps
    end
  end
end
