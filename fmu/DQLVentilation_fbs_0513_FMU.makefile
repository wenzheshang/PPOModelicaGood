# FIXME: before you push into master...
RUNTIMEDIR=D:/OM/include/omc/c/
#COPY_RUNTIMEFILES=$(FMI_ME_OBJS:%= && (OMCFILE=% && cp $(RUNTIMEDIR)/$$OMCFILE.c $$OMCFILE.c))

fmu:
	rm -f DQLVentilation_fbs_0513.fmutmp/sources/DQLVentilation_fbs_0513_init.xml
	cp -a "D:/OM/share/omc/runtime/c/fmi/buildproject/"* DQLVentilation_fbs_0513.fmutmp/sources
	cp -a DQLVentilation_fbs_0513_FMU.libs DQLVentilation_fbs_0513.fmutmp/sources/

