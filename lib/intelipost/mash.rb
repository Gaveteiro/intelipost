# frozen_string_literal: true

module Intelipost
  class Mash < ::Hashie::Mash
    disable_warnings if respond_to?(:disable_warnings)

    def success?
      key?('status') && status == 'OK'
    end

    def failure?
      !success?
    end

    def all_messages
      return unless key?('messages')
      messages.map(&:text).join(';')
    end

    def length
      self[:length]
    end

    def key
      self[:key]
    end
  end
end
