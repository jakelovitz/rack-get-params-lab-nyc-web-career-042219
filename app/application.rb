class Application

  @@items = ["Apples","Carrots","Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    #my code starts here:
    if req.path.match(/cart/)
      if @@cart.size == 0
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
      #changes here
    elsif req.path.match(/add/)
      item = req.params["item"]

      if @@items.include?(item)
        @@cart << item
        resp.write "added #{item}"
      elsif @@items.include?(item) == false
        resp.write "We don't have that item."
      # else
      #   resp.write "Path Not Found"
      end

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
