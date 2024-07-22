
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

AG_VERSION := 1.0.2
BIN := $(HOME)/bin
TIG_VERSION := 2.4.1

# Useful
targets += abduco
targets += devour
#targets += diagon
targets += fzf
targets += nnn

targets += h.sh
targets += tldr
targets += ansi
targets += cowsay

# Rust targets
rust_targets += bat
rust_targets += code-minimap
rust_targets += exa
rust_targets += fd
#rust_targets += lazycli
rust_targets += rg
#rust_targets += ruplacer
CARGO_HOME := $(shell mktemp -d)/cargo

# --- all ---
all: $(BIN) $(targets)

targets:
	@echo $(targets)


# ==============================================================================
# GITHUB TARGETS
# ==============================================================================

# --- abduco ---
abduco: abduco.git/abduco
	cp $^ $@
abduco.git/abduco: abduco.git
	make -C abduco.git
abduco.git:
	git clone --depth 1 https://github.com/toddyamakawa/abduco $@
	git -C $@ remote add upstream https://github.com/martanne/abduco

# --- devour ---
diagon: diagon.git/diagon
	cp $^ $@
	touch $@
diagon.git/diagon: diagon.git
	make -C $^
	touch $@
diagon.git:
	git clone --depth 1 https://github.com/ArthurSonzogni/Diagon $@

# --- devour ---
devour: devour.git/devour
	cp $^ $@
devour.git/devour: devour.git
	make -C devour.git
devour.git:
	git clone --depth 1 https://github.com/salman-abedin/devour $@

# --- dtach ---
dtach: dtach.git/dtach
	cp $^ $@
dtach.git/dtach: dtach.git/config.h
	make -C dtach.git
dtach.git/config.h: dtach.git
	cd $^ && ./configure
dtach.git:
	# REVISIT: Check out a specific commit
	git clone --depth 1 https://github.com/crigler/dtach.git $@

# --- fzf ---
# TODO: Make this into order only pre-req
# https://www.gnu.org/software/make/manual/html_node/Prerequisite-Types.html
fzf: fzf.git/bin/fzf
	cp $^ $@
fzf.git/bin/fzf: fzf.git
	fzf.git/install --no-key-bindings --no-completion --no-update-rc
	touch $@
fzf.git:
	git clone --depth 1 https://github.com/junegunn/fzf $@

# --- Gum ---
gum: gum.git/gum
	cp $^ $@
gum.git/gum: gum.git
	go build $@
gum.git:
	git clone --depth 1 https://github.com/charmbracelet/gum.git $@

# --- nnn ---
nnn: nnn.git/nnn
	ln -sf $^ $@
nnn.git:
	git clone --depth 1 https://github.com/toddyamakawa/nnn $@
	git -C $@ remote add upstream https://github.com/jarun/nnn
nnn.git/nnn: nnn.git
	make -C $(@D)


# ==============================================================================
# TARGETS
# ==============================================================================

# --- bin ---
$(BIN):
	ln -fns $(CURDIR) $(BIN)

# --- ack ---
ack:
	@wget -O $@ http://beyondgrep.com/ack-2.14-single-file
	@chmod +x $@

# --- ag ---
# TODO: Finish installation script
ag.tar.gz := the_silver_searcher-$(AG_VERSION).tar.gz
ag: $(HOME)/.ag/$(ag.tar.gz)
$(HOME)/.ag/$(ag.tar.gz):
	@mkdir -p $(@D)
	@wget -P $(@D) https://geoff.greer.fm/ggreer_gpg_key.asc
	@wget -P $(@D) https://geoff.greer.fm/ag/releases/$(ag.tar.gz)
	@wget -P $(@D) https://geoff.greer.fm/ag/releases/$(ag.tar.gz).asc
	@gpg --import $(@D)/ggreer_gpg_key.asc
	@gpg --verify $@.asc $@
	@tar xzf $@ -C $(@D)

# --- ansi ---
ansi:
	@curl -o $@ -OL git.io/ansi
	@chmod +x $@

# --- cowsay ---
cowsay: cowsay-repo/cli.js
	ln -sf $^ $@
cowsay-repo:
	git clone https://github.com/piuccio/cowsay $@
cowsay-repo/cli.js: cowsay-repo
	npm install --prefix $^ $^
	touch $@

# --- h.sh ---
h.sh:
	@curl -o $@ https://raw.githubusercontent.com/paoloantinori/hhighlighter/master/h.sh

# --- ticker.sh ---
ticker.sh:
	@curl -o $@ https://raw.githubusercontent.com/pstadler/ticker.sh/master/ticker.sh

# --- tig ---
tig: tig-repo
tig-repo:
	git clone https://github.com/jonas/tig $@
	git -C $@ checkout tig-$(TIG_VERSION)

# --- tldr ---
tldr:
	@curl -o $@ https://raw.githubusercontent.com/pepa65/tldr-bash-client/master/tldr
	@chmod +x $@


# ==============================================================================
# RUST TARGETS
# ==============================================================================
rust_targets: $(rust_targets)
bat:
	CARGO_HOME=$(CARGO_HOME) cargo install --git https://github.com/sharkdp/bat
	cp $(CARGO_HOME)/bin/bat .
code-minimap:
	CARGO_HOME=$(CARGO_HOME) cargo install --git https://github.com/wfxr/code-minimap
	cp $(CARGO_HOME)/bin/$@ .
exa:
	CARGO_HOME=$(CARGO_HOME) cargo install --git https://github.com/ogham/exa
	cp $(CARGO_HOME)/bin/$@ .
fd:
	CARGO_HOME=$(CARGO_HOME) cargo install --git https://github.com/sharkdp/fd
	cp $(CARGO_HOME)/bin/$@ .
lazycli:
	CARGO_HOME=$(CARGO_HOME) cargo install --git https://github.com/jesseduffield/lazycli
	cp $(CARGO_HOME)/bin/$@ .
rg:
	CARGO_HOME=$(CARGO_HOME) cargo install --git https://github.com/BurntSushi/ripgrep
	cp $(CARGO_HOME)/bin/$@ .
ruplacer:
	CARGO_HOME=$(CARGO_HOME) cargo install --git https://github.com/dmerejkowsky/ruplacer
	cp $(CARGO_HOME)/bin/$@ .

