require 'time'

class Timer

  def self.init
    @@last = Time.now
  end

  def self.deltaTime
    return @@deltaTime
  end

  def self.update
    @@deltaTime = Time.now - @@last
    @@last = Time.now
  end


end
