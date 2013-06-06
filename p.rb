#!/usr/bin/env ruby
$: << "./lib"

require 'helpers'
include Helpers

parser = Parser.new

page = File.read('output.html')

parser.parse(page,'rahat')