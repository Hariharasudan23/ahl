module ReportsHelper
  def html(markdown_content)
    renderer = Redcarpet::Render::HTML
    markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    markdown.render(markdown_content).html_safe
  end
end
