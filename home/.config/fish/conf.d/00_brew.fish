set -gx HOMEBREW_BUNDLE_NO_LOCK 1

set brew /opt/homebrew/bin/brew
if test (uname -m) = x86_64
    set brew /usr/local/bin/brew
end

if type -fq $brew
    $brew shellenv | source
end

set -e brew
