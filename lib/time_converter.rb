class TimeConverter
  def split(time_string)
    hours = minutes = 0
    if time_string =~ /(\d+)[Mm]/
      minutes = $1.to_i
    end
    if time_string =~ /(\d+)[Hh]/
      hours = $1.to_i
    end
    [hours, minutes]
  end

  def join(hours, minutes)
    times = []
    times << "#{hours}h"   if hours > 0
    times << "#{minutes}m" if minutes > 0
    times.join(" ")
  end
end
