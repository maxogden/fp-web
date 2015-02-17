# == Schema Information
#
# Table name: snapshots
#
#  id                :string(8)        not null, primary key
#  print_id          :string(8)
#  print_page_number :string(5)        not null
#  print_href        :text(65535)
#  min_row           :float(24)
#  min_column        :float(24)
#  min_zoom          :integer
#  max_row           :float(24)
#  max_column        :float(24)
#  max_zoom          :integer
#  description       :text(65535)
#  is_private        :string(3)        default("no")
#  will_edit         :string(3)        default("yes")
#  has_geotiff       :string(3)        default("no")
#  has_geojpeg       :string(3)        default("no")
#  has_stickers      :string(3)        default("no")
#  base_url          :string(255)
#  uploaded_file     :string(255)
#  geojpeg_bounds    :text(65535)
#  decoding_json     :text(65535)
#  country_name      :string(64)
#  country_woeid     :integer
#  region_name       :string(64)
#  region_woeid      :integer
#  place_name        :string(128)
#  place_woeid       :integer
#  user_id           :string(8)
#  created_at        :datetime         default("CURRENT_TIMESTAMP"), not null
#  decoded_at        :datetime         default("0000-00-00 00:00:00"), not null
#  failed            :integer          default("0")
#  progress          :float(24)
#  updated_at        :datetime
#

require 'test_helper'

class SnapshotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end