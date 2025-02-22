#!zsh
#
# Installation
# ------------
#
# To achieve git-flow completion nirvana:
#
#  0. Update your zsh's git-completion module to the newest verion.
#     From here. http://zsh.git.sourceforge.net/git/gitweb.cgi?p=zsh/zsh;a=blob_plain;f=Completion/Unix/Command/_git;hb=HEAD
#
#  1. Install this file. Either:
#
#     a. Place it in your .zshrc:
#
#     b. Or, copy it somewhere (e.g. ~/.git-flow-completion.zsh) and put the following line in
#        your .zshrc:
#
#            source ~/.git-flow-completion.zsh
#
#     c. Or, use this file as a oh-my-zsh plugin.
#
#
# The Fine Print
# --------------
# Author:
# Copyright (c) 2021 Sourajyoti Basak
#
# Original Author:
# Copyright not mentioned

_git-flow ()
{
	local curcontext="$curcontext" state line
	typeset -A opt_args

	_arguments -C \
		':command:->command' \
		'*::options:->options'

	case $state in
		(command)

			local -a subcommands
			subcommands=(
				'init:Initialize a new git repo with support for the branching model.'
				'feature:Manage your feature branches.'
				'bugfix:Manage your bugfix branches'
				'release:Manage your release branches.'
				'hotfix:Manage your hotfix branches.'
				'support:Manage your support branches.'
				'version:Shows version information.'
			)
			_describe -t commands 'git flow' subcommands
		;;

		(options)
			case $line[1] in

				(init)
					_arguments \
						-f'[Force setting of gitflow branches, even if already configured]'
					;;

					(version)
					;;

					(hotfix)
						__git-flow-hotfix
					;;

					(release)
						__git-flow-release
					;;

					(feature)
						__git-flow-feature
					;;
					(bugfix)
						__git-flow-bugfix
					;;
			esac
		;;
	esac
}

__git-flow-release ()
{
	local curcontext="$curcontext" state line
	typeset -A opt_args

	_arguments -C \
		':command:->command' \
		'*::options:->options'

	case $state in
		(command)

			local -a subcommands
			subcommands=(
				'start:Start a new release branch.'
				'finish:Finish a release branch.'
				'list:List all your release branches. (Alias to `git flow release`)'
				'publish:Publish release branch to remote.'
				'track:Checkout remote release branch.'
			)
			_describe -t commands 'git flow release' subcommands
			_arguments \
				-v'[Verbose (more) output]'
		;;

		(options)
			case $line[1] in

				(start)
					_arguments \
						-F'[Fetch from origin before performing finish]'\
						':version:__git_flow_version_list'
				;;

				(finish)
					_arguments \
						-F'[Fetch from origin before performing finish]' \
						-s'[Sign the release tag cryptographically]'\
						-u'[Use the given GPG-key for the digital signature (implies -s)]'\
						-m'[Use the given tag message]'\
						-p'[Push to $ORIGIN after performing finish]'\
						':version:__git_flow_version_list'
				;;

				(publish)
					_arguments \
						':version:__git_flow_version_list'
				;;

				(track)
					_arguments \
						':version:__git_flow_version_list'
				;;

				*)
					_arguments \
						-v'[Verbose (more) output]'
				;;
			esac
		;;
	esac
}

__git-flow-hotfix ()
{
	local curcontext="$curcontext" state line
	typeset -A opt_args

	_arguments -C \
		':command:->command' \
		'*::options:->options'

	case $state in
		(command)

			local -a subcommands
			subcommands=(
				'start:Start a new hotfix branch.'
				'finish:Finish a hotfix branch.'
				'list:List all your hotfix branches. (Alias to `git flow hotfix`)'
			)
			_describe -t commands 'git flow hotfix' subcommands
			_arguments \
				-v'[Verbose (more) output]'
		;;

		(options)
			case $line[1] in

				(start)
					_arguments \
						-F'[Fetch from origin before performing finish]'\
						':hotfix:__git_flow_version_list'\
						':branch-name:__git_branch_names'
				;;

				(finish)
					_arguments \
						-F'[Fetch from origin before performing finish]' \
						-s'[Sign the release tag cryptographically]'\
						-u'[Use the given GPG-key for the digital signature (implies -s)]'\
						-m'[Use the given tag message]'\
						-p'[Push to $ORIGIN after performing finish]'\
						':hotfix:__git_flow_hotfix_list'
				;;

				*)
					_arguments \
						-v'[Verbose (more) output]'
				;;
			esac
		;;
	esac
}

__git-flow-feature ()
{
	local curcontext="$curcontext" state line
	typeset -A opt_args

	_arguments -C \
		':command:->command' \
		'*::options:->options'

	case $state in
		(command)

			local -a subcommands
			subcommands=(
				'start:Start a new feature branch.'
				'finish:Finish a feature branch.'
				'list:List all your feature branches. (Alias to `git flow feature`)'
				'publish:Publish feature branch to remote.'
				'track:Checkout remote feature branch.'
				'diff:Show all changes.'
				'rebase:Rebase from integration branch.'
				'checkout:Checkout local feature branch.'
				'pull:Pull changes from remote.'
			)
			_describe -t commands 'git flow feature' subcommands
			_arguments \
				-v'[Verbose (more) output]'
		;;

		(options)
			case $line[1] in

				(start)
					_arguments \
						-F'[Fetch from origin before performing finish]'\
						':feature:__git_flow_feature_list'\
						':branch-name:__git_branch_names'
				;;

				(finish)
					_arguments \
						-F'[Fetch from origin before performing finish]' \
						-r'[Rebase instead of merge]'\
						':feature:__git_flow_feature_list'
				;;

				(publish)
					_arguments \
						':feature:__git_flow_feature_list'\
				;;

				(track)
					_arguments \
						':feature:__git_flow_feature_list'\
				;;

				(diff)
					_arguments \
						':branch:__git_branch_names'\
				;;

				(rebase)
					_arguments \
						-i'[Do an interactive rebase]' \
						':branch:__git_branch_names'
				;;

				(checkout)
					_arguments \
						':branch:__git_flow_feature_list'\
				;;

				(pull)
					_arguments \
						':remote:__git_remotes'\
						':branch:__git_branch_names'
				;;

				*)
					_arguments \
						-v'[Verbose (more) output]'
				;;
			esac
		;;
	esac
}

__git-flow-bugfix () {
	local curcontext="$curcontext" state line
	typeset -A opt_args

	_arguments -C \
		':command:->command' \
		'*::options:->options'

	case $state in
		(command)

			local -a subcommands
			subcommands=(
				'list:List bugfix branches'
				'start:Start a new bugfix branch'
				'finish:Finish a bugfix branch'
				'publish:Publish a bugfix branch'
				'track:Track a remote bugfix branch'
				'diff:Show all changes'
				'rebase:Perform a rebase'
				'checkout:Checkout a bugfix branch'
				'pull:Pull a bugfix branch'
				'delete:Delete a bugfix branch'
				'rename:Rename a bugfix branch'
			)
			_describe -t commands 'git flow bugfix' subcommands
			_arguments \
				-v'[Verbose (more) output]' \
				-h'[Show help]'
		;;

	(options)
		case $line[1] in

			(start)
				_arguments -s \
					'(-h --help)'{-h,--help}'[Show help]' \
					'(-F --fetch)'{-f,--fetch}'[Fetch from origin first]' \
					--showcommands'[Show git commands while executing them]' \
					':bugfix:__git_flow_bugfix_list' \
					':branch-name:__git_branch_names'
			;;

			(finish)
				_arguments -s \
					'(-h --help)'{-h,--help}'[Show help]' \
					'(-f --fetch)'{-F,--fetch}'[Fetch from origin before performing finish]' \
					'(-r --rebase)'{-r,--rebase}'[Rebase instead of merge]' \
					'(-p --preserve-merges)'{-p,--preserve-merges}'[Preserve merges while rebasing]' \
					'(-k --keep)'{-k,--keep}'[Keep branch after performing finish]' \
					'(-D --force_delete)'{-D,--force_delete}'[Force delete bugfix branch after finish]' \
					'(-S --squash)'{-S,--squash}'[Squash bugfix during merge]' \
					--showcommands'[Show git commands while executing them]' \
					--keepremote'[Keep the remote branch]' \
					--keeplocal'[Keep the local branch]' \
					--no-ff'[Never fast-forward during merge]' \
					':bugfix:__git_flow_bugfix_list'
			;;	

			(publish)
				_arguments -s \
					'(-h --help)'{-h,--help}'[Show help]' \
					--showcommands'[Show git commands while executing them]' \
					':bugfix:__git_flow_bugfix_list'
			;;

			(track)
				_arguments -s \
					'(-h --help)'{-h,--help}'[Show help]' \
					--showcommands'[Show git commands while executing them]' \
					':bugfix:__git_flow_bugfix_list'
			;;

			(diff)
				_arguments -s \
					'(-h --help)'{-h,--help}'[Show help]' \
					--showcommands'[Show git commands while executing them]' \
					':branch:__git_branch_names'
			;;

			(rebase)
				_arguments -s \
					'(-h --help)'{-h,--help}'[Show help]' \
					'(-i --interactive)'{-i,--interactive}'[Do an interactive rebase]' \
					'(-p --preserve-merges)'{-p,--preserve-merges}'[Preserve merges]' \
					--showcommands'[Show git commands while executing them]' \
					':branch:__git_branch_names'
			;;

			(checkout)
				_arguments -s \
					'(-h --help)'{-h,--help}'[Show help]' \
					--showcommands'[Show git commands while executing them]' \
					':bugfix:__git_flow_bugfix_list'
			;;

			(pull)
				_arguments -s \
					'(-h --help)'{-h,--help}'[Show help]' \
					--showcommands'[Show git commands while executing them]' \
					':bugfix:__git_remotes' \
					':branch:__git_branch_names'
			;;

			(delete)
				_arguments -s \
					'(-h --help)'{-h,--help}'[Show help]' \
					'(-f --force)'{-f,--force}'[Force deletion]' \
					'(-r --remote)'{-r,--remote}'[Delete remote branch]' \
					--showcommands'[Show git commands while executing them]' \
					':bugfix:__git_flow_bugfix_list'
			;;

			(rename)
				_arguments -s \
					'(-h --help)'{-h,--help}'[Show help]' \
					--showcommands'[Show git commands while executing them]' \
					':bugfix:__git_flow_bugfix_list'
			;;
	esac
	;;
esac
}

__git_flow_version_list ()
{
	local expl
	declare -a versions

	versions=(${${(f)"$(_call_program versions git flow release list 2> /dev/null | tr -d ' |*')"}})
	__git_command_successful || return

	_wanted versions expl 'version' compadd $versions
}

__git_flow_feature_list ()
{
	local expl
	declare -a features

	features=(${${(f)"$(_call_program features git flow feature list 2> /dev/null | tr -d ' |*')"}})
	__git_command_successful || return

	_wanted features expl 'feature' compadd $features
}

__git_flow_bugfix_list () {
	local expl
	declare -a bugfixes

	bugfixes=(${${(f)"$(_call_program bugfixes git flow bugfix list 2> /dev/null | tr -d ' |*')"}})
	__git_command_successful || return

	_wanted bugfixes expl 'bugfix' compadd $bugfixes
}

__git_remotes () {
	local expl gitdir remotes

	gitdir=$(_call_program gitdir git rev-parse --git-dir 2>/dev/null)
	__git_command_successful || return

	remotes=(${${(f)"$(_call_program remotes git config --get-regexp '"^remote\..*\.url$"')"}//#(#b)remote.(*).url */$match[1]})
	__git_command_successful || return

	# TODO: Should combine the two instead of either or.
	if (( $#remotes > 0 )); then
		_wanted remotes expl remote compadd $* - $remotes
	else
		_wanted remotes expl remote _files $* - -W "($gitdir/remotes)" -g "$gitdir/remotes/*"
	fi
}

__git_flow_hotfix_list ()
{
	local expl
	declare -a hotfixes

	hotfixes=(${${(f)"$(_call_program hotfixes git flow hotfix list 2> /dev/null | tr -d ' |*')"}})
	__git_command_successful || return

	_wanted hotfixes expl 'hotfix' compadd $hotfixes
}

__git_branch_names () {
	local expl
	declare -a branch_names

	branch_names=(${${(f)"$(_call_program branchrefs git for-each-ref --format='"%(refname)"' refs/heads 2>/dev/null)"}#refs/heads/})
	__git_command_successful || return

	_wanted branch-names expl branch-name compadd $* - $branch_names
}

__git_command_successful () {
	if (( ${#pipestatus:#0} > 0 )); then
		_message 'not a git repository'
		return 1
	fi
	return 0
}

zstyle -g existing_user_commands ':completion:*:*:git:*' user-commands

zstyle ':completion:*:*:git:*' user-commands $existing_user_commands flow:'provide high-level repository operations'
