import subprocess
import sys

name = subprocess.check_output('xdotool getactivewindow getwindowname'.split(' ')).decode('utf-8').replace('\n', '').split('-')[-1].strip()
pid = subprocess.check_output('xdotool getactivewindow getwindowpid'.split(' ')).decode('utf-8').replace('\n', '')

if ("--pid" in sys.argv or "-p" in sys.argv):
    print(f'{name} | {pid}')
else:
    print(name)
