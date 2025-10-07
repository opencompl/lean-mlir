module {
  func.func @main(%arg0: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.xor %c-9_i64, %c-37_i64 : i64
    %1 = llvm.ashr %c-32_i64, %0 : i64
    %2 = llvm.urem %c-39_i64, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.urem %c35_i64, %arg0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.and %c-2_i64, %c-26_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.trunc %arg0 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.udiv %c-26_i64, %c-19_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.lshr %c44_i64, %1 : i64
    %3 = llvm.icmp "sle" %c-28_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "ule" %c18_i64, %c-36_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %c38_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "eq" %2, %c-36_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c-46_i64 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.or %c13_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "sle" %c48_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.lshr %c-10_i64, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %c-1_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.xor %c-14_i64, %arg1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %c22_i64, %c37_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.sdiv %arg0, %c-6_i64 : i64
    %1 = llvm.icmp "sgt" %c-39_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c-13_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.xor %c36_i64, %arg2 : i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    %3 = llvm.sdiv %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %2, %arg2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.and %c-20_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %c-41_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %c17_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %c5_i64, %0 : i64
    %2 = llvm.and %1, %c-8_i64 : i64
    %3 = llvm.icmp "sge" %2, %c16_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "sle" %arg0, %c21_i64 : i64
    %1 = llvm.select %0, %c-43_i64, %arg0 : i1, i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.srem %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "ugt" %c41_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %true = arith.constant true
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %c-7_i64 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.ashr %c38_i64, %arg0 : i64
    %1 = llvm.sdiv %c-40_i64, %0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.sdiv %c-14_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.icmp "ult" %2, %c2_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %arg1, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %c45_i64 : i64
    %2 = llvm.or %c-47_i64, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.and %c-27_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.sdiv %c43_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.select %1, %arg0, %arg1 : i1, i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %true = arith.constant true
    %false = arith.constant false
    %c11_i64 = arith.constant 11 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.select %false, %c11_i64, %c44_i64 : i1, i64
    %1 = llvm.urem %0, %c28_i64 : i64
    %2 = llvm.select %true, %1, %1 : i1, i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c20_i64 = arith.constant 20 : i64
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.select %false, %0, %c11_i64 : i1, i64
    %2 = llvm.srem %c20_i64, %1 : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "uge" %0, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.and %c-29_i64, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg2, %1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.urem %arg0, %c-20_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %c-50_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.or %2, %c43_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.and %c30_i64, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.ashr %c-13_i64, %c-33_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %0, %arg0 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %c35_i64, %0 : i64
    %2 = llvm.xor %c23_i64, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %c26_i64, %c26_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.srem %c-15_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "ult" %c33_i64, %c26_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %c-3_i64, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.srem %1, %c36_i64 : i64
    %3 = llvm.icmp "sle" %2, %c1_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.xor %c-19_i64, %c-45_i64 : i64
    %1 = llvm.ashr %c0_i64, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %c-3_i64, %0 : i64
    %2 = llvm.lshr %1, %c-2_i64 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %c29_i64, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %c1_i64 : i64
    %2 = llvm.icmp "sge" %c-30_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.ashr %arg0, %c-46_i64 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %c-3_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %c-26_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.lshr %arg1, %c37_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.select %1, %c-16_i64, %c42_i64 : i1, i64
    %3 = llvm.urem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sdiv %arg1, %c6_i64 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.udiv %c-25_i64, %arg0 : i64
    %1 = llvm.and %c28_i64, %0 : i64
    %2 = llvm.sdiv %0, %arg1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.ashr %c10_i64, %c-4_i64 : i64
    %1 = llvm.icmp "slt" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.lshr %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %c46_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.lshr %c-37_i64, %arg1 : i64
    %1 = llvm.icmp "slt" %0, %c9_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.select %1, %c-29_i64, %arg1 : i1, i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c23_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "ugt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.select %2, %1, %arg1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "sle" %c17_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.select %true, %arg0, %c-30_i64 : i1, i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %arg1, %c-8_i64 : i64
    %1 = llvm.udiv %c-40_i64, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c-27_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.select %true, %arg0, %arg0 : i1, i64
    %2 = llvm.xor %1, %c35_i64 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "ult" %arg0, %c-25_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c45_i64, %1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c47_i64 = arith.constant 47 : i64
    %true = arith.constant true
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.select %true, %c-32_i64, %arg0 : i1, i64
    %1 = llvm.sdiv %c49_i64, %0 : i64
    %2 = llvm.udiv %c47_i64, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c-38_i64 = arith.constant -38 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "sle" %arg0, %c48_i64 : i64
    %1 = llvm.select %arg1, %arg2, %c-38_i64 : i1, i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-37_i64 = arith.constant -37 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.udiv %c-3_i64, %c10_i64 : i64
    %1 = llvm.ashr %c-37_i64, %0 : i64
    %2 = llvm.select %false, %1, %arg0 : i1, i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.udiv %c-31_i64, %c-18_i64 : i64
    %2 = llvm.select %arg2, %c6_i64, %1 : i1, i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.udiv %c-33_i64, %c9_i64 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %c41_i64 : i64
    %2 = llvm.srem %1, %c-27_i64 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.or %c-28_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg1, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c1_i64 = arith.constant 1 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "sle" %arg0, %c36_i64 : i64
    %1 = llvm.sdiv %c1_i64, %c48_i64 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.ashr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "uge" %c40_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "ugt" %1, %c-8_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %c-23_i64 = arith.constant -23 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.srem %c-23_i64, %c39_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.srem %arg0, %c-22_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %c22_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-37_i64 = arith.constant -37 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %0, %c-33_i64 : i64
    %2 = llvm.or %c-37_i64, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.xor %c-29_i64, %c-21_i64 : i64
    %1 = llvm.sdiv %arg1, %arg1 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.icmp "ult" %c20_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %c-36_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.srem %c-26_i64, %c-44_i64 : i64
    %1 = llvm.ashr %arg0, %c13_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.sdiv %arg0, %c10_i64 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c-14_i64 = arith.constant -14 : i64
    %true = arith.constant true
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "sle" %c22_i64, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.sdiv %c-14_i64, %c46_i64 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %arg1, %arg1 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.select %2, %0, %arg2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.icmp "uge" %c33_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.ashr %c7_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %0 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "ne" %c-49_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.ashr %c23_i64, %arg0 : i64
    %1 = llvm.srem %c-33_i64, %0 : i64
    %2 = llvm.sdiv %arg0, %c-27_i64 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %c35_i64, %0 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "ugt" %arg0, %c36_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.udiv %c39_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.or %1, %c-25_i64 : i64
    %3 = llvm.icmp "uge" %c-3_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.or %c20_i64, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "sgt" %c-49_i64, %c37_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.srem %c6_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ugt" %c-1_i64, %c50_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.xor %arg1, %c37_i64 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.select %2, %arg2, %c45_i64 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.and %c-36_i64, %0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.xor %c-42_i64, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c46_i64 = arith.constant 46 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %c-4_i64 : i64
    %2 = llvm.udiv %c16_i64, %1 : i64
    %3 = llvm.icmp "slt" %c46_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.udiv %c-35_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.ashr %2, %c6_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %arg0, %c-11_i64 : i64
    %1 = llvm.sdiv %c-24_i64, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ult" %c8_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %c29_i64, %c-23_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c3_i64 = arith.constant 3 : i64
    %c16_i64 = arith.constant 16 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.sdiv %c16_i64, %c-18_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.xor %1, %c3_i64 : i64
    %3 = llvm.icmp "ult" %2, %c29_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c12_i64 = arith.constant 12 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.lshr %c12_i64, %c-10_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.ashr %arg0, %c15_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ne" %c36_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.xor %arg1, %c-8_i64 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.sdiv %arg2, %0 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "sge" %c0_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.lshr %c23_i64, %c-30_i64 : i64
    %1 = llvm.urem %c14_i64, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.udiv %c23_i64, %arg2 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %c42_i64 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.ashr %2, %c8_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %c19_i64 : i64
    %3 = llvm.icmp "uge" %2, %c35_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %c45_i64, %c4_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c4_i64 = arith.constant 4 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "ugt" %c4_i64, %c6_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %c-6_i64 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.urem %c23_i64, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %arg0, %c-12_i64 : i64
    %1 = llvm.and %c-32_i64, %0 : i64
    %2 = llvm.icmp "sle" %1, %c-45_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.lshr %c2_i64, %c-15_i64 : i64
    %1 = llvm.and %c-40_i64, %0 : i64
    %2 = llvm.srem %c-22_i64, %1 : i64
    %3 = llvm.icmp "ult" %c-45_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %c-28_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.or %c42_i64, %arg0 : i64
    %1 = llvm.xor %c6_i64, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.ashr %arg1, %arg2 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "eq" %c-44_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg1, %arg2 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %true = arith.constant true
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.select %true, %c11_i64, %arg0 : i1, i64
    %1 = llvm.urem %0, %c14_i64 : i64
    %2 = llvm.srem %arg1, %0 : i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %0, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %c29_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.and %arg0, %c20_i64 : i64
    %1 = llvm.or %arg0, %c48_i64 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg1, %arg2 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %c49_i64, %1 : i64
    %3 = llvm.sdiv %c41_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.xor %c20_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %c1_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %c-22_i64, %c-43_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.xor %c39_i64, %c-25_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c20_i64 = arith.constant 20 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.udiv %c20_i64, %1 : i64
    %3 = llvm.icmp "ugt" %c37_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "sgt" %c20_i64, %c29_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.select %arg0, %c-11_i64, %arg1 : i1, i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.ashr %c-42_i64, %arg2 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ule" %0, %c30_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %c47_i64, %c19_i64 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.xor %c30_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.urem %c-3_i64, %c-16_i64 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "sle" %c6_i64, %c15_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "uge" %c50_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %c-22_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.urem %c-14_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %c-15_i64 : i64
    %2 = llvm.icmp "ne" %c10_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.lshr %arg0, %c-11_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.or %c-45_i64, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %c21_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %c1_i64 : i64
    %3 = llvm.icmp "sle" %c19_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %c-12_i64, %0 : i64
    %2 = llvm.or %arg1, %arg2 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.ashr %c16_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.select %arg1, %arg0, %c36_i64 : i1, i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.or %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %false = arith.constant false
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "ult" %arg0, %c-23_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %c42_i64, %1 : i64
    %3 = llvm.select %false, %1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.urem %c-33_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c-14_i64 : i1, i64
    %2 = llvm.icmp "sge" %c23_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.sdiv %c15_i64, %c-14_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.icmp "sgt" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %arg2, %1 : i1, i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.sdiv %0, %0 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.select %arg0, %c-23_i64, %arg1 : i1, i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg1 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ne" %0, %c3_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.ashr %c-49_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.and %c-13_i64, %c23_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.lshr %c-44_i64, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %c-40_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.lshr %c0_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sge" %c40_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %arg1, %c21_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %c-42_i64 : i64
    %2 = llvm.udiv %c-4_i64, %0 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sdiv %arg0, %c27_i64 : i64
    %1 = llvm.xor %c1_i64, %0 : i64
    %2 = llvm.srem %0, %0 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.srem %c-15_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.xor %c44_i64, %c-3_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.ashr %1, %c-6_i64 : i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.ashr %c-37_i64, %arg1 : i64
    %1 = llvm.select %arg0, %c46_i64, %0 : i1, i64
    %2 = llvm.icmp "eq" %1, %c-46_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %c17_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %c-46_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.or %c10_i64, %arg0 : i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c13_i64 = arith.constant 13 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.urem %c13_i64, %c-44_i64 : i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "eq" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "uge" %c-4_i64, %c-38_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "slt" %c-40_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %c-2_i64 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %c-19_i64, %0 : i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.and %c-46_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "ne" %c-18_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "sle" %2, %c44_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.and %c5_i64, %arg2 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ne" %c-8_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.icmp "slt" %c10_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-39_i64 = arith.constant -39 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %0, %c8_i64 : i64
    %2 = llvm.and %c-39_i64, %1 : i64
    %3 = llvm.xor %2, %c16_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %true = arith.constant true
    %c1_i64 = arith.constant 1 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.select %true, %c1_i64, %c-28_i64 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %arg1, %c-44_i64 : i64
    %3 = llvm.select %true, %1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.and %arg0, %c45_i64 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.ashr %c9_i64, %arg0 : i64
    %1 = llvm.select %false, %arg1, %0 : i1, i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "sge" %c-6_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c1_i64 = arith.constant 1 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.sdiv %c1_i64, %c9_i64 : i64
    %1 = llvm.and %c-48_i64, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "eq" %c-17_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "uge" %c48_i64, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %c-26_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.ashr %c-9_i64, %c14_i64 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c47_i64 : i64
    %2 = llvm.or %1, %c-22_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "sge" %c24_i64, %c-49_i64 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %c-7_i64 : i64
    %2 = llvm.and %c27_i64, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "sle" %c-16_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.lshr %arg0, %c31_i64 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "sle" %arg0, %c18_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %arg0, %c-26_i64 : i64
    %1 = llvm.icmp "ult" %c10_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c49_i64 = arith.constant 49 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.sdiv %c49_i64, %c13_i64 : i64
    %1 = llvm.icmp "slt" %c-12_i64, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c-2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ule" %0, %c-50_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %c-2_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c41_i64 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %true = arith.constant true
    %c26_i64 = arith.constant 26 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.select %true, %c26_i64, %c32_i64 : i1, i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.srem %c-21_i64, %c-27_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %c10_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.select %true, %1, %arg0 : i1, i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.sdiv %arg1, %c50_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "uge" %c-38_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.select %0, %c-46_i64, %1 : i1, i64
    %3 = llvm.urem %2, %c-44_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %c-49_i64, %0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.srem %c-3_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.lshr %c48_i64, %0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c27_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "sle" %arg0, %c0_i64 : i64
    %1 = llvm.urem %arg1, %c-19_i64 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "sge" %c5_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.select %arg0, %1, %1 : i1, i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "ult" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.select %true, %arg0, %c3_i64 : i1, i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c-16_i64, %1 : i64
    %3 = llvm.icmp "sge" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.select %arg2, %c-33_i64, %arg1 : i1, i64
    %1 = llvm.ashr %0, %c11_i64 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %arg0, %c48_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.ashr %c17_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.ashr %0, %arg0 : i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %c44_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %c31_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "ult" %arg0, %c-36_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.lshr %c34_i64, %c36_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.ashr %0, %arg1 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.lshr %c-33_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %arg1, %c27_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.xor %arg1, %arg2 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %c-29_i64, %0 : i64
    %2 = llvm.xor %arg1, %c4_i64 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.urem %0, %arg2 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "ult" %c-28_i64, %c-45_i64 : i64
    %1 = llvm.ashr %c-30_i64, %arg0 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.icmp "sgt" %c-41_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sdiv %c32_i64, %arg0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c37_i64 = arith.constant 37 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.urem %c11_i64, %arg0 : i64
    %1 = llvm.or %c37_i64, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "uge" %c43_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %arg1, %0, %c2_i64 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.and %c33_i64, %c47_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "ule" %arg0, %c27_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.icmp "sge" %c-8_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.xor %c-40_i64, %arg0 : i64
    %1 = llvm.urem %0, %c-1_i64 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.ashr %2, %c42_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "sgt" %c-20_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.urem %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c12_i64 = arith.constant 12 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.lshr %c12_i64, %c-1_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "sle" %c40_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c44_i64 = arith.constant 44 : i64
    %c42_i64 = arith.constant 42 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.xor %c42_i64, %c29_i64 : i64
    %1 = llvm.srem %c44_i64, %0 : i64
    %2 = llvm.or %c20_i64, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %c23_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.icmp "eq" %1, %c23_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "sgt" %c10_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.sdiv %arg0, %c-25_i64 : i64
    %1 = llvm.icmp "sle" %arg0, %arg0 : i64
    %2 = llvm.select %1, %arg1, %0 : i1, i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.sdiv %c-19_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.srem %0, %arg2 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.srem %c2_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %c19_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.srem %c32_i64, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.select %1, %arg0, %arg2 : i1, i64
    %3 = llvm.xor %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %c-34_i64, %0 : i64
    %2 = llvm.urem %c-18_i64, %1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.xor %c-30_i64, %c33_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.urem %c-36_i64, %c13_i64 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c2_i64 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.icmp "ugt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %arg2, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "eq" %c-8_i64, %c43_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    %3 = llvm.lshr %c-20_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sdiv %arg0, %c41_i64 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %c-30_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "eq" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %2, %c18_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ule" %c48_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %c0_i64 : i64
    %3 = llvm.icmp "ult" %c-32_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %false = arith.constant false
    %c31_i64 = arith.constant 31 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.select %false, %c31_i64, %c3_i64 : i1, i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.icmp "ule" %c-45_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %false = arith.constant false
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.select %false, %c18_i64, %arg0 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %c-37_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.srem %arg2, %c-35_i64 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.select %true, %arg1, %1 : i1, i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "eq" %arg1, %arg2 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c36_i64, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %false = arith.constant false
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.select %arg0, %arg1, %c-13_i64 : i1, i64
    %1 = llvm.select %false, %c27_i64, %arg2 : i1, i64
    %2 = llvm.select %false, %arg2, %1 : i1, i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.select %arg2, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "ne" %arg1, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "sgt" %c-40_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.select %2, %arg2, %arg2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.urem %c-28_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c10_i64 = arith.constant 10 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.udiv %c19_i64, %arg0 : i64
    %1 = llvm.udiv %c10_i64, %0 : i64
    %2 = llvm.or %c20_i64, %1 : i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.xor %arg1, %c-37_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.srem %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.or %c-32_i64, %1 : i64
    %3 = llvm.icmp "ult" %c-47_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ne" %c10_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ult" %c29_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.udiv %c28_i64, %c0_i64 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.urem %c-42_i64, %c37_i64 : i64
    %1 = llvm.icmp "ule" %0, %c-26_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.xor %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.ashr %c-12_i64, %c38_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.xor %arg0, %c32_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "uge" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %0, %c8_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %c-39_i64 : i64
    %2 = llvm.sdiv %arg2, %1 : i64
    %3 = llvm.select %0, %arg2, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "uge" %arg0, %c-14_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %c26_i64 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %1, %c21_i64 : i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %c42_i64, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ne" %2, %c-24_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.or %c-15_i64, %1 : i64
    %3 = llvm.udiv %2, %c-5_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.select %2, %arg2, %c14_i64 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "slt" %c-20_i64, %c25_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sge" %c22_i64, %c6_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.urem %c3_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %0, %c-18_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %1, %arg2 : i1, i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %c-17_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.select %true, %arg0, %c16_i64 : i1, i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sle" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg1, %arg2 : i1, i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.sdiv %1, %c-13_i64 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %c-48_i64, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %c-11_i64 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.and %arg0, %c30_i64 : i64
    %1 = llvm.and %c9_i64, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.and %arg0, %c-3_i64 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.urem %c25_i64, %c-44_i64 : i64
    %1 = llvm.srem %c17_i64, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.xor %c-18_i64, %c-50_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.udiv %c-36_i64, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.udiv %c36_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %c44_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.urem %arg0, %c-8_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.and %c-6_i64, %1 : i64
    %3 = llvm.lshr %2, %c13_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c19_i64 = arith.constant 19 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ult" %c-34_i64, %c-13_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %c-49_i64, %1 : i1, i64
    %3 = llvm.icmp "ule" %c19_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "eq" %c0_i64, %c31_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.lshr %arg2, %arg2 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c5_i64 = arith.constant 5 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.udiv %c2_i64, %arg0 : i64
    %1 = llvm.and %c5_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %c38_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "sge" %c2_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %c-31_i64, %1 : i64
    %3 = llvm.icmp "ult" %c-37_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %c-2_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.urem %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ugt" %c44_i64, %c-12_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %c-36_i64, %c16_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.select %arg0, %c-48_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ule" %0, %c-46_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.sdiv %c39_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %c0_i64, %arg0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %c-8_i64, %0 : i64
    %2 = llvm.ashr %0, %0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c18_i64 = arith.constant 18 : i64
    %true = arith.constant true
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.select %true, %arg1, %c18_i64 : i1, i64
    %2 = llvm.select %0, %c-8_i64, %1 : i1, i64
    %3 = llvm.ashr %2, %c44_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.sdiv %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %arg2, %c-40_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "sgt" %c-47_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %c46_i64 : i64
    %3 = llvm.icmp "slt" %2, %c-11_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c10_i64 = arith.constant 10 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ugt" %c10_i64, %c48_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %c-42_i64, %arg0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.icmp "ugt" %2, %c29_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.srem %arg0, %c49_i64 : i64
    %1 = llvm.ashr %c22_i64, %0 : i64
    %2 = llvm.or %arg1, %arg2 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.select %arg2, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %0, %c50_i64 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ule" %c-40_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.select %arg0, %c29_i64, %arg1 : i1, i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.and %arg2, %c-32_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "sgt" %arg0, %c10_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %c-8_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c-32_i64, %arg0 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c-19_i64 : i64
    %2 = llvm.udiv %arg1, %c23_i64 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "ne" %c23_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg1 : i64
    %2 = llvm.select %0, %1, %c-46_i64 : i1, i64
    %3 = llvm.icmp "slt" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.xor %c39_i64, %c28_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.xor %c12_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "sgt" %c-3_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %arg0 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "ult" %c-14_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.select %arg0, %c-48_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg0 : i1, i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.xor %c-31_i64, %arg0 : i64
    %1 = llvm.and %c-41_i64, %arg1 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.lshr %c45_i64, %arg1 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %c10_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.xor %c-24_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %c45_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.ashr %c-36_i64, %arg0 : i64
    %1 = llvm.srem %0, %c34_i64 : i64
    %2 = llvm.icmp "sge" %c-20_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.and %arg2, %c-17_i64 : i64
    %2 = llvm.select %0, %arg2, %1 : i1, i64
    %3 = llvm.sdiv %2, %c-45_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.and %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "uge" %c-20_i64, %c-5_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.udiv %2, %c30_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %arg1, %c-8_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %c-11_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg1, %arg0 : i1, i64
    %1 = llvm.xor %0, %c15_i64 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "sge" %arg0, %c36_i64 : i64
    %1 = llvm.xor %c-3_i64, %c-49_i64 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.urem %c-29_i64, %arg0 : i64
    %1 = llvm.or %c-4_i64, %0 : i64
    %2 = llvm.icmp "ugt" %1, %c-29_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.or %arg1, %c-12_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "slt" %c30_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.srem %c-46_i64, %arg0 : i64
    %1 = llvm.xor %c48_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %c32_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.urem %arg0, %c23_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.and %c6_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.select %2, %arg1, %arg0 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.and %c-46_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c-30_i64, %0 : i64
    %2 = llvm.select %1, %c-16_i64, %arg0 : i1, i64
    %3 = llvm.srem %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %arg1, %arg0 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c20_i64 = arith.constant 20 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.udiv %c50_i64, %arg0 : i64
    %1 = llvm.ashr %c-47_i64, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "sgt" %c20_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.srem %c36_i64, %c14_i64 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.urem %c44_i64, %arg0 : i64
    %1 = llvm.and %c33_i64, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "eq" %c-3_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "ule" %c39_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.select %0, %c43_i64, %1 : i1, i64
    %3 = llvm.icmp "sge" %c-3_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.udiv %c8_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %arg2, %arg0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.or %arg0, %c42_i64 : i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.srem %c47_i64, %arg1 : i64
    %1 = llvm.or %arg0, %c5_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c34_i64 = arith.constant 34 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ugt" %c34_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %c14_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c45_i64 = arith.constant 45 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.or %c45_i64, %0 : i64
    %2 = llvm.udiv %c-6_i64, %0 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.ashr %c-26_i64, %c-27_i64 : i64
    %1 = llvm.ashr %c-1_i64, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.icmp "ugt" %c33_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.ashr %1, %c31_i64 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %arg0, %c-27_i64 : i64
    %1 = llvm.and %arg0, %c-1_i64 : i64
    %2 = llvm.sdiv %1, %c-28_i64 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "uge" %c25_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %c9_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %c50_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.ashr %c-45_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.select %1, %arg1, %c-46_i64 : i1, i64
    %3 = llvm.select %1, %arg1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.and %c-45_i64, %c24_i64 : i64
    %1 = llvm.srem %c-17_i64, %0 : i64
    %2 = llvm.icmp "ne" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %c9_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.lshr %c-29_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %c25_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c33_i64 = arith.constant 33 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.select %arg0, %c-12_i64, %arg1 : i1, i64
    %1 = llvm.icmp "slt" %c33_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %c-24_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "uge" %arg0, %c50_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %0, %arg1, %arg2 : i1, i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c3_i64 = arith.constant 3 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.icmp "ugt" %c3_i64, %c-10_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c49_i64, %1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.xor %c-27_i64, %1 : i64
    %3 = llvm.icmp "ugt" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "eq" %c7_i64, %c31_i64 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.sdiv %arg0, %c-21_i64 : i64
    %1 = llvm.icmp "ule" %c-16_i64, %0 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.icmp "ule" %arg1, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %true, %arg0, %1 : i1, i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.lshr %c-14_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.and %c-8_i64, %c-26_i64 : i64
    %1 = llvm.srem %c-11_i64, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.udiv %arg1, %c10_i64 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %c-27_i64 : i1, i64
    %3 = llvm.icmp "ugt" %c-26_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.ashr %c25_i64, %c43_i64 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %false = arith.constant false
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.urem %c13_i64, %arg0 : i64
    %1 = llvm.ashr %c8_i64, %arg0 : i64
    %2 = llvm.select %arg1, %0, %1 : i1, i64
    %3 = llvm.select %false, %0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.udiv %c-4_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.icmp "ule" %c26_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %c4_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.lshr %c33_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c49_i64 = arith.constant 49 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.and %c49_i64, %c21_i64 : i64
    %1 = llvm.urem %c-37_i64, %0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.or %0, %c11_i64 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %c-36_i64, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "ult" %c-9_i64, %c21_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c8_i64, %1 : i64
    %3 = llvm.urem %c3_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-40_i64 = arith.constant -40 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.ashr %c-40_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "slt" %2, %c-2_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c-5_i64, %c40_i64 : i1, i64
    %2 = llvm.urem %c-39_i64, %c21_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg2, %c-10_i64 : i1, i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "ult" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "uge" %c50_i64, %c-28_i64 : i64
    %1 = llvm.ashr %c-8_i64, %arg0 : i64
    %2 = llvm.select %0, %1, %c-48_i64 : i1, i64
    %3 = llvm.icmp "sge" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "slt" %c5_i64, %c33_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c12_i64 = arith.constant 12 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.srem %c-28_i64, %c-3_i64 : i64
    %1 = llvm.or %c12_i64, %0 : i64
    %2 = llvm.lshr %c23_i64, %0 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg1 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.udiv %c-31_i64, %arg0 : i64
    %1 = llvm.urem %c-27_i64, %c44_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.select %2, %arg1, %1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.xor %c-44_i64, %arg1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.lshr %c25_i64, %1 : i64
    %3 = llvm.icmp "ult" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %c-7_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %c44_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.select %arg1, %c-10_i64, %arg0 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.xor %c47_i64, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.lshr %c-39_i64, %c19_i64 : i64
    %1 = llvm.icmp "sgt" %0, %c0_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-48_i64 = arith.constant -48 : i64
    %true = arith.constant true
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.select %true, %c-46_i64, %arg0 : i1, i64
    %1 = llvm.icmp "sle" %0, %c-48_i64 : i64
    %2 = llvm.select %1, %c-37_i64, %0 : i1, i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "ult" %arg0, %c-44_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %c-40_i64 : i64
    %3 = llvm.urem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.ashr %c50_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.srem %c47_i64, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "sle" %c50_i64, %c-33_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %c23_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "ult" %c-44_i64, %c26_i64 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.icmp "ne" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "sle" %c-34_i64, %c-16_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.xor %arg0, %arg1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c0_i64 = arith.constant 0 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "uge" %c5_i64, %c-32_i64 : i64
    %1 = llvm.select %0, %c0_i64, %c-18_i64 : i1, i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "slt" %c-29_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.select %arg2, %c46_i64, %0 : i1, i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c34_i64 = arith.constant 34 : i64
    %c42_i64 = arith.constant 42 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.and %c42_i64, %c26_i64 : i64
    %1 = llvm.icmp "sgt" %c34_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ult" %c-32_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %c4_i64 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.ashr %2, %arg2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.lshr %c4_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %c46_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.urem %c9_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %c-30_i64, %0 : i64
    %2 = llvm.sdiv %c41_i64, %1 : i64
    %3 = llvm.icmp "uge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %c48_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.xor %c-19_i64, %c-34_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.xor %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.xor %c-21_i64, %arg0 : i64
    %1 = llvm.ashr %c-36_i64, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.icmp "sge" %c-26_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.xor %c30_i64, %arg1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.ashr %c15_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "uge" %c-1_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "ugt" %c-20_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.lshr %c-27_i64, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %c-15_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.srem %arg0, %c-26_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %arg0, %c49_i64 : i64
    %1 = llvm.lshr %c6_i64, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %arg1, %arg1 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.select %false, %arg0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.sdiv %c-10_i64, %0 : i64
    %2 = llvm.udiv %c-45_i64, %1 : i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.and %arg1, %c9_i64 : i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    %2 = llvm.and %0, %arg2 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.lshr %c-10_i64, %arg0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.sdiv %c-44_i64, %arg0 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "ne" %arg0, %c12_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %c17_i64, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "ne" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg0 : i64
    %2 = llvm.or %c-38_i64, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c21_i64 = arith.constant 21 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.sdiv %c21_i64, %c0_i64 : i64
    %1 = llvm.sdiv %c16_i64, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.xor %c-8_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.sdiv %c-33_i64, %arg1 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.sdiv %arg1, %c18_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.srem %c-2_i64, %arg0 : i64
    %1 = llvm.or %c-42_i64, %0 : i64
    %2 = llvm.lshr %1, %c-7_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %2, %c2_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.sdiv %c45_i64, %c-43_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.or %c0_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %c-46_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %c14_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.udiv %c3_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %arg1, %c-29_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "ugt" %arg0, %c-25_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c-48_i64, %arg1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.xor %arg0, %c31_i64 : i64
    %1 = llvm.ashr %c37_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %c48_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "uge" %c-12_i64, %c-42_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.srem %c-43_i64, %c46_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.udiv %arg0, %c43_i64 : i64
    %1 = llvm.urem %c-40_i64, %arg0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.lshr %c22_i64, %c-36_i64 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.lshr %arg0, %c8_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.and %c20_i64, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.xor %c-11_i64, %0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.icmp "ne" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "sge" %arg0, %c48_i64 : i64
    %1 = llvm.srem %arg1, %c-43_i64 : i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.icmp "uge" %2, %c-34_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %true = arith.constant true
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.urem %c-40_i64, %arg1 : i64
    %1 = llvm.icmp "sge" %0, %c-5_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %true, %arg0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.urem %arg0, %c-49_i64 : i64
    %1 = llvm.icmp "sle" %c8_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %c17_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "eq" %arg2, %c27_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "sgt" %c-46_i64, %c-24_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %arg0 : i1 to i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c25_i64 = arith.constant 25 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.udiv %c25_i64, %c14_i64 : i64
    %1 = llvm.xor %c-44_i64, %0 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.and %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.urem %c28_i64, %c-2_i64 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.urem %c-47_i64, %c-18_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %arg0, %arg1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.urem %c-36_i64, %c28_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.icmp "sgt" %2, %c-48_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %c-2_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "eq" %c-33_i64, %arg1 : i64
    %1 = llvm.select %0, %c11_i64, %c8_i64 : i1, i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "ne" %c-33_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %c-39_i64, %c45_i64 : i1, i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.xor %2, %c-50_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "ule" %c-9_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg1, %arg1 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "uge" %c-23_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %arg2, %arg2 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %c-11_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %c-30_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.srem %c-19_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %c28_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c13_i64 = arith.constant 13 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.xor %c-2_i64, %c-5_i64 : i64
    %1 = llvm.udiv %c42_i64, %c13_i64 : i64
    %2 = llvm.ashr %1, %c-21_i64 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ule" %c-32_i64, %c-6_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.srem %arg0, %c-20_i64 : i64
    %1 = llvm.udiv %0, %c48_i64 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "slt" %c25_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.ashr %arg2, %c-18_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sle" %2, %c44_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %c-1_i64, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.udiv %c-19_i64, %c-39_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %c-39_i64, %0 : i64
    %2 = llvm.icmp "sle" %c1_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c22_i64 = arith.constant 22 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.udiv %c22_i64, %c45_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sdiv %1, %c4_i64 : i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.select %arg2, %arg0, %arg0 : i1, i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.ashr %arg0, %c46_i64 : i64
    %1 = llvm.srem %c24_i64, %arg1 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.select %0, %1, %c-37_i64 : i1, i64
    %3 = llvm.icmp "ult" %c-2_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.lshr %arg0, %c30_i64 : i64
    %1 = llvm.xor %c-20_i64, %0 : i64
    %2 = llvm.select %arg1, %arg0, %0 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c35_i64 = arith.constant 35 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.srem %c27_i64, %arg0 : i64
    %1 = llvm.and %c35_i64, %0 : i64
    %2 = llvm.udiv %c-44_i64, %1 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %true = arith.constant true
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %arg1, %c-45_i64 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.select %true, %0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.or %arg0, %c-18_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.udiv %c-31_i64, %arg0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.ashr %arg0, %c20_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %c11_i64, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "sle" %c-29_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg0 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.icmp "sge" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sdiv %c20_i64, %c45_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.udiv %c45_i64, %1 : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.urem %c-33_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c-3_i64, %c5_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.icmp "sle" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %c-20_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg1, %arg1 : i1, i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.xor %arg2, %c-5_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %arg1, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.or %arg0, %c24_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c-41_i64 = arith.constant -41 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.lshr %c-41_i64, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %c-47_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %c-14_i64 = arith.constant -14 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.srem %c-14_i64, %c32_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.and %2, %c-49_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.sdiv %c-14_i64, %arg1 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c19_i64 = arith.constant 19 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.sdiv %c2_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %c19_i64 : i64
    %2 = llvm.udiv %1, %c24_i64 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "slt" %arg1, %c49_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %c-12_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %c-11_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %true = arith.constant true
    %false = arith.constant false
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.select %false, %arg2, %c41_i64 : i1, i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.select %true, %arg0, %1 : i1, i64
    %3 = llvm.ashr %c-42_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "sge" %c-41_i64, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "sle" %c-29_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.lshr %arg0, %c6_i64 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.and %arg0, %c-35_i64 : i64
    %1 = llvm.sdiv %c45_i64, %0 : i64
    %2 = llvm.udiv %1, %c11_i64 : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %c-33_i64, %0 : i64
    %2 = llvm.xor %c-17_i64, %1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %c29_i64, %arg0 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %arg1, %c3_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "uge" %c3_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.and %c-24_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg1 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c8_i64 = arith.constant 8 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.and %c8_i64, %c49_i64 : i64
    %1 = llvm.icmp "uge" %0, %c19_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.xor %1, %c-35_i64 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.xor %c26_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c31_i64 = arith.constant 31 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.and %arg0, %c-33_i64 : i64
    %1 = llvm.urem %c31_i64, %0 : i64
    %2 = llvm.and %c28_i64, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "sle" %c13_i64, %c-45_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %c24_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %0, %2, %arg0 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %c-13_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.udiv %c10_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c-7_i64 : i64
    %2 = llvm.and %c-35_i64, %1 : i64
    %3 = llvm.lshr %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %c-15_i64 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.sdiv %c40_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.udiv %c-37_i64, %1 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %arg2, %c31_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.select %arg0, %arg1, %c41_i64 : i1, i64
    %1 = llvm.icmp "sgt" %arg2, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c-32_i64 = arith.constant -32 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.select %true, %c-32_i64, %c21_i64 : i1, i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.srem %c14_i64, %c50_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.and %c11_i64, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %true = arith.constant true
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "ult" %c45_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %true, %1, %1 : i1, i64
    %3 = llvm.icmp "ult" %c-39_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "ne" %c27_i64, %c-42_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.ashr %c-27_i64, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "ult" %arg1, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c-7_i64, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.urem %c4_i64, %c-22_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %c-25_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %c31_i64, %0 : i64
    %2 = llvm.or %1, %c-37_i64 : i64
    %3 = llvm.or %c-16_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c33_i64 = arith.constant 33 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c33_i64 : i64
    %2 = llvm.and %c-36_i64, %1 : i64
    %3 = llvm.icmp "slt" %2, %c-44_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.ashr %c-36_i64, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %c-11_i64, %0 : i64
    %2 = llvm.ashr %c5_i64, %c24_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %true = arith.constant true
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.select %true, %c-35_i64, %arg0 : i1, i64
    %1 = llvm.icmp "ult" %c12_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %arg0, %c48_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.or %c-37_i64, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.sdiv %c-45_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.lshr %c-9_i64, %c12_i64 : i64
    %1 = llvm.icmp "sgt" %0, %c-43_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.and %c-43_i64, %c-26_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.or %c30_i64, %1 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.udiv %c42_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.xor %c-1_i64, %c-33_i64 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.icmp "ule" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.ashr %c-10_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.and %c-27_i64, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %c25_i64 = arith.constant 25 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.urem %c25_i64, %c29_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %arg0, %c-16_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.urem %arg0, %c29_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ne" %c35_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.srem %arg0, %c-3_i64 : i64
    %1 = llvm.icmp "ult" %c-1_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %c-26_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %c-27_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %c6_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.ashr %c27_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %c-3_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.udiv %arg0, %c-13_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "sgt" %c24_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %c-33_i64, %0 : i64
    %2 = llvm.and %1, %c-9_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.xor %c15_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "ne" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg2, %arg1 : i1, i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.select %0, %2, %c15_i64 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.or %arg0, %c24_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "sgt" %c7_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "ne" %c-38_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c4_i64, %1 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "sge" %c-2_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %arg0, %arg0 : i1, i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.udiv %arg0, %c-32_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.urem %c-42_i64, %c-41_i64 : i64
    %1 = llvm.sdiv %c-16_i64, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-50_i64 = arith.constant -50 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.and %c36_i64, %arg0 : i64
    %1 = llvm.xor %c-50_i64, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c22_i64 : i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.udiv %0, %c-41_i64 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.and %c-50_i64, %c-36_i64 : i64
    %1 = llvm.srem %0, %c-26_i64 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "slt" %c-5_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.srem %c-19_i64, %arg0 : i64
    %1 = llvm.udiv %arg2, %arg2 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.srem %c-42_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.or %1, %c28_i64 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %c30_i64 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %false = arith.constant false
    %c33_i64 = arith.constant 33 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.select %false, %c33_i64, %c34_i64 : i1, i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.lshr %c27_i64, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.srem %1, %c-38_i64 : i64
    %3 = llvm.icmp "sge" %2, %c37_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.and %c10_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c36_i64 = arith.constant 36 : i64
    %c25_i64 = arith.constant 25 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.lshr %c11_i64, %arg0 : i64
    %1 = llvm.urem %c25_i64, %0 : i64
    %2 = llvm.or %c36_i64, %1 : i64
    %3 = llvm.icmp "ule" %2, %c-17_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c39_i64 = arith.constant 39 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.ashr %c39_i64, %c-1_i64 : i64
    %1 = llvm.and %c-2_i64, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.or %arg0, %c13_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.and %arg0, %0 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c45_i64 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "sge" %c-18_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "slt" %2, %c6_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "sge" %arg0, %c-1_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.sdiv %c23_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.srem %c17_i64, %1 : i64
    %3 = llvm.icmp "ne" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.xor %c47_i64, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-37_i64 = arith.constant -37 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c18_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %true, %c-37_i64, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg1, %arg1 : i1, i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %c36_i64 : i64
    %3 = llvm.srem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.lshr %c-20_i64, %c-10_i64 : i64
    %1 = llvm.srem %c49_i64, %0 : i64
    %2 = llvm.udiv %0, %0 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.select %arg0, %c-41_i64, %c-9_i64 : i1, i64
    %1 = llvm.select %arg1, %0, %c39_i64 : i1, i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %c14_i64, %c-11_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.select %1, %c-43_i64, %0 : i1, i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c-13_i64, %1 : i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "slt" %c-19_i64, %c-9_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.urem %c17_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.xor %c-48_i64, %arg0 : i64
    %1 = llvm.select %true, %0, %arg1 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %false = arith.constant false
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.select %false, %1, %c-20_i64 : i1, i64
    %3 = llvm.icmp "ugt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.select %arg0, %c28_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ule" %0, %c42_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %false = arith.constant false
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.select %false, %c23_i64, %arg0 : i1, i64
    %1 = llvm.urem %c41_i64, %0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.icmp "uge" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c-48_i64, %1 : i64
    %3 = llvm.icmp "sge" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.and %arg0, %c44_i64 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %c-41_i64 : i64
    %2 = llvm.and %1, %c8_i64 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "ult" %c-41_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %false, %1, %arg1 : i1, i64
    %3 = llvm.lshr %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.or %c-25_i64, %1 : i64
    %3 = llvm.and %c-2_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "sle" %arg0, %c-35_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %arg1, %arg0 : i1, i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.udiv %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c48_i64 = arith.constant 48 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.urem %c48_i64, %c31_i64 : i64
    %1 = llvm.icmp "ult" %c-15_i64, %arg0 : i64
    %2 = llvm.select %1, %0, %arg1 : i1, i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %arg1, %c-7_i64, %arg0 : i1, i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %c-28_i64, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "ne" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.ashr %c-22_i64, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %c17_i64, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.xor %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.xor %c21_i64, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.or %c32_i64, %1 : i64
    %3 = llvm.icmp "sge" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %true = arith.constant true
    %c-3_i64 = arith.constant -3 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.xor %c-3_i64, %c36_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.lshr %1, %c-9_i64 : i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %c-29_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %0, %c-36_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c13_i64 = arith.constant 13 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "eq" %c5_i64, %c-34_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c13_i64, %c-2_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %c-19_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.and %c25_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "slt" %2, %c37_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.select %arg0, %c46_i64, %arg1 : i1, i64
    %1 = llvm.select %true, %0, %arg2 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.ashr %c-5_i64, %arg1 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.select %arg2, %0, %1 : i1, i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.lshr %c-48_i64, %c-1_i64 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.udiv %c-7_i64, %c23_i64 : i64
    %1 = llvm.srem %0, %c16_i64 : i64
    %2 = llvm.urem %arg1, %0 : i64
    %3 = llvm.select %arg0, %1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.or %arg0, %c-29_i64 : i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c-39_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.select %true, %arg0, %0 : i1, i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.lshr %arg0, %c-10_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.urem %0, %0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.udiv %c-16_i64, %arg1 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.trunc %arg0 : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %c-14_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "slt" %c22_i64, %c-5_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %c18_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c41_i64 = arith.constant 41 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.urem %c41_i64, %1 : i64
    %3 = llvm.icmp "sge" %c26_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.urem %c18_i64, %c-23_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "eq" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.select %arg0, %c41_i64, %arg1 : i1, i64
    %1 = llvm.icmp "sle" %0, %c-47_i64 : i64
    %2 = llvm.select %1, %0, %arg2 : i1, i64
    %3 = llvm.icmp "ult" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c34_i64 = arith.constant 34 : i64
    %c33_i64 = arith.constant 33 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.sdiv %c33_i64, %c-49_i64 : i64
    %1 = llvm.icmp "sle" %0, %c30_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c34_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.sdiv %c42_i64, %c-28_i64 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c21_i64 = arith.constant 21 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.select %true, %c21_i64, %c-1_i64 : i1, i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %c-29_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %c2_i64, %0 : i64
    %2 = llvm.ashr %arg1, %arg0 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sdiv %c12_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c-1_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.ashr %arg2, %c38_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.udiv %c-25_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %c-27_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ult" %c50_i64, %arg0 : i64
    %1 = llvm.select %0, %c13_i64, %arg0 : i1, i64
    %2 = llvm.ashr %c-25_i64, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %c33_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "sge" %c11_i64, %c-13_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %c32_i64 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.urem %c33_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.and %c-25_i64, %arg0 : i64
    %1 = llvm.or %0, %c-29_i64 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "uge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %c-30_i64, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %c11_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.ashr %c45_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.urem %c3_i64, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg2 : i1, i64
    %2 = llvm.urem %c-19_i64, %1 : i64
    %3 = llvm.icmp "ule" %c7_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "uge" %arg0, %c4_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.sdiv %c48_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c32_i64 = arith.constant 32 : i64
    %c10_i64 = arith.constant 10 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.select %arg0, %c10_i64, %c4_i64 : i1, i64
    %1 = llvm.or %c32_i64, %0 : i64
    %2 = llvm.udiv %arg1, %c-5_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c26_i64 = arith.constant 26 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.and %c26_i64, %c-36_i64 : i64
    %1 = llvm.urem %c31_i64, %arg0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.udiv %1, %c12_i64 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %c-49_i64, %0 : i64
    %2 = llvm.srem %arg1, %c8_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %c10_i64, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.lshr %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %c50_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.ashr %c45_i64, %c-35_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.udiv %c-44_i64, %c-36_i64 : i64
    %1 = llvm.icmp "sle" %0, %c15_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c-15_i64 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.srem %c6_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.xor %c-17_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.udiv %arg0, %c43_i64 : i64
    %1 = llvm.and %0, %c34_i64 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.and %c5_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %arg0, %c-11_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.lshr %1, %c17_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ne" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c12_i64 = arith.constant 12 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "sge" %c12_i64, %c-14_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %c44_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "ugt" %arg0, %c-45_i64 : i64
    %1 = llvm.select %0, %c-32_i64, %arg0 : i1, i64
    %2 = llvm.srem %arg1, %arg2 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %c-26_i64, %1 : i64
    %3 = llvm.srem %c0_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.or %c-28_i64, %1 : i64
    %3 = llvm.srem %c41_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %c25_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.sdiv %arg0, %c24_i64 : i64
    %1 = llvm.icmp "ne" %c-33_i64, %0 : i64
    %2 = llvm.select %1, %arg1, %c46_i64 : i1, i64
    %3 = llvm.lshr %2, %arg2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.and %1, %c-37_i64 : i64
    %3 = llvm.icmp "uge" %2, %c-9_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %c-12_i64, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "uge" %c37_i64, %c-9_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.or %c32_i64, %arg1 : i64
    %1 = llvm.or %arg2, %0 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.and %c13_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.udiv %arg1, %c-43_i64 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ult" %2, %c-21_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.udiv %c-12_i64, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.udiv %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.lshr %c47_i64, %arg0 : i64
    %1 = llvm.or %arg0, %c49_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "slt" %c41_i64, %c43_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.sdiv %arg0, %arg0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ne" %arg0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %c-22_i64 : i64
    %2 = llvm.xor %c-23_i64, %1 : i64
    %3 = llvm.select %0, %2, %c35_i64 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %c40_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %c-5_i64, %0 : i64
    %2 = llvm.sdiv %1, %c-39_i64 : i64
    %3 = llvm.or %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.srem %c0_i64, %arg0 : i64
    %1 = llvm.xor %c41_i64, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.urem %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.select %false, %c38_i64, %arg0 : i1, i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %c-36_i64, %0 : i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-1_i64 = arith.constant -1 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.select %false, %c-1_i64, %c-24_i64 : i1, i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %c-47_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %1, %c-10_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.or %c-32_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %c-40_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.urem %c9_i64, %c-35_i64 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.lshr %arg1, %c-37_i64 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %c-14_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %arg1, %c8_i64 : i64
    %2 = llvm.urem %c3_i64, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.select %0, %2, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.udiv %c-15_i64, %arg0 : i64
    %1 = llvm.udiv %c28_i64, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.and %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %c35_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %c46_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c20_i64 = arith.constant 20 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.sdiv %c-6_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.and %c20_i64, %1 : i64
    %3 = llvm.icmp "ne" %c-8_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.select %arg1, %arg2, %c2_i64 : i1, i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "slt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c29_i64 = arith.constant 29 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.xor %c-37_i64, %arg0 : i64
    %1 = llvm.srem %c29_i64, %c-17_i64 : i64
    %2 = llvm.lshr %1, %c27_i64 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %c-7_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.xor %c6_i64, %c-38_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c27_i64 = arith.constant 27 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.select %0, %c50_i64, %arg1 : i1, i64
    %2 = llvm.sdiv %c27_i64, %c24_i64 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.and %c5_i64, %c-33_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %arg2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "ne" %arg0, %c-37_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %c36_i64, %arg1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.icmp "ne" %c-37_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %c-32_i64, %arg2 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c26_i64 = arith.constant 26 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.lshr %c0_i64, %arg0 : i64
    %1 = llvm.srem %c26_i64, %0 : i64
    %2 = llvm.and %0, %c41_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c-9_i64 = arith.constant -9 : i64
    %false = arith.constant false
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.select %false, %arg2, %c-42_i64 : i1, i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.urem %c-9_i64, %c-1_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "sle" %arg1, %arg2 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %1, %c27_i64 : i1, i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg1, %arg0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c-7_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %c41_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "ne" %c-23_i64, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c25_i64 = arith.constant 25 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.sdiv %arg0, %c26_i64 : i64
    %1 = llvm.icmp "eq" %c25_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %c43_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.udiv %0, %c50_i64 : i64
    %3 = llvm.select %arg0, %1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "sle" %c-40_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %c40_i64, %c28_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %false = arith.constant false
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %false, %c2_i64, %0 : i1, i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.ashr %arg2, %c-27_i64 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.udiv %arg0, %c-22_i64 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.select %1, %arg0, %arg1 : i1, i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "sle" %arg0, %c39_i64 : i64
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.select %0, %2, %1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "eq" %c-40_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg1, %c15_i64 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.urem %arg0, %c44_i64 : i64
    %1 = llvm.lshr %c30_i64, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.sdiv %arg1, %c8_i64 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.srem %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %c9_i64, %arg0 : i1, i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.or %c-29_i64, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.urem %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.and %c-1_i64, %arg1 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.select %arg0, %c-7_i64, %arg1 : i1, i64
    %1 = llvm.or %c38_i64, %arg2 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %c27_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.udiv %c32_i64, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %c-35_i64, %c38_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.udiv %c-35_i64, %c-29_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.urem %c19_i64, %arg0 : i64
    %1 = llvm.or %0, %c-20_i64 : i64
    %2 = llvm.icmp "sgt" %1, %c15_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.select %false, %c-6_i64, %arg0 : i1, i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "sle" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.urem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %c10_i64, %c-49_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.udiv %c-23_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %c34_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ult" %c-13_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %c29_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "ult" %c13_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %c-44_i64, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.ashr %c43_i64, %1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.select %arg1, %1, %c10_i64 : i1, i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %0, %c-36_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ule" %0, %c-8_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c32_i64 = arith.constant 32 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c46_i64 : i1, i64
    %2 = llvm.lshr %c14_i64, %1 : i64
    %3 = llvm.icmp "eq" %c32_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "eq" %c23_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "ule" %c-11_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.xor %c15_i64, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.and %1, %c15_i64 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %c34_i64, %arg1 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.urem %c-27_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.srem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %arg2, %c0_i64 : i1, i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.and %arg1, %c-14_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.lshr %arg0, %c9_i64 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ne" %2, %c50_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "sge" %arg2, %c18_i64 : i64
    %1 = llvm.select %0, %arg2, %c-44_i64 : i1, i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    %3 = llvm.and %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.srem %c-16_i64, %c-22_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.lshr %c-3_i64, %1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.ashr %c19_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sge" %c46_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg1, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.select %false, %1, %0 : i1, i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.select %arg0, %c-17_i64, %c-39_i64 : i1, i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %c43_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c2_i64 = arith.constant 2 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.udiv %c2_i64, %c18_i64 : i64
    %1 = llvm.xor %c-4_i64, %0 : i64
    %2 = llvm.udiv %1, %c21_i64 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %true = arith.constant true
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %true, %c37_i64, %1 : i1, i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.udiv %c-12_i64, %c2_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %c-11_i64, %0 : i64
    %2 = llvm.sdiv %1, %c49_i64 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %false = arith.constant false
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.and %arg2, %c46_i64 : i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.icmp "sle" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.select %false, %arg2, %c34_i64 : i1, i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %arg0, %arg0 : i1, i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.sdiv %arg0, %c-27_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.xor %c-41_i64, %1 : i64
    %3 = llvm.icmp "ule" %c47_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.udiv %c39_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %c-26_i64 : i1, i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.xor %arg1, %c7_i64 : i64
    %3 = llvm.select %true, %1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %c46_i64, %0 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %c20_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %c-9_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %true = arith.constant true
    %c43_i64 = arith.constant 43 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.select %true, %c43_i64, %c-30_i64 : i1, i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.urem %c-47_i64, %arg0 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.or %0, %arg0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.srem %c-5_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %arg1, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.ashr %arg0, %c-33_i64 : i64
    %1 = llvm.xor %arg2, %c-45_i64 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.srem %c11_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.and %c-21_i64, %arg0 : i64
    %1 = llvm.ashr %0, %c-30_i64 : i64
    %2 = llvm.icmp "eq" %c-3_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.and %arg0, %c-50_i64 : i64
    %1 = llvm.icmp "eq" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %arg0, %c-26_i64 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.select %arg0, %c-43_i64, %arg1 : i1, i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "ule" %arg1, %c-2_i64 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.ashr %c-32_i64, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.xor %c25_i64, %arg2 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.xor %arg1, %c42_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.xor %arg0, %c49_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.ashr %c-50_i64, %arg1 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.and %c-26_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %c-3_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.select %arg0, %arg1, %c0_i64 : i1, i64
    %1 = llvm.sdiv %0, %c34_i64 : i64
    %2 = llvm.or %c-5_i64, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.and %c33_i64, %c-3_i64 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.select %arg0, %c25_i64, %arg1 : i1, i64
    %1 = llvm.lshr %c-3_i64, %0 : i64
    %2 = llvm.lshr %c-3_i64, %1 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %2, %c42_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.xor %c-37_i64, %c16_i64 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.srem %c5_i64, %c-15_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.xor %arg0, %c2_i64 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg1, %c-31_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.sdiv %c-18_i64, %c-38_i64 : i64
    %1 = llvm.icmp "sle" %0, %c41_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %c-21_i64, %c18_i64 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "slt" %c-35_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %c-26_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c27_i64 : i1, i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c49_i64 = arith.constant 49 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "slt" %c49_i64, %c37_i64 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.select %0, %c12_i64, %1 : i1, i64
    %3 = llvm.icmp "eq" %c-43_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.udiv %c-45_i64, %c37_i64 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.icmp "uge" %c-32_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.xor %c-40_i64, %1 : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.xor %1, %c-22_i64 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.xor %c3_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %c46_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.srem %c-11_i64, %c-32_i64 : i64
    %1 = llvm.icmp "sgt" %c-40_i64, %0 : i64
    %2 = llvm.select %1, %c-46_i64, %0 : i1, i64
    %3 = llvm.and %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %arg1, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.urem %c-11_i64, %c6_i64 : i64
    %1 = llvm.sdiv %c-18_i64, %0 : i64
    %2 = llvm.or %0, %c-5_i64 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.udiv %c40_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "ult" %arg0, %c38_i64 : i64
    %1 = llvm.select %0, %arg1, %c-27_i64 : i1, i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "ne" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "ne" %c46_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.urem %2, %c-9_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "ugt" %arg0, %c17_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.udiv %c-38_i64, %c-7_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.select %arg1, %arg2, %c27_i64 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "sgt" %c-17_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %c-17_i64, %1 : i64
    %3 = llvm.icmp "ugt" %2, %c45_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.xor %2, %c-33_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sgt" %c-8_i64, %c6_i64 : i64
    %1 = llvm.select %0, %c34_i64, %c18_i64 : i1, i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %c-9_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "ne" %c-16_i64, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %c-16_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.udiv %c11_i64, %c-12_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.and %1, %c-47_i64 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.xor %0, %arg2 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "ne" %0, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.udiv %arg1, %arg1 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %c-18_i64 = arith.constant -18 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.srem %c-18_i64, %c9_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.srem %c-12_i64, %c9_i64 : i64
    %1 = llvm.ashr %0, %c-24_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.sdiv %2, %c-36_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %c-36_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c13_i64 = arith.constant 13 : i64
    %false = arith.constant false
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %c19_i64, %0 : i64
    %2 = llvm.select %false, %1, %c13_i64 : i1, i64
    %3 = llvm.icmp "ugt" %2, %c35_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.or %c26_i64, %0 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.ashr %c-33_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "eq" %c37_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c-12_i64, %1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.lshr %c-28_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %c16_i64, %0 : i64
    %2 = llvm.udiv %arg0, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "uge" %arg1, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %c19_i64 : i64
    %3 = llvm.select %arg0, %2, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.srem %arg0, %c-34_i64 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "eq" %c44_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "slt" %c3_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %c-35_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "ult" %c27_i64, %c-45_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c-19_i64, %1 : i64
    %3 = llvm.icmp "ugt" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.select %arg0, %arg1, %c40_i64 : i1, i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.xor %c-46_i64, %arg2 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
