
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

struct DrillConnection
   host::String
   port::Int
   ssl::Bool
end


function make_url(conn::DrillConnection)
    proto = conn.ssl ? "https" : "http"
    return "$proto://$(conn.host):$(conn.port)"
end

function drill_options(conn::DrillConnection)
    url = make_url(conn)
    HTTP.open("GET", "$url/options.json") do http
       io = BufferedInputStream(http)
       println(JSON.parse(io))
    end	
end


function drill_connection(host::String, port::Integer; ssl::Bool=false)
    return DrillConnection(host,port, ssl)
end

println("hello world")

drill_conn = drill_connection("localhost", 8047) 
println(drill_conn)
println(make_url(drill_conn))
drill_options(drill_conn)
# TODO timeout
"http://192.168.0.20:8047/options.json"
