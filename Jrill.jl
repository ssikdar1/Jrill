
using HTTP
using BufferedStreams
import JSON

# TODO make a connection class
# TODO organize repo into a module structure
# with different functions
# TODO HTTPS
# TODO <IP address or host name>
# TODO actual query 
# TODO results to Dataframe
# TODO is this slow?

function drill_options()
    HTTP.open("GET", "http://192.168.0.20:8047/options.json") do http
       io = BufferedInputStream(http)
       println(JSON.parse(io))
    end	
end


println("hello world")
drill_options()
