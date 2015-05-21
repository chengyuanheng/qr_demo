class CreateFileUploadTable < ActiveRecord::Migration
  def change
    create_table :file_uploads do |t|
      t.string :name
      t.string :address
      t.string :file_type

      t.timestamp
    end
  end
end
