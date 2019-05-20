
build:
	docker build -t my_julia .

julia:
	docker run -i -v ${CURDIR}:/home/Jrill -t my_julia /bin/bash

drill-shell:
	docker run -i -p 8047:8047 -t drill/apache-drill:1.16.0 /bin/bash  

drill:
	docker run -i  -p 8047:8047 --detach -t drill/apache-drill:1.16.0 /bin/bash
