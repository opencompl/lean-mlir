#!/usr/bin/env python3
from xdsl.dialects.builtin import ModuleOp
from xdsl.dialects.llvm import LLVM, ReturnOp
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
import subprocess
from pathlib import Path
from xdsl.printer import Printer
from multiprocessing import Pool

# Initialize the MLIR context and register the LLVM dialect
ctx = MLContext(allow_unregistered=True)
ctx.load_dialect(LLVM)
ctx.load_dialect(Builtin)


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
    # we do not support void returns. Someone should look into this!
    if isinstance(op,ReturnOp) and op.arg is None:
        return False
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


def parse_module(module):
    parser = Parser(ctx, module)
    try:
        return parser.parse_module()
    except ParseError:
        print(f"failed to parse the module")


def parse_from_file(file_name):
    return parse_module(read_file(file_name))


# subprocess.run("""
# cd SSA/Projects/InstCombine/scripts &&
# rm -rf ./llvm-project-main &&
# curl -o llvm-project-main.zip https://codeload.github.com/llvm/llvm-project/zip/refs/heads/main &&
# unzip llvm-project-main.zip
# """, shell=True)


subprocess.run("""
rm -f SSA/Projects/InstCombine/tests/LLVM/*
""", shell=True)

expensive_files = [
    "pr96012.ll"
]
directory = os.fsencode(
    "SSA/Projects/InstCombine/scripts/llvm-project-main/llvm/test/Transforms/InstCombine"
)
# for file in os.listdir(directory):
def process_file(file):
    filename = os.fsdecode(file)
    print(filename)
    if filename in expensive_files:
        print("file too expensive, skipping")
        return
    stem = "g" + filename.split(".")[0].replace("-", "h")
    output = ""

    # module1 = parse_from_file(os.path.join("../vcombined-mlir", filename))
    full_name = f"SSA/Projects/InstCombine/scripts/llvm-project-main/llvm/test/Transforms/InstCombine/{filename}"
    print(f"opt -passes=instcombine -S {full_name}  | mlir-translate -import-llvm | mlir-opt --mlir-print-op-generic")
    process1 = subprocess.run(
            f"opt -passes=instcombine -S {full_name} | mlir-translate -import-llvm | mlir-opt --mlir-print-op-generic",
            shell=True,
            capture_output=True,
            encoding="utf-8"
    )
    # print(process1)
    module1 = parse_module(
       process1.stdout
    )
    module2 = parse_module(
        subprocess.run(
            f"mlir-translate -import-llvm {full_name} | mlir-opt --mlir-print-op-generic",
            shell=True,
            capture_output=True,
            encoding="utf-8"
        ).stdout
    )
    if module1 is None or module2 is None:
        return
    # module2 = parse_from_file(os.path.join("../vbefore-mlir", filename))
    funcs = [
        func
        for func in module1.walk()
        if isinstance(func, FuncOp)
        and all(allowed(o) for o in func.walk())
        and size(func) > 1
    ]
    funcs2 = {f.sym_name.data: f for f in module2.walk() if isinstance(f, FuncOp)}
    for func in funcs:
        other = funcs2.get(func.sym_name.data, None)
        if other is None:
            print(f"Cannot function function with sym name {func.sym_name}")
            continue

        if not all(allowed(o) for o in other.walk()):
            print(f"{other.sym_name} contains unsupported operations, ignoring")
            continue

        s1 = showr(func.body)
        s2 = showr(other.body)
        # Our parser is bad, someone should really fix this
        s1 = s1.replace('"value"', 'value')
        s2 = s2.replace('"value"', 'value')
        name = func.sym_name.data.replace("-","h")
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
  intros
  try simp
  ---BEGIN {name}
  all_goals (try extract_goal ; sorry)
  ---END {name}\n\n\n"""
        print(o1)
        write_file = os.path.join(
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
                    f"""
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open LLVM
open BitVec

open MLIR AST
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
section {stem}_statements
                                                    """
                )
            f3.write(o1)
        # with open(write_file, "a+") as f3:
        #     f3.write(f"end {stem}_statements")
with Pool(7) as p:
    p.map(process_file, os.listdir(directory))
