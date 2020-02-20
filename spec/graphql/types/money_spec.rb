# frozen_string_literal: true

require 'graphql/types/money'

module GraphQL
  RSpec.describe Types do
    describe 'ISO4217' do
      it 'is valid for a real currency code' do
        result = Types::ISO4217.coerce_isolated_result('USD')

        expect(result).to eql('USD')
      end

      it 'raises for invalid currency codes' do
        expect do
          Types::ISO4217.coerce_isolated_result('FOOBAR')
        end.to raise_error GraphQL::EnumType::UnresolvedValueError
      end
    end

    describe 'Currency' do
      %w[isoCode symbol subunitToUnit smallestDenomination].each do |field_name|
        it "defines #{field_name}" do
          expect_field_to_be_defined(Types::Currency, field_name)
        end
      end
    end

    describe 'Money' do
      %w[fractional amount currency displayString].each do |field_name|
        it "defines #{field_name}" do
          expect_field_to_be_defined(Types::Money, field_name)
        end
      end
    end

    def expect_field_to_be_defined(type, field_name)
      expect(type.get_field(field_name)).to be_a(GraphQL::Schema::Field)
    end
  end
end
