#!/usr/bin/env ruby
$: << "."

require 'nokogiri'
require 'open-uri'
autoload :Decoder, "decoder"

min = 1
max = 20019

link = 'http://static.bacalaureat.edu.ro/2012/rapoarte/rezultate/dupa_medie/page_'
extensie = '.html'

completed =0


current_link = 'http://static.bacalaureat.edu.ro/2012/rapoarte/rezultate/dupa_medie/page_1.html'


page = Nokogiri::HTML(open( current_link ) )


encoded = page.css("script").text.scan(/"([^"]*)"/)[0]
completed += 1


decoder = Decoder.new(encoded)
decoded = decoder.s3()
puts decoder
exit()

File.open( 'files/' + completed.to_s + '.64', 'w' ) { |file| file.puts (encoded  ) }


for j in 1..10 do
	urls=[]

	for i in 1..300 do
		urls[i-1] = link+(i+300*(j-1)).to_s+extensie
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
			File.open( 'files/' + completed.to_s + '.64', 'w' ) { |file| file.puts (encoded  ) }
		end
		i+=1
	end

	th[0].join
end


