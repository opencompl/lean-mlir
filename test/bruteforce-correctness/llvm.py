#!/usr/bin/env python3
# Generate the file for LLVM
import itertools
from tqdm import tqdm
from typing import *
import subprocess
import re


MAX_OP_ARITY = 3

class LLVMArithBinopInfo:
  arity : int
  name : str

  def __init__(self, name : str, arity : int):
    self.name = name
    self.arity = arity

  def to_str(self, w : int) -> str:
    out = ""
    assert self.arity <= MAX_OP_ARITY
    for vs in itertools.product(*[range(0, 2 ** w) for ix in range(self.arity)]):
      vs_underscore = "__".join([f"val_{v}" for v in vs])
      vs_comma = ",".join([str(v) for v in vs])
      out += f"define i{w} @test_{self.name}_width_{w}__{vs_underscore}() {{\n"
      out += f"  %out = {self.name} i{w} {vs_comma}\n"
      out += f"  ret i{w} %out\n"
      out += "}\n"
      out += "\n"
    return out



def sh(*commands):
  command_str = " ".join([str(s) for s in commands])
  print(f"running '{command_str}'")
  proc = subprocess.run([*commands])
  proc.check_returncode()
  print("stdout:")
  print(f"{proc.stdout}")
  print("---")
  print("stderr")
  print(f"{proc.stderr}")
  print("---")


class Row:
  def __init__(self, op : str, width : str, vs : List[str], ret_val : str):
    self.op = op
    self.width = width
    self.vs = vs
    self.ret_val = ret_val

  @staticmethod
  def to_header():
    vs = ",".join([f"in{i}" for i in range(MAX_OP_ARITY)]) # which input
    return f"op, width, {vs}, ret_val"

  def to_csv(self):
    assert len(self.vs) >= 1
    assert len(self.vs) <= MAX_OP_ARITY
    vs = ", ".join([str(v) for v in self.vs] + \
                    ["<none>" for _ in range(MAX_OP_ARITY - len(self.vs))])
    return f"{self.op}, {self.width}, {vs}, {self.ret_val}"

def parse_generated_llvm_file(lines):
  i = 0
  out = []
  # define i3 @test_add_width_3__val_7__val_6() {
  #   ret i3 -3
  # }
  while i < len(lines):
    i += 1
    if lines[i].startswith("define"):
      def_line = lines[i]; i += 1

      re_def_line = r"define i\d+ @test_([a-z]+)"
      match = re.search(re_def_line, def_line)
      vals = None

      if match: # we have matched the regular expression.
        op_name = match.group(1)
        if op_name == "add":
          # binary operation
          re_def_line = r"define i\d+ @test_[a-z]+_width_(\d+)__val_(\d+)__val_(\d+)"
          match = re.search(re_def_line, def_line)
          assert match
          vals = [match.group(2 + i) for i in range(0, 2)]
        else:
          raise RuntimeError("unknown operation '{op_name}'")
        assert vals
        ret_line = lines[i]; i += 1
        re_ret = r"ret i(\d+) ([+-]?\d+|false|true)"
        ret_match = re.search(re_ret, ret_line)
        if not ret_match:
          print(f"unable to find pattern '{re_ret}' in '{ret_line}'")
        assert ret_match
        width = ret_match.group(1)
        ret_val = ret_match.group(2)
        yield Row(op=op_name, width=width, vs=vals, ret_val=ret_val)
      else:
       i += 1

    i += 1; # skip }


LLVM_ARITH_BINOPS = [LLVMArithBinopInfo("add", 2)]
if __name__ == "__main__":
  with open("generated-llvm.ll", "w") as f:
    for (w, info) in tqdm(itertools.product(range(1, 4), LLVM_ARITH_BINOPS)):
        f.write(info.to_str(w))

  sh("opt-15", "-S", "generated-llvm.ll", "-instcombine", "-o", "generated-llvm-optimized.ll")

  with open("generated-llvm-optimized.ll", "r") as f:
    rows = parse_generated_llvm_file(f.readlines())

  with open("generated-llvm-optimized-data.csv", "w") as f:
    f.write(Row.to_header())
    for row in tqdm(rows):
      f.write(row.to_csv() + "\n")
