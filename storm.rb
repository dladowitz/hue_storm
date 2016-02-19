# Color Chooser
# http://colllor.com/

# Whitest Tempeature: 153


require 'hue'
require 'audite'

@client = Hue::Client.new
@player = Audite.new

@left  = @client.lights[0]
@back  = @client.lights[1]
@right = @client.lights[2]

def strobe(strike_distance)
  puts "* Lightning Strike *"
  puts "Strike was #{strike_distance} miles away."


  brightness = (254/strike_distance).round(0)
  puts "Brightness is #{brightness}"
  puts "Hue is #{@client.lights.first.hue}"
  puts "Temperature is #{@client.lights.first.color_temperature}"



  if brightness >= 245
    puts "Flash was 100%"
  else
    puts "Flash was #{((brightness/254.0) * 100).round(0)}%"
  end

  rand(3..10).times do
    light = @client.lights[rand(0..2)]
    light.set_state({bri: brightness, on: true, transitiontime: rand(0..3)})
    light.set_state({:on => false, transitiontime: rand(0..3)})
  end
end

def thunder(strike_distance)
  puts "\n* Thunder Clap *"
  volume_coefficient = 2
  volume = (volume_coefficient/strike_distance).round(2)
  puts "Volume was #{volume}db"

  thunder_files = ["thunder1.mp3", "thunder2.mp3", "thunder3.mp3", "thunder4.wav"]
  audio_file = thunder_files[rand(thunder_files.length)]

  system "afplay #{audio_file} -v volume"
end


while true do
  puts "\n -------------------------------"
  strike_distance = (rand(0.0..2.0)).round(3)

  strobe(strike_distance)

  sleep(strike_distance)

  thunder(strike_distance)

  strike_interval = rand(0..600)
  puts "\nNext strike in #{(strike_interval/60.0).round(2)} minutes"
  sleep(strike_interval)
  puts "-----------------------------------"
end
