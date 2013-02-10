# ----------------------------------------------------------------------
# Homebrew paths
# ----------------------------------------------------------------------

# prefer user homebrew directory if installed
[[ -d ~/.homebrew ]] && homebrew=~/.homebrew || homebrew=/usr/local

# PATH
for dir (
  $homebrew/sbin             # homebrew-installed system binaries
  $homebrew/bin              # homebrew-installed user binaries
  $homebrew/share/python     # homebrew python's distutils binaries
)
if [[ -d $dir ]];
  then path=($dir $path);
fi

# MANPATH
for dir (
  $homebrew/share/man        # homebrew-installed manpages
)
if [[ -d $dir ]];
  then manpath=($dir $manpath);
fi
