if ENV['SIMPLECOV']
  require 'simplecov'
  SimpleCov.start do
    add_filter %r{^/spec/}
    add_filter %r{^/functional_spec/}
  end
  puts 'Collecting coverage report...'
end
