class Timeline < ActiveRecord::Base
	belongs_to :user
	
	has_many :events

	has_many :timeline_tags
	has_many :tags, through: :timeline_tags

	validates_length_of :title, :minimum => 3, :maximum => 50
	validates_length_of :tagline, :minimum => 10, :maximum => 100

	def render_description
		renderer = WikiRender.new(filter_html: true, hard_wrap: true)
		markdown = Redcarpet::Markdown.new(renderer, autolink: true, no_intra_emphasis: true)
		markdown.render(self.description)
	end
end

