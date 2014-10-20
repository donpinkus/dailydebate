class Tag < ActiveRecord::Base
	has_many :timeline_tags
	has_many :timelines, through: :timeline_tags
end
