if [ -f ~/gitstatus/gitstatus.prompt.sh ]; then
    echo "gitstatus_stop" >>~/gitstatus/gitstatus.prompt.sh
    source ~/gitstatus/gitstatus.prompt.sh
    sed -i '$d' ~/gitstatus/gitstatus.prompt.sh
fi
