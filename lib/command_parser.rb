require 'dry-initializer'
require 'dry-types'

module Types
  include Dry.Types()
end

class CommandParser
  extend Dry::Initializer

  param :raw_command, Types::Strict::String

  def call
    action, params = parse_raw_command

    case action
    when Constants::CREATE_PARKING_LOT
      { capacity: params&.first&.to_i }
    when Constants::PARK
      { vehicle: Vehicle.new(registration_number: params[0], colour: params[1]) }
    when Constants::LEAVE
      { slot_number: params&.first&.to_i }
    when Constants::STATUS
      {}
    when Constants::REGISTRATION_NUMBER_FOR_CARS_WITH_COLOUR, Constants::SLOT_NUMBERS_FOR_CARS_WITH_COLOUR
      { colour: params&.first }
    when Constants::SLOT_NUMBER_FOR_REGISTRATION_NUMBER
      { registration_number: params&.first }
    end.merge(action: action)
  end

  private

  def parse_raw_command
    command_fields = raw_command.split(/\s/)
    command_action = command_fields.shift

    raise Exceptions::UnknowCommandError unless Constants::ACTIONS.include?(command_action)

    [command_action, command_fields]
  end
end
