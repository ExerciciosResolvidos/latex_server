require "date"
require "latex_to_png"

class Server

  ROOT_LIB = File.dirname __FILE__


  def call(env)
    formula=  URI.unescape(env["PATH_INFO"].gsub(/.*formula\//, "").gsub(/\/size.*/,""))
    size =  env["PATH_INFO"].gsub(/.*size\//,"").to_i || 10

# debugger
    begin
      tmp_file = LatexToPng::Convert.new(formula: formula,size: size ).to_png
      status = 200
    rescue => e
      formula = "erro"
      tmp_file = LatexToPng::Convert.new(formula: formula, size: size ).to_png
      status = 422
    end


    # image_path = resolve_path formula, size


    Thread.new {
        image_path = "#{ROOT_LIB}/public/formula/#{formula}/size/#{size}"
        FileUtils.mkdir_p File.dirname( image_path)
        FileUtils.cp(tmp_file.path, image_path)

    }.run()
    # if Env == "production"

    [status, { "Content-Type" => "image/png" }, tmp_file ]
  end

end
