class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
    	t.references :user, index: true, default: 0
      t.text :title
      t.boolean :is_daily_topic
      t.integer :agree_votes_override
      t.integer :disagree_votes_override

      t.timestamps
    end
  end
end
