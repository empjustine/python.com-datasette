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
all: add

${PYTHON}.template:
	curl -s ${PYTHON_DL} -o $@ -z $@ && chmod +x $@

${PROJECT}: ${PYTHON}.template
	cp -f ${PYTHON}.template ${PROJECT}

${ZIP}:
	curl -s ${ZIP_DL} -o $@ -z $@
	chmod +x ${ZIP}

add: ${ZIP} ${PROJECT}
	python -m venv venv
	venv/bin/pip install -r requirements.txt --target venv/.python
	cd venv/ && ../${ZIP} -r ../${PROJECT} .python
	./${ZIP} -r ./${PROJECT} .python .args

start: ${PROJECT}
	./${PROJECT}

clean:
	rm -f ${PROJECT} ${PYTHON} ${PYTHON}.template ${ZIP}
	rm -rf venv/.python
