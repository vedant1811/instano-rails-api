# rest of the config is handled by capistrano-unicorn in config/deploy.rb

worker_processes 4
preload_app true
timeout 20

# setting the below code because of the preload_app true setting above:
# http://unicorn.bogomips.org/Unicorn/Configurator.html#preload_app-method

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Rails.logger.info('Disconnected from ActiveRecord')
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
    Rails.logger.info('Connected to ActiveRecord')
  end
end

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
  ENV["BUNDLE_GEMFILE"] = File.join(root, 'Gemfile')
end
