class TimelineTag < ActiveRecord::Base
  belongs_to :timeline
  belongs_to :tag, counter_cache: true
end
