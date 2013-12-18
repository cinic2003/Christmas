module ApplicationHelper
  def markdown(text)
    if text.present?
      # text = text.gsub('\r\n', '<br/>').gsub('\r', '<br/>').gsub('\n', '<br/>')
      # markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      options = {
            :autolink => true,
            :space_after_headers => true,
            :hard_wrap => true,
            :strikethrough => true,
            :fenced_code_blocks => true}
      # html = markdown.render(text).gsub('\r\n', '<br/>').gsub('\r', '<br/>').gsub('\n', '<br/>')
      markdown = Redcarpet::Markdown.new(HTMLCode, options)
      html = markdown.render(text).gsub('\r\n', '<br/>').gsub('\r', '<br/>').gsub('\n', '<br/>')
      sanitize html, :tags => %w(br a p)
    end
  end
  
  class HTMLCode < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div(:tab_with=>2)
    end
  end
  
end
