import matplotlib.pyplot as plt

# load raw data from file and plot it
data = open("Data.txt", "r").readlines()
x = [float(i.split(",")[0]) for i in data]
y = [float(i.split(",")[1]) for i in data]
print(f"x: {x}")
print(f"y: {y}")

# split x and y with 17 elements
x = [x[i : i + 17] for i in range(0, len(x), 17)]
y = [y[i : i + 17] for i in range(0, len(y), 17)]
print(f"x: {x}")
print(f"y: {y}")

# plot x and y, show every value
for i in range(len(x)):
    plt.plot(x[i], y[i], marker="o", label=f"Line {i+1}")

plt.xlabel("X")
plt.ylabel("Y")
plt.title("Data")
plt.legend()
plt.savefig("Data.png")
