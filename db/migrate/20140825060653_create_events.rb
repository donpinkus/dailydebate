class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :date, :default => Time.now
      t.string :title
      t.text :content
      t.string :image
      t.text :caption
      t.references :timeline, index: true
      t.references :user, index: true, default: 0
      
      t.timestamps
    end
  end
end
