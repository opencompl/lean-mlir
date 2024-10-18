#!/usr/bin/env python3
from xdsl.dialects.llvm import LLVM
from xdsl.context import MLContext
from xdsl.dialects.builtin import (
    Builtin,
)
import os
from enum import Enum

# The path from lean-mlir to llvm-project
llvm_path = "../llvm-project-main"

if len(llvm_path) == 0:
    raise ValueError("You need to give the path to llvm in config.py")

test_path = "SSA/Projects/InstCombine/tests/LLVM"
log_path = "SSA/Projects/InstCombine/tests/logs"
llvm_test_path = llvm_path + "/llvm/test/Transforms/InstCombine"
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
}
allowed_unregistered = set()

Msg = Enum('Msg', ['FUNC_NAME', 'OP', 'E_PARSE', 'E_UNSUPPORTED', 'E_EMPTY', 'E_NOT_FOUND', 'E_NOT_CHANGED', 'E_VECTOR'])