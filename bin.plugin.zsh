
# --- ack ---
if [[ -f ~/bin/ack ]]; then
	alias acki='ack -i'
fi


# --- h ---
if [[ -f ~/bin/h.sh ]]; then
	source $(readlink -f ~/bin/h.sh)
	alias hlog='h -i error "info|success\w+" "warn\w+|exit\w+"'
fi

