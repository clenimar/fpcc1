import sys


input_file = sys.argv[1]
output_file = sys.argv[2]


with open(input_file) as i:
    with open(output_file, "w") as o:
        for line in i.readlines():
            ls = line.split(",")
            if ls[2][-2:] == "ms":
                time = float(ls[2][:-2]) / 1000
                ls[2] = str(time)
                o.write(",".join(ls))
            else:
                if ls[2] != "avg" and ls[2][-1:] != "s":
                    print ls[2]
                    print "w00t"
                    raise Exception
                ls[2] = ls[2][:-1]
                o.write(",".join(ls))
