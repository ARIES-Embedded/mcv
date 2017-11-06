#
# MCV reference project
#
# Copyright (C) 2016-2017 ARIES Embedded GmbH
#

PROJECT := mcv_reference
# CONFIG  := c2

QSYS_FILE := mcv_hps.qsys

VERILOG_FILES := mcv_reference.v

QSYS_SYSTEM_NAME := $(subst .qsys,,$(QSYS_FILE))
QSYS_QIP_FILE := $(QSYS_SYSTEM_NAME)/synthesis/$(QSYS_SYSTEM_NAME).qip

ASSIGNMENT_FILES := $(PROJECT).qpf $(PROJECT).qsf

SOURCE_FILES := $(ASSIGNMENT_FILES) $(VERILOG_FILES) $(QSYS_QIP_FILE)

OUTPUT_DIR := ./output_files

STAMP := echo done >
RM    := rm -f

QUARTUS := quartus
#Q_ARGS  := --read_settings_file=off --write_settings_file=off $(PROJECT) -c $(PROJECT)_$(CONFIG)
Q_ARGS  := --read_settings_file=off --write_settings_file=off $(PROJECT) -c $(PROJECT)

.PHONY: all clean distclean clean-qsys

all: $(OUTPUT_DIR)/$(PROJECT).sof $(OUTPUT_DIR)/$(PROJECT).rbf

distclean: clean clean-qsys
	$(RM) -r db incremental_db simulation
	$(RM) *~ *.bak

clean-qsys:
	$(RM) -r $(QSYS_SYSTEM_NAME) .qsys_edit
	$(RM) $(QSYS_SYSTEM_NAME).{cmp,html,sopcinfo}

clean-git:
	git clean -d -f

clean:
	$(RM) -r $(OUTPUT_DIR)
	$(RM) *~ *.rpt *.chg *.htm *.txt *.eqn *.pin *.sof *.pof *.summary

.PHONY: cfg

cfg: $(OUTPUT_DIR)/$(PROJECT).sof
	$(QUARTUS)_pgm $(PROJECT)_sof.cdf

$(OUTPUT_DIR)/$(PROJECT).sof: asm
$(OUTPUT_DIR)/$(PROJECT).pof: asm

$(QSYS_QIP_FILE): $(QSYS_FILE)
	qsys-generate --synthesis=VERILOG $<

.PHONY: map fit asm sta
map: $(OUTPUT_DIR)/$(PROJECT).map.rpt
fit: $(OUTPUT_DIR)/$(PROJECT).fit.rpt
asm: $(OUTPUT_DIR)/$(PROJECT).asm.rpt
sta: $(OUTPUT_DIR)/$(PROJECT).sta.rpt

#MAP_ARGS := --read_settings_file=on --write_settings_file=off $(PROJECT) -c $(PROJECT)_$(CONFIG)
MAP_ARGS := --read_settings_file=on --write_settings_file=off $(PROJECT) -c $(PROJECT)
FIT_ARGS := $(Q_ARGS)
ASM_ARGS := $(Q_ARGS)
STA_ARGS := $(PROJECT)

$(OUTPUT_DIR)/$(PROJECT).map.rpt: map.chg $(SOURCE_FILES) $(IP_FILES)
	$(QUARTUS)_map $(MAP_ARGS)
	$(STAMP) fit.chg

$(OUTPUT_DIR)/$(PROJECT).fit.rpt: fit.chg $(OUTPUT_DIR)/$(PROJECT).map.rpt $(PIN_ASSIGNMENTS)
	$(QUARTUS)_fit $(FIT_ARGS)
	$(STAMP) asm.chg
	$(STAMP) sta.chg

$(OUTPUT_DIR)/$(PROJECT).asm.rpt: asm.chg $(OUTPUT_DIR)/$(PROJECT).fit.rpt
	$(QUARTUS)_asm $(ASM_ARGS)

$(OUTPUT_DIR)/$(PROJECT).sta.rpt: sta.chg $(OUTPUT_DIR)/$(PROJECT).fit.rpt
	$(QUARTUS)_sta $(STA_ARGS)

map.chg:
	$(STAMP) map.chg
fit.chg:
	$(STAMP) fit.chg
sta.chg:
	$(STAMP) sta.chg
asm.chg:
	$(STAMP) asm.chg
