# Base taken from
# http://unix.stackexchange.com/questions/44214/encrypt-offlineimap-password
#
# To create a new password file, store the password in a file new.passwd
# and run the following:
#   $ cat new.passwd | gpg -e -r "Johan S. R. Nielsen" > new.gpg

import os, subprocess, sys
def mailpasswd(acct):
  acct = os.path.basename(acct)
  path = "/Users/johanrosenkilde/mail/%s.gpg" % acct
  args = ["gpg", "-d", path]
  try:
    t = subprocess.check_output(args, text=True).strip()
    return t
  except subprocess.CalledProcessError:
    return ""

def prime_gpg_agent():
  ret = False
  i = 1
  while not ret:
    ret = (mailpasswd("prime") == "prime")
    print("Ret:", ret)
    if i > 2:
      from offlineimap.ui import getglobalui
      sys.stderr.write("Error reading in passwords. Terminating.\n")
      getglobalui().terminate()
    i += 1
  return ret

prime_gpg_agent()
