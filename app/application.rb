class Application
  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    
    item_name = req.path.split(/items/).last
    item = @@items.find{ |i| i.name == item_name}

    if @@items.include?{ |i| i.name == item_name }
      resp.write item.price
      resp.status = 200
    else
      resp.write "Route not found."
      resp.status = 404
    end

    resp.finish
  end
end
