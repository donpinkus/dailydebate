class Comment < ActiveRecord::Base
	belongs_to :user
  belongs_to :topic
  has_many :votes

  def render_content
    renderer = WikiRender.new(filter_html: true, hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer, autolink: true, no_intra_emphasis: true)
    markdown.render(self.content)
  end

  def score
    self.votes.count + self.votes_count_override
  end
end

