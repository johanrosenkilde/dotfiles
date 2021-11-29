# Base taken from
# http://unix.stackexchange.com/questions/44214/encrypt-offlineimap-password
import os, subprocess
def mailpasswd(acct):
  acct = os.path.basename(acct)
  path = "/Users/johanprivate/mail/%s.gpg" % acct
  args = ["gpg", "--quiet", "-d", path]
  try:
    return subprocess.check_output(args).strip()
  except subprocess.CalledProcessError:
    return ""

def prime_gpg_agent():
  ret = False
  i = 1
  while not ret:
    ret = (mailpasswd("prime") == "prime")
    if i > 2:
      from offlineimap.ui import getglobalui
      sys.stderr.write("Error reading in passwords. Terminating.\n")
      getglobalui().terminate()
    i += 1
  return ret

prime_gpg_agent()
