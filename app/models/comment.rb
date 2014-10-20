class Comment < ActiveRecord::Base
	belongs_to :user
  belongs_to :topic

  def render_content
    renderer = WikiRender.new(filter_html: true, hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer, autolink: true, no_intra_emphasis: true)
    markdown.render(self.content)
  end
end

