group :rspec do
  guard 'rspec', :version => 2 do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^spec/factories/.+\.rb$})
    watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')  { "spec" }
  end
end


group :livereload do
  guard 'livereload' do
    watch(%r{app/views/.+\.(erb|haml|slim)$})
    watch(%r{app/helpers/.+\.rb})
    watch(%r{public/.+\.(css|js|html)})
    watch(%r{config/locales/.+\.yml})
    # Rails Assets Pipeline
    watch(%r{(app|vendor)/assets/\w+/(.+\.(css|js|html)).*})  { |m| "/assets/#{m[2]}" }
  end
end
