class AddLabelRefToLabellings < ActiveRecord::Migration[6.1]
  def change
    add_reference :labellings, :label, foreign_key: true
  end
end
