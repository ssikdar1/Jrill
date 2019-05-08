using HTTP;


#  TODO make a connection class
# with different functions
# TODO HTTPS
# TODO <IP address or host name>
# TODO actual query 
# TODO results to Dataframe

function drill_options()
    r = HTTP.request("GET", "http://localhost:8047/options.json";)
    println(r.status)
    println(String(r.body))
end


println("hello world")
drill_options()
