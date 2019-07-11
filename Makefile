.PHONY: all
fl:=$(shell seq -w 0000 0099)
all: $(fl:%=STM/%.h5)

SHELL:=/bin/bash

# dos 是 Density of States，态密度
dos-position/%.h5: dos-momentum/%.h5
	mkdir -p $(dir $@)
	python3 scatter.py $^ $@

N-scatter/%.csv:
	echo $$(($$RANDOM % 50)) > $@

scatter-centers/%.csv: N-scatter/%.csv
	mkdir -p $(dir $@)
	python3 sample-centers.py $^ $@

# STM 是 scanning tunneling microscope 扫描隧道显微镜
STM/%.h5: dos-position/%.h5 scatter-centers/%.csv
	mkdir -p $(dir $@)
	python3 superimpose.py $^ $@
