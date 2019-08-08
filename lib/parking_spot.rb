require 'dry-initializer'
require 'dry-types'
require_relative './vehicle'

class ParkingSpot
  extend Dry::Initializer
  param :slot_number, Types::Strict::Integer
  param :vehicle, Vehicle, optional: true
end
