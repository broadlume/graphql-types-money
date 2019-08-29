# frozen_string_literal: true

require 'money'
require_relative './money'

module GraphQL
  module Types
    MoneyInput = GraphQL::InputObjectType.define do
      name 'MoneyInput'
      description 'An input object representing money, with an amount and '\
                  'currency'

      argument :fractional, !types.Int, 'Fractional unit value of a given '\
                                        'currency'

      argument :isoCode,
               ISO4217.to_non_null_type,
               'The currency format as defined by IS0 4217'
    end
  end
end
