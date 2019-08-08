Dir[File.expand_path('**/*.rb', __dir__)].each do |file|
  unless file.include?('main.rb')
    require file
  end
end
ParkingOperator.new(ARGV).process
