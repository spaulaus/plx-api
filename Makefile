SUBDIRS	= \
	  PlxApi                   \

all:      $(SUBDIRS)
	for i in $(SUBDIRS); do $(MAKE) -C $$i all; sleep 2; done
	@echo


clean:    $(SUBDIRS)
	for i in $(SUBDIRS); do $(MAKE) -C $$i clean; sleep 1; done
	@echo


cleanall: $(SUBDIRS)
	for i in $(SUBDIRS); do $(MAKE) -C $$i cleanall; sleep 1; done
	@echo
