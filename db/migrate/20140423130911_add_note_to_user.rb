class AddNoteToUser < ActiveRecord::Migration
  def change
  add_column :users, :usr_note, :string
  end
end
