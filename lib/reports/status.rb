require 'dry-initializer'

module Reports
  class Status
    extend Dry::Initializer
    param :parked_vehicle_map, Types::Hash.map(Types::Strict::Integer, Vehicle)

    def call
      puts 'Slot No.    Registration No    Colour'

      parked_vehicle_map.each do |slot, vehicle|
        puts "#{slot}           #{vehicle.registration_number}      #{vehicle.colour}"
      end
    end
  end
end
