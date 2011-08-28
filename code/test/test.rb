#!/usr/bin/ruby

require '../lib/parsers.rb'
require 'pp'

latex_test_docs = %w{documents/01/doc.tex}

latex_test_docs.each do |doc|
  l = LaTeXDocument.new(doc)

  puts "Document \"#{doc}\" has #{l.images.size} images:"
  l.images.each_with_index do |photo, i|
    puts "  #{i+1}) #{File.basename(photo.fname)}:"
    puts "    License: #{photo.license}"
    puts "    Attr Name: #{photo.attr_name}"
    puts "    Attr URL: #{photo.attr_url}"
  end
end
