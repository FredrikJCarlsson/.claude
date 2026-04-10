#!/usr/bin/env bash
input=$(cat)

cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // ""')

git_root=$(git -C "$cwd" --no-optional-locks rev-parse --show-toplevel 2>/dev/null)
if [ -n "$git_root" ]; then
    folder=$(basename "$git_root")
else
    folder=$(basename "$cwd")
fi

branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
model=$(echo "$input" | jq -r '.model.display_name // ""')
thinking=$(echo "$input" | jq -r '.thinking.effort_level // .effortLevel // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five_hour_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_day_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Build model+thinking segment
model_seg=""
if [ -n "$model" ]; then
    model_seg="$model"
    [ -n "$thinking" ] && model_seg+=" ($thinking)"
fi

caveman_text=""
caveman_flag="$HOME/.claude/.caveman-active"
if [ -f "$caveman_flag" ]; then
  caveman_mode=$(cat "$caveman_flag" 2>/dev/null)
  if [ "$caveman_mode" = "full" ] || [ -z "$caveman_mode" ]; then
    caveman_text="\033[38;5;172m[CAVEMAN]\033[0m"
  else
    caveman_suffix=$(echo "$caveman_mode" | tr '[:lower:]' '[:upper:]')
    caveman_text="\033[38;5;172m[CAVEMAN:${caveman_suffix}]\033[0m"
  fi
fi

SEP="   "

parts=("$folder")
[ -n "$branch" ] && parts+=("$branch")
[ -n "$model_seg" ] && parts+=("$model_seg")
[ -n "$used_pct" ] && parts+=("ctx:$(printf '%.0f' "$used_pct")%")
[ -n "$five_hour_pct" ] && parts+=("5h:$(printf '%.0f' "$five_hour_pct")%")
[ -n "$seven_day_pct" ] && parts+=("7d:$(printf '%.0f' "$seven_day_pct")%")
[ -n "$caveman_text" ] && parts+=("$caveman_text")

result=""
for part in "${parts[@]}"; do
    [ -n "$result" ] && result+="${SEP}"
    result+="$part"
done

printf '%b' "$result"
