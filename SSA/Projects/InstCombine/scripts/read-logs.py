#!/usr/bin/env python3
import os
import re
import subprocess
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
    log_errors = []
    func_count = 0
    for log in os.listdir(llvm_log_path):
        with open(f"{llvm_log_path}/{log}", "r") as l:
            func_success = False
            lines = l.readlines()
            if not (len(lines) > 0):
                log_errors.append(log)
                continue
            for line in lines:
                s_line = re.split('"|: |\n', line)
                s_line = [s.strip() for s in s_line if s != ""]
                if len(s_line) > 0:
                    msg = Msg(int(s_line[0]))
                    func = s_line[-1]
                    if msg == Msg.E_UNSUPPORTED:
                        add_or_1(unsupported_func, func)
                        if func_success:
                            add_or_1(error_dict, msg)
                            func_success = False
                    elif msg == Msg.OP:
                        add_or_1(success_func, func)
                    elif msg == Msg.FUNC_NAME:
                        if func_success:
                            func_count += 1
                        func_success = True
                    else:
                        func_success = False
                        add_or_1(error_dict, msg)
    llvm_test_count = len(os.listdir(llvm_test_path))
    translated_test_count = len(os.listdir(test_path))
    proof_count = len(os.listdir(proof_path)) >> 1
    build_error = len(os.listdir(proof_log_path))
    grep_process = f"grep -o theorem {proof_path}/*_proof.lean | wc -l"

    theorem_count = subprocess.run(
        grep_process, shell=True, capture_output=True, encoding="utf-8"
    ).stdout

    print(f"Number of files in llvm's tests: {llvm_test_count}\n")
    print(f"Number of translated test files: {translated_test_count}\n")
    print(f"Number of successfully built test files: {proof_count}\n")

    print(f"Empty logs: {log_errors}\n")

    print(f"Number of builds that failed: {build_error}\n")
    print(f"Number of generated BitVector theorems: {theorem_count}\n")
    print(f"Occurrences of unsupported functions: {sum(unsupported_func.values())}")
    for key, value in sorted(unsupported_func.items(), key=lambda x: x[1]):
        print("{} : {}".format(key, value))

    print(
        f"Number of functions that couldn't be translated due to each error: {sum(error_dict.values())}"
    )
    for key, value in sorted(error_dict.items(), key=lambda x: x[1]):
        print("{} : {}".format(key, value))


if __name__ == "__main__":
    main()
