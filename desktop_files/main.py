import os
import glob

# Desktop file locations

applications = '/usr/share/applications/*.desktop'
user_applications = f'{os.path.expanduser("~")}/.local/share/applications/*.desktop'

# application_dirs_list = os.listdir(applications)+os.listdir(user_applications)

list = glob.glob(applications) + glob.glob(user_applications)

for i, item in enumerate(list):
    print(i, ": ", item)
