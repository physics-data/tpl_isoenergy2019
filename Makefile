.PHONY: all
fl:=$(shell seq -w 00 99)
all: $(fl:%=STM-%.h5)

# dos 是 Density of States，态密度
dos-position_%.h5: dos-momentum_%.h5
	python3 scatter.py $^ $@

scatter-centers_%.csv: N-scatter_%.csv
	python3 sample-centers.py $^ $@

# STM 是 scanning tunneling microscope 扫描隧道显微镜
STM-%.h5: dos-position_%.h5 scatter-centers_%.csv
	python3 superimpose.py $^ $@
