About watchETC.sh
==================

I have used inotifywait utility for this cript so we can do 2 things with i.e.
1. Either we can run it in background, using this command: ./watchETC.sh &
   Using this approach all the logs will be collected at the realtime in the log file defined in the script.
   To stop this script, run this command: fg
   and, then press ctrl+c
2. Or, we can run it as cron job also. For this purpose we need to make an entry in crontab using this command: crontab -e
   Then, make this entry: 0 0 * * * /path/to/watchETC.sh
