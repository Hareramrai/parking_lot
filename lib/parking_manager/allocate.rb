require_relative '../parking_manager'
require_relative './../exceptions'
module ParkingManager
  class Allocate < ::Base
    def call(vehicle)
      raise Exceptions::SlotNotAvailable if available_spots_queue.empty?

      avaiable_spot = available_spots_queue.pop

      slot_number_vehicle_map[avaiable_spot.slot_number] = vehicle

      registration_number_slot_number_map[vehicle.registration_number] = avaiable_spot.slot_number

      colour_registration_number_map[vehicle.colour] ||= []
      colour_registration_number_map[vehicle.colour] << vehicle.registration_number

      colour_slot_number_map[vehicle.colour] ||= []
      colour_slot_number_map[vehicle.colour] << avaiable_spot.slot_number

      puts "Allocated slot number: #{avaiable_spot.slot_number}"
    end
  end
end
