class Seniority
  extend Forwardable
  include Comparable

  NAMES = %w[ Apprentice Junior Junior+ Semi-Senior Semi-Senior+ Senior
              Senior+ Team-Lead Architect Hero ]

  def_delegators :@seniority, :to_i

  def initialize seniority
    @seniority = seniority
  end

  def self.options
    @options ||= NAMES.collect.with_index do |name, index|
      [name, index]
    end
  end

  def <=> other
    @seniority <=> other.to_i
  end

  def to_s
    NAMES.fetch(@seniority)
  end

  def previous
    raise "There is no previous for #{ self }" if @seniority == 0
    self.class.new(@seniority - 1)
  end

  def next
    raise "There is no next for #{ self }" if @seniority == (NAMES.size + 1)
    self.class.new(@seniority + 1)
  end
end
