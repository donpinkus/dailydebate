class Topic < ActiveRecord::Base
	belongs_to :user

	has_many :comments

	has_many :topic_categories
	has_many :categories, through: :topic_categories

	validates_length_of :title, :minimum => 3, :minimum => 10

	def render_description
		renderer = WikiRender.new(filter_html: true, hard_wrap: true)
		markdown = Redcarpet::Markdown.new(renderer, autolink: true, no_intra_emphasis: true)
		markdown.render(self.description)
	end
end

