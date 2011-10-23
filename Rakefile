require 'rake/testtask'
Rake::TestTask.new do |i|
  i.test_files = FileList['test/*_spec.rb']
  i.verbose = true
end

task :default => :test
