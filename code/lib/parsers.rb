# Class to parse LaTeX documents, obtaining information about the indended
# license and licenses of any embedded images
# TODO: use proper rdoc

require 'cc_licensed'
require 'rubygems'
require 'mini_exiftool'

##########################################################################
## Common Classes Used in All Parsers ####################################
##########################################################################

class Annotation
  attr_reader :lic, :attr_name, :attr_url, :commercial_use
  def initialize(fname)

    debug = false

    @lic            = ""
    @attr_name      = ""
    @attr_url       = ""
    @commercial_use = ""

    # Example annotation that this class extracts
    #% CC-Lic: BY
    #% CC-Attribution-Name: Matthew Bohnsack
    #% CC-Attribution-URL: http://bohnsack.com/
    #% CC-Commercial-Use: F

    # TODO: need to catch file open exceptions
    f = File.open(fname, "r")

    f.each_line do |line|
      if m = line.match(/%\s+CC-Lic: (.+)/)
        @lic = m[1]
        puts "CC-Lic: #{@lic}" if debug
      elsif m = line.match(/%\s+CC-Attribution-Name: (.+)/)
        @attr_name = m[1]
        puts "CC-Attribution-Name: #{@attr_name}" if debug
      elsif m = line.match(/%\s+CC-Attribution-URL: (.+)/)
        @attr_url = m[1]
        puts "CC-Attribution-URL: #{@attr_url}" if debug
      elsif m = line.match(/%\s+CC-Commercial-Use: (.+)/)
        @commercial_use = m[1]
        puts "CC-Commercial-Use: #{@commercial_use}" if debug
      end
    end

    f.close
  end
end

class Image
  include CCLicensed
  def initialize(fname)
    @fname = fname
    @photo = MiniExiftool.new fname

    # We look via regex at the license URL that should be embedded in each
    # image via XMP.  E.g., "http://creativecommons.org/licenses/by/3.0/" =>
    # 'Attribution'
    case @photo.License
    when %r|/zero/|     # 0
      @photo.set_lic 'PublicDomain'
    when %r|/by/|       # 1
      @photo.set_lic 'Attribution'
    when %r|/by-sa/|    # 2
      @photo.set_lic 'Attribution-ShareAlike'
    when %r|/by-nd/|    # 3
      @photo.set_lic 'Attribution-NoDerivs'
    when %r|/by-nc/|    # 4
      @photo.set_lic 'Attribution-NonCommercial'
    when %r|/by-nc-sa/| # 6
      @photo.set_lic 'Attribution-NonCommercial-ShareAlike'
    when %r|/by-nc-nd/| # 7
      @photo.set_lic 'Attribution-NonCommercial-NoDerives'
    else
      # TODO, what do we do when we can't determine the license type?
      raise "Unsupported Creative Commons License Type"
    end
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
    @annotation = Annotation.new(@fname)
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
