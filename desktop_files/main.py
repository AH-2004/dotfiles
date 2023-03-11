import os.path as path
from glob import glob

# Desktop file locations

applications = '/usr/share/applications/*.desktop'
user_applications = f'{path.expanduser("~")}/.local/share/applications/*.desktop'

list = glob(applications) + glob(user_applications)

for i, item in enumerate(list):
    print(i, ": ", item)
