# Parse INI style config files in Bash
# Source: https://github.com/sukima/config-parser
# Version: 2.1.2
parse_ini() {
  [[ -z "$1" || -e "$1" ]] || return 1
  local system_sed=$(which sed)
  local safe_name_replace='s/[ 	]*$//;s/[^a-zA-Z0-9_]/_/g'
  local trimming="s/^[\"']\(.*\)[\"'][;]*$/\1/;s/\"/\\\\\"/g"
  echo "config.global() {"
  echo "  :"
  cat ${1:--} | \
    $system_sed '/^[ 	]*#/d;/^[ 	]*$/d' | \
    while IFS="= " read var val; do
      case "$var" in
        \[*])
          echo "}"
          section="$(echo "${var:1:${#var}-2}" | "$system_sed" "$safe_name_replace")"
          section="${section%"${section##*[![:space:]]}"}"
          section="${section#"${section%%[![:space:]]*}"}"
          echo "config.section.${section}() {"
          echo "  :"
          ;;
        *)
          var="$(echo "$var" | "$system_sed" "$safe_name_replace")"
          var="${var%"${var##*[![:space:]]}"}"
          var="${var#"${var%%[![:space:]]*}"}"
          val="${val%"${val##*[![:space:]]}"}"
          val="${val#"${val%%[![:space:]]*}"}"
          val="$(echo "$val" | "$system_sed" "$trimming")"
          echo "  ${var}=\"${val}\""
          ;;
      esac
    done
  echo "}"
}

config_parser() {
  eval "$(parse_ini $1)"
}
