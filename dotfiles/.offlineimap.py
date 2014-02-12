import os
import io
import re
import ConfigParser
import subprocess

mapping = { 'INBOX':              'INBOX'
          , '[Gmail]/All Mail':   'all_mail'
          , '[Gmail]/Drafts':     'drafts'
          , '[Gmail]/Important':  'important'
          , '[Gmail]/Sent Mail':  'sent_mail'
          , '[Gmail]/Spam':       'spam'
          , '[Gmail]/Starred':    'starred'
          , '[Gmail]/Trash':      'trash'
          }

r_mapping = { val: key for key, val in mapping.items() }

account_config = ConfigParser.SafeConfigParser()

def nt_remote(folder):
    return mapping.get(folder, folder)

def nt_local(folder):
    return r_mapping.get(folder, folder)

# folderfilter = exclude(['Label', 'Label', ... ])
def exclude(excludes):
    return lambda folder: not folder in excludes

def load_account():
    config = subprocess.check_output(["gpg", "--no-tty", "--use-agent", "--decrypt", "-q", os.path.expanduser("~/.secure/offlineimap_account.gpg")])
    account_config.readfp(io.BytesIO(config))

def get_username(account):
    return account_config.get(account, "user")

def get_password(account):
    return account_config.get(account, "password")

load_account()
