require 'dry-struct'

class Vehicle < Dry::Struct
  attribute :colour, Types::Strict::String
  attribute :registration_number, Types::Strict::String
end
