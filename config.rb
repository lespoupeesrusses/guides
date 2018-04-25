# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

set :markdown_engine, :redcarpet
set :markdown, with_toc_data: true, tables: true, autolink: true, gh_blockcode: true, fenced_code_blocks: true

helpers do
  def table_of_contents(resource)
    content = File.read(resource.source_file)
    toc_renderer = Redcarpet::Render::HTML_TOC.new
    markdown = Redcarpet::Markdown.new(toc_renderer, nesting_level: 2) # nesting_level is optional
    markdown.render(content)
  end
end

activate :sprockets

activate :deploy do |deploy|
  deploy.deploy_method = :git
end