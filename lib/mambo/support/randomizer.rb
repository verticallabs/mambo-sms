module Randomizer
  def self.string(length)
    (0...length).map{ ('a'..'z').to_a[Kernel.rand(26)] }.join
  end

  def self.integer(length)
    (0...length).map{ ('1'..'9').to_a[Kernel.rand(9)] }.join.to_i #no zeroes because it messes up the length
  end

  def self.boolean
    Kernel.rand(1) == 1
  end

  def self.enum(enum)
    enum[Kernel.rand(enum.length)]
  end

  def self.password(length)
    Digest::SHA1.hexdigest(self.string(length))
  end
end
