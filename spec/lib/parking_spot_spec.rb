require 'spec_helper'

RSpec.describe ParkingSpot, type: :model do
  let(:registration_number) { 'KA-01-HH-1234' }
  let(:colour) { 'White' }
  let(:vehicle) { Vehicle.new(registration_number: registration_number, colour: colour) }
  let(:parking_spot) { ParkingSpot.new(slot_number, vehicle) }

  context 'with valid values' do
    let(:slot_number) { 3 }

    describe '#slot_number' do
      it 'returns assigned registration_number' do
        expect(parking_spot.slot_number).to eq(slot_number)
      end
    end

    describe '#vehicle' do
      it 'returns assigned vehicle' do
        expect(parking_spot.vehicle).to eq(vehicle)
      end
    end
  end

  context 'with invalid values' do
    let(:slot_number) { 'abcd' }

    it 'raise type error for incorrect field type' do
      expect do
        ParkingSpot.new(slot_number, vehicle)
      end.to raise_error Dry::Types::ConstraintError
    end
  end
end
