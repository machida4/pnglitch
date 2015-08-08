require 'pnglitch'
PNGlitch.open('png.png') do |p|
  p.change_all_filters 4
  p.each_scanline do |l|
    l.register_filter_encoder do |data, prev|
      data.size.times.reverse_each do |i|
        x = data.getbyte(i)
        v = prev ? prev.getbyte(i - 6) : 0
        data.setbyte(i, (x - v) & 0xff)
      end
      data
    end
  end
  p.output 'png-incorrect-filter02.png'
end
