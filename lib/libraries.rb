require 'bundler'
Bundler.require :default, ENV['RACK_ENV']

class PygmentsHTML < Redcarpet::Render::HTML
  def block_code code, language
    Pygments.highlight code, lexer: language, options: { linenos: 'table' }
  end
end
