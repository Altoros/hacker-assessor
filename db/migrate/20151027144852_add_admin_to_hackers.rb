class AddAdminToHackers < ActiveRecord::Migration
  def change
    add_column :hackers, :admin, :boolean, default: false, null: false
  end
end
