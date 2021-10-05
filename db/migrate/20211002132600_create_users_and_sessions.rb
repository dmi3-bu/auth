class CreateUsersAndSessions < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'citext'

    create_table :users do |t|
      t.string :name, null: false
      t.citext :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.timestamps
    end

    create_table :user_sessions do |t|
      t.uuid :uuid, null: false, index: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
