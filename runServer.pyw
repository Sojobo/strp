from subprocess import Popen, PIPE, check_output
import time
import os
import requests

''' Global Variables '''
# Rapture times and messages
MAXTIME = 360       # 6hr in Minutes
MSG1 = "Raptured successfully, server restarting again in 5 hours and 55 minutes."
MSG2 = "The server will automatically restart in 1 hour for rapture."
MSG3 = "The server will automatically restart in 30 minutes for rapture."
MSG4 = "The server will automatically restart in 15 minutes for rapture."
MSG5 = "The server will automatically restart in 10 minutes for rapture."
MSG6 = "The server will automatically restart in 5 minutes for rapture."
MSG7 = "The server will automatically restart momentarily for rapture."
DISCORD = "https://discordapp.com/api/webhooks/562287462639075369/ZAdwPt3u8-9mwseyv0WID67VqdQpUVs-OWmAZ4eiQHgxoXlxiPp78CI7x6VElieuIwv8"
SRVNUM = "1"

# RCON Tool Location + IP:PORT / PW
RCON_TOOL = "C:/servers/fivem/tools/rcon.exe"
RCONIP = "localhost:30120"
RCONPW = "dP3FjFSVEB8lT3t6MY9z"

executable = "C:/servers/fivem/server1/server-data/runServer.bat"
procname = "FXServer-server1.exe"

# -------------------------------------------------------
# msgDiscord() - msg: message
# returns: none
def msgDiscord(msg):
    message = {
        "content": "[Server " + SRVNUM + "] " + msg
    }

    # Push the text to the server
    requests.post(DISCORD, data=message)

# -------------------------------------------------------
# heartbeat() - timeout: time (in sec) [default: 15sec]
# returns: output or -1 (server down)
def heartbeat(timeout=15):
    proc = Popen([RCON_TOOL, "-c", "uptime", RCONIP, RCONPW], stdout=PIPE)

    timer = 0
    while timer < timeout and proc.poll() is None:
        time.sleep(1)
        timer += 1

    if proc.poll() is None:
        # no? terminate it, the server is offline
        proc.terminate()
        msgDiscord("Server is reporting offline, attempting to restart...")
        return -1
    else:                 
        # we got a response let's decode it & get the int
        decoded = proc.stdout.read().decode("utf-8")
        return int(decoded.split()[-1])

# -------------------------------------------------------
# rcon() - cmd: cmd, timeout: time (sec) [default: 15sec]
# returns: 1 (success) or -1 (server down)
def rcon(cmd, timeout=15):
    proc = Popen([RCON_TOOL, "-c", cmd, RCONIP, RCONPW], stdout=PIPE)

    timer = 0
    while timer < timeout and proc.poll() is None:
        time.sleep(1)
        timer += 1

    if proc.poll() is None:     # check for success
        proc.terminate()        # failure! kill it
        return -1               
    else:                       # success! beer time
        return 1                

# -------------------------------------------------------
# isWindowsProcessRunning( exeName )
def isWindowsProcessRunning( exeName ):
    sysCall = 'TASKLIST', '/FI', 'imagename eq %s' % exeName
    process = Popen( 
        sysCall,
        stdout=PIPE, stderr=PIPE,
        universal_newlines=True )
    out, err = process.communicate()    
    try : return procname in out
    except : return False

# -------------------------------------------------------
# restartServer() - says what it does
def restartServer():
    # see if a process exists.. then kill it
    status = isWindowsProcessRunning(procname)
    if status == True:
        os.system("taskkill /f /im " + procname)
        msgDiscord("Server has been shutdown for restart")

    # wait a few seconds, then restart server
    time.sleep(5)
    Popen([executable])
    msgDiscord("Starting Server ")

# -------------------------------------------------------
# functions for managing rapture notices
def restart_success():
    rcon("printsrv \"" + MSG1 + "\"", 2)
    msgDiscord(MSG1)

def restart_hr():
    rcon("printsrv \"" + MSG2 + "\"", 2)
    msgDiscord(MSG2)

def restart_30():
    rcon("printsrv \"" + MSG3 + "\"", 2)
    msgDiscord(MSG3)

def restart_15():
    rcon("printsrv \"" + MSG4 + "\"", 2)
    msgDiscord(MSG4)

def restart_10():
    rcon("printsrv \"" + MSG5 + "\"", 2)
    msgDiscord(MSG5)

def restart_5():
    rcon("printsrv \"" + MSG6 + "\"", 2)
    msgDiscord(MSG6)

def restart_min():
    rcon("printsrv \"" + MSG7 + "\"", 2)
    msgDiscord(MSG7)

def restart_now():
    restartServer()

# -------------------------------------------------------
# main() - does stuff
def main():
    uptime = heartbeat(5)

    if uptime == -1:
        restartServer()
        exit(1)

    intervals = { 
        5: restart_success,
        (MAXTIME - 60): restart_hr,
        (MAXTIME - 30): restart_30,
        (MAXTIME - 15): restart_15, 
        (MAXTIME - 10): restart_10,
        (MAXTIME - 5): restart_5,
        (MAXTIME - 1): restart_min,
        (MAXTIME): restart_now,
    }

    intervals[uptime]()

# -------------------------------------------------------
# pythonic shit
if __name__ == "__main__":
    main()