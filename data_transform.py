"""Convert the original data to simple format, with each row in the file is:
latitude, longitude

length limit of the decimal is 4,
range of latitude: 39 to 41
range of longitude: 115 to 117.5
"""
import zipfile
from zipfile import ZipFile
import sys
import os
import argparse


def check_path(path):
    if not os.path.exists(path):
        print "Trajectory file not found!"
        sys.exit()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("input", help="path to data source zip file")
    parser.add_argument("-o", "--output", default="", help="output directory")

    args = parser.parse_args()

    data_source = args.input
    output = args.output

    check_path(data_source)

    with ZipFile(data_source) as myzip:
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
        with ZipFile(os.path.join(output, 'data.zip'), 'w', zipfile.ZIP_DEFLATED) as new_zip:
            for user in users.iterkeys():
                print user
                rows = []
                for member in users[user]:
                    with myzip.open(member) as f:
                        for row in f.readlines()[6:]:
                            first = row.find(',')
                            second = row.find(',', first + 1)
                            # new_row = row[:second]  # simple format
                            latitude = float(row[:first])
                            if latitude < 39 or latitude > 41:
                                continue
                            longitude = float(row[first + 1: second])
                            if longitude < 115 or longitude > 117.5:
                                continue
                            length = 4
                            latitude = str(round(latitude, length))
                            longitude = str(round(longitude, length))
                            new_row = latitude + ',' + longitude
                            rows.append(new_row)

                new_zip.writestr(user, "\n".join(rows))
                # sys.exit()

if __name__ == "__main__":
    main()
