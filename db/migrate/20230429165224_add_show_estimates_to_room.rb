class AddShowEstimatesToRoom < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :show_estimates, :boolean, default: false
  end
end
