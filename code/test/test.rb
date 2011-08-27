#!/usr/bin/ruby

require '../lib/parsers.rb'
require 'pp'

latex_test_docs = %w{documents/01/doc.tex}

latex_test_docs.each do |doc|
  p = LaTeXDocument.new(doc)
  p.parse
  pp p
end
