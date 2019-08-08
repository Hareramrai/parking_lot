require 'forwardable'
module ParkingManager
  class ::Base
    extend Forwardable

    def_delegators :parking_lot, :available_spots_queue,
                   :slot_number_vehicle_map,
                   :registration_number_slot_number_map,
                   :colour_registration_number_map,
                   :colour_slot_number_map

    def initialize(parking_lot)
      @parking_lot = parking_lot
    end

    def call
      raise NotImplementedError
    end

    private

    attr_reader :parking_lot
  end
end
