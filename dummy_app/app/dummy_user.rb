class DummyUser
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name)
    self.first_name = first_name
    self.last_name  = last_name
  end

  def to_s
    full_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end