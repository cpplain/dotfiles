set -gx HOMEBREW_BUNDLE_NO_LOCK 1

switch (uname -sm)
    case "Darwin arm64"
        set -gx HOMEBREW_PREFIX /opt/homebrew
        set -gx HOMEBREW_REPOSITORY $HOMEBREW_PREFIX
    case '*'
        set -gx HOMEBREW_PREFIX /usr/local
        set -gx HOMEBREW_REPOSITORY $HOMEBREW_PREFIX/Homebrew
end
set -gx HOMEBREW_CELLAR $HOMEBREW_PREFIX/Cellar

set -q MANPATH || set MANPATH ""
set -gxp MANPATH $HOMEBREW_PREFIX/share/man
set -q INFOPATH || set INFOPATH ""
set -gxp INFOPATH $HOMEBREW_PREFIX/share/info

fish_add_path -gP $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin
