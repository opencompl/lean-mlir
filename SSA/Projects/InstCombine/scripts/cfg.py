#!/usr/bin/env python3
from xdsl.dialects.llvm import LLVM
from xdsl.context import MLContext
from xdsl.dialects.builtin import (
    Builtin,
)
import os
from enum import Enum

# The path from lean-mlir to llvm-project
llvm_path = "../llvm-project"

if len(llvm_path) == 0:
    raise ValueError("You need to give the path to llvm in config.py")

test_path = "SSA/Projects/InstCombine/tests/LLVM"
proof_path = "SSA/Projects/InstCombine/tests/proofs"
log_path = "SSA/Projects/InstCombine/tests/logs"
llvm_test_path = llvm_path + "/llvm/test/Transforms/InstCombine"

skipped_funcs = {
    # These 3 functions are skipped because the `noundef` tag is unsupported
    "bools2_logical_commute3_nopoison": "noundef",
    "logical_or_noundef_b": "noundef",
    "logical_and_noundef": "noundef",
}
expensive_files = [
    "pr96012.ll",
]

directory = os.fsencode(llvm_test_path)

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
    "llvm.udiv",
    "llvm.zext",
    "llvm.sext",
    "llvm.trunc",
    "llvm.icmp",
}

allowed_unregistered = {
    "llvm.select",
}


class Msg(Enum):
    FUNC_NAME = 1
    OP = 2
    E_PARSE = 3
    E_UNSUPPORTED = 4
    E_EMPTY = 5
    E_NOT_FOUND = 6
    E_NOT_CHANGED = 7
    E_VECTOR = 8

    def is_error(self):
        return self.value > 2
