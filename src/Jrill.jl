module Jrill

using HTTP
using BufferedStreams
using DataFrames
import JSON

#TODO jdbc
# TODO organize repo into a module structure
# with different functions
# TODO HTTPS
# TODO <IP address or host name>
# TODO actual query 
# TODO results to Dataframe

struct DrillConnection
   host::String
   port::Int
   ssl::Bool
end

"""
	make_url(conn::DrillConnection)

Create base url for connection to Drill REST API

# Arguments
- `conn::DrillConnection`: Drill Connection info

# Returns
- base url string for HTTP requests
"""
function make_url(conn::DrillConnection)
    proto = conn.ssl ? "https" : "http"
    return "$proto://$(conn.host):$(conn.port)"
end

"""
   drill_query(conn::DrillConnection, query::String; to_df::Bool=false, limit::Int=nothing)

Submit a query and return results. 

# Arguments
- `conn::DrillConnection`: Drill Connection info
- `query::String`: query to submit
- `to_df::Bool=false`: to return as Dataframe otherwise return JSON.parse of the result
- `limit::Int=nothing`: sets autoLimit in the HTTP request to limit number of rows (Drill 1.16+)

# Returns
- Dataframe or the result of JSON.parse depending on to_df
"""
function drill_query(conn::DrillConnection, query::String; to_df::Bool=false, limit::Int=-1)
    url = make_url(conn)
    io = Base.BufferStream()
    headers = ["Content-Type" => "application/json"]
    params = Dict(
                  "queryType"=>"SQL",
                  "query" => query
                 )
    if limit != -1
       params["autoLimit"] = limit
    end

    r = HTTP.request("POST", "$url/query.json", 
             headers,
             JSON.json(params),
             response_stream=io)
    # TODO create Dataframe
    if to_df
       println(JSON.parse(io))
    else
      return JSON.parse(io)
    end
end


"""
	drill_cluster(conn::DrillConnection)	
	
Get Drillbit information, such as port numbers.

# Arguments
- `conn::DrillConnection`: Drill Connection info

# Returns
- the result of JSON.parse

"""
function drill_cluster(conn::DrillConnection)
    url = make_url(conn)
    io = Base.BufferStream()
    r = HTTP.request("GET", "$url/cluster.json", response_stream=io)
    return JSON.parse(io)
end


"""
	Get the status of Drill.

TODO
"""
#function drill_status(conn::DrillConnection)
#end

"""
	drill_metrics(conn::DrillConnection)

Get the current memory metrics.

# Arguments
- `conn::DrillConnection`: Drill Connection info

# Returns
- the result of JSON.parse

"""
function drill_metrics(conn::DrillConnection)
    url = make_url(conn)
    io = Base.BufferStream()
    r = HTTP.request("GET", "$url/status/metrics", response_stream=io)
    return JSON.parse(io)
end

"""
	drill_threads(conn::DrillConnection)

Get the status of threads.

# Arguments
- `conn::DrillConnection`: Drill Connection info

# Returns
- String of the request body
"""
function drill_threads(conn::DrillConnection)
    url = make_url(conn)
    r = HTTP.request("GET", "$url/status/threads")
    #TODO make this parasable/browsable in someway?
    return String(r.body)
end

"""
	drill_options(conn::DrillConnection)

List the name, default, and data type of the system and session options.

# Examples
```julia-repl
julia> dc = drill_connection("localhost", 8047) 
julia> drill_options(drill_conn) 
```
# Arguments
- `conn::DrillConnection`: Drill Connection info

# Returns
- the result of JSON.parse
"""
function drill_options(conn::DrillConnection)
    url = make_url(conn)
    io = Base.BufferStream()
    r = HTTP.request("GET", "$url/options.json", response_stream=io)
    return JSON.parse(io)
end


function drill_connection(host::String, port::Integer; ssl::Bool=false)
    return DrillConnection(host,port, ssl)
end

## Test block #
#println("hello world")
#
#drill_conn = drill_connection("192.168.0.20", 8047) 
#println(drill_conn)
#println(make_url(drill_conn))
##r = drill_options(drill_conn)
##println(typeof(r))
##println(drill_threads(drill_conn))
##println(drill_metrics(drill_conn))
## TODO timeout
##"http://192.168.0.20:8047/options.json"
#query = "SELECT * FROM sys.version"
#ret = drill_query(drill_conn, query)
#println(ret)

end # module
