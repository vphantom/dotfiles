export PERL5LIB=$HOME/bin/lib

# Personal addition for user-level global NodeJS stuff
if [ -d "$HOME/.node_modules_global/bin" ]; then
	export PATH="$HOME/.node_modules_global/bin:$PATH"
fi

# Personal Go installation
if [ -d "$HOME/bin/go/bin" ]; then
	export PATH="$HOME/bin/go/bin:$PATH"
	export GOROOT=$HOME/bin/go
fi
if [ -d "$HOME/Secure/devel/go" ]; then
	export GOPATH=$HOME/Secure/devel/go
	export PATH="$PATH:$GOPATH/bin"
fi

