class CreateTimelines < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
    	t.references :user, index: true, default: 0

      t.timestamps
    end
  end
end
