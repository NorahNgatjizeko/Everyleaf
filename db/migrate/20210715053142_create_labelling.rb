class CreateLabelling < ActiveRecord::Migration[6.1]
  def change
    create_table :labellings do |t|

      t.timestamps
    end
  end
end
