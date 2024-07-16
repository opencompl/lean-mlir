#!/usr/bin/env python3
from xdsl.dialects.builtin import ModuleOp
from xdsl.dialects.llvm import LLVM
from xdsl.utils.exceptions import ParseError
from xdsl.context import MLContext
from xdsl.dialects import get_all_dialects
from xdsl.dialects.llvm import FuncOp
from xdsl.parser import Parser
from xdsl.printer import Printer
from xdsl.dialects.builtin import (
    Builtin,
    IndexType,
    IntegerAttr,
    IntegerType,
    ModuleOp,
    StringAttr,
    i32,
    i64,
)
import os
import io
from pathlib import Path
from xdsl.printer import Printer

# Initialize the MLIR context and register the LLVM dialect
ctx = MLContext(allow_unregistered=True)
ctx.load_dialect(LLVM)
ctx.load_dialect(Builtin)

directory = os.fsencode("../vcombined-mlir")


allowed_names = {
    "llvm.return",
    "llvm.mul",
    "llvm.add",
    "llvm.sub",
    "llvm.shl",
    "llvm.and",
    "llvm.or",
    "llvm.xor",
    "llvm.mlir.constant",
    "llvm.lshr",
    "llvm.ashr",
    "llvm.urem",
    "llvm.srem",
    "llvm.add",
    "llvm.mul",
    "llvm.sub",
    "llvm.sdiv",
}
allowed_unregistered = set()  # {


# "llvm.icmp"
# }
def allowed(op):
    return (
        hasattr(op, "sym_name")
        or (
            op.name == "builtin.unregistered"
            and op.op_name.data in allowed_unregistered
        )
        or (op.name in allowed_names)
    )


def show(block):
    output = io.StringIO()
    p = Printer(stream=output)
    block.print(p)
    contents = output.getvalue()
    output.close()
    return contents


def showr(region):
    output = io.StringIO()
    p = Printer(stream=output)
    p.print_region(region)
    contents = output.getvalue()
    output.close()
    return contents


def size(func):
    return sum(1 for _ in func.walk())

def read_file(file_name):
    with open(file_name, "r") as f:
        return f.read()
for file in os.listdir(directory):
    filename = os.fsdecode(file)
    print(filename)
    stem = "g" + filename.split(".")[0].replace("-", "h")
    output = ""
    data1 = read_file(os.path.join("../vcombined-mlir"))
    data2 = read_file(os.path.join("../vbefore-mlir"))
    parser = Parser(ctx, data1)
    try:
        module = parser.parse_module()
        parser2 = Parser(ctx, data2)
        module2 = parser2.parse_module()
        funcs = [
            func
            for func in module.walk()
            if isinstance(func, FuncOp)
            and all(allowed(o) for o in func.walk())
            and size(func) > 1
        ]
        for func in funcs:
            try:
                other = next(
                    f
                    for f in module2.walk()
                    if isinstance(f, FuncOp) and f.sym_name == func.sym_name
                )
                if all(allowed(o) for o in other.walk()):
                    s1 = showr(func.body)
                    s2 = showr(other.body)
                    name = func.sym_name.data
                    if s1 == s2:
                        continue
                    if "vector" in (s1 + s2):
                        continue
                    print(f"-----{filename}.{func.sym_name}-----")
                    o1 = f"""
def {name}_before := [llvm|
{s2}
]
def {name}_after := [llvm|
{s1}
]
theorem {name}_proof : {name}_before ⊑ {name}_after := by
unfold {name}_before {name}_after
simp_alive_peephole
simp_alive_undef
simp_alive_ops
simp_alive_case_bash
try alive_auto
---BEGIN {name}
all_goals (try extract_goal ; sorry)
---END {name}\n\n\n"""
                    print(o1)
                    write_file = os.path.join(
                        "../lean-mlir",
                        "SSA",
                        "Projects",
                        "InstCombine",
                        "tests",
                        "LLVM",
                        f"{stem}.lean",
                    )
                    with open(write_file, "a+") as f3:
                        if os.stat(write_file).st_size == 0:
                            f3.write(
                                """
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open LLVM
open BitVec

open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                """
                            )
                        f3.write(o1)

            except StopIteration as e:
                print(
                    f"Cannot find a function named {func.sym_name} in file {filename}"
                )
    except ParseError as e:
        print("failed to parse the file")
