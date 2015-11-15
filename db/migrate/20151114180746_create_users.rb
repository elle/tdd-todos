class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :twitter_name
      t.string :github_name
      t.string :url
      t.string :avatar_image_name
      t.text :bio

      t.timestamps null: false
    end
  end
end
