module StylesheetDependencies
  def stylesheet_dependencies
    stylesheets = Dir[File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'public', 'stylesheets', '**', '*.css')].collect {|a| a.gsub(/^.*\/public(.*)$/, '\1') }
    YAML.load_file(File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'config', 'stylesheets.yml')).collect do |a|
      stylesheets.detect { |b| b =~ /#{a}\.css$/ }
    end.concat(stylesheets).compact.uniq
  end
end