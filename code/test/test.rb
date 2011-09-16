#!/usr/bin/ruby

$:.unshift File.join(%w{ ../lib })

require 'parsers.rb'
require 'pp'

latex_test_docs = %w{documents/01/doc.tex}

latex_test_docs.each do |doc|
  l = LaTeXDocument.new(doc)

  puts "Document \"#{doc}\" has been marked with the following annotations:"
  puts "  CC-Lic: #{l.annotation.lic}"
  puts "  CC-Attribution-Name: #{l.annotation.attr_name}"
  puts "  CC-Attribution-URL: #{l.annotation.attr_url}"
  puts "  CC-Commercial-Use: #{l.annotation.commercial_use}"
  puts "Document \"#{doc}\" has #{l.images.size} images with the following licenses:"
  l.images.each_with_index do |photo, i|
    puts "  #{i+1}) #{File.basename(photo.fname)}:"
    puts "    License: #{photo.license}"
    puts "    Attr Name: #{photo.attr_name}"
    puts "    Attr URL: #{photo.attr_url}"
  end
end
