EXEC    =../../exec/nemsio_chgdate
FOPTS   =-O -FR -I$(NEMSIO_INC) -convert big_endian
LOPTS   = $(OPTS)
LIBS    =$(NEMSIO_LIB) $(BACIO_LIB4)
OBJS = nemsio_chgdate.o
SRCS = nemsio_chgdate.f90
# *************************************************************************
all: ${OBJS}
$(OBJS): $(SRCS)
	$(FCMP)  $(FOPTS) $(LOPTS) $(SRCS) -o $(EXEC) $(LIBS)
