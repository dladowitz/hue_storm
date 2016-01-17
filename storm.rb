require 'hue'
require 'audite'

@client = Hue::Client.new
@player = Audite.new

@left  = @client.lights[0]
@back  = @client.lights[1]
@right = @client.lights[2]

def strobe(cycles)
  cycles.times do
    rand(3..10).times do
      light = @client.lights[rand(0..2)]
      light.set_state({bri: rand(150..254), on: true, transitiontime: rand(0..3)})
      light.set_state({:on => false, color_temperature: 153, transitiontime: rand(0..3)})
    end
  end
end

def thunder
  thunder_files = ["thunder1.mp3", "thunder2.mp3", "thunder3.mp3", "thunder4.wav"]
  audio_file = thunder_files[rand(thunder_files.length)]

  system "afplay #{audio_file}"
end


while true do
  puts "\n"
  puts "------------Lightning Strike-------------------"
  strobe(1)
  sleep(rand(0..3))

  puts "Thunder Clap"
  thunder

  sleep_time = rand(0..300)
  puts "Sleeping for #{(sleep_time/60.0).round(1)} minutes"
  sleep(sleep_time)
  puts "-------------Waking-------------------------"
end
