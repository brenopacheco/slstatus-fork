# See LICENSE file for copyright and license details
# slstatus - suckless status monitor
.POSIX:

include config.mk

REQ = util
COM =\
	components/battery\
	components/cat\
	components/cpu\
	components/datetime\
	components/disk\
	components/entropy\
	components/hostname\
	components/ip\
	components/kernel_release\
	components/keyboard_indicators\
	components/keymap\
	components/load_avg\
	components/netspeeds\
	components/num_files\
	components/ram\
	components/run_command\
	components/swap\
	components/temperature\
	components/uptime\
	components/user\
	components/volume\
	components/wifi

all: slstatus

.c.o:
	$(CC) -o $@ -c $(CPPFLAGS) $(CFLAGS) $<

slstatus: slstatus.o $(COM:=.o) $(REQ:=.o)
	$(CC) -o $@ $(LDFLAGS) $(COM:=.o) $(REQ:=.o) slstatus.o $(LDLIBS)

version:
	@echo ${VERSION}

clean:
	rm -f slstatus slstatus.o $(COM:=.o) $(REQ:=.o) slstatus-${VERSION}.tar.gz

dist: all
	tar --create --file=slstatus-${VERSION}.tar --transform 's,^,bin/,' --mode='755' slstatus
	tar --append --file=slstatus-${VERSION}.tar --transform 's,^,share/man/man1/,' --mode='644' slstatus.1
	tar --append --file=slstatus-${VERSION}.tar --transform 's,^,share/licenses/slstatus/,' --mode='644' LICENSE
	gzip -f slstatus-${VERSION}.tar
