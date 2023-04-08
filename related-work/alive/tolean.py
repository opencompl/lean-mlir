#!/usr/bin/env python3
import sys
# This script is used to convert from Alive IR
# into our SSA based encoding.
# Converted files are automatically written to
# the folder /ssa/examples/alive-<filename>.lean
import re

class Test:
    def __init__(self, ix, rawstr, name, pre, find, replace):
        self.ix = ix
        self.name = name
        self.pre = pre 
        self.find = find
        self.replace = replace
        self.rawstr = rawstr

    @classmethod
    def parse(cls, ix, rawstr : str):
        rawstr = re.sub(r";(.*?)\n", "", rawstr, flags=re.MULTILINE|re.DOTALL|re.ASCII) # remove comments till end of line.
        rawstr = rawstr.lstrip()
        # Name: <name>"
        pattern = r"Name:(?P<Name>.+?)\n\s*" + \
                  r"(?P<Pre>Pre:(.+?)\n)?\s*" + \
                  r"(?P<Find>.+?)" + \
                  r"=>" + \
                  r"(?P<Replace>.+?)\Z"
        match = re.match(pattern, rawstr, flags=re.DOTALL|re.ASCII)
        if not match:
            print("failed to parse: '" + "\n  ".join(rawstr.split("\n")) + "'", file=sys.stderr)
            return  None
        # print(match)
        name = match.group("Name").strip()
        pre = match.group("Pre")
        if pre: pre = pre.strip()
        find = match.group("Find").strip()
        replace = match.group("Replace").strip()
        return Test(ix, rawstr, name, pre, find, replace)

    def __repr__(self):
        out = ""
        out += f"ix: {self.ix}\n"
        out += f"name: {self.name}\n"
        out += f"pre: {self.pre}\n"
        out += f"find: {self.find}\n"
        out += f"replace: {self.replace}"
        return out

    def __str__(self): return self.__repr__()


def to_lean(source_file_path, dest_file_path):
    with open(source_file_path, "r") as f:
        alive = f.read()

    alive_tests = alive.split("\n\n")
    print("number of test cases: %s" % len(alive_tests))

    tests = []
    N = len(alive_tests)
    for (n, raw) in enumerate(alive_tests):
        print("**converting test [%s/%s]" % (n, N), end="")
        parsed = Test.parse(n, raw)
        print(" ✓" if parsed else " x")
        if parsed: 
            print(parsed)
            tests.append(parsed)
    print("Summary: [%4d (%4.0f %%)] succeeded out of [%4d] total." % 
            (len(tests), len(tests)/N*100, N))

    n_pre = len([t for t in tests if t.pre is not None])
    print("Summary: [%4d / %4d (%4.0f %%)] of all parsed tests have preconditions." %
        (n_pre, len(tests), n_pre/len(tests)*100))
    return tests

    # Name: <name>


if __name__ == "__main__":
    to_lean("alive/tests/instcombine/addsub.opt", "../../SSA/Examples/addsub.lean")



