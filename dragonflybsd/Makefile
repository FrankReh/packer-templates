.PHONY: install-boxes minimal full

all: install-boxes

install-boxes: minimal full

minimal: dragonflybsd-minimal-virtualbox.box
	vagrant box add -f --name frankreh/dragonflybsd-minimal --provider virtualbox dragonflybsd-minimal-virtualbox.box

full: dragonflybsd-full-virtualbox.box
	vagrant box add -f --name frankreh/dragonflybsd-full --provider virtualbox dragonflybsd-full-virtualbox.box

dragonflybsd-minimal-virtualbox.box: dragonflybsd-minimal.json http/p Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso dragonflybsd-minimal.json

dragonflybsd-full-virtualbox.box: dragonflybsd-full.json http/p Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso dragonflybsd-full.json

clean: clean-boxes clean-vagrant clean-artifacts

clean-boxes:
	-rm *.box

clean-vagrant:
	-rm -rf .vagrant

clean-artifacts:
	-rm -rf packer_cache

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
