# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend Classmethods
    base.send :include, Instancemethods
  end

  module Classmethods
    attr_reader :validation_array
    def validate(name, type, args = nil)
      @validation_array ||= []
      @validation_array << [name, type, args]
    end
  end

  module Instancemethods
    def validate!
      self.class.validation_array.each do |name, type, args|
        value = instance_variable_get("@#{name}")
        send("validate_#{type}", value, args)
      end
    end

    def validate_presence(value, _args)
      raise "var name can't be nil " if value.nil?
    end

    def validate_format(value, args)
      raise 'format_error' if value !~ args
    end

    def validate_type(value, args)
      raise 'type error' unless value.is_a? args
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
    end
end
