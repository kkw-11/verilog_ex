
RTL_DIR   = ./rtl
TB_DIR    = ./tb
BUILD_DIR = ./build
FILELIST  = files.f
SIMV      = $(BUILD_DIR)/simv

TOP     ?= fifo_top_tb
TB_FILE  = $(TB_DIR)/$(TOP).sv

INCDIR    = +incdir+$(RTL_DIR) +incdir+$(TB_DIR)

VCS_OPT   = -full64 -sverilog -debug_access+all -kdb -lca \
            -timescale=1ns/1ps \
            -top $(TOP) \
            -l $(BUILD_DIR)/compile.log \
            -o $(SIMV)

ifeq ($(findstring uvm,$(TOP)),uvm)
VCS_OPT  += -ntb_opts uvm-1.2
endif

SIMV_OPTS  = -l $(BUILD_DIR)/sim.log
# SIMV_OPTS += +UVM_VERBOSITY=UVM_HIGH
# SIMV_OPTS += -cm line+cond+fsm+tgl+branch+assert -cm_dir $(BUILD_DIR)/coverage.vdb -cm_name sim1

.PHONY: all filelist compile run verdi clean

all: compile run

filelist:
	@find $(RTL_DIR) -name "*.sv" > $(FILELIST)
	@if [ ! -f $(TB_FILE) ]; then \
		echo "ERROR: $(TB_FILE) 이 없습니다. TOP=<tb 파일명(확장자 제외)> 로 지정하세요."; \
		exit 1; \
	fi
	@echo $(TB_FILE) >> $(FILELIST)

compile: filelist
	@mkdir -p $(BUILD_DIR)
	vcs $(VCS_OPT) $(INCDIR) -f $(FILELIST)

run: compile
	$(SIMV) $(SIMV_OPTS)

verdi:
	verdi -dbdir $(SIMV).daidir -ssf wave.fsdb &

clean:
	rm -rf $(BUILD_DIR) csrc novas* ucli.key verdiLog $(FILELIST) \
	       *.fsdb inter.fsdb* simv* DVEfiles