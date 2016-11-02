"""This script plots a demo of result
"""
import os
import numpy as np
import matplotlib.pyplot as plt

users = range(1, 101)
USER_NUMBER = 100


def generate_data(mu, sigma, amount):
    data = np.random.normal(mu, sigma, amount)
    return data


algorithm_1 = generate_data(25, 5, USER_NUMBER)
algorithm_1_average = [25] * USER_NUMBER

algorithm_2 = generate_data(30, 3, USER_NUMBER)
algorithm_2_average = [30] * USER_NUMBER

algorithm_3 = generate_data(35, 3, USER_NUMBER)
algorithm_3_average = [35] * USER_NUMBER

algorithm_4 = generate_data(40, 3, USER_NUMBER)
algorithm_4_average = [40] * USER_NUMBER

algorithm_5 = generate_data(45, 3, USER_NUMBER)
algorithm_5_average = [45] * USER_NUMBER

algorithm_6 = generate_data(50, 2, USER_NUMBER)
algorithm_6_average = [50] * USER_NUMBER

algorithm_7 = generate_data(60, 1, USER_NUMBER)
algorithm_7_average = [60] * USER_NUMBER


fig1 = plt.figure(figsize=(12, 8))

axes = fig1.add_subplot(111)

# specify axis range
# plt.axis([0, 100, 0, 100])

# add title and label axis
axes.set_title("Quality Comparision of Different Algorithms")
plt.xlabel('User(s)')
plt.ylabel('Quality')

# lines
axes.plot(users, algorithm_1, "r", label='algorithem_1')
axes.plot(users, algorithm_1_average, "r-")

axes.plot(users, algorithm_2, "g", label='algorithem_2')
axes.plot(users, algorithm_2_average, "g-")

axes.plot(users, algorithm_3, "b", label='algorithem_3')
axes.plot(users, algorithm_3_average, "b-")

axes.plot(users, algorithm_4, color="black", label='algorithem_4')
axes.plot(users, algorithm_4_average, color="black", linestyle="-")

axes.plot(users, algorithm_5, color="red", linestyle="-", label='algorithem_5')
axes.plot(users, algorithm_5_average, "r-")

axes.plot(users, algorithm_6, "g", label='algorithem_6')
axes.plot(users, algorithm_6_average, "g-")

axes.plot(users, algorithm_7, "b", label='algorithem_7')
axes.plot(users, algorithm_7_average, "b-")

# add legend
legend = plt.legend(loc='upper left', shadow=True, fontsize='small')
# Put a nicer background color on the legend.
legend.get_frame().set_facecolor('#00FFCC')

# build path
if not os.path.isdir("output"):
    os.mkdir("output")

fig1.savefig(os.path.join("output", "sample_results.png"))

plt.show()
