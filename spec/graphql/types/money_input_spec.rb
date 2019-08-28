# frozen_string_literal: true

require 'graphql/types/money_input'

module GraphQL
  RSpec.describe Types do
    describe 'MoneyInput' do
      let(:input_object) { Types::MoneyInput.graphql_definition }
      it 'returns valid result when given valid arguements' do
        valid_input = {"fractional" => 5.50, "isoCode" => "USD"}
        expect(input_object.valid_isolated_input?(valid_input)).to be true
      end
      it 'returns an invalid result when given missing isoCode arguement' do
        invalid_input = {"fractional" => 5.50}
        expect(input_object.valid_isolated_input?(invalid_input)).to be false
      end
      it 'returns an invalid result when invalid type for fractional arguement' do
        invalid_input = {"fractional" => "5.50", "isoCode" => "USD"}
        expect(input_object.valid_isolated_input?(invalid_input)).to be false
      end
      it 'returns an invalid result when invalid isoCode arguement' do
        invalid_input = {"fractional" => 5.50, "isoCode" => "WHUFFIE"}
        expect(input_object.valid_isolated_input?(invalid_input)).to be false
      end
    end
  end
end
