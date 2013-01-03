class PostsControllers < AppControllers

  def call(env)
    path = env["PATH_INFO"]
    method = env["REQUEST_METHOD"]
    case path
    when '/' || '' then
      case method
      when "GET" then
        index
      when "POST" then
        params = parse_query(env["rack.input"].read)
        create path, params
      else
        not_found
      end
    when /^\/\d+(.?\w+)?$/ then
      case method
      when "GET" then
        show path
      when "PUT" || "PATCH" then
        params = parse_query(env["rack.input"].read)
        update path, params
      when "DELETE" then
        destroy path
      else
        not_found
      end
    else
      not_found
    end
  end

private

  def index
    posts = Post.all
    body = Yajl::Encoder.encode posts
    render_json body
  end

  def show(path)
    id = path.match(/^\/\d+/)[0].split("/")[1].to_i
    post = Post.find(id)
    body = Yajl::Encoder.encode post.as_json
    render_json body
  end

  def create(path, params)
    puts params
    post = Post.new params
    if post.save
      render_json Yajl::Encoder.encode(post.as_json)
    else
      body = { "errors" => post.errors.full_messages }
      render_json Yajl::Encoder.encode(body), 422
    end
  end

  def update(path, params)
    id = path.match(/^\/\d+/)[0].split("/")[1].to_i
    post = Post.find(id)
    if post.update_attributes params
      render_json
    else
      body = { "errors" => post.errors.full_messages }
      render_json Yajl::Encoder.encode(body), 422
    end
  end

  def destroy(path)
    id = path.match(/^\/\d+/)[0].split("/")[1].to_i
    post = Post.find(id)
    if post.destroy
      render_json
    else
      render_json "", 422
    end
  end

  def not_found
    body = "not found"
    respond_with body, 'text/plain', 404
  end
end