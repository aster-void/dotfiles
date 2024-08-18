bleopt highlight_syntax=
bleopt highlight_filename=
bleopt highlight_variable=
# bleopt complete_auto_complete=
bleopt complete_auto_delay=300
# bleopt complete_auto_history=
# bleopt complete_ambiguous=
bleopt complete_menu_complete=

bleopt complete_menu_filter=
bleopt exec_errexit_mark=

# Disable elapsed-time marker like "[ble: elapsed 1.203s (CPU 0.4%)]"
# bleopt exec_elapsed_mark=
# bleopt exec_elapsed_mark=$'\e[94m[%ss (%s %%)]\e[m'
# Tip: you may instead change the threshold of showing the mark
bleopt exec_elapsed_enabled='sys+usr>=10*60*1000' # e.g. ten minutes for total CPU usage
