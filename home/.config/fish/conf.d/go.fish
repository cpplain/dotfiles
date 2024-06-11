if type -fq go
    set -gx GOPATH (go env GOPATH)
    fish_add_path $GOPATH/bin
end
