# what is the fastest way to load configs
# 1) hava a yaml file
# 2) have a ruby file with the constants set, this file is required
# 3) memcache - not benchmarked
# 4) others like sqlite db - not benchmarked 
# i would guess that the yaml file would be slower as iyt has to read,
# parse the file and set the constant.
# But the benchmark is order dependent, the first benchmark run is faster

# for a sinatra is there any way put config on the thin config file or
# passenger config and access it from the app. Better option in case
# we know that these configs will be read and not lazy read on a
# action what may happed. eg header which is shown on every page

require 'benchmark'

TIMES = 10_000_00

Benchmark.bmbm do |bm|
  bm.report('yaml-file') do
    TIMES.times do
      require File.expand_path('../yaml_file', __FILE__)
    end
    #puts "WEBSITE_URL_YAML: #{WEBSITE_URL_YAML.inspect}"
  end
  bm.report('const-rb') do
    TIMES.times do
      require(File.expand_path('../const_set', __FILE__))
    end
    #puts "WEBSITE_URL_CONST: #{WEBSITE_URL_CONST.inspect}"
  end
end

__END__

ruby 1.9.2p180 (2011-02-18 revision 30909) [x86_64-darwin10.6.0]
Rehearsal ---------------------------------------------
yaml-file   0.120000   0.090000   0.210000 (  0.204797)
const-rb    0.080000   0.070000   0.150000 (  0.151177)
------------------------------------ total: 0.360000sec

                user     system      total        real
yaml-file   0.070000   0.080000   0.150000 (  0.147553)
const-rb    0.070000   0.070000   0.140000 (  0.150287)

if we change the order of the benchmark, then

ruby 1.9.2p180 (2011-02-18 revision 30909) [x86_64-darwin10.6.0]
Rehearsal ---------------------------------------------
const-rb    0.070000   0.070000   0.140000 (  0.138894)
yaml-file   0.120000   0.090000   0.210000 (  0.205301)
------------------------------------ total: 0.350000sec

                user     system      total        real
const-rb    0.060000   0.080000   0.140000 (  0.137204)
yaml-file   0.090000   0.080000   0.170000 (  0.177898)

The first one is faster
