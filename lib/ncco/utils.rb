# frozen_string_literal: true

module NCCO
  module Utils
    # Transforms the keys of a Hash with the provided block recursively, walking through
    # nested hashes
    #
    # @param hash [Hash] the hash to transform
    # @yieldparam the key to transform
    # @return [Hash] the transformed hash, with the block recursively applied to its keys
    def self.deep_transform_keys(hash, &block)
      result = {}

      hash.each do |key, value|
        result[yield(key)] = if value.is_a?(Hash)
                               deep_transform_keys(value, &block)
                             else
                               value
                             end
      end

      result
    end

    # Transforms the keys of Hash into symbols recursively, walking through nested hashes
    #
    # @param hash [Hash] the hash to transform
    def self.deep_transform_keys_to_symbols(hash)
      deep_transform_keys(hash, &:to_sym)
    end
  end
end
