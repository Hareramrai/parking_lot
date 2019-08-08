require 'spec_helper'

RSpec.describe ParkingOperator, type: :model do
  let(:filename) { File.join(File.dirname(__FILE__), '../..', 'functional_spec', 'fixtures', 'file_input.txt') }

  context 'when passing filename as argument' do
    subject { ParkingOperator.new([filename]) }

    describe '#process' do
      let(:expected_file_output) do
        <<~MESSAGE
          Created a parking lot with 6 slots
          Allocated slot number: 1
          Allocated slot number: 2
          Allocated slot number: 3
          Allocated slot number: 4
          Allocated slot number: 5
          Allocated slot number: 6
          Slot number 4 is free
          Slot No.    Registration No    Colour
          1           KA-01-HH-1234      White
          2           KA-01-HH-9999      White
          3           KA-01-BB-0001      Black
          5           KA-01-HH-2701      Blue
          6           KA-01-HH-3141      Black
          Allocated slot number: 4
          Sorry, parking lot is full
          KA-01-HH-1234, KA-01-HH-9999, KA-01-P-333
          1, 2, 4
          6
          Not found
        MESSAGE
      end

      it 'print the result on stdout for processing file' do
        expect { subject.process }.to output(expected_file_output).to_stdout
      end
    end
  end

  context 'when filename doesnot exists' do
    subject { ParkingOperator.new(['abc.rb']) }

    describe '#process' do
      let(:missing) { "Unable to load given file, got this error - No such file or directory @ rb_sysopen - abc.rb\n" }

      it 'raises exception' do
        expect { subject.process }.to output(missing).to_stdout
      end
    end
  end

  context 'when without any filename-interactive' do
    let(:parking_lot) { File.join(File.dirname(__FILE__), '../..', 'bin', 'parking_lot') }

    describe '#process' do
      let(:commands) do
        [
          "create_parking_lot 6\n",
          "park KA-01-HH-1234 White\n"
        ]
      end

      let(:expected) do
        [
          "Created a parking lot with 6 slots\n",
          "Allocated slot number: 1\n"
        ]
      end

      it 'opens an interactive console to operate parking' do
        pty = PTY.spawn(parking_lot)
        commands.each_with_index do |cmd, index|
          run_command(pty, cmd)
          expect(fetch_stdout(pty)).to end_with(expected[index])
        end
      end
    end
  end
end
