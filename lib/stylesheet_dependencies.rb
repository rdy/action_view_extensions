module StylesheetDependencies
 def stylesheet_dependencies
   stylesheets = Dir[File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'public', 'stylesheets', '**', '*.css')].collect {|a| a.gsub(/^.*\/public(.*)$/, '\1') }
   config = YAML.load_file(File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'config', 'stylesheets.yml'))
   order, rejects = if config.is_a?(Hash)
     [config['order'], config['reject']]
   else
     [config, []]
   end

   order.collect do |a|
     stylesheets.detect { |b| File.basename(b, '.css') == File.basename(a, '.css') }
   end.concat(stylesheets).reject do |a|
     rejects.detect { |b| File.basename(a, '.css') == File.basename(b, '.css') }
   end.compact.uniq
 end
end
