class Form
  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

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
