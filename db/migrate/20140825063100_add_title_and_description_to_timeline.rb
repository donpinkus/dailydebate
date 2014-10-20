class AddTitleAndDescriptionToTimeline < ActiveRecord::Migration
  def change
    add_column :timelines, :title, :string
    add_column :timelines, :description, :text
  end
end
