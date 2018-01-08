
export PREFIX=/usr/local/

dummy:

.build:

build: nmap-docker-build

buildclean: nmap-docker-clobber
	rm -f .build

clean:
	rm -f nmap-vuln

clobber: clean buildclean
	rm -rf nmap-vulners

rebuild: buildclean build

install: build nmap-install

remove: nmap-remove

nmap-docker-build: nmap-vulners
	docker build -f Dockerfile.nmap -t nmap-vulners .

nmap-docker-clobber:
	docker rm -f nmap-vulners 1>/dev/null 2>/dev/null; true

nmap-shortcut:
	@echo "#! /usr/bin/env sh"
	@echo "export args=\$$@"
	@echo "docker run --rm --name nmap-vulners -t nmap-vulners \$$args"

nmap-vuln:
	make -s nmap-shortcut | tee nmap-vuln
	chmod +x nmap-vuln

nmap-install: nmap-vulners nmap-vuln
	install -m755 nmap-vuln "$(PREFIX)/bin"

nmap-remove:
	rm "$(PREFIX)/bin/nmap-vuln"

nmap-vulners:
	git clone https://github.com/vulnersCom/nmap-vulners.git

