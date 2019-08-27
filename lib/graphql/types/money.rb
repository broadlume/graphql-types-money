# frozen_string_literal: true

require 'money'
require 'graphql'

module GraphQL
  module Types
    ISO4217 = GraphQL::EnumType.define do
      name 'ISO4217'
      description 'A valid ISO 4217 currency code string.'

      ::Money::Currency.all.uniq(&:name).sort_by(&:iso_code).each do |curr|
        value curr.iso_code, curr.name
      end
    end

    Currency = GraphQL::ObjectType.define do
      name 'Currency'
      description 'A currency as defined by the ISO 4217 standard.'

      field :isoCode, ISO4217, 'The currency format as defined by IS0 4217.' do
        resolve ->(obj, *) { obj.iso_code }
      end

      field :symbol, types.String, 'The symbol for the currency (i.e. "€").'

      field :smallestDenomination do
        type types.Int
        description 'The smallest denomination of the currency.'
        resolve ->(obj, *) { obj.smallest_denomination }
      end

      field :subunitToUnit do
        type types.Int
        description 'Factor used to convert a subunit to a unit.'
        resolve ->(obj, *) { obj.subunit_to_unit }
      end
    end

    Money = GraphQL::ObjectType.define do
      name 'Money'
      description 'An object representing money, with an amount and currency.'

      field :fractional, types.Int, 'Fractional unit value of a given currency.'

      field :amount, types.Float, 'Numerical amount of the money.'

      field :currency, Currency

      field :displayString, types.String, 'Displayable string (i.e. "$1.00").' do
        resolve ->(obj, *) { obj.format }
      end
    end
  end
end
