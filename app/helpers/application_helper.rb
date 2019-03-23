module ApplicationHelper
  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      begin
        CodeRay.scan(code, language).div
      rescue ArgumentError
        Rails.logger.warn "No language detected in note code block"
      end
    end
  end

  def markdown(text)

    coderayified = CodeRayify.new(:filter_html => true,
                                  :hard_wrap => true)
    options = {
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :autolink => true,
      :strikethrough => true,
      :lax_html_blocks => true,
      :superscript => true
    }
    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)

    begin
      markdown_to_html.render(text).html_safe
    rescue TypeError
      Rails.logger.warn "No language type in markdown defaulting to plain text"
      return text
    end
  end
end
