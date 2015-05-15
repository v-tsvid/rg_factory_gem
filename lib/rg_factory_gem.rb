require "rg_factory_gem/version"
require "rg_factory_gem"

module RgFactoryGem
  def self.name
  	"RG Factory Gem"
  end

  class Factory

    def self.new(*params, &block)

      Class.new do
        params.each do |param|
          raise ArgumentError, "Argument #{param} is not symbol" until param.class == Symbol
        end

        define_method :initialize do |*init_params|
          init_params.each_with_index do |init_param, i|
            instance_variable_set("@#{params[i]}", init_param)
          end
        end

        define_method :[] do |param|
          instance_variables.each_with_index do |ins_var, i|
            return instance_variable_get(ins_var) if param == i || "@#{param}" == ins_var.to_s
          end
          return nil
        end

        define_method :[]= do |name, param|
          if name.class == Fixnum
            instance_variable_set(instance_variables[name], param) 
          else
            instance_variable_set("@#{name}", param)
          end
        end

        define_method :== do |other|
          return false unless self.class == other.class
          instance_variables.each_with_index do |ins_var, i|
            return false unless instance_variable_get(ins_var) == other[i]
          end
          return true
        end

        define_method :to_h do
          h = Hash.new
          self.instance_variables.each do |ins_var|
            h[ins_var.to_s.delete("@").to_sym] = instance_variable_get(ins_var.to_s)
          end
          return h
        end

        define_method :to_s do
          s = "#{self.class} "
          self.to_h.each_pair { |key, value| s += ", #{key.to_s}= \"#{value.to_s}\"" }
          return s
        end

        alias_method :inspect, :to_s

        define_method :length do
          self.to_h.length
        end

        alias_method :size, :length

        self.class_eval &block if block_given?
      end
    end
  end
end
