class CreateArchivedEmployeePhotos < ActiveRecord::Migration
  def self.up
    create_table :archived_employee_photos do |t|
      t.integer    :archived_employee_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :archived_employee_photos
  end
end
