import sys


input_file = sys.argv[1]
output_file = sys.argv[2]


with open(input_file) as i:
    with open(output_file, "w") as o:
        for line in i.readlines():
            ls = line.split(",")
            if ls[3][-2:] == "ms":
                time = float(ls[3][:-2]) / 1000
                ls[3] = str(time)
                o.write(",".join(ls))
            else:
                if ls[3] != "avg" and ls[3][-1:] != "s":
                    print ls[3]
                    print "w00t"
                    raise Exception
                ls[3] = ls[3][:-1]
                o.write(",".join(ls))
