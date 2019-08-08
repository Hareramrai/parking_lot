require 'spec_helper'

RSpec.describe Vehicle, type: :model do
  let(:vehicle) { Vehicle.new(registration_number: registration_number, colour: colour) }

  context 'with valid values' do
    let(:registration_number) { 'KA-01-HH-1234' }
    let(:colour) { 'White' }

    describe '#registration_number' do
      it 'returns assigned registration_number' do
        expect(vehicle.registration_number).to eq(registration_number)
      end
    end

    describe '#colour' do
      it 'returns assigned colour' do
        expect(vehicle.colour).to eq(colour)
      end
    end
  end

  context 'with invalid values' do
    let(:registration_number) { :my_incorrect_number }
    let(:colour) { 1234 }

    it 'raise type error for incorrect field type' do
      expect do
        Vehicle.new(registration_number: registration_number, colour: colour)
      end.to raise_error Dry::Struct::Error
    end
  end
end
