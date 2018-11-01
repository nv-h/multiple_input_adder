#!/usr/bin/env python3

for i in range(0, 300):
	print("0-{:>3}: {:>5}".format(i, sum(list(range(0, i+1)))))
