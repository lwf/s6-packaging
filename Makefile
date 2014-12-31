VERSION := 2.0.0.0
REVISION := 1
ARCH := $(shell dpkg --print-architecture)

skalibs_version := $(VERSION)
s6_version := $(VERSION)
execline_version := $(VERSION)

skalibs_revision := $(REVISION)
s6_revision := $(REVISION)
execline_revision := $(REVISION)

skalibs_debs = $(addsuffix _$(skalibs_version)-$(skalibs_revision)_$(ARCH).deb,skalibs skalibs-dev)
execline_debs = execline_$(execline_version)-$(execline_revision)_$(ARCH).deb
s6_debs = s6_$(s6_version)-$(s6_revision)_$(ARCH).deb

all: skalibs execline s6

skalibs: $(skalibs_debs)

execline: $(execline_debs)

s6: $(s6_debs)

$(skalibs_debs): skalibs_$(skalibs_version).orig.tar.gz
	cd skalibs-$(skalibs_version) && \
		debuild -uc -us

skalibs_$(skalibs_version).orig.tar.gz:
	wget -O$@ http://skarnet.org/software/skalibs/skalibs-$(skalibs_version).tar.gz

$(execline_debs):
	cd execline-$(execline_version) && \
		debuild -uc -us

$(s6_debs):
	cd s6-$(s6_version) && \
		debuild -uc -us
