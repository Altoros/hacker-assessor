class AddSeniorityToHackers < ActiveRecord::Migration
  def change
    add_column :hackers, :seniority, :integer, default: 0, null: false
  end
end
