class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.boolean :is_subscribed

      t.timestamps
    end
  end
end
