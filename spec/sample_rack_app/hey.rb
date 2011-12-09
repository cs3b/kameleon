class Hey

  def initialize(body)
    @body = body
  end

  def call(env)
    [200, {"Content-Type" => "text/plain"}, [@body]]
  end
end