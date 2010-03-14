module ActionView::Helpers
  class << self
    include StylesheetDependencies
  end

  def join_asset_file_contents(paths)
    if paths.any? { |path| path =~ /\.js\?\d+$/ }
      paths.collect { |path| JSMin.minify(File.read(asset_file_path(path))) }
    elsif paths.any? { |path| path =~ /\.css\?\d+$/ }
      paths.collect { |path| CSSMin.minify(File.read(asset_file_path(path))) }
    else
      paths.collect { |path| File.read(asset_file_path(path)) }
    end.join(" ")
  end
end

ActionView::Helpers::AssetTagHelper.register_stylesheet_expansion :everything => ActionView::Helpers.stylesheet_dependencies

ActionView::Base.field_error_proc = lambda do |html_tag, instance|
  "<span class=\"fieldWithErrors\">#{html_tag}</span>"
end