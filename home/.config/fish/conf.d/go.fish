command -q go || exit

set -gx GOPATH (go env GOPATH)
fish_add_path -gP $GOPATH/bin
