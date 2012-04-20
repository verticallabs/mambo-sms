module Randomizer
  def self.string(length)
    (0...length).map{ ('a'..'z').to_a[Kernel.rand(26)] }.join
  end

  def self.integer(length)
    (0...length).map{ ('1'..'9').to_a[Kernel.rand(9)] }.join.to_i #no zeroes because it messes up the length
  end
end
