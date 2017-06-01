
AG_VERSION := 1.0.2
BIN := $(HOME)/bin

# --- all ---
all: $(BIN) ack ag ansi

# --- bin ---
bin: $(BIN)
$(BIN):
	@ln -fs $(PWD) $(BIN)

# --- ack ---
ack:
	@wget -O $@ http://beyondgrep.com/ack-2.14-single-file
	@chmod +x $@

# --- ag ---
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

# --- clean ---
clean:
	rm ack ag ansi

