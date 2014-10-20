class CreateTopicCategories < ActiveRecord::Migration
  def change
    create_table :topic_categories do |t|
      t.references :topic, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
