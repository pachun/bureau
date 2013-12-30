unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

Motion::Project::App.setup do |app|
  Dir.glob(File.join(File.dirname(__FILE__), 'bureau/*.rb')).each do |file|
    app.files.unshift(file)
  end

  app.files_dependencies 'lib/bureau/bureau.rb' => 'lib/bureau/bureau_menu.rb'
  app.frameworks += ['QuartzCore']
end
