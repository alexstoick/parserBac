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

completed = 12000

for j in 81..133 do
	urls=[]

	for i in 1..150 do
		urls[i-1] = link+(i+150*(j-1)).to_s+extensie
	end

	i = 0
	th =[]

	urls.each do |url|
		th[i] = Thread.new do
			current_link = url

			start = Time.now
			page = Nokogiri::HTML(open( current_link ) )

			encoded = page.css("script").text.scan(/"([^"]*)"/)[0]
			completed += 1
			fin = Time.now
			puts 'completed ' + completed.to_s + ' duration: ' + (fin-start).to_s
			File.open( 'files/' + completed.to_s + '.64', 'w' ) { |file| file.puts ( encoded[0].to_s ) }
		end
		i+=1
	end

	th.each { |t| t.join }
end

