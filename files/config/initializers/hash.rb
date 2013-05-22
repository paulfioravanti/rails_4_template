# This is the original Hash#diff method from Rails that will be depreciated.
#
# Currently in rails 4.0.0.rc1, Webrick still uses the method, though
# in 4.1.0.beta, it doesn't seem to.
# However, amongst the gems being used in this project, at least
# Rails Footnotes and possibly other gems use this method, so it has been
# ported here.
#
# The sole purpose of having this here at this time is to stop depreciation
# notices, so if in the future there is a Hash#diff alternative that dependent
# gems use, this can be removed.
class Hash
  # Returns a hash that represents the difference between two hashes.
  #
  #   {1 => 2}.diff(1 => 2)         # => {}
  #   {1 => 2}.diff(1 => 3)         # => {1 => 2}
  #   {}.diff(1 => 2)               # => {1 => 2}
  #   {1 => 2, 3 => 4}.diff(1 => 2) # => {3 => 4}
  def diff(other)
    dup.
      delete_if { |k, v| other[k] == v }.
      merge!(other.dup.delete_if { |k, v| has_key?(k) })
  end
end