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
llvm_log_path = "SSA/Projects/InstCombine/tests/logs/LLVM"
proof_log_path = "SSA/Projects/InstCombine/tests/logs/proofs"
llvm_test_path = llvm_path + "/llvm/test/Transforms/InstCombine"

skipped_funcs = {
    # These 3 functions are skipped because the `noundef` tag is unsupported
    "bools2_logical_commute3_nopoison": "noundef",
    "logical_or_noundef_b": "noundef",
    "logical_and_noundef": "noundef",
    "logical_and_noundef_b": "noundef",
    "replace_with_y_noundef": "noundef",
    "PR96857_xor_with_noundef": "noundef",
    "pr110631": "range",
    "test_nonzero": "range",
    "test_nonzero2": "range",
    "test_nonzero3": "range",
    "test_nonzero4": "range",
    "test_nonzero5": "range",
    "test_nonzero6": "range",
    "test_not_in_range": "range",
    "test_in_range": "range",
    "test_range_sgt_constant": "range",
    "test_range_slt_constant": "range",
    "test_multi_range1": "range",
    "test_multi_range2": "range",
    "test_two_ranges": "range",
    "test_two_attribute_ranges": "range",
    "test_two_ranges2": "range",
    "test_two_argument_ranges": "range",
    "test_one_range_and_one_argument_range": "range",
    "test_one_argument_range_and_one_range": "range",
    "test_two_ranges3": "range",
    "test_two_ranges_vec": "range",
    "test_two_ranges_vec_false": "range",
    "test_two_ranges_vec_true": "range",
    "test_two_argument_ranges_thm": "range",
    "test_two_argument_ranges_vec": "range",
    "test_two_argument_ranges_vec_false": "range",
    "test_two_argument_ranges_vec_true": "range",
    "test_two_return_attribute_ranges_not_simplified": "range",
    "test_two_return_attribute_ranges_one_in_call": "range",
    "test_two_return_attribute_ranges": "range",
    "test_one_return_argument_and_one_argument_range": "range",
    "test_one_range_and_one_return_argument": "range",
    "icmp_eq_bool_0": "range",
    "icmp_ne_bool_0": "range",
    "icmp_ne_bool_1": "range",
}

skipped_files = {
    "pr96012.ll":"expensive",
    "icmp-or.ll":"expensive",
    "instcombine-verify-known-bits.ll":"range meta-data unsuported"
}

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
    # "llvm.lshr",
    # "llvm.ashr",
    # "llvm.urem",
    # "llvm.srem",
    "llvm.add",
    "llvm.mul",
    "llvm.sub",
    # "llvm.sdiv",
    # "llvm.udiv",
    # "llvm.zext",
    # "llvm.sext",
    # "llvm.trunc",
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
    E_PTRARG = 9
    
    def is_error(self):
        return self.value > 2
