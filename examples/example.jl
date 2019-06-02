using Jrill

println("hello world")

drill_conn = Jrill.drill_connection(ARGS[1], 8047) 
#println(drill_conn)

println(Jrill.make_url(drill_conn))

options = Jrill.drill_options(drill_conn)
#println(typeof(options))

#println(Jrill.drill_threads(drill_conn))
#println(Jrill.drill_metrics(drill_conn))

query = "SELECT * FROM sys.version"
#ret = Jrill.drill_query(drill_conn, query)
#println(ret)

ret = Jrill.drill_query(drill_conn, query, to_df=true)
#println(ret)
