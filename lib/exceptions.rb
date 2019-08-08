module Exceptions
  class UnknowCommandError < StandardError
    def message
      'Given operation does exists'
    end
  end

  class SlotNotAvailable < StandardError
    def message
      'Sorry, parking lot is full'
    end
  end

  class UnknowSpotNumber < StandardError
    def message
      'Slot number doesnot exists'
    end
  end

  class RegistrationNumberNotFound < StandardError
    def message
      'Not found'
    end
  end
end
