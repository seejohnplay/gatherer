class Task

  attr_accessor :size, :completed_at

  def initialize(options = {})
    complete!(options[:completed]) if options[:completed]
    @size = options[:size]
  end

  def complete!(date = nil)
    @completed_at = (date || Time.current)
  end

  def complete?
   !completed_at.nil?
  end

  def counts_toward_velocity?
    return false unless complete?
    completed_at > Project.velocity_length_in_days.days.ago
  end

  def points_toward_velocity
    counts_toward_velocity? ? size : 0
  end
end