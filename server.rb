require "date"
require "latex_to_png"

class Server

  ROOT_LIB = File.dirname __FILE__
  

  def call(env)
    Logger.write "path = #{env["PATH_INFO"]}\n"
    formula=  URI.unescape(env["PATH_INFO"].gsub(/.*formula\//, "").gsub(/\/size.*/,""))
    size =  env["PATH_INFO"].gsub(/.*size\//,"").to_i || 10
    Logger.write "formula = #{formula}\n"
    Logger.write "size = #{size}\n"
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

    if Env == "production"
      image_path = "#{ROOT_LIB}/public/formula/#{formula}/size/#{size}"

      # gambiarra para caminho com /current/ no capistrano
      begin
        FileUtils.mkdir_p File.dirname( image_path)
        FileUtils.cp(tmp_file.path, image_path) 
      rescue => e
        image_path = tmp_file.path
      end
    else
      image_path = tmp_file.path
    end

    [status, { "Content-Type" => "image/png" }, open(image_path) ]
  end

end
