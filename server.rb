require "date"
require "latex_to_png"
require "./cache"

ROOT_LIB = File.dirname __FILE__



class Server

  def initialize env
    @env = env
    @cache = Cache.new @env
  end

  def call(env)

    if env["PATH_INFO"] == "/favicon.ico"
      return [ 204, {}, [] ]
    end

    formula = URI.unescape(env["PATH_INFO"].gsub(/.*formula\//, "").gsub(/\/size.*/,""))
    size =  env["PATH_INFO"].gsub(/.*size\//,"").to_i || 10

    data = @cache.get "latex:#{formula}:size:#{size}"
    status = 200
    
    if data
      puts "hit cache"
      
      return [ status, { "Content-Type" => "image/png" }, [ data ] ]
    else
      puts "no cache"
      
      begin
        tmp_file = LatexToPng::Convert.new(formula: formula, size: size ).to_png
      rescue => e
        formula = "erro"
        tmp_file = LatexToPng::Convert.new(formula: formula, size: size ).to_png
        status = 422
      end

      Thread.new {
        @cache.set("latex:#{formula}:size:#{size}" , open(tmp_file.path).read)
        image_path = "#{ROOT_LIB}/public/formula/#{formula}/size/#{size}"
        FileUtils.mkdir_p File.dirname(image_path)
        FileUtils.cp(tmp_file.path, image_path)
      }.run()

      [ status, { "Content-Type" => "image/png" }, tmp_file ]
    end
  end

end
