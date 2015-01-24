class AddCommentToDropIns < ActiveRecord::Migration
  def change
    add_column :drop_ins, :comment, :text
  end
end
