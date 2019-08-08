require_relative '../parking_manager'
require_relative './../exceptions'
module ParkingManager
  class Deallocate < ::Base
    def call(slot_number)
      vehicle = slot_number_vehicle_map[slot_number]
      raise Exceptions::UnknowSpotNumber unless vehicle

      slot_number_vehicle_map.delete(slot_number)

      registration_number_slot_number_map.delete(vehicle.registration_number)

      colour_registration_number_map[vehicle.colour].delete(vehicle.registration_number)
      colour_slot_number_map[vehicle.colour].delete(slot_number)

      available_spots_queue.push(ParkingSpot.new(slot_number), slot_number)

      puts "Slot number #{slot_number} is free"
    end
  end
end
