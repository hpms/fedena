class CreateSchoolDetailLogos < ActiveRecord::Migration
  def self.up
    create_table :school_detail_logos do |t|
      t.integer    :school_detail_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :school_detail_logos
  end
end
