
currentOS=$(uname)
currentGitEmail=$(git config user.email)
currentGitName=$(git config user.name) #no blank space


initProcess(){
    echo Check Git installed;
    echo ------------------------------------
    if  [ ! "$(command -v git)" ];
    then
        echo Git is not installed.
        echo ---------------------
        echo Do you want to install Git?
        echo 1.yes
        echo 2.no
        echo \(default: yes\)
        read installGit #here is a string, not a number
        if [ -z $installGit ] || [ $installGit == "1" ];
        then
            echo installing Git
            # install command
            if [ $currentOS == "Darwin" ];
            then
                brew install git
            elif [ $currentOS == "Debian"  ];
            then
                apt-get install git
            elif [ $currentOS == "CentOS" ];
            then
                yum instsall git
            fi
        else
            echo This tool needs Git, be sure to install Git manually.
            exit
        fi
        echo ------------------------------------
        
    else
        echo git is installed
        echo ------------------------------------
    fi
    
    while true
    do
        echo Choosing working directory: \(defalut: current directory\)
        read workingDir
        if [ -z $workingDir ];
        then
            workingDir=$(pwd);
        fi
        if [ -d $workingDir ];
        then
            break;
        fi
        echo Wrong directory.
        
    done
    echo Working directory is $workingDir
    echo ------------------------------------
    cd $workingDir
    
    
    if [ -d $workingDir/.git ];
    then
        echo Current directory has deployed Git.
        echo ------------------------------------
        echo Show git status.
        echo ------------------------------------
        git status
        echo ------------------------------------
        echo List tracking files.
        echo ------------------------------------
        git ls-files
        
    else
        echo ------------------------------------
        echo Init a git repository
        echo ------------------------------------
        git init
        git add -A
    fi
    echo ------------------------------------
    echo Finish deploying Git on $workingDir
    echo ------------------------------------
    
    
}


configProcess(){
    echo Checking account
    echo ------------------------------------
    if [ ! -z $currentGitEmail ] && [ ! -z $currentGitName ];
    then
        echo Account is $currentGitName
        echo Email is $currentGitEmail
        echo ------------------------------------
    else
        echo Setting account
        while true
        do
            read -p "Your email: " email
            read -p "Your name: " name
            if [ ! -z $email ] && [ ! -z $name ];
            then
                break
            fi
        done
        git config --global user.name $name
        git config --global user.email $email
        echo ------------------------------------
    fi
    
    echo Check connection with Github. Please wait and according to the result to install ssh key manually or not.
    ssh -T git@github.com
    echo Do you need to config ssh with Github? \(yes or no, defalut is no\)
    read configFlag
    if [ ! $configFlag ];
    then
        configFlag="no"
    fi
    if [ $configFlag == "yes" ];
    then
        # ssh-keygen -t ed25519 -C $currentGitEmail
        echo ------------------------------------
        echo Please copy the private key and paste on Git.com
        echo ------------------------------------
        cat ~/.ssh/id_rsa
    fi
    echo ------------------------------------
    echo Finish initiate account
    echo ------------------------------------
    
}

commitProcess(){
    echo Do you need to check the differences \(yes or no, defalut is no\)?
    read checkFlag
    if [ ! $checkFlag ];
    then
        checkFlag="no"
    fi
    if [ "$checkFlag" == "yes" ];
    then
        echo check git status 
        echo ------------------------------------
        git diff
    fi
    echo "Enter the commiting message? (default is timestamp)"
    read message
    echo "$message"
    if [ ! "$message" ];
    then
        local timeStamp=$(date +%F-%T)
        git add -A
        git commit -m "$timeStamp"
    fi
    git add -A
    git commit -m "$message"
}


echo Welcome to the Git-command-line tool.
echo bash GitDev.sh help for more.
echo ------------------------------------

case $1 in
    "init")
    initProcess;;
    "config")
    configProcess;;
    "commit")
    commitProcess;;
    "help")
        echo usage: bash GitDev.sh init \| config \| commit \| push \| help
        echo ------------------------------------
        echo init: init a repository in the current directory.
        echo config: config a account used to connect to Github.
        echo commit: git diff and git commit.
        echo push: push to Github.
    ;;
esac
