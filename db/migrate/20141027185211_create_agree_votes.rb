class CreateAgreeVotes < ActiveRecord::Migration
  def change
    create_table :agree_votes do |t|
      t.references :user, index: true
      t.references :topic, index: true
      t.boolean :is_agree

      t.timestamps
    end
  end
end
