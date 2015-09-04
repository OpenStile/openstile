module BlogHelper
  def markdown(text)
    options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true
    }
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, options).render(text).html_safe
  end

  def preserve_markdown(text) # Used to get the indentation right in the <pre> code blocks with Haml
    preserve markdown(text)
  end
end
