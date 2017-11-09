#
# MCV reference project
#
# Copyright (C) 2016-2017 ARIES Embedded GmbH
#

PROJECT := mcv_reference
CONFIG  := c2
#CONFIG  := c6

QSYS_FILE := mcv_hps.qsys

VERILOG_FILES := mcv_reference.v

QSYS_SYSTEM_NAME := $(subst .qsys,,$(QSYS_FILE))
QSYS_QIP_FILE := $(QSYS_SYSTEM_NAME)/synthesis/$(QSYS_SYSTEM_NAME).qip

ASSIGNMENT_FILES := $(PROJECT).qpf $(widlcard *.qsf)

SOURCE_FILES := $(ASSIGNMENT_FILES) $(VERILOG_FILES) $(QSYS_QIP_FILE)

OUTPUT_DIR := ./output_files

STAMP := echo done >
RM    := rm -f

QUARTUS := quartus
#Q_ARGS  := --read_settings_file=off --write_settings_file=off $(PROJECT) -c $(CONFIG)
Q_ARGS  := --read_settings_file=off --write_settings_file=off $(PROJECT) -c $(CONFIG)

.PHONY: all clean distclean clean-qsys

all: $(OUTPUT_DIR)/$(CONFIG).sof $(OUTPUT_DIR)/$(CONFIG).rbf

distclean: clean clean-qsys
	$(RM) -r db incremental_db simulation
	$(RM) *.qws *.sopcinfo *.csv
	$(RM) *~ *.bak

clean-qsys:
	$(RM) -r $(QSYS_SYSTEM_NAME) .qsys_edit
	$(RM) $(QSYS_SYSTEM_NAME).{cmp,html,sopcinfo}

clean-git:
	git clean -d -f

clean:
	$(RM) -r $(OUTPUT_DIR)
	$(RM) -r hps_isw_handoff
	$(RM) *~ *.rpt *.chg *.htm *.txt *.eqn *.pin *.sof *.pof *.rbf *.summary

.PHONY: cfg

cfg: $(OUTPUT_DIR)/$(CONFIG).sof
	$(QUARTUS)_pgm $(CONFIG)_sof.cdf

$(OUTPUT_DIR)/$(CONFIG).sof: asm
$(OUTPUT_DIR)/$(CONFIG).rbf: asm

$(QSYS_QIP_FILE): $(QSYS_FILE)
	qsys-generate --synthesis=VERILOG $<

.PHONY: qsys map fit asm sta
qsys:$(QSYS_QIP_FILE)
map: $(OUTPUT_DIR)/$(CONFIG).map.rpt
fit: $(OUTPUT_DIR)/$(CONFIG).fit.rpt
asm: $(OUTPUT_DIR)/$(CONFIG).asm.rpt
sta: $(OUTPUT_DIR)/$(CONFIG).sta.rpt

#MAP_ARGS := --read_settings_file=on --write_settings_file=off $(PROJECT) -c $(CONFIG)
MAP_ARGS := --read_settings_file=on --write_settings_file=off $(PROJECT) -c $(CONFIG)
FIT_ARGS := $(Q_ARGS)
ASM_ARGS := $(Q_ARGS)
STA_ARGS := $(CONFIG)

$(OUTPUT_DIR)/$(CONFIG).map.rpt: map.chg $(SOURCE_FILES) $(IP_FILES)
	$(QUARTUS)_map $(MAP_ARGS)
	$(STAMP) fit.chg

$(OUTPUT_DIR)/$(CONFIG).fit.rpt: fit.chg $(OUTPUT_DIR)/$(CONFIG).map.rpt $(PIN_ASSIGNMENTS)
	$(QUARTUS)_fit $(FIT_ARGS)
	$(STAMP) asm.chg
	$(STAMP) sta.chg

$(OUTPUT_DIR)/$(CONFIG).asm.rpt: asm.chg $(OUTPUT_DIR)/$(CONFIG).fit.rpt
	$(QUARTUS)_asm $(ASM_ARGS)

$(OUTPUT_DIR)/$(CONFIG).sta.rpt: sta.chg $(OUTPUT_DIR)/$(CONFIG).fit.rpt
	$(QUARTUS)_sta $(STA_ARGS)

map.chg:
	$(STAMP) map.chg
fit.chg:
	$(STAMP) fit.chg
sta.chg:
	$(STAMP) sta.chg
asm.chg:
	$(STAMP) asm.chg