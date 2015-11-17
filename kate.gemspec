# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','kate','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'kate'
  s.version = Kate::VERSION
  s.author = 'jugglinghobo'
  s.email = 'jugglinghobo@gmail.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'KAT torrent search, remember and download via CLI'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','kate.rdoc']
  s.rdoc_options << '--title' << 'kate' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'kate'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_development_dependency('pry')
  s.add_runtime_dependency('gli','2.13.3')
  s.add_runtime_dependency('kat', '2.0.11')
  s.add_runtime_dependency('terminal-table', '1.5.2')
end
