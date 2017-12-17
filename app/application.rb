class Application
  @@items = Array.new

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    item_name = req.path.split(/items/).last.downcase.delete('/')
    item = @@items.detect{ |i| i.name.downcase == item_name}

    if @@items.include?(item)
      resp.write item.price
      resp.status = 200
    elsif req.path.match(/items/)
      resp.write "Item not found"
      resp.status = 400
    else
      resp.write "Route not found."
      resp.status = 404
    end

    resp.finish
  end
end
