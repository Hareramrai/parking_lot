require 'spec_helper'

RSpec.describe Reports::Status, type: :model do
  let(:registration_number) { 'KA-01-HH-1234' }
  let(:colour) { 'White' }
  let(:vehicle) { Vehicle.new(registration_number: registration_number, colour: colour) }
  let(:slot_number) { 2 }

  describe '#call' do
    subject { Reports::Status.new(params) }

    context 'when params has values' do
      let(:params) { { slot_number => vehicle } }
      let(:status_with_vehicle_details) do
        <<~MESSAGE
          Slot No.    Registration No    Colour
          2           KA-01-HH-1234      White
        MESSAGE
      end

      it 'returns report with vehicle details' do
        expect { subject.call }.to output(status_with_vehicle_details).to_stdout
      end
    end

    context 'when params has no values' do
      let(:params) { {} }
      let(:status_header) do
        <<~MESSAGE
          Slot No.    Registration No    Colour
        MESSAGE
      end

      it 'returns only status header' do
        expect { subject.call }.to output(status_header).to_stdout
      end
    end
  end
end
