class AddEstimateToRoom < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :estimates, :string, null: false
  end
end
