# typed: strict
# frozen_string_literal: true

module Homebrew
  module Livecheck
    # The interface for livecheck strategies. Because third-party strategies are not required to extend this module,
    #   we do not provide any default method implementations here.
    module Strategic
      extend T::Helpers

      interface!

      # Whether the strategy can be applied to the provided URL.
      #
      # @param url [String] the URL to match against
      sig { abstract.params(url: String).returns(T::Boolean) }
      def match?(url); end

      # Generates a URL and checks the content at the URL for new versions.
      #   Implementations may not support all options.
      #
      # @param url [String] the URL of the content to check
      # @param regex [Regexp, nil] a regex for matching versions in content
      # @param provided_content [String, nil] content to check instead of fetching
      # @param homebrew_curl [Boolean] whether to use brewed curl with the URL
      # @return [Hash]
      sig {
        abstract.params(
          url:              String,
          regex:            T.nilable(Regexp),
          provided_content: T.nilable(String),
          homebrew_curl:    T::Boolean,
          unused:           T.untyped,
          block:            T.nilable(Proc),
        ).returns(T::Hash[Symbol, T.untyped])
      }
      def find_versions(url:, regex: nil, provided_content: nil, homebrew_curl: false, **unused, &block); end
    end
  end
end
