class CreateStudentPhotos < ActiveRecord::Migration
  def self.up
    create_table :student_photos do |t|
      t.integer    :student_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :student_photos
  end
end
