class Renderer
  def render page
    Redcarpet::Markdown.new(PygmentsHTML, {
      autolink: true,
      tables: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      underline: true
    }).render(page)
  end
end
