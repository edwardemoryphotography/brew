# typed: true # rubocop:todo Sorbet/StrictSigil
# frozen_string_literal: true

require "unpack_strategy"

module Cask
  class DSL
    # Class corresponding to the `container` stanza.
    class Container
      attr_accessor :nested, :type

      def initialize(nested: nil, type: nil)
        @nested = nested
        @type = type

        return if type.nil?
        return unless UnpackStrategy.from_type(type).nil?

        raise "invalid container type: #{type.inspect}"
      end

      def pairs
        # `drop` is not a method on `Symbol`
        # rubocop:disable Performance/ArraySemiInfiniteRangeSlice
        instance_variables.to_h { |ivar| [ivar[1..].to_sym, instance_variable_get(ivar)] }.compact
        # rubocop:enable Performance/ArraySemiInfiniteRangeSlice
      end

      def to_yaml
        pairs.to_yaml
      end

      sig { returns(String) }
      def to_s = pairs.inspect
    end
  end
end
