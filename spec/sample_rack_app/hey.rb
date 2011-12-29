class Hey
  def initialize(filename = 'default')
    @body = get_body(filename)
  end

  def call(env)
    [200, {"Content-Type" => "text/plain"}, [@body]]
  end

  private

  def get_body(filename)
    File.open(File.dirname(__FILE__) + "/../dummy/#{filename}").read
  rescue
    filename
  end
end
