class ParkingOperator
  def initialize(arg)
    @filename = arg&.first
    @interactive = filename ? false : true
    @parking_lot = nil
  end

  def process
    process_file_command if filename
    process_interactive_command if interactive
  end

  private

  attr_reader :filename, :interactive

  def process_file_command
    File.readlines(filename).each do |raw_command|
      execute(raw_command)
    end
  rescue Errno::ENOENT => e
    puts "Unable to load given file, got this error - #{e.message}"
  end

  def process_interactive_command
    loop do
      command = gets.chomp
      break if command.casecmp('exit').zero?

      execute(command)
    end
  end

  def execute(raw_command)
    command = CommandParser.new(raw_command).call
    action = command.delete(:action)

    if action == Constants::CREATE_PARKING_LOT
      @parking_lot = ParkingLot.new(command)
      puts "Created a parking lot with #{command[:capacity]} slots"
    elsif command.empty?
      @parking_lot.public_send(action)
    else
      @parking_lot.public_send(action, command)
    end
  rescue StandardError => e
    puts e.message
  end
end
