class CreateHeaders < ActiveRecord::Migration
  def change
    create_table :headers do |t|
      t.string :github_username
      t.string :title
      t.string :tagline
      t.text :intro
    end
  end
end
