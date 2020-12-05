class RenamePartyColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :parties, :duration, :party_duration
    rename_column :parties, :start_time, :time
  end
end
