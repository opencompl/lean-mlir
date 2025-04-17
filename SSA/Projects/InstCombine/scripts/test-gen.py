#!/usr/bin/env python3
from xdsl.dialects.llvm import ReturnOp, LLVMPointerType
from xdsl.utils.exceptions import ParseError
from xdsl.dialects.llvm import FuncOp
from xdsl.parser import Parser
from xdsl.printer import Printer
import os
import io
import subprocess
from xdsl.printer import Printer
from multiprocessing import Pool
from cfg import *


def allowed(op):
    # we do not support void returns. Someone should look into this!
    if isinstance(op, ReturnOp) and op.arg is None:
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


def remove():
    rm_tests = "\nrm -r " + test_path + "/*\n"
    rm_logs = "\nrm -r " + llvm_log_path + "/*\n"
    subprocess.run(rm_tests, shell=True)
    subprocess.run(rm_logs, shell=True)


def make_theorem(s1, s2, name):
    return f"""
def {name}_before := [llvm|
{s2}
]
def {name}_after := [llvm|
{s1}
]
set_option debug.skipKernelTC true in
theorem {name}_proof : {name}_before ⊑ {name}_after := by
  unfold {name}_before {name}_after
  simp_alive_peephole
  intros
  ---BEGIN {name}
  all_goals (try extract_goal ; sorry)
  ---END {name}\n\n\n"""


def make_intro(stem):
    return f"""
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
section {stem}_statements\n"""


def print_log(log, log_file):
    with open(log_file, "a+") as l:
        l.writelines(log)


def op_name(op):
    if op.name == "builtin.unregistered":
        return f"builtin.unregistered: {op.op_name.data}"
    return op.name


def process_file(file):
    filename = os.fsdecode(file)
    print(filename)
    if err := skipped_files.get(filename):
        print(f"file {filename} skipped: {err}")
        return
    stem = "g" + filename.split(".")[0].replace("-", "h")
    full_name = f"{llvm_test_path}/{filename}"
    run_process1 = f"opt -passes=instcombine -S {full_name}  | mlir-translate -import-llvm | mlir-opt --mlir-print-op-generic"
    log_file = f"{llvm_log_path}/{filename}".replace(".ll", ".txt")
    log = []
    print(run_process1)

    process1 = subprocess.run(
        run_process1, shell=True, capture_output=True, encoding="ISO-8859-1"
    )

    module1 = parse_module(process1.stdout)

    process2 = subprocess.run(
        f"mlir-translate -import-llvm {full_name} | mlir-opt --mlir-print-op-generic",
        shell=True,
        capture_output=True,
        encoding="ISO-8859-1",
    )

    module2 = parse_module(process2.stdout)

    if module1 is None or module2 is None:
        log.append(f"{Msg.E_PARSE.value}: {filename}: parsing has failed\n\n")
        print_log(log, log_file)
        return

    funcs2 = {f.sym_name.data: f for f in module2.walk() if isinstance(f, FuncOp)}
    for func in module1.walk():
        if not isinstance(func, FuncOp):
            continue
        func_name = func.sym_name
        if err := skipped_funcs.get(func_name.data):
            log.append(
                f"{Msg.E_UNSUPPORTED.value}: {func_name} has unsupported operation: {err}\n\n"
            )
            continue
        log.append(f"{Msg.FUNC_NAME.value}: {func_name}\n")

        flag = False
 
        for input_type in func.function_type.inputs:
            if isinstance(input_type, LLVMPointerType):
                log.append(f"{Msg.E_PTRARG.value}: {func_name} has pointer type input\n\n")
                flag = True
                break

        for op in func.walk():
            if not allowed(op):
                flag = True
                log.append(
                    f"{Msg.E_UNSUPPORTED.value}: {func_name} has unsupported operation: {op_name(op)}\n\n"
                )
                continue
        if flag:
            continue

        if not size(func) > 1:
            log.append(f"{Msg.E_EMPTY.value}: {func_name} is empty\n\n")
            continue

        other = funcs2.get(func.sym_name.data, None)
        func_name = func.sym_name

        if other is None:
            log.append(
                f"{Msg.E_NOT_FOUND.value}: Cannot find function after optimization with sym name: {func_name}\n\n"
            )
            continue

        s1 = showr(func.body)
        s2 = showr(other.body)
        # Our parser is bad, someone should really fix this
        s1 = s1.replace('"value"', "value")
        s2 = s2.replace('"value"', "value")
        name = func.sym_name.data.replace("-", "h")
        if s1 == s2:
            log.append(
                f"{Msg.E_NOT_CHANGED.value}: {func_name} is unchanged by InstCombine\n\n"
            )
            continue
        if "vector" in (s1 + s2):
            log.append(
                f"{Msg.E_VECTOR.value}: {func_name} contains vectors which are unsupported\n\n"
            )
            continue

        tmp_log = []
        flag = False
        for op in other.walk():
            tmp_log.append(f"{Msg.OP.value}: {op_name(op)}\n")
            if not allowed(op):
                log.append(
                    f"{Msg.E_UNSUPPORTED.value}: {func_name} has unsupported operation after optimization: {op_name(op)}\n\n"
                )
                flag = True
        if flag:
            continue
        log = log + tmp_log
        log.append("\n")

        print(f"-----{filename}.{func_name}-----")
        o1 = make_theorem(s1, s2, name)
        print(o1)
        write_file = f"{test_path}/{stem}.lean"
        with open(write_file, "a+") as f3:
            if os.stat(write_file).st_size == 0:
                f3.write(make_intro(stem))
            f3.write(o1)
    print_log(log, log_file)


if __name__ == "__main__":
    remove()
    with Pool(300) as p:
        p.map(process_file, os.listdir(directory))