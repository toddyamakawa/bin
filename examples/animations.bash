#!/usr/bin/env bash
# https://github.com/Silejonu/bash_loading_animations/blob/main/bash_loading_animations.sh
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
# Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.

# ASCII Animations
classic=( 0.25 '-' '\' '|' '/' )
box=( 0.2 ┤ ┴ ├ ┬ )
bubble=( 0.6 · o O O o · )
breathe=( 0.9 '  ()  ' ' (  ) ' '(    )' ' (  ) ' )
growing_dots=( 0.5 '.  ' '.. ' '...' '.. ' '.  ' '   ' )
passing_dots=( 0.25 '.  ' '.. ' '...' ' ..' '  .' '   ' )
metro=( 0.2 '[    ]' '[=   ]' '[==  ]' '[=== ]' '[ ===]' '[  ==]' '[   =]' )

# UTF-8 Animations
classic_utf8=( 0.25 '—' '\' '|' '/' )
bounce=( 0.3 . · ˙ · )
vertical_block=( 0.25 ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ █ ▇ ▆ ▅ ▄ ▃ ▁ )
horizontal_block=( 0.25 ▏ ▎ ▍ ▌ ▋ ▊ ▉ ▉ ▊ ▋ ▌ ▍ ▎ ▏ )
quarter=( 0.25 ▖ ▘ ▝ ▗ )
triangle=( 0.45 ◢ ◣ ◤ ◥)
semi_circle=( 0.1 ◐ ◓ ◑ ◒ )
rotating_eyes=( 0.4 ◡◡ ⊙⊙ ⊙⊙ ◠◠ )
firework=( 0.4 '⢀' '⠠' '⠐' '⠈' '*' '*' ' ' )
braille=( 0.2 ⠁ ⠂ ⠄ ⡀ ⢀ ⠠ ⠐ ⠈ )
braille_whitespace=( 0.2 ⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷ )
trigram=( 0.25 ☰ ☱ ☳ ☶ ☴ )
arrow=( 0.15 ▹▹▹▹▹ ▸▹▹▹▹ ▹▸▹▹▹ ▹▹▸▹▹ ▹▹▹▸▹ ▹▹▹▹▸ ▹▹▹▹▹ ▹▹▹▹▹ ▹▹▹▹▹ ▹▹▹▹▹ ▹▹▹▹▹ ▹▹▹▹▹ ▹▹▹▹▹ )
bouncing_ball=( 0.4 '(●     )' '( ●    )' '(  ●   )' '(   ●  )' '(    ● )' '(     ●)' '(    ● )' '(   ●  )' '(  ●   )' '( ●    )' )
big_dot=( 0.7 ∙∙∙ ●∙∙ ∙●∙ ∙∙● )
modern_metro=( 0.15 ▰▱▱▱▱▱▱ ▰▰▱▱▱▱▱ ▰▰▰▱▱▱▱ ▱▰▰▰▱▱▱ ▱▱▰▰▰▱▱ ▱▱▱▰▰▰▱ ▱▱▱▱▰▰▰ ▱▱▱▱▱▰▰ ▱▱▱▱▱▱▰ ▱▱▱▱▱▱▱ ▱▱▱▱▱▱▱ ▱▱▱▱▱▱▱ ▱▱▱▱▱▱▱ )
pong=( 0.35 '▐⠂       ▌' '▐⠈       ▌' '▐ ⠂      ▌' '▐ ⠠      ▌' '▐  ⡀     ▌' '▐  ⠠     ▌' '▐   ⠂    ▌' '▐   ⠈    ▌' '▐    ⠂   ▌' '▐    ⠠   ▌' '▐     ⡀  ▌' '▐     ⠠  ▌' '▐      ⠂ ▌' '▐      ⠈ ▌' '▐       ⠂▌' '▐       ⠠▌' '▐       ⡀▌' '▐      ⠠ ▌' '▐      ⠂ ▌' '▐     ⠈  ▌' '▐     ⠂  ▌' '▐    ⠠   ▌' '▐    ⡀   ▌' '▐   ⠠    ▌' '▐   ⠂    ▌' '▐  ⠈     ▌' '▐  ⠂     ▌' '▐ ⠠      ▌' '▐ ⡀      ▌' '▐⠠       ▌' )
earth=( 0.45 🌍 🌎 🌏 )
clock=( 0.2 🕛 🕐 🕑 🕒 🕓 🕔 🕕 🕖 🕗 🕘 🕙 🕚 )
moon=( 0.8 🌑 🌒 🌓 🌔 🌕 🌖 🌗 🌘 )
orange_pulse=( 0.35 🔸 🔶 🟠 🟠 🔶 )
blue_pulse=( 0.35 🔹 🔷 🔵 🔵 🔷 )
football=( 0.25 ' 👧⚽️       👦' '👧  ⚽️      👦' '👧   ⚽️     👦' '👧    ⚽️    👦' '👧     ⚽️   👦' '👧      ⚽️  👦' '👧       ⚽️👦 ' '👧      ⚽️  👦' '👧     ⚽️   👦' '👧    ⚽️    👦' '👧   ⚽️     👦' '👧  ⚽️      👦' )
blink=( 0.25 😐 😐 😐 😐 😐 😐 😐 😐 😐 😑 )
camera=( 0.1 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📸 📷 📸 )
sparkling_camera=( 0.1 '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📸✨' '📷 ' '📸✨' )
sick=( 0.9 🤢 🤢 🤮 )
monkey=( 0.4 🙉 🙈 🙊 🙈 )
bomb=( 0.25 '💣   ' ' 💣  ' '  💣 ' '   💣' '   💣' '   💣' '   💣' '   💣' '   💥' '    ' '    ' )

