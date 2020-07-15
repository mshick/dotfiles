compdef _c c

function _c {
  _path_files -W $PROJECTS -/
  _path_files -W $GOPATH/src/github.com -/
}
