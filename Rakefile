require "coffee-script"
require "closure-compiler"
require "less"
require "yui/compressor"
require "image_optim"

DOCDIR      = "doc"
OUTDIR      = "rel"
SRCDIR      = "src"

def dir(root, o={:ext=>"",:dir=>""})
  path = o[:dir] || ""
  ext  = o[:ext] || ""

  File.join root, "#{path}#{ext}"
end

def outdir(dir="")
  dir OUTDIR, {:dir => dir}
end

def docdir(dir="", ext="html")
  dir DOCDIR, {:dir => dir, :ext => ext}
end

def srcdir(dir="")
  dir SRCDIR, {:dir => dir}
end

def documented
  [
  ]
end

def compile_coffeescript(&block)
  FileList[srcdir("js")].each do |src|
    res = { :dest => src.gsub(/\.coffee/, ""), :out => "" }
    File.open(src, "r") { |f| res[:out] = CoffeeScript.compile(f.read) }
    yield res if block_given?
    File.open(res[:dest], "w") { |f| f.write(res[:out]) }
  end
end

def compile_less(&block)
  Dir[srcdir("less/*.less")].each do |src|
    res = {:dest => src.gsub(/\.less/, ""), :out => ""}
    parser = Less::Parser.new({
      :paths => [srcdir("less"), srcdir("less/mixins")], :filename => src
    })
    File.open(src, "r") do |f|
      css = parser.parse(f.read)
      res[:out] = parser.parse.to_css
    end
    yield res if block_given?
    File.open(res[:dest], "w") { |f| f.write(res[:out]) }
  end
end

def compile_images(&block)

end

task "clean" do
  puts outdir
  # Recreate directory for a blank slate.
  rm_r  outdir, {:force => true, :secure => true}
  mkdir outdir
  mkdir outdir("img")
  mkdir outdir("css")
  mkdir outdir("js")
end

task "compile:images" => "clean" do
  cp_r srcdir("img"), outdir("img")
end

task "compile:images:min" => ["clean", "compile:images"] do
  io = ImageOptim.new(:pngout => true, :threads => true)
  io.optimize_images!(Dir[outdir("img/*.png")])
end

task "compile:js" => "clean" do
  compile_coffeescript
end

task "compile:js:min" => "clean" do
  compile_coffeescript do |res|
    res[:out] = Closure::Compiler.new.compile(res[:out], {
      :compilation_level => "ADVANCED_OPTIMIZATIONS"
    })
  end
end

task "compile:css" => "clean" do
  compile_less
end

task "compile:css:min" => "clean" do
  compile_less do |res|
    res[:out] = YUI::CssCompressor.new.compress(res[:out])
  end
end

task "build" => ["clean", "copy_images", "compile:css:min", "compile:js:min", "compile:images:min"] do
  puts "Ok"
end

task "build:doc" do
  rm_r  docdir, :force => true, :secure => true
  mkdir docdir
  system "tomdoc -f html #{documented} > #{docdir("index")}"
  system "open #{docdir("index")}"
end

task "test" do
  puts "No"
end
