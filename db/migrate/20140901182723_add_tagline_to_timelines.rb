class AddTaglineToTimelines < ActiveRecord::Migration
  def change
    add_column :timelines, :tagline, :string
  end
end
