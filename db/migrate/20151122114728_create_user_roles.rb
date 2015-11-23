class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.string :name

      t.timestamps
    end

    add_index :user_roles, :name, unique: true
  end
end
