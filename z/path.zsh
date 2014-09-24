# ----------------------------------------------------------------------
# Z tool
# Sourced from brew installed code
# ----------------------------------------------------------------------

z_path="$(brew --prefix)/etc/profile.d"

if [[ -d $z_path ]]; then
    source "${z_path}/z.sh"
fi
