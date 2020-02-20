# frozen_string_literal: true

require 'money'
require 'graphql'

module GraphQL
  module Types
    class ISO4217 < GraphQL::Schema::Enum
      graphql_name 'ISO4217'
      description 'A valid ISO 4217 currency code string.'

      ::Money::Currency.all.uniq(&:name).sort_by(&:iso_code).each do |curr|
        value curr.iso_code, curr.name
      end
    end

    class Currency < GraphQL::Schema::Object
      graphql_name 'Currency'
      description 'A currency as defined by the ISO 4217 standard.'

      field :iso_code, ISO4217, 'The currency format as defined by IS0 4217.', null: false

      field :symbol, String, 'The symbol for the currency (i.e. "€").', null: false

      field :smallest_denomination, Integer, 'The smallest denomination of the currency.', null: false

      field :subunit_to_unit, Integer, 'Factor used to convert a subunit to a unit.', null: false
    end

    class Money < GraphQL::Schema::Object
      graphql_name 'Money'
      description 'An object representing money, with an amount and currency.'

      field :fractional, Integer, 'Fractional unit value of a given currency.', null: false

      field :amount, Float, 'Numerical amount of the money.', null: false

      field :currency, Currency, null: false

      field :display_string, String, 'Displayable string (i.e. "$1.00").', null: false

      def display_string
        object.format
      end
    end
  end
end
