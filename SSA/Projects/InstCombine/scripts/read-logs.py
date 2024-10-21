#!/usr/bin/env python3
import os
import re
from cfg import *

def add_or_1(d, k):
    if k in d:
        d[k] += 1
    else:
        d[k] = 1

def main():
    unsupported_func = dict()
    success_func = dict()
    error_dict = dict()
    print(os.listdir(log_path))
    for log in os.listdir(log_path):
        with open(f"{log_path}/{log}", "r") as l:
            lines = l.readlines()
            for line in lines:
                s_line = re.split('"|: |\n', line)
                s_line = [s.strip() for s in s_line if s != '']
                if len(s_line) > 0:
                    print(s_line)
                    msg = Msg(int(s_line[0]))
                    print(msg, msg.is_error())
                    func = s_line[-1]
                    if msg == Msg.E_UNSUPPORTED:
                        add_or_1(unsupported_func, func)
                    elif msg == Msg.OP:
                        add_or_1(success_func, func)
                    elif msg.is_error():
                        add_or_1(error_dict, msg)
    print(unsupported_func)
    print(success_func)
    print(error_dict)
    
if __name__ == "__main__":
   main()