module Constants
  ACTIONS = %w[
    create_parking_lot park leave status registration_numbers_for_cars_with_colour
    slot_numbers_for_cars_with_colour slot_number_for_registration_number
  ].freeze

  CREATE_PARKING_LOT                       = 'create_parking_lot'.freeze
  PARK                                     = 'park'.freeze
  LEAVE                                    = 'leave'.freeze
  STATUS                                   = 'status'.freeze
  REGISTRATION_NUMBER_FOR_CARS_WITH_COLOUR = 'registration_numbers_for_cars_with_colour'.freeze
  SLOT_NUMBERS_FOR_CARS_WITH_COLOUR        = 'slot_numbers_for_cars_with_colour'.freeze
  SLOT_NUMBER_FOR_REGISTRATION_NUMBER      = 'slot_number_for_registration_number'.freeze
end
