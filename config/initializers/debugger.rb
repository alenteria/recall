# === debug helpers ======
if Rails.env.development? || Rails.env.test?

  Object.class_eval do
    def gmethods(grep='')
      (self.methods - Object.methods).grep(/#{grep}/).sort
    end
    def self.gmethods(grep='')
      (self.instance_methods - Object.methods).grep(/#{grep}/).sort
    end
  end 
  ActiveRecord::Base.class_eval do
    class << self
      def gassociations(grep='')
        self.reflections.map(&:first).grep(/#{grep}/).sort
      end
      alias_method :gassoc, :gassociations
      def gattributes(grep='')
        self.attribute_names.grep(/#{grep}/).map(&:to_sym).sort
      end
      alias_method :gattrib, :gattributes
    end 
    def gassociations(grep='')
      self.class.gassociations(grep)
    end
    alias_method :gassoc, :gassociations
    def gattributes(grep='')
      self.class.gattributes(grep)
    end
    alias_method :gattrib, :gattributes
  end  
end

# FIXME Disabled because it prevents Sorcery to initialize auth stuffs
# load Rails.root.join 'test/blueprints.rb' if Rails.env.development?
if Rails.env.development?
  if File.exists?(local_dev_env = Rails.root.join('config/local/development.rb'))
    load local_dev_env
  end
end

if Rails.env.test?
  if File.exists?(local_test_env = Rails.root.join('config/local/test.rb'))
    load local_test_env
  end
end
