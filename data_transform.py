"""Convert the original data to simple format, with each row in the file is:
longitude,latitude
"""

from zipfile import ZipFile
import sys
import os

INPUT = "/Volumes/SanDiskDu/Geolife Trajectories 1.3.zip"  # todo: change to parameter
OUTPUT = ""  # todo: change to parameter

output_folder = os.path.join(OUTPUT, "Data")

if not os.path.exists(INPUT):
    print "Trajectory file not found!"
    sys.exit()

if os.path.isdir(output_folder):
    print "Data folder exist, remove it first!"
    sys.exit()

os.mkdir(output_folder)

with ZipFile(INPUT) as myzip:
    # map
    users = {}
    for member in myzip.namelist():
        if member.endswith('plt'):
            path = member.split('/')
            if len(path) == 5:
                user = path[2]
                if user in users.keys():
                    users[user].append(member)
                else:
                    users[user] = [member]
    # reduce
    for user in users.iterkeys():
        print user
        with open(os.path.join(output_folder, user), 'w') as new_file:
            rows = []
            for member in users[user]:
                with myzip.open(member) as f:
                    for row in f.readlines()[6:]:
                        rows.append(row[:row.find(',', row.find(',')+1)])

            new_file.write("\n".join(rows))




