# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'bureau'
end

# This is intended to change to ordering of displayed
# rake spec files. No effect so far. Still Alphabetical.
#
# task :test do
#   file_list = %W(bureau_class bureau_instantiation bureau_instance).join(',')
#   Rake::Task["spec"].invoke("files=#{file_list}")
# end
