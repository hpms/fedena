class CreateArchivedStudentPhotos < ActiveRecord::Migration
  def self.up
    create_table :archived_student_photos do |t|
      t.integer    :archived_student_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :archived_student_photos
  end
end
