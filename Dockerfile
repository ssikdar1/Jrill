
FROM julia

RUN apt-get update && apt-get install vim -y
RUN julia -e 'import Pkg; Pkg.add("HTTP")'
RUN julia -e 'import Pkg; Pkg.add("JSON")'
RUN julia -e 'using Pkg; Pkg.add("BufferedStreams")'
RUN julia -e 'using Pkg; Pkg.add("Parameters")'

WORKDIR home


