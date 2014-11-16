class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :topic, index: true
      t.references :user, index: true, default: 0
      t.boolean :is_agree, index: true
      t.integer :reply_to, default: 0
      t.integer :votes_count, default: 0

      t.timestamps
    end

    Comment.find_each do |result|
      Comment.reset_counters(result.id, :comments)
    end
  end
end
