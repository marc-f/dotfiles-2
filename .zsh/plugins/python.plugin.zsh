#
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/python/python.plugin.zsh
#

# Find python file
alias pyfind='find . -name "*.py"'

# Remove python compiled byte-code
alias pyclean='find . -type f -name "*.py[co]" -delete'

# Grep among .py files
alias pygrep='grep --include="*.py"'

#
# pythonbrew
#
function py273() {
    if type pybrew > /dev/null 2>&1; then
        pybrew switch 2.7.3 > /dev/null 2>&1 \
        && pybrew venv use py273 > /dev/null 2>&1
    fi
}

function py323() {
    if type pybrew > /dev/null 2>&1; then
        pybrew switch 3.2.3 > /dev/null 2>&1 \
        && pybrew venv use py323 > /dev/null 2>&1
    fi
}
