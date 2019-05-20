
FROM julia

RUN apt-get update && apt-get install vim -y
RUN julia -e 'import Pkg; Pkg.add("HTTP")'
RUN julia -e 'import Pkg; Pkg.add("JSON")'
RUN julia -e 'using Pkg; Pkg.add("BufferedStreams")'
RUN julia -e 'using Pkg; Pkg.add("DataFrames")'

# Works but pulls from Github
#RUN julia -e 'using Pkg; Pkg.clone("https://github.com/ssikdar1/Jrill")'

# So far this seems to work for testing locally
ADD .  /usr/local/julia/share/julia/stdlib/v1.1/Jrill/

WORKDIR home
