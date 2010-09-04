require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "songkicky"
    gem.summary = %Q{Wrapper for Songkick's API.}
    gem.description = %Q{Very simple Ruby wrapper for Songkick's API. (http://developer.songkick.com/)}
    gem.email = "saleandro@yahoo.com"
    gem.homepage = "http://github.com/saleandro/songkicky"
    gem.authors = ["Sabrina Leandro"]
    gem.add_development_dependency "json", ">= 0"
    gem.files = [".document",  ".gitignore","LICENSE", "Rakefile", "VERSION",'lib/**/*.rb']

  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "songkicky #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
