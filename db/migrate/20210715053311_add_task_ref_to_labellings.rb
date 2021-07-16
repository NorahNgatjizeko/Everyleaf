class AddTaskRefToLabellings < ActiveRecord::Migration[6.1]
  def change
    add_reference :labellings, :task, foreign_key: true
  end
end
