.PHONY: all
fl:=$(shell seq -w 0000 0099)
all: $(fl:%=STM/%.png) $(fl:%=STM/m/%.png)
all: $(fl:%=STM/damp/%.png) $(fl:%=STM/damp/m/%.png)

SHELL:=/bin/bash

# dos 是 Density of States，态密度
dos-position/%.h5: dos-momentum/%.h5
	mkdir -p $(dir $@)
	python3 scatter.py 0 $^ $@

# 磁性散射中心，在散射中心带 pi 相位差
dos-position/m/%.h5: dos-momentum/%.h5
	mkdir -p $(dir $@)
	python3 scatter.py 1 $^ $@

# 加入退相干衰减
dos-position/damp/%.h5: dos-position/%.h5
	mkdir -p $(dir $@)
	python3 damping.py $^ $@

dos-position/m/damp/%.h5: dos-position/m/%.h5
	mkdir -p $(dir $@)
	python3 damping.py $^ $@


# 画倒空间等能面附近电子态密度图
p_momentum/%.png: dos-momentum/%.h5
	mkdir -p $(dir $@)
	python3 gimage.py 0 $^ $@

# 画实空间散射中心周围电子态密度图
STM/%.png: dos-position/%.h5
	mkdir -p $(dir $@)
	python3 gimage.py 1 $^ $@

# Delete partial files when the processes are killed.
.DELETE_ON_ERROR:
# Keep intermediate files around
.SECONDARY:
