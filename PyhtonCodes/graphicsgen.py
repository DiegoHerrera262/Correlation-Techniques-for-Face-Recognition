import matplotlib.pyplot as plt

plt.axes()

rad = 0.05
NumCirc = 2
height = 1
width = 0.5

for i in range(0,NumCirc):
    for j in range(0,NumCirc):
        circle = plt.Circle((i, j), radius = rad, fc='k')
        plt.gca().add_patch(circle)

name = 'Lattice' + str(NumCirc) + '.png'

plt.axis('off')
plt.axis([-rad,NumCirc+rad,-rad,NumCirc+rad])
plt.axis('scaled')
plt.savefig(name)
plt.show()
