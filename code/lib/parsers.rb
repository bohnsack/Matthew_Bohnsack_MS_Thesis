# Class to parse LaTeX documents, obtaining information about the indended
# license and licenses of any embedded images
# TODO: use proper rdoc

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

  attr_reader :photo, :fname

  def license
    @photo.License
  end

  def attr_name
    @photo.AttributionName
  end

  def attr_url
    @photo.AttributionURL
  end
end

##########################################################################
## Filetype-Specific Parsers #############################################
##########################################################################

# LaTeX Document Parser
class LaTeXDocument

  def initialize(fname)
    @fname  = fname
    @images = Array.new
    @annotation = Annotation.new
    @dir = File.dirname(@fname)
    parse
  end

  attr_reader :fname, :images, :annotation, :dir

  # Given a file handle to a LaTeX file, go through the file, looking for image
  # files.  For each file that's found, get an Image object and add that object
  # to the @images array.
  #
  # This parser is currently really naive, as it is really only keying off of
  # "\includegraphics{imagename.ext}" directives that a) fully qualify the path
  # to the image, b) include the full extension, and c) have the whole command
  # on one line.  In addition, it's only working on images that have the
  # following extensions: %w{jpg png}
  def get_images
    target_exts = %w{jpg png}

    # TODO: need to catch file open exceptions
    f = File.open(@fname, "r")

    f.each_line do |line|
      if line.match(/includegraphics/) && !line.match(/%.+includegraphics/)
        target_exts.each do |ext|
          if m = line.match(/\{(.+\.#{ext})\}/)
            image_filename = m[1]
            # prepend relative path, if image file name doesn't start with a "/"
            image_filename = "#{@dir}/#{image_filename}" if !image_filename.match(/^\//)
            # TODO catch exceptions
            @images << Image.new(image_filename)
          end
        end
      end
    end

    f.close
  end

  def get_annotation
  end

  def parse
    get_images
    get_annotation
  end
end
