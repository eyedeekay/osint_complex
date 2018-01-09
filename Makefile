
export PREFIX=/usr/local/

dummy:

.build:

build: nmap-docker-build osrframework-docker-build theharvester-docker-build

buildclean: nmap-docker-clobber osrframework-docker-clobber theharvester-docker-clobber
	rm -f .build

clean:
	rm -f nmap-vuln osrframework-run usufy entify searchfy mailfy domainfy phonefy

clobber: clean buildclean
	rm -rf nmap-vulners osrframework-run

rebuild: buildclean build

install: build nmap-install osrframework-install

remove: nmap-remove

nmap-docker-build: nmap-vulners
	docker build -f Dockerfile.nmap -t nmap-vulners .

nmap-docker-clobber:
	docker rm -f nmap-vulners 1>/dev/null 2>/dev/null; true

nmap-shortcut:
	@echo "#! /usr/bin/env sh"
	@echo "args=\"\$$@\""
	@echo "docker run --rm --name nmap-vulners -t n\"map-vulners \$$args\""

nmap-vuln:
	make -s nmap-shortcut | tee nmap-vuln
	chmod +x nmap-vuln

nmap-install: nmap-vulners nmap-vuln
	install -m755 nmap-vuln "$(PREFIX)/bin"

nmap-remove:
	rm "$(PREFIX)/bin/nmap-vuln"

nmap-vulners:
	git clone https://github.com/vulnersCom/nmap-vulners.git

osrframework-docker-build: osrframework
	docker build -f Dockerfile.osrframework -t osrframework .

osrframework-docker-clobber:
	docker rm -f osrframework 1>/dev/null 2>/dev/null; true

osrframework-shortcut:
	@echo "#! /usr/bin/env sh"
	@echo "args=\"\$$@\""
	@echo "echo \$$args"
	@echo "docker run --rm --name osrframework -t osrframework \"osrfconsole.py \$$args\""

usufy-shortcut:
	@echo "#! /usr/bin/env sh"
	@echo "args=\"\$$@\""
	@echo "echo \$$args"
	@echo "docker run --rm --name osrframework -t osrframework \"usufy.py \$$args\""

usufy:
	make -s usufy-shortcut | tee usufy

mailfy-shortcut:
	@echo "#! /usr/bin/env sh"
	@echo "args=\"\$$@\""
	@echo "echo \$$args"
	@echo "docker run --rm --name osrframework -t osrframework \"mailfy.py \$$args\""

mailfy:
	make -s mailfy-shortcut | tee mailfy

searchfy-shortcut:
	@echo "#! /usr/bin/env sh"
	@echo "args=\"\$$@\""
	@echo "echo \$$args"
	@echo "docker run --rm --name osrframework -t osrframework \"searchfy.py \$$args\""

searchfy:
	make -s searchfy-shortcut | tee searchfy

domainfy-shortcut:
	@echo "#! /usr/bin/env sh"
	@echo "args=\"\$$@\""
	@echo "echo \$$args"
	@echo "docker run --rm --name osrframework -t osrframework \"domainfy.py \$$args\""

domainfy:
	make -s domainfy-shortcut | tee domainfy

phonefy-shortcut:
	@echo "#! /usr/bin/env sh"
	@echo "args=\"\$$@\""
	@echo "echo \$$args"
	@echo "docker run --rm --name osrframework -t osrframework \"phonefy.py \$$args\""

phonefy:
	make -s phonefy-shortcut | tee phonefy

entify-shortcut:
	@echo "#! /usr/bin/env sh"
	@echo "args=\"\$$@\""
	@echo "echo \$$args"
	@echo "docker run --rm --name osrframework -t osrframework \"entify.py \$$args\""

entify:
	make -s entify-shortcut | tee entify

#-shortcut:

osrframework-run: usufy mailfy searchfy domainfy phonefy entify
	make -s osrframework-shortcut | tee osrframework-run

osrframework-install: osrframework-run
	install -m755 osrframework-run "$(PREFIX)/bin"
	install -m755 usufy "$(PREFIX)/bin"
	install -m755 mailfy "$(PREFIX)/bin"
	install -m755 searchfy "$(PREFIX)/bin"
	install -m755 domainfy "$(PREFIX)/bin"
	install -m755 phonefy "$(PREFIX)/bin"
	install -m755 entify "$(PREFIX)/bin"

osrframework:
	git clone https://github.com/i3visio/osrframework.git

theharvester-docker-build:
	docker build Dockerfile.theharvester -F -t theharvester .

theharvester-docker-clobber:
	docker rm -f theharvester 1>/dev/null 2>/dev/null; true

theharvester-shortcut:
	@echo "#! /usr/bin/env sh"
	@echo "args=\"\$$@\""
	@echo "echo \$$args"
	@echo "docker run --rm --name theharvester -t theharvester \"\$$args\""

harvester:
	make -s theharvester-shortcut | tee harvester

theharvester-install:
	install -m755 harvester "$(PREFIX)/bin"

theharvester:
	git clone https://github.com/laramies/theharvester.git
