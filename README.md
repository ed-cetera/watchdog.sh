# watchdog.sh
Bourne Shell script that restarts required processes if necessary.

``watchdog.sh`` takes a ``watchlist`` text file as input.
The file defines pairs of process names and commands to start them.
When executed, ``watchdog.sh`` checks for each pair whether a process by the given process name is running and if not runs the provided starting command.

## Usage
    usage: watchdog.sh [-q|--quiet] watchlist

    Bourne Shell script that restarts required processes if necessary.

    positional arguments:
      watchlist             list of process names and restart commands

    optional arguments:
      -q, --quiet           no output on missing processes

## Cron
Typically, ``watchdog.sh`` is launched via cron to regularly check that all processes are running.

A ``crontab`` entry to run ``watchdog.sh`` every 10 minutes would be:

    */10 * * * * /path/to/watchdog.sh /path/to/watchlist

## Watchlist file
The ``watchlist`` is a simple text file.

Every line in the file defines a pair of process name and command.
The first word in a line is the process name.
From the second word on, the rest of the line is considered to be the command that starts the process.

If the first (non-whitespace) character of a line is ``#``, the line is a comment.
Comments and empty lines are ignored. 

For examples see the provided ``watchlist`` file.
