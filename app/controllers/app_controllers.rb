class AppControllers

  def call(env); end

private

  def respond_with(body, type = 'text/html; charset=utf-8', status = 200)
   [status, { 'Content-Type' => type }, [body]]
  end

  def render_json(body="", status = 200)
    respond_with body, 'application/json; charset=utf-8', status
  end

  def parse_query(query)
    begin
      Hash[*query.split(/=|&/)]
    rescue
      Hash.new
    end
  end
end