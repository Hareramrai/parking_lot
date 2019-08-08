require 'spec_helper'

RSpec.describe CommandParser, type: :model do
  let(:command_parer) { CommandParser.new(raw_coammand) }

  describe 'create_parking_lot action' do
    let(:raw_coammand) { 'create_parking_lot 6' }

    it 'returns parsed action with params' do
      expect(command_parer.call).to eq(action: 'create_parking_lot', capacity: 6)
    end
  end

  describe 'park action' do
    let(:raw_coammand) { 'park KA-01-HH-1234 White' }
    let(:vehicle) { Vehicle.new(registration_number: 'KA-01-HH-1234', colour: 'White') }

    it 'returns parsed action with params' do
      expect(command_parer.call).to eq(action: 'park', vehicle: vehicle)
    end
  end

  describe 'leave action' do
    let(:raw_coammand) { 'leave 4' }

    it 'returns parsed action with params' do
      expect(command_parer.call).to eq(action: 'leave', slot_number: 4)
    end
  end

  describe 'status action' do
    let(:raw_coammand) { 'status' }

    it 'returns parsed action with params' do
      expect(command_parer.call).to eq(action: 'status')
    end
  end

  describe 'registration_numbers_for_cars_with_colour action' do
    let(:raw_coammand) { 'registration_numbers_for_cars_with_colour White' }
    let(:action) { 'registration_numbers_for_cars_with_colour' }

    it 'returns parsed action with params' do
      expect(command_parer.call).to eq(action: action, colour: 'White')
    end
  end

  describe 'slot_numbers_for_cars_with_colour action' do
    let(:raw_coammand) { 'slot_numbers_for_cars_with_colour White' }
    let(:action) { 'slot_numbers_for_cars_with_colour' }

    it 'returns parsed action with params' do
      expect(command_parer.call).to eq(action: action, colour: 'White')
    end
  end

  describe 'slot_number_for_registration_number action' do
    let(:raw_coammand) { 'slot_number_for_registration_number KA-01-HH-1234' }
    let(:action) { 'slot_number_for_registration_number' }

    it 'returns parsed action with params' do
      expect(command_parer.call).to eq(action: action, registration_number: 'KA-01-HH-1234')
    end
  end

  describe 'unknowcommand action' do
    let(:raw_coammand) { 'abcdabcdunknowcommand' }

    it 'returns parsed action with params' do
      expect { command_parer.call }.to raise_error(Exceptions::UnknowCommandError)
    end
  end
end
