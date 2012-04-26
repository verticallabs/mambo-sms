# add dirs to load_path
gem_root = File.join(File.dirname(__FILE__), '../..')
Dir[File.join(gem_root, 'app', '**', '*')].each do |f| 
  if Dir.exist?(f)
    $: << File.expand_path(f)
  end
end

# hijack rails autoload system
include ActiveSupport
$:.each do |path|
  Dependencies.autoload_paths << File.expand_path(path)
end
