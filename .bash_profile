# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;


# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter Thunderbird" killall;

#configure nvm
source $(brew --prefix nvm)/nvm.sh

#ssh key auto add
ssh-add ~/.ssh/id_rsa

#configure virtual env
export WORKON_HOME=~/Envs
source /usr/local/bin/virtualenvwrapper.sh

#disable bell
set bell-style visible

#alias
alias start-glassfish="/Applications/NetBeans/glassfish-4.1/bin/asadmin start-domain --debug --verbose"
alias redeploy-glassfish="/Users/stevennguyen/knorex/glassfish4/glassfish/bin/asadmin redeploy --name arise-cms-server ./target/*.war"
#docker
eval "$(docker-machine env default)"

export PATH="/Users/stevennguyen/.rbenv/shims:${PATH}"
