# Jrill
Julia Library For Apache Drill


Inspiration:

https://drill.apache.org/docs/rest-api/

Python: https://github.com/PythonicNinja/pydrill
R/tidyverse: https://github.com/hrbrmstr/sergeant

## Installation
Running the following should install Jrill from github:

```
julia -e 'using Pkg; Pkg.clone("https://github.com/ssikdar1/Jrill")'
```


## Testing with Containers

To save setup time on your machine you can use the Makefile. `drill` and `drill-shell` simply launch the default drill image with port 8047 published.
`build` and `julia` make and build a julia image that puts the code into `/home`. From there you should be able to interface with Drill by using the 
host ip. ( `http://<host-ip>:8047`) 
