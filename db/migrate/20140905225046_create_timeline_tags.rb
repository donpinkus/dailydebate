class CreateTimelineTags < ActiveRecord::Migration
  def change
    create_table :timeline_tags do |t|
      t.references :timeline, index: true
      t.references :tag, index: true

      t.timestamps
    end

    Tag.find_each do |result|
      Tag.reset_counters(result.id, :timeline_tags)
    end
  end
end
