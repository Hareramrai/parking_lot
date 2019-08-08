require 'spec_helper'

RSpec.describe ParkingLot, type: :model do
  let(:vehicle1) { Vehicle.new(registration_number: 'KA-01-HH-1234', colour: 'White') }
  let(:vehicle2) { Vehicle.new(registration_number: 'KA-01-MM-4321', colour: 'Black') }
  let(:capacity) { 1 }

  subject { ParkingLot.new(capacity: capacity) }

  describe '#park' do
    context 'when parking available' do
      let(:allocate_status) { "Allocated slot number: 1\n" }

      it 'returns the allocated parking number' do
        expect { subject.park(vehicle: vehicle1) }.to output(allocate_status).to_stdout
      end
    end

    context 'when parking not available' do
      before { subject.park(vehicle: vehicle1) }

      it 'raise exception for not available parking' do
        expect { subject.park(vehicle: vehicle2) }.to raise_error(Exceptions::SlotNotAvailable)
      end
    end
  end

  describe '#leave' do
    context 'when already parked' do
      let(:deallocate_status) { "Slot number 1 is free\n" }

      before { subject.park(vehicle: vehicle1) }

      it 'returns the deallocation message' do
        expect { subject.leave(slot_number: 1) }.to output(deallocate_status).to_stdout
      end
    end

    context 'when slot_number doesnot exists' do
      it 'raise exception for not available parking' do
        expect { subject.leave(slot_number: 29) }.to raise_error(Exceptions::UnknowSpotNumber)
      end
    end
  end

  describe '#status' do
    before { subject.park(vehicle: vehicle1) }

    it 'calls the report status' do
      double = double('book', call: 'enjoy')
      expect(Reports::Status).to receive(:new).with(subject.slot_number_vehicle_map).and_return(double)
      subject.status
    end
  end

  describe '#registration_numbers_for_cars_with_colour' do
    context 'when already parked' do
      before { subject.park(vehicle: vehicle1) }

      it 'returns the deallocation message' do
        expect do
          subject.registration_numbers_for_cars_with_colour(colour: vehicle1.colour)
        end.to output("#{vehicle1.registration_number}\n").to_stdout
      end
    end

    context 'when not parked' do
      it 'returns nil' do
        expect do
          subject.registration_numbers_for_cars_with_colour(colour: vehicle1.colour)
        end.to output("\n").to_stdout
      end
    end
  end

  describe '#slot_numbers_for_cars_with_colour' do
    context 'when already parked' do
      before { subject.park(vehicle: vehicle1) }

      it 'returns the slot_number' do
        expect do
          subject.slot_numbers_for_cars_with_colour(colour: vehicle1.colour)
        end.to output("1\n").to_stdout
      end
    end

    context 'when not parked' do
      it 'returns blank' do
        expect do
          subject.slot_numbers_for_cars_with_colour(colour: vehicle1.colour)
        end.to output("\n").to_stdout
      end
    end
  end

  describe '#slot_number_for_registration_number' do
    context 'when already parked' do
      before { subject.park(vehicle: vehicle1) }

      it 'returns the slot_number' do
        expect do
          subject.slot_number_for_registration_number(registration_number: vehicle1.registration_number)
        end.to output("1\n").to_stdout
      end
    end

    context 'when not parked' do
      it 'raises exception for not found' do
        expect do
          subject.slot_number_for_registration_number(registration_number: vehicle1.registration_number)
        end.to raise_error(Exceptions::RegistrationNumberNotFound)
      end
    end
  end
end
