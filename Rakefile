require "coffee-script"
require "less"
require "skim"
require "sprockets"
require "closure-compiler"
require "yui/compressor"
require "image_optim"

ROOTDIR = Pathname(File.dirname(__FILE__))
DOCDIR  = ROOTDIR.join "doc"
OUTDIR  = ROOTDIR.join "rel"
SRCDIR  = ROOTDIR.join "src"
VENDIR  = ROOTDIR.join "vendor"
BUNDLES = ["application.js", "application.css"]

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

def vendir(dir="")
  dir VENDIR, {:dir => dir}
end

def documented
  [
  ]
end

def sprockets
  @sprockets ||= Sprockets::Environment.new
end

task "clean" do
  # Recreate directory for a blank slate.
  rm_r  outdir, {:force => true, :secure => true}
  mkdir outdir
end

task "compress:images" => "clean" do
  cp_r srcdir("img"), outdir("img")

  io = ImageOptim.new(:pngout => true, :threads => true)
  io.optimize_images!(Dir[outdir("img/*.png")])
end

task "sprockets:setup" => "clean" do
  Skim::Engine.default_options[:use_asset] = true

  [srcdir("css"), srcdir("js"), srcdir("img"), vendir("js")].each do |path|
    sprockets.append_path path
  end

  sprockets.css_compressor = YUI::CssCompressor.new
  #sprockets.js_compressor = Closure::Compiler.new
end

task "sprockets:bundle" => ["clean", "sprockets:setup"] do
  BUNDLES.each do |bundle|
    assets = sprockets.find_asset(bundle)
    prefix, basename = assets.pathname.to_s.split('/')[-2..-1]

    puts "Compiling: #{basename}"

    mkpath outdir(prefix)
    assets.write_to(outdir(File.join(prefix, basename)))
  end
end

task "build" => ["clean", "sprockets:setup", "sprockets:bundle", "compress:images"] do
  cp srcdir("manifest.json"), outdir
  puts "Ok"
end

task "default" => "build"

task "build:doc" do
  rm_r  docdir, :force => true, :secure => true
  mkdir docdir
  system "tomdoc -f html #{documented} > #{docdir("index")}"
  system "open #{docdir("index")}"
end

task "test" do
  puts "No"
end
