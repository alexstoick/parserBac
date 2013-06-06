#!/usr/bin/env ruby
$: << "./lib"

require 'nokogiri'
require 'open-uri'
require 'helpers'

include Helpers

min = 1
max = 20019

link = 'http://static.bacalaureat.edu.ro/2012/rapoarte/rezultate/dupa_medie/page_'
extensie = '.html'

completed = 6000

for j in 41..80 do
	urls=[]

	for i in 1..150 do
		urls[i-1] = link+(i+150*(j-1)).to_s+extensie
	end

	i = 0
	th =[]

	urls.each do |url|
		th[i] = Thread.new do

			start = Time.now
			completed += 1

			parser = Parser.new
			page = File.read('output.html')
			completed += 1
			parser.parse(page,completed.to_s)

			fin = Time.now
			puts 'completed ' + completed.to_s + ' duration: ' + (fin-start).to_s

		end
		i+=1
	end

	th.each { |t| t.join }
end

