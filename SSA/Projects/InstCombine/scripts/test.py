#!/usr/bin/env python3

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

s = """
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "test_or", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg11: i64):
    %21 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %22 = "llvm.or"(%arg11, %21) : (i64, i64) -> i64
    "llvm.return"(%arg11) : (i64) -> ()
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} : () -> ()
"""

parser = Parser(ctx, s)
module = parser.parse_module()
print(module)
for  function in module.walk():
    for operation in function.walk():
        print(operation)
        print(type(operation))
        if isinstance(operation,ReturnOp):
            print(operation.arg)
        # print(operation.)
