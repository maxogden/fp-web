# == Schema Information
#
# Table name: snapshots
#
#  id             :integer          not null, primary key
#  slug           :string(8)        not null
#  user_id        :integer
#  page_id        :integer
#  print_href     :text(65535)
#  min_row        :float(24)
#  max_row        :float(24)
#  min_column     :float(24)
#  max_column     :float(24)
#  min_zoom       :integer
#  max_zoom       :integer
#  description    :text(4294967295)
#  private        :boolean          default("0"), not null
#  has_geotiff    :string(3)        default("no")
#  has_geojpeg    :string(3)        default("no")
#  base_url       :string(255)
#  uploaded_file  :string(255)
#  geojpeg_bounds :text(65535)
#  decoding_json  :text(65535)
#  country_name   :string(64)
#  country_woeid  :integer
#  region_name    :string(64)
#  region_woeid   :integer
#  place_name     :string(128)
#  place_woeid    :integer
#  failed         :integer          default("0")
#  progress       :float(24)
#  created_at     :datetime
#  updated_at     :datetime
#  decoded_at     :datetime
#

class Snapshot < ActiveRecord::Base
  # kaminari (pagination) configuration

  paginates_per 50

  # relations

  belongs_to :uploader,
    class_name: "User",
    foreign_key: :user_id

  belongs_to :page
  has_one :atlas, through: :page

  # scopes

  default_scope {
    includes([:atlas, :page, :uploader])
      .joins(:atlas)
      .where("#{self.table_name}.page_id IS NOT NULL AND #{self.table_name}.private = false AND #{Atlas.table_name}.private = false")
      .order("#{self.table_name}.created_at DESC")
  }

  scope :date,
    -> date {
      where("DATE(created_at) = ?", date)
    }

  scope :month,
    -> month {
      where("CONCAT(YEAR(created_at), '-', LPAD(MONTH(created_at), 2, '0')) = ?", month)
    }

  scope :place,
    -> place {
      where("place_woeid = ? OR region_woeid = ? OR country_woeid = ?", place, place, place)
    }

  scope :user,
    -> user {
      where(user_id: user)
    }

  # instance methods

  def title
    "Page #{page.page_number} of #{atlas.title}"
  end

  def uploader_name
    uploader && uploader.username || "anonymous"
  end
end
