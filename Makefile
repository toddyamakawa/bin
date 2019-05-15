
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

AG_VERSION := 1.0.2
BIN := $(HOME)/bin
FZF := $(CURDIR)/fzf
TIG_VERSION := 2.4.1

targets := ack ansi h.sh tldr $(HOME)/.fzf.zsh

# --- all ---
all: $(BIN) $(targets)

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
	ln -s $^ $@
cowsay-repo:
	git clone https://github.com/piuccio/cowsay $@
cowsay-repo/node_modules: cowsay-repo
	npm install --prefix $^ $^
cowsay-repo/cli.js: cowsay-repo/node_modules

# --- fzf ---
$(HOME)/.fzf.zsh: $(HOME)/.fzf
	$(HOME)/.fzf/install --no-key-bindings --no-completion --no-update-rc
$(HOME)/.fzf: $(FZF)
	ln -fns $(FZF) $(@)
$(FZF):
	git clone --depth 1 https://github.com/junegunn/fzf

# --- h.sh ---
h.sh:
	@curl -o $@ https://raw.githubusercontent.com/paoloantinori/hhighlighter/master/h.sh

# --- tig ---
tig: tig-repo
tig-repo:
	git clone https://github.com/jonas/tig $@
	git -C $@ checkout tig-$(TIG_VERSION)

# --- tldr ---
tldr:
	@curl -o $@ https://raw.githubusercontent.com/pepa65/tldr-bash-client/master/tldr
	@chmod +x $@

# --- clean ---
clean:
	rm -rf $(targets)

