unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

Motion::Project::App.setup do |app|
  files = Dir.glob(File.join(File.dirname(__FILE__), 'bureau/*.rb'))
  files.each do |file|
    app.files.unshift(file)
  end
  bureau_dot_rb = files.select{ |f| File.basename(f) == 'bureau.rb' }.first
  bureau_menu_dot_rb = files.select{ |f| File.basename(f) == 'bureau_menu.rb' }.first
  bureau_controller_dot_rb = files.select{ |f| File.basename(f) == 'bureau_controller.rb' }.first
  app.files_dependencies bureau_dot_rb => bureau_menu_dot_rb
  app.files_dependencies bureau_menu_dot_rb => bureau_controller_dot_rb

  app.frameworks += ['QuartzCore']
end
