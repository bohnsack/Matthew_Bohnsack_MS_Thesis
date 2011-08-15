# Class to parse LaTeX documents, obtaining information about the indended
# license and licenses of any embedded images

require 'rubygems'
require 'mini_exiftool'

##########################################################################
## Common Classes Used in All Parsers ####################################
##########################################################################

class Annotation
  def initialize
  end
end

class Image
  def initialize(fname)
    @fname = fname
    @photo = MiniExiftool.new fname
  end

  def license
    @photo.License
  end

  def attribution_name
    @photo.AttributionName
  end

  def attribution_url
    @photo.AttributionURL
  end
end

##########################################################################
## Filetype-Specific Parsers #############################################
##########################################################################

# LaTeX Document Parser
class LaTeXDocument
  def initialize(fname, lname)
    @fname  = fname
    @images = Array.new
    @annotation = Annotation.new
  end

  def parse
  end
end
