#!/usr/bin/env bash

# Nags when the yabai daemon has been up for a long time.
#
# Why this exists: Mach port rights that WindowServer holds on a client's behalf
# are only reclaimed when that client's connection dies. Nothing in userspace can
# ask WindowServer to release them in place — there is no yabai flag, no
# launchctl verb, no API. Restarting the daemon is the only non-disruptive lever,
# so it's worth knowing when it was last done.
#
# Tune with: export YABAI_RESTART_AFTER_DAYS=14   (before this file is sourced)

: "${YABAI_RESTART_AFTER_DAYS:=7}"

# Whole days the running yabai daemon has been up. Prints nothing and returns
# non-zero when yabai isn't running or can't be read.
yabai_uptime_days() {
    command -v pgrep >/dev/null 2>&1 || return 1

    local pid etime
    pid="$(pgrep -x yabai 2>/dev/null | head -1)"
    [ -n "$pid" ] || return 1

    # `ps -o etime=` renders as [[dd-]hh:]mm:ss, so the day count is present
    # only once uptime passes 24h.
    etime="$(ps -p "$pid" -o etime= 2>/dev/null | tr -d '[:space:]')"
    [ -n "$etime" ] || return 1

    case "$etime" in
        *-*) printf '%s\n' "${etime%%-*}" ;;
        *)   printf '0\n' ;;
    esac
}

# Prints the warning if the threshold is met. Safe to call from a prompt.
yabai_uptime_check() {
    command -v yabai >/dev/null 2>&1 || return 0

    local days threshold
    days="$(yabai_uptime_days)" || return 0

    # Numeric guards: `test -ge` on a non-integer errors out, and this runs at
    # every prompt — an empty or hand-edited threshold must not print noise.
    threshold="$YABAI_RESTART_AFTER_DAYS"
    case "$threshold" in
        ''|*[!0-9]*) threshold=7 ;;
    esac
    case "$days" in
        ''|*[!0-9]*) return 0 ;;
    esac

    if [ "$days" -ge "$threshold" ]; then
        printf '\033[33m⚠  yabai has been running for %s days.\033[0m\n' "$days"
        printf '   Restart it to clear up any issues (frees accumulated Mach ports):\n'
        printf '     \033[36myabai --restart-service\033[0m\n'
    fi
}
