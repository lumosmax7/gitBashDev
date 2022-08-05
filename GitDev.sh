
currentOS=$(uname)
currentGitEmail=$(git config user.email)
currentGitName=$(git config user.name) #no blank space



echo Welcome to the Git-command-line tool
echo ------------------------------------
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

# check account setted
# if not set account

# echo Checking account
# echo ------------------------------------
# if [ ! -z $currentGitEmail ] && [ ! -z $currentGitName ];
# then
#     echo Account is $currentGitName
#     echo Email is $currentGitEmail
#     echo ------------------------------------
# else
#     echo Setting account
#     while true
#     do
#         read -p "Your email: " email
#         read -p "Your name: " name
#         if [ ! -z $email ] && [ ! -z $name ];
#         then
#             break
#         fi
#     done
#     git config --global user.name $name
#     git config --global user.email $email
#     echo ------------------------------------
# fi

# echo Finish initiate account
# echo ------------------------------------

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
    echo  Current directory has deployed Git.
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


#TODO: add "commit" and "diff" command function.