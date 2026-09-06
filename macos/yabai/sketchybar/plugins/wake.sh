#!/usr/bin/env bash

# Refresh every item once the machine comes back from sleep.
#
# The SENDER guard is load-bearing, not defensive. `sketchybar --update` forces
# every item to run its script, and wake_handler is itself an item — so an
# unguarded `--update` here re-triggers this script, which sleeps 2s and calls
# `--update` again, forever. Measured at 75 wake.sh/min with 100% of runs
# carrying SENDER=forced and not one carrying system_woke.
#
# The cascade also dragged every other item along with it, overriding their
# update_freq: wifi/battery (update_freq=30) ran ~200x/min and docker
# (update_freq=120, ~1.03s/run) ran ~86x/min, which on its own is roughly 1.5
# cores of pure shell.
#
# On a forced or routine update SENDER is "forced"/"routine", so the loop dies
# here and only a genuine system_woke gets through.
[ "$SENDER" = "system_woke" ] || exit 0

# Give yabai a moment to come back after wake before refreshing.
sleep 2
sketchybar --update
