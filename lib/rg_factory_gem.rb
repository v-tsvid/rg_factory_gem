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

        define_method == do |other|
          instance_variables.each_with_index do |ins_var, i|
            return false if ins_var == other
          end
        end

        self.class_eval &block if block_given?
      end
    end
  end
end
