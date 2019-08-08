require 'fc'
require_relative './parking_spot'
class ParkingLot
  attr_reader :available_spots_queue, :slot_number_vehicle_map,
              :registration_number_slot_number_map, :colour_registration_number_map,
              :colour_slot_number_map

  def initialize(capacity:)
    @capacity = capacity
    @available_spots_queue = FastContainers::PriorityQueue.new(:min)
    # {slot_number:vehicle}
    @slot_number_vehicle_map = {}
    # {registration_number:slot_number}
    @registration_number_slot_number_map = {}
    # {colour:registration_number}
    @colour_registration_number_map = {}
    # {colour:slot_number}
    @colour_slot_number_map = {}

    create_default_spots
  end

  def park(vehicle:)
    ParkingManager::Allocate.new(self).call(vehicle)
  end

  def leave(slot_number:)
    ParkingManager::Deallocate.new(self).call(slot_number)
  end

  def status
    Reports::Status.new(slot_number_vehicle_map).call
  end

  def registration_numbers_for_cars_with_colour(colour:)
    puts colour_registration_number_map[colour]&.join(', ')
  end

  def slot_numbers_for_cars_with_colour(colour:)
    puts colour_slot_number_map[colour]&.join(', ')
  end

  def slot_number_for_registration_number(registration_number:)
    slot_number = registration_number_slot_number_map[registration_number]
    raise Exceptions::RegistrationNumberNotFound unless slot_number

    puts slot_number
  end

  private

  attr_reader :capacity

  def create_default_spots
    capacity.times do |spot_number|
      available_spots_queue.push(ParkingSpot.new(spot_number + 1), spot_number + 1)
    end
  end
end
