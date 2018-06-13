# After modification run ./sync_profile_pgpass.sh to sync to remote hosts
# Edit this locally on Mac not remote hosts

[ -z "$PS1" ] && return

alias ls='ls -ltrh'
alias svim='sudo vim'
alias vi='vim'
alias back='cd $OLDPWD'
alias grep='grep --color=auto'
alias df='df -h'
alias h="history|grep "
alias install="sudo ap-get install"
alias du='du -h'                # Disk usage
alias rm='rm -i'
alias yaml_check="python -c 'import yaml,sys;yaml.safe_load(sys.stdin) < "

# Hadoop
alias hcat='hadoop fs -cat'     # Output a file to standard out
alias hchown='hadoop fs -chown' # Change ownership
alias hchmod='hadoop fs -chmod' # Change permissions
alias hls='hadoop fs -ls'       # List files
alias hmkdir='hadoop fs -mkdir' # Make a directory
alias hcp='hadoop fs -cp'       # Copy hadoop to hadoop
alias hmv='hadoop fs -mv'       # Move hadoop to hadoop
alias hrm='hadoop fs -rm'       # Move hadoop to hadoop
alias hget='hadoop fs -get'      # hdfs to local
alias hput='hadoop fs -put'     # local to hdfs
alias hdu=$'hadoop fs -ls /user/$USER | awk \'{print $8}\' | xargs hdfs dfs -du -s -h'
#alias meld='/Applications/Meld.app/Contents/MacOS/Meld'


unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
   export JAVA_HOME=$(/usr/libexec/java_home)
   #/usr/local/bin/autossh -M 30020 -f -N -L 4552:DbHostname:5432 -N Tunnel_Hostname
   
fi



# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTFILESIZE=20000
export HISTSIZE=10000

# append to the history file, don't overwrite it
shopt -s histappend

# Combine multiline commands into one in history
shopt -s cmdhist

# Ignore duplicates, ls without options and builtin commands
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"
export EDITOR=vim


PS1='\n[\u@\h]: \w\n$?> '

# find /home/joe -type f -name '*.txt' -print | xargs grep -l "Monthly Report"

# up 4

up(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

# extract file

extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *.deb)       ar -x $1       ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

# find <dir> <file name regexp> <file contents regexp>
#function fing { find "$1" -name "$2" -exec grep -H "$3" "{}" \; }



# df -h|fawk 2
function fawk {
    first="awk '{print "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
}
 

#netinfo - shows network information for your system
netinfo ()
{
echo "--------------- Network Information ---------------"
/sbin/ifconfig | awk /'inet addr/ {print $2}'
/sbin/ifconfig | awk /'Bcast/ {print $3}'
/sbin/ifconfig | awk /'inet addr/ {print $4}'
/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
echo "${myip}"
echo "---------------------------------------------------"
}

#dirsize - finds directory sizes and lists them for the current directory
dirsize ()
{
du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
egrep '^ *[0-9.]*M' /tmp/list
egrep '^ *[0-9.]*G' /tmp/list
rm -rf /tmp/list
}

openports()
{

if [ `uname` == "Darwin" ]; then
   echo 'sudo netstat -atp tcp | grep -i "listen"'
   netstat -atp tcp | grep -i "listen"
else
   sudo netstat -ntlp | grep LISTEN
fi 
}


help ()
{
printf "\n---------------------------------------------------------------\nModified BashRC\n\n"
echo "dirsize : finds directory sizes and lists them for the current directory"
echo "netinfo : shows network information for your system"
echo "extract file : Extract any compressed file"
echo "up 4 : cd up level"
echo "df -h| fawk 2"
echo "hls : hls /user/sumedhk"
echo "hcat : hcat /user/sumedhk/file"
echo "hmkdir : hmkdir /user/sumedhk/new_folder"
echo "hcp : Hadoop to Hadoop hcp file/folder folder"
echo "hrm : hrm -r folder/file"
echo "hget : hdfs to local"
echo "hput : local to hdfs"
echo "openports : List open ports"
}

