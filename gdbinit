source /home/krig/dots/gdb-dashboard.py
add-auto-load-safe-path /usr/share/go/src/runtime/runtime-gdb.py

set history save
set confirm off
set verbose off
set print pretty on
set print array off
set print array-indexes on
set python print-stack full

# Start ------------------------------------------------------------------------

python Dashboard.start()
