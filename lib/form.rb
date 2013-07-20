class Form
  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def self.accepts_nested_attributes_for(*keys)
    keys.each do |key|
      define_method "#{key}_attributes=" do |attrs|
        self.send(key).attributes = attrs
      end
    end
  end

  def persisted?; false; end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  protected

  def persist!
    raise "Classes extending Form should implement persist!"
  end
end
