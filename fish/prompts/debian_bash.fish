# Defined interactively
function fish_prompt
    set -l __last_command_exit_status $status

    if not set -q -g __fish_robbyrussell_functions_defined
        set -g __fish_robbyrussell_functions_defined
        function _git_branch_name
            set -l branch (git symbolic-ref --quiet HEAD 2>/dev/null)
            if set -q branch[1]
                echo (string replace -r '^refs/heads/' '' $branch)
            else
                echo (git rev-parse --short HEAD 2>/dev/null)
            end
        end

        function _is_git_dirty
            echo (git status -s --ignore-submodules=dirty 2>/dev/null)
        end

        function _is_git_repo
            type -q git
            or return 1
            git rev-parse --git-dir >/dev/null 2>&1
        end

        function _hg_branch_name
            echo (hg branch 2>/dev/null)
        end

        function _is_hg_dirty
            echo (hg status -mard 2>/dev/null)
        end

        function _is_hg_repo
            fish_print_hg_root >/dev/null
        end

        function _repo_branch_name
            _$argv[1]_branch_name
        end

        function _is_repo_dirty
            _is_$argv[1]_dirty
        end

        function _repo_type
            if _is_hg_repo
                echo hg
                return 0
            else if _is_git_repo
                echo git
                return 0
            end
            return 1
        end
    end

    set -l cyan (set_color -o cyan)
    set -l yellow (set_color -o yellow)
    set -l red (set_color -o red)
    set -l green (set_color -o green)
    set -l blue (set_color -o blue)
    set -l normal (set_color normal)

    set -l user_sign_color "$normal"
    if test $__last_command_exit_status != 0
        set user_sign_color "$red"
    end

    set -l user_sign "$user_sign_color\$"
    if test "$USER" = root
        set user_sign "$user_sign_color#"
    end
    
    set -g fish_prompt_pwd_dir_length 0
    set -l cwd $blue(prompt_pwd)
    
    set -l hostName $green(prompt_hostname)
    
    set -l user $green$USER

    set -l repo_info
    if set -l repo_type (_repo_type)
    
        set -l dirty (_is_repo_dirty $repo_type)
        set -l Dirty ''
        if test -n "$dirty"
            set Dirty "$yellow✗"
        end
        set -l repo_branch $red(_repo_branch_name $repo_type)
        set repo_info "$normal:$green$repo_type($repo_branch$Dirty$blue)"

    end

    echo -n -s $user@$hostName $normal':'$cwd $repo_info $user_sign ' '
end
