# Configuration of the compsys system
autoload -Uz compinit
ZCOMPDUMP=${ZCACHEDIR}/zcompdump

fpath+=( $HOME/.zsh/completions )
typeset -U fpath

# Use cache if updated within 24hr.
if [[ -n $ZCOMPDUMP(.mh+24) ]]
then
	compinit -d $ZCOMPDUMP
else
	compinit -C -d $ZCOMPDUMP
fi

# zstyle ':completion:function:completer:command:argument:tag'
# 'completion' - indicates this style is used by the completion system
# 'function' - if completion is caleld from a named widget.  Typ. blank, but is set by widgets such as 'predict-on' and the various functions in the Widget direcotry to the name of that function
# 'completer' - the name of the function (without leading _ and with other _ replaced by -).  In control of how completion is to be performed.
# 'command' or context just as it apperaf following the #compdef tag or compdef function.
# 'argument' - indicates which command line or option argument is being completed.
# 'tag' - used to discriminate types of matches.
#
# The below uses normal completion as the first argument to the option -o of the dvips command
# zstyle ':completion::complete:dvips:option-o-1:files'
#
# _complete_help bindable command shows all possible tags in an order given by the completion function.
# Automatically rehash commands
# Might be better to replace with a pacman hook as per the Arch Wiki
zstyle ':completion:*' rehash true

# Use a cache for completions
zstyle ':completion:*:complete:*' use-cache true
zstyle ':completion:*:complete:*' cache-path $ZCACHEDIR/compcache

# Use menu selection
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes

# Group matches
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{default}%B--- %d ---%b%f'

# Warning message when no matches
zstyle ':completion:*:warnings' format '%F{red}Sorry, no matches for: %d%f'

# Colour file matches
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS:-\'\'}

# Smart case matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Fuzzy match mistyped completions
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

# Partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

# Page completions if necessary
zmodload zsh/complist
zstyle ':completion:*:default' list-prompt '%S%M matches %s'

# Command specifics {{{1
# kill -Always list PIDS
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# cd - ignore parent directory in cases like ../<TAB>
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# End of specific commands 1}}}

# vim: set foldmethod=marker:
