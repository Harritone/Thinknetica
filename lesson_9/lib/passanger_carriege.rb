require_relative 'carriege'

class PassangerCarriege < Carriege
  attr_reader :taken_seats

  def initialize(seats)
    super(:passanger)
    @seats = seats
    @taken_seats = 0
  end

  def to_s
    "Type: #{@type}, seats: #{@seats}, taken volume: #{taken_seats}, free space: #{free_seats}."
  end

  def take_seat
    @taken_seats += 1 unless @taken_seats > @seats
  end

  def free_seats
    @seats - @taken_seats
  end
end
