# frozen_string_literal: true

require 'money'
require_relative './money'

module GraphQL
  module Types
    class MoneyInput < GraphQL::Schema::InputObject
      graphql_name 'MoneyInput'
      description 'An input object representing money, with an amount and '\
                  'currency'

      argument :fractional, Integer, 'Fractional unit value of a given currency', required: true

      argument :iso_code,
               ISO4217,
               'The currency format as defined by IS0 4217',
               required: true
    end
  end
end
