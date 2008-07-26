#--
# Mobile API Ruby library
#
# Ruby Gem Name::  gl-mobile
# Author::    Greg Moreno  (mailto:greg.moreno@gmail.com)
# Copyright:: Copyright (c) 2008 Greg Moreno
# License::   Distributes under the same terms as Ruby
#++

module Mobile
  class Base
    attr_reader :params
    
    def initialize(options)
      @params = {                 
        :use_ssl => true,
      }.merge(options)
    end
  end
  
  class SMS
    # Storage for an SMS that will be sent
    # Standard compliant and not tied to any mobile provider    
    attr_reader :params
    
    def initialize(options = {})
      @params = options
    end
    
    def method_missing(method_id, *arguments)
      @params[method_id.to_sym]
    end
  end    
end


module Validation
  def validate_presence_of(*options)      
    in_param = options.find{ |v| v.is_a?(Hash) && v[:in] }
    raise ArgumentError, ":in must be a Hash" unless in_param.is_a?(Hash)
    
    values = in_param[:in]
    keys = options.reject{ |v| v.is_a?(Hash)}
    keys.each do |key|
      raise ArgumentError, ":#{key} is required" if values[key].nil? || values[key].empty?
    end
  end
end