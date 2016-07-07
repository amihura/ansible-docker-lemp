#!/usr/bin/env python

import optparse
import os
import datetime, time
import shutil
from subprocess import Popen, PIPE

DATE = datetime.datetime.now().strftime('%Y-%m-%d_%H-%M')
DB_USER = 'root'
DB_PASS = 'secret'
DB_NAME = 'wordpress'
LOG_DIR = '/var/log/db_logs/'
 
def backup_wp_db():
    """
    Creates db backup
    """
    args = ['mysqldump', '-u', DB_USER, '-p' + DB_PASS, DB_NAME]
    with open(LOG_DIR + DATE + ".sql.gz", 'wb') as f:
        p1 = Popen(args, stdout=PIPE)
        p2 = Popen('gzip', stdin=p1.stdout, stdout=f)
        p1.stdout.close()
        p2.wait()
        p1.wait()

def cleanup():
    """
    Removes files from the LOG_DIR which are older than 8
    days
    """
    now = time.time()
    for f in os.listdir(LOG_DIR):
        log_file = os.path.join(LOG_DIR, f)
        if os.stat(log_file).st_mtime < now - 8 * 86400:
            if os.path.isfile(log_file):
                os.remove(log_file)

def main():
    d = os.path.dirname(LOG_DIR)
    if not os.path.exists(d):
        os.makedirs(d)
    backup_wp_db()
    cleanup()   
 
if __name__ == "__main__":
    main()
