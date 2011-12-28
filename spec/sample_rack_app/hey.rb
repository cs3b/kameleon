class Hey
  def initialize(filename_or_body)
    @body = get_body(filename_or_body)
  end

  def call(env)
    [200, {"Content-Type" => "text/plain"}, [@body]]
  end

  private

  def get_body(filename_or_body)
    File.open(File.dirname(__FILE__) + "/../dummy/#{filename_or_body}").read
  rescue
    filename_or_body
  end
end
