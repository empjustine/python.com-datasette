# /*─────────────────────────────────────────────────────────────────╗
# │ To the extent possible under law, Jared Miller has waived        │
# │ all copyright and related or neighboring rights to this file,    │
# │ as it is written in the following disclaimers:                   │
# │   • http://unlicense.org/                                        │
# ╚─────────────────────────────────────────────────────────────────*/
.PHONY: all clean test log ls log start start-daemon restart-daemon stop-daemon

PROJECT=datasette.com
PYTHON=python.com
PYTHON_DL=https://redbean.dev/python.com

ZIP=zip.com
ZIP_DL=https://redbean.dev/zip.com
UNZIP=unzip.com
UNZIP_DL=https://redbean.dev/unzip.com


all: add

${PYTHON}.template:
	curl -s ${PYTHON_DL} -o $@ -z $@ && chmod +x $@

${PROJECT}: ${PYTHON}.template
	cp ${PYTHON}.template ${PROJECT}

${ZIP}:
	curl -s ${ZIP_DL} -o $@ -z $@
	chmod +x ${ZIP}

venv/bin/pip:
	python -m venv venv

add: ${ZIP} ${PYTHON} venv/bin/pip
	cp -f ${PYTHON}.template ${PROJECT}
	venv/bin/pip install -r requirements.txt --target srv-pip/
	cd srv/ && ../${ZIP} -r ../${PROJECT} .args `ls -A`
	cd srv-pip/ && ../${ZIP} -r ../${PROJECT} `ls -A`

unzip.com: ; curl -s ${ZIP_DL} -o $@ -z $@
ls: unzip.com
	@unzip -vl ./${PYTHON} | grep -v 'usr/\|.symtab'

log: ${PROJECT}.log
	tail -f ${PROJECT}.log

start: ${PYTHON}
	./${PYTHON} -vv

clean:
	rm -f ${PYTHON} ${PYTHON}.template ${ZIP} ${UNZIP} srv-pip/
