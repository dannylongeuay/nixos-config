function show_path
    for item in $PATH
        echo $item
    end
end

function kprof
    if test (count $argv) -ne 1
        echo "One argument expected, 'kprof <profile>'"
        return
    end
    set match (kubectl config get-contexts -o name | grep $argv[1])
    if test (count $match) -ne 1
        if test (count $match) -eq 0
            echo "No profiles matched argument."
        else
            echo "Multiple profiles matched argument. Try again with a more specific profile name."
        end
        return
    end
    set friendly_name (string split '/' $match)
    export KUBE_CLUSTER_CONTEXT=$friendly_name[-1]
    kubectl config use-context $match
end

function fish_title
    set -l title
    set -q argv[1]; or set argv fish
    set title (basename (prompt_pwd)) \| $argv
    echo $title
end

function fish_greeting
    neofetch
end

function _gcm
    argparse --name=_gcm b/breaking -- $argv
    set -l breaking ""
    set -l cmd
    if set -q _flag_breaking
        set breaking '!'
    end
    switch (count $argv)
        case 4
            set cmd git commit -m "\"$argv[1]($argv[3])$breaking: $argv[2] $argv[4..-1]\""
        case 3
            set cmd git commit -m "\"$argv[1](*)$breaking: $argv[2] $argv[3..-1]\""
        case '*'
            set cmd echo "Incorrect number of arguments"
    end
    eval $cmd
end

function gfeat
    _gcm feat ":sparkles:" $argv
end
function gfix
    _gcm fix ":bug:" $argv
end
function gperf
    _gcm perf ":zap:" $argv
end
function gchore
    _gcm chore ":wrench:" $argv
end
function grefactor
    _gcm refactor ":recycle:" $argv
end
function gstyle
    _gcm style ":art:" $argv
end
function gdocs
    _gcm docs ":pencil:" $argv
end

