class DummyApp
  @@public_path = File.join(File.expand_path("../../", __FILE__), 'public')

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
    File.join(@@public_path, filename)
  end
end
