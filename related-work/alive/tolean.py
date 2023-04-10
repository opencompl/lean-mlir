#!/usr/bin/env python3
import sys
# This script is used to convert from Alive IR
# into our SSA based encoding.
# Converted files are automatically written to
# the folder /ssa/examples/alive-<filename>.lean
import re
# import alive.common
# import alive.value
# import alive.constants
# import alive.language
# import alive.parser
# # import alive.alive

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
            return None
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



class SSAVar:
    def __init__(self, s : str): 
        assert s[0] == '%'
        self.s = s[1:]
    def __str__(self):
        return f"%{self.s}"

    def __repr__(self):
        return self.__str__()

    def __hash__(self):
        return self.s.__hash__()

    def compile_to_lean_stmt(self, env, lean_stmts):
        if self.s in env:
            return env[self.s]
        else:
            v = len(env) + len(lean_stmts)
            env[self.s] = v
            return v


DUMMY_ARG = 424242


class SSAConstValue:
    def __init__(self, s:str): # C, C2, or 1, 2, etc.
        self.val = s

    def __str__(self):
        return f"{self.val}"
    
    def __repr__(self):
        return self.__str__()

    def compile_to_lean_stmt(self, env, lean_stmts):
        v = len(env) + len(lean_stmts)
        lean_stmts.append(LeanOp(v, f"const(w, {self.val})", DUMMY_ARG))
        return v


class CompileException(RuntimeError):
    pass

class SSAConstUnaryExpr:
    def __init__(self, op, val):
        assert isinstance(op, str)
        assert isinstance(val, str)
        self.op = op
        self.val = val

    def __str__(self):
        return f"({self.op} {self.val})"
    
    def __repr__(self):
        return self.__str__()

    def compile_to_lean_stmt(self, env, lean_stmts):
        oconst = len(env) + len(lean_stmts)
        lean_stmts.append(LeanOp(oconst, f"const(w, {self.val})", DUMMY_ARG))

        ovar = len(env) + len(lean_stmts)
        lean_stmts.append(LeanOp(ovar, f"{self.op}(w)", oconst))
        return ovar

def SSAConstExpr(s : str):
    if s[0] == '~':
        return SSAConstUnaryExpr("negate", s[1:])
    else:
        raise CompileException(f"unknown constant expression '{s}'")

# parse constant expressions such as -C, ^C, etc.
def SSAConst(s : str):
    if s[0].isupper() or s[0].isdigit():
        return SSAConstValue(s)
    else:
        return SSAConstExpr(s)

# parse RHS arguments.
def SSAArg(s : str):
    if s[0] == '%':
        return SSAVar(s)
    else:
        return SSAConst(s)



class SSAOp:
    def __init__(self, s : str):
        self.op = s.split()[0]
        args = s.split(self.op)[1].strip()
        binops = ["add", "and", "or", "sub", "xor"]
        if self.op in binops:
            self.args = [SSAArg(a.strip()) for a in args.split(",")]
        else:
            raise CompileException(f"unknown op '{self.op}' in rhs '{s}'")
    def __str__(self):
        return f"{self.op} {', '.join(map(str, self.args))}"

    def __repr__(self):
        return self.__str__()

    def compile_to_lean_stmt(self, env, lean_stmts):
        if len(self.args) == 2:
            vararg0 = self.args[0].compile_to_lean_stmt(env, lean_stmts)
            vararg1 = self.args[1].compile_to_lean_stmt(env, lean_stmts)
            varpair = len(env) + len(lean_stmts)
            p = LeanPair(varpair, vararg0, vararg1)
            lean_stmts.append(p)

            varout = len(env) + len(lean_stmts)
            out = LeanOp(varout, f"{self.op}(w)", varpair) # add bit width
            lean_stmts.append(out)

            return varout
        else:
            raise CompileException(f"cannot compile {self}")



def write_prologue(f):
    out = """
import SSA.Framework
import Alive.Template

"""
    f.write(out)


class LeanPair:
    def __init__(self, lhs : int, rhs1 : int, rhs2 : int):
        assert isinstance(lhs, int)
        assert isinstance(rhs1, int)
        assert isinstance(rhs2, int)
        self.lhs = lhs
        self.rhs1 = rhs1
        self.rhs2 = rhs2

    def __str__(self):
        return f"%v{self.lhs} := pair: %v{self.rhs1} %v{self.rhs2}"

    def __repr__(self):
        return self.__str__()

class LeanOp:
    def __init__(self, lhs : int, op : str, rhs : int):
        assert isinstance(lhs, int)
        assert isinstance(op, str)
        assert isinstance(rhs, int)
        self.lhs = lhs
        self.op = op
        self.rhs = rhs

    def __str__(self):
        return f"%v{self.lhs} := op:{self.op} %v{self.rhs}"

    def __repr__(self):
        return self.__str__()

def alive_ir_to_lean(ir: str) -> str:
    assigns = []
    for line in ir.split("\n"):
        # %out = <blah>
        lhs = line.split("=")[0].strip()
        rhs = line.split("=")[1].strip()
        lhs = SSAVar(lhs)
        rhs = SSAOp(rhs)
        assigns.append((lhs, rhs))

    # for assign in assigns: print(assign)

    env = {} # renaming environment.
    lean_stmts = []
    last = 0
    for (lhs, rhs) in assigns:
        last = rhs.compile_to_lean_stmt(env, lean_stmts)
        env[lhs] = last
    out = ""
    out += ";\n".join(["  " + str(s) for s in lean_stmts])
    out += f"\n  dsl_ret %v{last}\n"
    return out

def test_to_lean(test: Test):
    out = ""
    out += ("\n\n")
    out += (f"-- Name:{test.name}\n")
    out += (f"-- precondition: {test.pre if test.pre is not None else 'NONE'}\n")
    out += (f"def thm{test.ix} (Width: Nat) : ")
    out += ("SSA.eval (Op := op) (Val := val) e re  [dsl_bb|\n");
    out += (alive_ir_to_lean(test.find))
    out += ("  ]");
    out += ("  = \n");
    out += ("  SSA.eval (Op := op) (Val := val) e re [dsl_bb|\n");
    out += (alive_ir_to_lean(test.replace))
    out += ("  ]");
    out += ("\n  := by simp[SSA.eval]; sorry")
    return out

def to_lean(source_file_path: str, dest_file_path: str):
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

    with open(dest_file_path, "w") as f:
        write_prologue(f)
        for t in tests: 
            try:
                out = test_to_lean(t)
                f.write(out); f.flush()
            except CompileException as c:
                print(f"ERROR: {c}")
    return tests

    # Name: <name>


if __name__ == "__main__":
    to_lean("alive/tests/instcombine/addsub.opt", "../../Alive/AddSub.lean")



