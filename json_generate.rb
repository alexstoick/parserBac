#!/usr/bin/env ruby
$: << "./lib"

require 'nokogiri'
require 'open-uri'
require 'helpers'

include Helpers

link = 'files/'
extensie = '.64'

completed = 0



for j in 1..40 do
	urls=[]

	for i in 1..150 do
		urls[i-1] = link+(i+150*(j-1)).to_s+extensie
	end

	i = 0
	th =[]
	entries = []

	urls.each do |url|
		th[i] = Thread.new do

			start = Time.now

			parser = Parser.new
			file = File.read(url)
			decoder = Decoder.new
			decoder.setEncoded(file)
			page = decoder.s3

			parser.parse(page)

			completed += 1
			#parser.writeToFile(completed.to_s)
			entries.push( parser.getCanditati )

			fin = Time.now
			puts 'completed ' + completed.to_s + ' duration: ' + (fin-start).to_s

		end
		i+=1
	end
	th.each { |t| t.join }
	File.open( 'json/ABC' + j.to_s + '.json' , 'w') { |file| file.puts ( entries ) }
end
