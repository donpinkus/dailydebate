ActionView::Base.send(:include, Rails.application.routes.url_helpers)

class WikiRender < Redcarpet::Render::HTML
  def header(text, level)
    level += 2
    level < 6 ? "<h#{level}>#{text}</h#{level}>" : "<h6>#{text}</h6>"
  end

  def link(link, title, alt_text)
    "<a rel=\"nofollow\" href=\"#{link}\">#{alt_text}</a>"
  end

  def autolink(link, link_type)
    "<a rel=\"nofollow\" href=\"#{link}\">#{link}</a>"
  end

  def postprocess(full_document)
    full_document.gsub!(/(\@([\w]+))/) do
      user = User.where(id: $2).try(:first)
      user ||= User.where('name LIKE ?', $2).try(:first)

      if user
        ActionController::Base.helpers.link_to(user.name, user)
      else
        $1
      end
    end

    full_document
  end
end
