module ApplicationHelper
  def markdown(text)
    if text.present?
      sanitize text.gsub(" ", '&nbsp;').gsub("\r", '<br/>').gsub("\n", '<br/>'), :tags => %w(br a p)
    end
  end
    
end
