class Hey
  def call(env)
    if  env["PATH_INFO"] == "/"
      [200, {"Content-Type" => "text"}, ['welcome on homepage']]
    else
      [200, {"Content-Type" => "text/html"}, [get_body(env['PATH_INFO'])]]
    end
  end

  private

  def get_body(filename)
    file = File.open(file_path(filename))
    body = file.read
    file.close
    body
  rescue
    filename
  end

  def file_path(filename)
    File.dirname(__FILE__) + "/../dummy/#{filename}"
  end
end
