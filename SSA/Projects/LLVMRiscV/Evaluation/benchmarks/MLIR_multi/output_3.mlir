module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %c-38_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "sle" %c35_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %c-15_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.ashr %c28_i64, %arg0 : i64
    %1 = llvm.and %c6_i64, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.xor %1, %c31_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.icmp "slt" %c-46_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %c-23_i64, %0 : i64
    %2 = llvm.icmp "ne" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %c26_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %arg1, %arg0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.lshr %arg0, %c8_i64 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c49_i64 = arith.constant 49 : i64
    %c48_i64 = arith.constant 48 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.and %c48_i64, %c50_i64 : i64
    %1 = llvm.lshr %c49_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %c40_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %arg1, %arg1 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %arg1, %c7_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.udiv %c-4_i64, %c-29_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c31_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.urem %c21_i64, %arg1 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c7_i64 = arith.constant 7 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "eq" %c7_i64, %c42_i64 : i64
    %1 = llvm.select %0, %c-11_i64, %arg0 : i1, i64
    %2 = llvm.select %0, %1, %c-12_i64 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.srem %c31_i64, %c47_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c23_i64 = arith.constant 23 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.urem %arg0, %c32_i64 : i64
    %1 = llvm.lshr %c23_i64, %0 : i64
    %2 = llvm.icmp "ule" %c47_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "ne" %c-45_i64, %c-28_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.srem %arg0, %c27_i64 : i64
    %1 = llvm.xor %c0_i64, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %c0_i64, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.sdiv %c0_i64, %arg0 : i64
    %1 = llvm.ashr %0, %c4_i64 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %c-48_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %true = arith.constant true
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.select %true, %c49_i64, %arg0 : i1, i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %c-10_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %c-48_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.urem %arg0, %c-22_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.xor %c-36_i64, %c18_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.or %c46_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.or %c-22_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.srem %c-44_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.or %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.and %arg0, %c7_i64 : i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "sgt" %c-18_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %c-16_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "eq" %c-42_i64, %c-3_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.select %false, %c7_i64, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.ashr %c10_i64, %c4_i64 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.udiv %arg0, %c-23_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.and %c14_i64, %c-30_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.lshr %c23_i64, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %c-39_i64 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.udiv %c-47_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.ashr %c-13_i64, %arg0 : i64
    %1 = llvm.lshr %c-19_i64, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.select %arg0, %c21_i64, %c1_i64 : i1, i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sdiv %c41_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.urem %arg1, %c-41_i64 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.and %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "eq" %0, %c5_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "ult" %c-16_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %c-17_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sdiv %c-1_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.and %1, %c-9_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-23_i64 = arith.constant -23 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %0, %c-26_i64 : i64
    %2 = llvm.icmp "uge" %c-23_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.sdiv %c39_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.xor %c16_i64, %0 : i64
    %2 = llvm.icmp "sle" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg2, %arg2 : i1, i64
    %2 = llvm.icmp "eq" %1, %c20_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c13_i64 = arith.constant 13 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.ashr %0, %c-21_i64 : i64
    %2 = llvm.icmp "eq" %c13_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %c37_i64 = arith.constant 37 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.srem %c37_i64, %c-20_i64 : i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %c-13_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %c9_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.ashr %arg1, %c-5_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "uge" %c-23_i64, %c5_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %c5_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c27_i64 = arith.constant 27 : i64
    %c28_i64 = arith.constant 28 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.udiv %c28_i64, %c-39_i64 : i64
    %1 = llvm.or %c27_i64, %0 : i64
    %2 = llvm.srem %1, %c-1_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.or %c-43_i64, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.and %arg0, %c50_i64 : i64
    %1 = llvm.select %arg1, %arg2, %c-10_i64 : i1, i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "slt" %c-15_i64, %c42_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %c-29_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg1, %arg2 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.ashr %c43_i64, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.sdiv %c7_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "uge" %c-44_i64, %c4_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %c18_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.lshr %arg0, %c-48_i64 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ugt" %c-49_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.select %false, %arg0, %arg2 : i1, i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c9_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.xor %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.ashr %c-38_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %c-22_i64 = arith.constant -22 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.xor %c-22_i64, %c28_i64 : i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.or %c40_i64, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.select %true, %arg0, %c22_i64 : i1, i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.srem %arg0, %c-41_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.srem %c4_i64, %c28_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %c29_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.lshr %c-4_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c11_i64 = arith.constant 11 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.urem %c10_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %c21_i64 : i64
    %2 = llvm.icmp "ne" %c11_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.or %1, %c43_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sdiv %c44_i64, %c44_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.sdiv %arg1, %c37_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.udiv %c-4_i64, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.urem %c7_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.ashr %c15_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.xor %c33_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %c39_i64, %0 : i64
    %2 = llvm.select %1, %c4_i64, %arg0 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.sdiv %arg0, %c16_i64 : i64
    %1 = llvm.or %c37_i64, %0 : i64
    %2 = llvm.and %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ugt" %c-2_i64, %c-49_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.xor %arg0, %c-42_i64 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %c8_i64, %0 : i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.select %arg0, %c26_i64, %arg1 : i1, i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "ult" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c48_i64, %0 : i64
    %2 = llvm.ashr %1, %c-50_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.and %arg0, %c-11_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %arg2, %c14_i64 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.and %c3_i64, %arg0 : i64
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "ne" %c-25_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.select %arg0, %c-36_i64, %arg1 : i1, i64
    %1 = llvm.srem %arg1, %c-13_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "sle" %c32_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-41_i64 = arith.constant -41 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.xor %c14_i64, %arg0 : i64
    %1 = llvm.select %true, %c-41_i64, %0 : i1, i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c-50_i64 = arith.constant -50 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %0, %c-31_i64 : i64
    %2 = llvm.icmp "ule" %c-50_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.udiv %arg0, %c-29_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %c-18_i64, %0 : i64
    %2 = llvm.udiv %c-18_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.or %c-38_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.xor %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.lshr %c23_i64, %arg1 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.icmp "ule" %c8_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "ugt" %c-22_i64, %c-2_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.lshr %c-33_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.xor %0, %c17_i64 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "ule" %c46_i64, %c-50_i64 : i64
    %1 = llvm.srem %c-16_i64, %arg0 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.lshr %c-14_i64, %arg2 : i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.select %arg0, %c-14_i64, %c40_i64 : i1, i64
    %1 = llvm.icmp "slt" %0, %c-19_i64 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.sdiv %c-37_i64, %c2_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %c15_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "sle" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.ashr %c44_i64, %arg1 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.sdiv %c-37_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.sdiv %c44_i64, %c-45_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "eq" %1, %c-28_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.udiv %c-48_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %c39_i64, %0 : i64
    %2 = llvm.sdiv %c5_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c17_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c49_i64 = arith.constant 49 : i64
    %true = arith.constant true
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.select %true, %c49_i64, %c40_i64 : i1, i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.ashr %c30_i64, %c-23_i64 : i64
    %1 = llvm.and %0, %c-5_i64 : i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c32_i64 = arith.constant 32 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.lshr %c32_i64, %c48_i64 : i64
    %1 = llvm.udiv %c36_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.sdiv %c-40_i64, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.select %true, %c40_i64, %arg1 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c-25_i64 = arith.constant -25 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %c-25_i64, %0 : i64
    %2 = llvm.icmp "uge" %c30_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.srem %c-36_i64, %arg0 : i64
    %1 = llvm.xor %c-18_i64, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "ult" %c-20_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.urem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %c37_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.urem %c-10_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "sge" %c30_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.or %arg0, %c-15_i64 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %c12_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.udiv %arg0, %c-1_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "sgt" %1, %c-13_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c26_i64 = arith.constant 26 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.select %arg0, %c26_i64, %c-40_i64 : i1, i64
    %1 = llvm.select %arg1, %c48_i64, %arg2 : i1, i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.srem %c-4_i64, %c-4_i64 : i64
    %1 = llvm.xor %c-24_i64, %c12_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "ne" %c-1_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c21_i64 : i1, i64
    %2 = llvm.sdiv %1, %c6_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c24_i64 = arith.constant 24 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.lshr %c38_i64, %arg0 : i64
    %1 = llvm.lshr %c24_i64, %0 : i64
    %2 = llvm.urem %1, %c-24_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %c-3_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "ne" %c-39_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %true, %0, %arg1 : i1, i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "ne" %arg0, %c31_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %c46_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %c-32_i64, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.xor %c-40_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "sge" %c8_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.udiv %c20_i64, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.urem %1, %c46_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg1, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "ugt" %c-14_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %c33_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.ashr %0, %c-6_i64 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %c7_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %0, %c12_i64 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %c-48_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.select %arg2, %arg1, %arg0 : i1, i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.udiv %c-42_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.udiv %c2_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "sle" %arg0, %c-8_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %c-48_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.lshr %c-49_i64, %arg0 : i64
    %1 = llvm.sdiv %c30_i64, %arg0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.xor %arg0, %c14_i64 : i64
    %1 = llvm.select %arg1, %arg2, %0 : i1, i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.ashr %c-2_i64, %arg2 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.and %c37_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %c4_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %c-27_i64 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.xor %c2_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.ashr %c21_i64, %arg1 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %c-31_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.ashr %c-30_i64, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ne" %c-19_i64, %c-11_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %c35_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.srem %c-39_i64, %arg0 : i64
    %1 = llvm.or %arg0, %c27_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %c14_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg1, %c-40_i64 : i1, i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg1, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.or %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.ashr %1, %c6_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.lshr %c-49_i64, %c21_i64 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg1, %arg2 : i1, i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %0, %c-34_i64 : i64
    %2 = llvm.icmp "eq" %c-4_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.xor %arg0, %c26_i64 : i64
    %1 = llvm.icmp "sgt" %c-27_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.udiv %arg1, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c13_i64 = arith.constant 13 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %c13_i64, %0 : i64
    %2 = llvm.lshr %1, %c26_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c-45_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c0_i64 = arith.constant 0 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sge" %c0_i64, %c6_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c12_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "ugt" %c-29_i64, %c-35_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %c19_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.udiv %c-19_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %c40_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c12_i64 = arith.constant 12 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.xor %c12_i64, %c-11_i64 : i64
    %1 = llvm.urem %c-43_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.lshr %arg0, %c-39_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c29_i64 = arith.constant 29 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.ashr %c29_i64, %c7_i64 : i64
    %1 = llvm.srem %c9_i64, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "sle" %arg0, %c-21_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.ashr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c28_i64 = arith.constant 28 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.udiv %c28_i64, %c25_i64 : i64
    %1 = llvm.sdiv %0, %c36_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.srem %c2_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.srem %c-47_i64, %0 : i64
    %2 = llvm.srem %1, %c42_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c20_i64 = arith.constant 20 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "ugt" %c20_i64, %c2_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ne" %c1_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %0, %0 : i1, i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.ashr %c37_i64, %c-31_i64 : i64
    %1 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.ashr %c-48_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %c25_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "ult" %c20_i64, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg2 : i1, i64
    %2 = llvm.srem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.udiv %c27_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.udiv %c11_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.icmp "ult" %1, %c43_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %c-3_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.xor %arg0, %c26_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.xor %arg0, %c-26_i64 : i64
    %1 = llvm.urem %c-21_i64, %0 : i64
    %2 = llvm.icmp "ugt" %c41_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.and %arg2, %c-8_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c11_i64 : i64
    %2 = llvm.icmp "ne" %1, %c25_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %c3_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.srem %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %c38_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.select %true, %arg0, %c36_i64 : i1, i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %c48_i64, %arg1 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.or %0, %c-19_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c24_i64 = arith.constant 24 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.srem %arg0, %c-9_i64 : i64
    %1 = llvm.ashr %c24_i64, %c-13_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.udiv %arg2, %c-25_i64 : i64
    %1 = llvm.select %true, %arg1, %0 : i1, i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sdiv %c-12_i64, %0 : i64
    %2 = llvm.icmp "ult" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "ne" %c-20_i64, %c40_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %c13_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %false = arith.constant false
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %false, %0, %c-25_i64 : i1, i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %c41_i64, %0 : i64
    %2 = llvm.icmp "ugt" %c-33_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.select %true, %0, %arg1 : i1, i64
    %2 = llvm.udiv %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.ashr %arg0, %c17_i64 : i64
    %1 = llvm.and %c43_i64, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %c37_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c30_i64 = arith.constant 30 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.xor %c30_i64, %c37_i64 : i64
    %1 = llvm.lshr %0, %c-15_i64 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.srem %arg0, %c-21_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "ule" %c41_i64, %c-24_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %c49_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.ashr %c-3_i64, %c30_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.urem %c12_i64, %c-31_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sdiv %c31_i64, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %false = arith.constant false
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.sdiv %c34_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c-25_i64 = arith.constant -25 : i64
    %false = arith.constant false
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.select %false, %c-10_i64, %arg0 : i1, i64
    %1 = llvm.sdiv %c-25_i64, %0 : i64
    %2 = llvm.lshr %1, %c15_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %c-15_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.lshr %arg0, %c-30_i64 : i64
    %1 = llvm.icmp "sle" %0, %c30_i64 : i64
    %2 = llvm.select %1, %arg1, %arg1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.ashr %c-21_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.urem %arg0, %c-45_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.xor %c50_i64, %c31_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %arg0, %c-17_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.sdiv %c7_i64, %c7_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg2, %arg1 : i1, i64
    %2 = llvm.icmp "ne" %1, %c-37_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.urem %c-5_i64, %c-10_i64 : i64
    %1 = llvm.and %c-45_i64, %0 : i64
    %2 = llvm.icmp "uge" %c2_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c3_i64 = arith.constant 3 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.urem %c3_i64, %c11_i64 : i64
    %1 = llvm.ashr %c22_i64, %arg0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c22_i64 = arith.constant 22 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "eq" %c22_i64, %c16_i64 : i64
    %1 = llvm.srem %c-35_i64, %c32_i64 : i64
    %2 = llvm.select %0, %1, %c-11_i64 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-38_i64 = arith.constant -38 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %c-38_i64, %0 : i64
    %2 = llvm.or %1, %c-30_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.lshr %arg0, %c-29_i64 : i64
    %1 = llvm.xor %0, %c-39_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "ugt" %arg1, %c-19_i64 : i64
    %1 = llvm.select %0, %c-21_i64, %c39_i64 : i1, i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.and %c-41_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %c-29_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "ule" %c-33_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.urem %c-42_i64, %c-8_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.xor %c37_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.srem %arg0, %c13_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %c15_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %arg1, %c-47_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ne" %c-30_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %arg1, %0, %0 : i1, i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.and %c-43_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %c14_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %c-33_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "eq" %c13_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %c22_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "sle" %c4_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.or %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "uge" %c13_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.icmp "sgt" %c32_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %c36_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.or %0, %c-24_i64 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "slt" %c22_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sle" %c-26_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.and %c3_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %c14_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.sdiv %arg0, %c23_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c-38_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.or %arg0, %c7_i64 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.and %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %c31_i64, %c-3_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %c-5_i64, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.sdiv %c-28_i64, %c-7_i64 : i64
    %1 = llvm.or %0, %c-9_i64 : i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.or %arg0, %c-12_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %c-2_i64, %c-28_i64 : i64
    %1 = llvm.icmp "slt" %c41_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.lshr %c-2_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %c13_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "ule" %arg0, %c6_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.udiv %1, %c42_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "uge" %c37_i64, %arg0 : i64
    %1 = llvm.select %0, %c-20_i64, %c-45_i64 : i1, i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %false = arith.constant false
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.select %false, %c8_i64, %arg1 : i1, i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %c10_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "eq" %c-48_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %c50_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.or %c9_i64, %arg0 : i64
    %1 = llvm.lshr %c-49_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.and %arg0, %c38_i64 : i64
    %1 = llvm.udiv %c-44_i64, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.sdiv %c50_i64, %c5_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "sge" %c-42_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.sdiv %c-48_i64, %arg0 : i64
    %1 = llvm.or %arg0, %c18_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c4_i64 = arith.constant 4 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %c29_i64, %arg0 : i64
    %1 = llvm.sdiv %c4_i64, %c-39_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.select %arg0, %c-5_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ugt" %c-8_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.xor %c-40_i64, %c-32_i64 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c26_i64 = arith.constant 26 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.ashr %c42_i64, %c-26_i64 : i64
    %1 = llvm.sdiv %c26_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %c-39_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.and %c-25_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.srem %c-34_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.srem %1, %c35_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %c26_i64, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.udiv %c-20_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.lshr %1, %c35_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ugt" %arg1, %c-27_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %c4_i64, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %true = arith.constant true
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.select %true, %c25_i64, %c32_i64 : i1, i64
    %1 = llvm.sdiv %c32_i64, %0 : i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "slt" %c42_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.sdiv %arg1, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.srem %arg0, %c-37_i64 : i64
    %1 = llvm.or %0, %c-40_i64 : i64
    %2 = llvm.icmp "ne" %c-13_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %c-25_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %c-33_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %c11_i64 = arith.constant 11 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.select %true, %c11_i64, %c-12_i64 : i1, i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "ugt" %c-20_i64, %c-29_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %c25_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "sge" %arg0, %c-2_i64 : i64
    %1 = llvm.select %0, %c11_i64, %arg0 : i1, i64
    %2 = llvm.icmp "ule" %c49_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "sle" %c29_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %c-1_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sdiv %arg2, %arg0 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.lshr %c-46_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.and %c-27_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "sgt" %0, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %c13_i64 : i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "ule" %arg0, %c-17_i64 : i64
    %1 = llvm.select %0, %arg0, %c-37_i64 : i1, i64
    %2 = llvm.xor %c-17_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.select %arg0, %c-25_i64, %arg1 : i1, i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c16_i64 = arith.constant 16 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.select %arg0, %c16_i64, %c-17_i64 : i1, i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.lshr %1, %c12_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c44_i64 = arith.constant 44 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %c44_i64, %0 : i64
    %2 = llvm.icmp "uge" %1, %c2_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c30_i64 = arith.constant 30 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.xor %c30_i64, %c34_i64 : i64
    %1 = llvm.icmp "ugt" %c-46_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ule" %c-18_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.urem %c-31_i64, %c-12_i64 : i64
    %1 = llvm.urem %0, %c-29_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.udiv %0, %c-36_i64 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c35_i64 = arith.constant 35 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.select %arg0, %c47_i64, %c-33_i64 : i1, i64
    %1 = llvm.ashr %c35_i64, %c-15_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.srem %c27_i64, %arg0 : i64
    %1 = llvm.udiv %c-10_i64, %0 : i64
    %2 = llvm.icmp "ult" %1, %c46_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %c-7_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.and %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c34_i64 = arith.constant 34 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %0, %c-23_i64 : i64
    %2 = llvm.icmp "sge" %c34_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.xor %c-18_i64, %c12_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "sle" %c48_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.xor %arg0, %c-14_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.and %c43_i64, %arg1 : i64
    %1 = llvm.select %arg0, %c-12_i64, %0 : i1, i64
    %2 = llvm.icmp "sgt" %c-45_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %c-24_i64, %0 : i64
    %2 = llvm.select %1, %0, %arg2 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.xor %c-2_i64, %c10_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "ult" %c20_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c26_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c9_i64 : i64
    %2 = llvm.xor %c20_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.udiv %arg0, %c8_i64 : i64
    %1 = llvm.or %c16_i64, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.xor %arg0, %c-41_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.xor %c-4_i64, %arg1 : i64
    %1 = llvm.xor %0, %c44_i64 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.icmp "ne" %c30_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "ule" %c34_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.xor %0, %c-46_i64 : i64
    %2 = llvm.icmp "eq" %1, %c25_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "ne" %c1_i64, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.udiv %c10_i64, %c-13_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c-8_i64 : i64
    %2 = llvm.icmp "sle" %c-19_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "ugt" %c44_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.icmp "eq" %c42_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.ashr %arg0, %c-33_i64 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.ashr %arg0, %c-6_i64 : i64
    %1 = llvm.sdiv %0, %c36_i64 : i64
    %2 = llvm.icmp "sgt" %1, %c-44_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.sdiv %c-30_i64, %c29_i64 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c27_i64 = arith.constant 27 : i64
    %c5_i64 = arith.constant 5 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.udiv %c5_i64, %c7_i64 : i64
    %1 = llvm.udiv %c27_i64, %0 : i64
    %2 = llvm.icmp "ne" %c-36_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c41_i64 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %c16_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.ashr %c-25_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %c-21_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.or %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.urem %arg0, %c-6_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "sle" %c-31_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %c-12_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.udiv %c-24_i64, %c-15_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.udiv %c25_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.or %c20_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.sdiv %c-33_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg1 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %0, %c10_i64 : i64
    %2 = llvm.icmp "sle" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg2, %arg1 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.urem %c50_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.select %1, %c-18_i64, %arg2 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.select %true, %arg2, %c39_i64 : i1, i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.and %1, %c-38_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %c50_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.urem %c-48_i64, %c22_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "eq" %c-12_i64, %c-38_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.sdiv %c17_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.sdiv %arg0, %c19_i64 : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.urem %c18_i64, %arg0 : i64
    %1 = llvm.srem %c1_i64, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c38_i64 = arith.constant 38 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.lshr %c43_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c38_i64 : i64
    %2 = llvm.icmp "ne" %1, %c-20_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %c6_i64 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.udiv %arg0, %c12_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %c31_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "ult" %arg0, %c-33_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.udiv %c-45_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.and %arg0, %c16_i64 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.urem %c-17_i64, %c20_i64 : i64
    %1 = llvm.urem %c-26_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.udiv %c-14_i64, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "slt" %c-40_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %c-33_i64, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.select %true, %0, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.udiv %c46_i64, %c-13_i64 : i64
    %1 = llvm.sdiv %c-28_i64, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.and %c8_i64, %arg0 : i64
    %1 = llvm.udiv %c-31_i64, %0 : i64
    %2 = llvm.lshr %c1_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.xor %arg0, %c-45_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c32_i64 = arith.constant 32 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.sdiv %c16_i64, %arg0 : i64
    %1 = llvm.udiv %c32_i64, %0 : i64
    %2 = llvm.xor %c36_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "ugt" %c-42_i64, %c28_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c-23_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.and %c29_i64, %arg1 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.select %arg0, %c9_i64, %arg1 : i1, i64
    %1 = llvm.icmp "uge" %c-18_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.and %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.xor %c-37_i64, %0 : i64
    %2 = llvm.icmp "uge" %c4_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c50_i64 : i1, i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.xor %c25_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sdiv %arg0, %c11_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.select %arg0, %c-49_i64, %c15_i64 : i1, i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %c5_i64, %0 : i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c24_i64 = arith.constant 24 : i64
    %true = arith.constant true
    %c-37_i64 = arith.constant -37 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.select %true, %c-37_i64, %c28_i64 : i1, i64
    %1 = llvm.and %c24_i64, %0 : i64
    %2 = llvm.icmp "ugt" %c10_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %true = arith.constant true
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.select %true, %c28_i64, %0 : i1, i64
    %2 = llvm.udiv %c46_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "slt" %arg0, %c-33_i64 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.icmp "ne" %c-6_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "sge" %c-23_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %c16_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %0, %c3_i64 : i64
    %2 = llvm.sdiv %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.lshr %c0_i64, %c-45_i64 : i64
    %1 = llvm.and %c-2_i64, %0 : i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.select %arg2, %c12_i64, %0 : i1, i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.sdiv %c-16_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.and %c-33_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ne" %arg0, %c-49_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c45_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %true = arith.constant true
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.select %true, %c8_i64, %arg0 : i1, i64
    %1 = llvm.udiv %c11_i64, %0 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.sdiv %arg0, %c32_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.xor %c22_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.sdiv %arg0, %c3_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %c33_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.srem %c-37_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c14_i64 = arith.constant 14 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %c-38_i64, %0 : i64
    %2 = llvm.select %false, %c14_i64, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %c-41_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "ugt" %c-2_i64, %c28_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.or %c-43_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.xor %c-18_i64, %c2_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "sge" %c43_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.urem %c-29_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c-30_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sdiv %1, %c28_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.xor %c49_i64, %c39_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.ashr %c35_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.xor %c50_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.select %arg0, %c33_i64, %0 : i1, i64
    %2 = llvm.lshr %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c13_i64 : i1, i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %c-40_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.udiv %c-1_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c33_i64 = arith.constant 33 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "eq" %c33_i64, %c39_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %c16_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.ashr %c-3_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.ashr %c38_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "ult" %c-29_i64, %c-20_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %c-31_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.and %c29_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg1, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "ule" %c39_i64, %c-26_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.ashr %c-9_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %c45_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.lshr %c-44_i64, %c38_i64 : i64
    %1 = llvm.xor %0, %c-23_i64 : i64
    %2 = llvm.icmp "ult" %c7_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "slt" %1, %c20_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.and %c18_i64, %arg0 : i64
    %1 = llvm.and %0, %c-10_i64 : i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %arg1, %c-35_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "ult" %c-6_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.srem %c-33_i64, %c-12_i64 : i64
    %1 = llvm.icmp "ule" %0, %c-36_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %arg0, %c0_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg1, %arg0 : i1, i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %arg1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.ashr %c-32_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.lshr %arg0, %c-24_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "sle" %c37_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %arg2 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %c16_i64, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c1_i64 = arith.constant 1 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "eq" %c-13_i64, %c-22_i64 : i64
    %1 = llvm.select %0, %c1_i64, %c43_i64 : i1, i64
    %2 = llvm.icmp "ule" %c5_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.ashr %c-47_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %c33_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "ne" %c-2_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.icmp "ule" %1, %c44_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "sle" %c44_i64, %c19_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %arg0, %c-28_i64 : i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "ne" %c-4_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.select %arg0, %arg1, %c-42_i64 : i1, i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.srem %c-2_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.sdiv %arg0, %c-8_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c14_i64 = arith.constant 14 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.srem %c45_i64, %arg0 : i64
    %1 = llvm.select %true, %c14_i64, %0 : i1, i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.select %arg0, %c-7_i64, %c31_i64 : i1, i64
    %1 = llvm.urem %0, %c-5_i64 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.select %arg0, %c-16_i64, %c-50_i64 : i1, i64
    %1 = llvm.xor %0, %c-36_i64 : i64
    %2 = llvm.sdiv %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %0, %c-28_i64 : i64
    %2 = llvm.xor %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.and %c38_i64, %c26_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.xor %c-39_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.sdiv %c-26_i64, %c38_i64 : i64
    %1 = llvm.icmp "slt" %c-30_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.udiv %c22_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c-14_i64 = arith.constant -14 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %c-14_i64, %c-4_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.lshr %c21_i64, %c-32_i64 : i64
    %1 = llvm.urem %c-16_i64, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.urem %c-34_i64, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %c1_i64, %arg1 : i1, i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.or %c15_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.and %arg0, %c-30_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.udiv %arg1, %c49_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.select %arg0, %arg1, %c-22_i64 : i1, i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.udiv %c36_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.urem %c14_i64, %0 : i64
    %2 = llvm.icmp "slt" %c42_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %c20_i64 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c-41_i64 = arith.constant -41 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %c-41_i64, %0 : i64
    %2 = llvm.icmp "slt" %c12_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %c-23_i64, %0 : i1, i64
    %2 = llvm.icmp "ule" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "ule" %1, %c23_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %arg0, %c4_i64 : i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c-31_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.udiv %c-16_i64, %c-13_i64 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-11_i64 = arith.constant -11 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.select %true, %c-11_i64, %c-48_i64 : i1, i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %0, %c24_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %c9_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.or %arg0, %c-26_i64 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.or %c-21_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %c-9_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c27_i64 = arith.constant 27 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.ashr %c27_i64, %c36_i64 : i64
    %1 = llvm.select %arg0, %c-23_i64, %c-34_i64 : i1, i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "sle" %c13_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c-23_i64 : i1, i64
    %2 = llvm.urem %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.and %c37_i64, %arg1 : i64
    %1 = llvm.and %c-36_i64, %0 : i64
    %2 = llvm.select %arg0, %1, %arg2 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c38_i64 = arith.constant 38 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.lshr %c38_i64, %c-31_i64 : i64
    %1 = llvm.icmp "ule" %c-8_i64, %0 : i64
    %2 = llvm.select %1, %c-48_i64, %0 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg2, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c14_i64 = arith.constant 14 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.or %arg0, %c2_i64 : i64
    %1 = llvm.udiv %c14_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %c-3_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %false = arith.constant false
    %c-36_i64 = arith.constant -36 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.select %false, %c-36_i64, %c-12_i64 : i1, i64
    %1 = llvm.urem %0, %c-21_i64 : i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "sle" %c-14_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.select %arg0, %c-2_i64, %c28_i64 : i1, i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.and %c-26_i64, %arg1 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "uge" %c-18_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.or %c-28_i64, %arg0 : i64
    %1 = llvm.and %arg1, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %c39_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.or %c-3_i64, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %c36_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.icmp "sle" %c-10_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %c13_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.srem %c-22_i64, %c-44_i64 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %c-27_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.ashr %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %true = arith.constant true
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.urem %1, %c-11_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "ugt" %arg0, %c20_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %c24_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.xor %c-48_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %c-12_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c18_i64 = arith.constant 18 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.srem %c18_i64, %c37_i64 : i64
    %1 = llvm.icmp "eq" %0, %c-35_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "ne" %c15_i64, %c47_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.srem %arg1, %arg1 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.ashr %c-20_i64, %c-1_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sdiv %c-6_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.ashr %arg1, %c-42_i64 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %c-48_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.urem %0, %c-3_i64 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "ugt" %c-38_i64, %c16_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %c32_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c38_i64 = arith.constant 38 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.select %true, %c38_i64, %c-20_i64 : i1, i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.srem %c49_i64, %c-49_i64 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "sgt" %arg0, %c-45_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %c38_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.lshr %c-38_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c18_i64 = arith.constant 18 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %c18_i64, %c-21_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %c44_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %c14_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "ne" %c-35_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "sgt" %arg1, %c-35_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.icmp "ult" %c-21_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.xor %c-33_i64, %arg0 : i64
    %1 = llvm.xor %c-9_i64, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %arg1, %c3_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.sdiv %c10_i64, %arg0 : i64
    %1 = llvm.xor %c36_i64, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.ashr %arg2, %c-16_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %c23_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.and %c-18_i64, %c20_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.lshr %c7_i64, %c-23_i64 : i64
    %1 = llvm.icmp "ugt" %0, %c47_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.ashr %1, %c-22_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c10_i64 = arith.constant 10 : i64
    %c38_i64 = arith.constant 38 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.ashr %c38_i64, %c19_i64 : i64
    %1 = llvm.urem %c10_i64, %0 : i64
    %2 = llvm.or %c13_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.urem %arg1, %c-33_i64 : i64
    %1 = llvm.sdiv %c-5_i64, %c-18_i64 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "uge" %arg0, %c46_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %c-9_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "slt" %c25_i64, %c-50_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %c38_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.and %c1_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c-34_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.udiv %c20_i64, %arg0 : i64
    %1 = llvm.xor %c-6_i64, %arg0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.xor %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %c37_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %c19_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "sge" %c40_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.and %arg1, %c-2_i64 : i64
    %1 = llvm.lshr %c20_i64, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %false = arith.constant false
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.select %false, %c-38_i64, %arg0 : i1, i64
    %1 = llvm.sdiv %arg0, %c30_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.lshr %arg0, %c18_i64 : i64
    %1 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %c2_i64, %c-31_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %c40_i64, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %c38_i64, %0 : i64
    %2 = llvm.select %arg0, %1, %arg1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %0, %c36_i64 : i64
    %2 = llvm.srem %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "ule" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.srem %c-28_i64, %arg0 : i64
    %1 = llvm.xor %arg1, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.select %arg1, %c-15_i64, %arg2 : i1, i64
    %1 = llvm.select %arg0, %0, %c-34_i64 : i1, i64
    %2 = llvm.icmp "ule" %1, %c11_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.and %c-29_i64, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.lshr %c-5_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c50_i64, %arg0 : i1, i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "sle" %arg0, %c-43_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.srem %c-23_i64, %c24_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "eq" %1, %c25_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "ule" %1, %c48_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.srem %c45_i64, %c-48_i64 : i64
    %1 = llvm.urem %c23_i64, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %false = arith.constant false
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.select %false, %arg0, %c28_i64 : i1, i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.srem %c-14_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %c1_i64, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "eq" %c6_i64, %arg1 : i64
    %1 = llvm.select %0, %arg2, %c50_i64 : i1, i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.udiv %c-36_i64, %c44_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c45_i64 = arith.constant 45 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.and %c45_i64, %c3_i64 : i64
    %1 = llvm.ashr %0, %c-26_i64 : i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.lshr %c33_i64, %c28_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %c-2_i64, %c1_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.xor %c-17_i64, %c12_i64 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.sdiv %c-36_i64, %arg0 : i64
    %1 = llvm.ashr %c48_i64, %0 : i64
    %2 = llvm.icmp "ugt" %c35_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.xor %arg0, %c-40_i64 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c48_i64 = arith.constant 48 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.lshr %c48_i64, %c44_i64 : i64
    %1 = llvm.icmp "sgt" %c17_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "sle" %c-3_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %c28_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "slt" %c4_i64, %arg0 : i64
    %1 = llvm.select %0, %c-6_i64, %arg0 : i1, i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "ugt" %c47_i64, %c-39_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.and %c3_i64, %c50_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "sle" %c-32_i64, %c21_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg1, %arg2 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %c-3_i64, %0 : i64
    %2 = llvm.and %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "eq" %arg0, %c1_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %arg1, %c43_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.or %arg0, %c-20_i64 : i64
    %1 = llvm.lshr %0, %c11_i64 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.urem %arg0, %c18_i64 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c25_i64 = arith.constant 25 : i64
    %false = arith.constant false
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.udiv %arg0, %c17_i64 : i64
    %1 = llvm.select %false, %0, %c21_i64 : i1, i64
    %2 = llvm.ashr %c25_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.and %arg0, %c-46_i64 : i64
    %1 = llvm.lshr %0, %c-37_i64 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.or %arg0, %c-40_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ult" %1, %c46_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ne" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "slt" %arg1, %c-11_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg2, %arg1 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.urem %c35_i64, %c-19_i64 : i64
    %1 = llvm.sdiv %c-6_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %c20_i64, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %c-47_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "ult" %c-13_i64, %c31_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %c36_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.sdiv %c22_i64, %arg0 : i64
    %1 = llvm.srem %0, %c-7_i64 : i64
    %2 = llvm.lshr %1, %c18_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.sdiv %c-7_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "uge" %c-22_i64, %c-8_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %c-41_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.lshr %c0_i64, %0 : i64
    %2 = llvm.urem %c12_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.or %c47_i64, %arg0 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %c20_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.urem %c7_i64, %c-24_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %arg1, %arg1 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.or %arg1, %c16_i64 : i64
    %1 = llvm.select %arg0, %c-6_i64, %0 : i1, i64
    %2 = llvm.icmp "ule" %1, %c-19_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.and %c-17_i64, %arg0 : i64
    %1 = llvm.urem %c42_i64, %0 : i64
    %2 = llvm.icmp "eq" %1, %c-2_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %true, %arg1, %0 : i1, i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c3_i64 = arith.constant 3 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %c3_i64, %c-43_i64 : i64
    %1 = llvm.icmp "uge" %c44_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ule" %c-12_i64, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.lshr %c24_i64, %arg2 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.ashr %c35_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c-14_i64 : i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c43_i64 = arith.constant 43 : i64
    %c26_i64 = arith.constant 26 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.srem %c26_i64, %c-36_i64 : i64
    %1 = llvm.srem %c43_i64, %0 : i64
    %2 = llvm.icmp "sle" %1, %c-44_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.or %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %c-13_i64, %0 : i64
    %2 = llvm.icmp "sgt" %c-41_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.lshr %arg0, %c2_i64 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "ne" %arg0, %c38_i64 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.icmp "sle" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "eq" %c-22_i64, %c-37_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.and %c-42_i64, %c24_i64 : i64
    %1 = llvm.icmp "sle" %c-14_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "sle" %c-18_i64, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.udiv %arg0, %c12_i64 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.lshr %c43_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c-20_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg1, %arg2 : i1, i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %c42_i64, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.select %arg0, %c-44_i64, %arg1 : i1, i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %c-38_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.sdiv %arg0, %c-33_i64 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.urem %c-17_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "ult" %c17_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.sdiv %c-2_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c16_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.sdiv %c-48_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %c7_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.lshr %c-7_i64, %arg0 : i64
    %1 = llvm.udiv %c44_i64, %arg1 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.urem %arg0, %c17_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %0, %c19_i64 : i64
    %2 = llvm.and %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg2, %arg0 : i1, i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %c23_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c46_i64 = arith.constant 46 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.srem %c46_i64, %c43_i64 : i64
    %1 = llvm.udiv %c-14_i64, %0 : i64
    %2 = llvm.icmp "uge" %c-38_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c47_i64 = arith.constant 47 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.srem %c47_i64, %c4_i64 : i64
    %1 = llvm.urem %c38_i64, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.icmp "slt" %arg0, %c32_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c-50_i64 : i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "ule" %c-33_i64, %c35_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %c8_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %c50_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.srem %c-50_i64, %c48_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.urem %arg0, %c-17_i64 : i64
    %1 = llvm.and %c10_i64, %c-12_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.udiv %c-21_i64, %arg0 : i64
    %1 = llvm.or %c49_i64, %0 : i64
    %2 = llvm.udiv %c-26_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sdiv %arg0, %c28_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "slt" %c18_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.udiv %c33_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.or %c-46_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %c-50_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.srem %c2_i64, %c38_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.urem %c26_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "ne" %arg0, %c22_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.udiv %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "ugt" %c-16_i64, %c49_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c21_i64 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c8_i64 = arith.constant 8 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.urem %c8_i64, %c39_i64 : i64
    %1 = llvm.lshr %c-26_i64, %0 : i64
    %2 = llvm.ashr %c2_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.udiv %c27_i64, %arg0 : i64
    %1 = llvm.ashr %c2_i64, %arg0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "sgt" %arg0, %c30_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.sdiv %arg0, %c-27_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %c14_i64, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %c4_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %c-39_i64, %0 : i64
    %2 = llvm.srem %c-46_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %c-21_i64, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %c-1_i64 : i1, i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %c-6_i64, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %c-38_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %arg0, %c48_i64 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "uge" %c-8_i64, %c38_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c20_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ne" %c-13_i64, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %c-40_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %0, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.lshr %c-20_i64, %arg0 : i64
    %1 = llvm.and %arg1, %c-3_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %c3_i64, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.and %arg2, %c-42_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.or %arg0, %c24_i64 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.sext %arg2 : i1 to i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.and %c-15_i64, %c44_i64 : i64
    %1 = llvm.icmp "ule" %c-45_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.udiv %c-45_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c14_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "eq" %c12_i64, %c-35_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.urem %arg0, %c-7_i64 : i64
    %1 = llvm.udiv %0, %c-30_i64 : i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.udiv %arg0, %c-47_i64 : i64
    %1 = llvm.ashr %c-18_i64, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.icmp "sle" %c7_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %c-4_i64, %c-43_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.and %arg0, %c50_i64 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.urem %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.srem %arg0, %c11_i64 : i64
    %1 = llvm.sdiv %0, %c-13_i64 : i64
    %2 = llvm.icmp "ule" %1, %c27_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.and %arg0, %c-17_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.and %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.udiv %c9_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c29_i64 : i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %c-37_i64, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.and %c18_i64, %c-46_i64 : i64
    %1 = llvm.lshr %c-20_i64, %0 : i64
    %2 = llvm.icmp "ne" %c31_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %0, %c-15_i64 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %c-12_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sdiv %c-31_i64, %c6_i64 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-41_i64 = arith.constant -41 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.or %c-36_i64, %arg0 : i64
    %1 = llvm.urem %c-38_i64, %0 : i64
    %2 = llvm.select %false, %c-41_i64, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c39_i64 = arith.constant 39 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.ashr %c39_i64, %c24_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "ugt" %c-47_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.urem %c-15_i64, %c-45_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "ult" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %c-33_i64, %0 : i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ule" %c-40_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %c18_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "eq" %arg0, %c-41_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.xor %arg0, %c41_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.lshr %0, %c-35_i64 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.xor %c34_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.ashr %c36_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.ashr %c4_i64, %c-44_i64 : i64
    %1 = llvm.select %arg1, %arg2, %0 : i1, i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.ashr %c-48_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %c32_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %arg2 : i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.srem %arg0, %c43_i64 : i64
    %1 = llvm.xor %0, %c-41_i64 : i64
    %2 = llvm.and %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.ashr %c-4_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.lshr %c31_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "ne" %1, %c3_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "uge" %arg0, %c-42_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %c17_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "ugt" %arg0, %c1_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.srem %c-42_i64, %c31_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.lshr %c-46_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %c49_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.sdiv %c-30_i64, %c-42_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-27_i64 = arith.constant -27 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.select %true, %c-27_i64, %c7_i64 : i1, i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.udiv %arg0, %c-32_i64 : i64
    %1 = llvm.and %0, %c-35_i64 : i64
    %2 = llvm.icmp "sle" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.or %c24_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %c26_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.and %arg0, %c-43_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "ne" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.srem %arg0, %c22_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.lshr %c15_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %c30_i64, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.or %c36_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %c44_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c31_i64 = arith.constant 31 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.srem %c31_i64, %c23_i64 : i64
    %1 = llvm.icmp "ugt" %0, %c-16_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "eq" %c-29_i64, %c-14_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %c-46_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "sle" %arg0, %c17_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.lshr %1, %c42_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %c-5_i64, %c13_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "sgt" %c42_i64, %c19_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.udiv %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.urem %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %c29_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %c3_i64, %0 : i64
    %2 = llvm.icmp "ugt" %c49_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.srem %c-5_i64, %arg0 : i64
    %1 = llvm.and %0, %c-31_i64 : i64
    %2 = llvm.icmp "ult" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.xor %c-15_i64, %c-5_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.urem %c-9_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.xor %c-23_i64, %c13_i64 : i64
    %1 = llvm.urem %c-22_i64, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.icmp "ugt" %c-28_i64, %c32_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.xor %arg0, %c-49_i64 : i64
    %1 = llvm.and %0, %c16_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.and %c20_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.srem %c-13_i64, %arg0 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.xor %arg0, %c-41_i64 : i64
    %1 = llvm.udiv %0, %c-23_i64 : i64
    %2 = llvm.ashr %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.urem %arg0, %c-16_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %0, %c15_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c29_i64 = arith.constant 29 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.sdiv %c29_i64, %c25_i64 : i64
    %1 = llvm.udiv %c-24_i64, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c2_i64, %c-24_i64 : i1, i64
    %2 = llvm.icmp "eq" %c-29_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %c16_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "sge" %arg0, %c-22_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %c-40_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.or %c26_i64, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c29_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.xor %c50_i64, %c-29_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "ult" %c-15_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.select %false, %c14_i64, %arg0 : i1, i64
    %1 = llvm.select %arg1, %arg2, %arg2 : i1, i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.urem %arg0, %c-44_i64 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "slt" %c-22_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %c-31_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "sle" %c-18_i64, %c-50_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %c23_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.xor %1, %c-11_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.lshr %c-42_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %0, %c39_i64 : i64
    %2 = llvm.icmp "sge" %1, %c11_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %c-37_i64, %0 : i64
    %2 = llvm.icmp "ugt" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.and %c45_i64, %c-37_i64 : i64
    %1 = llvm.urem %0, %c37_i64 : i64
    %2 = llvm.sdiv %c-24_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.xor %c-18_i64, %0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "ule" %1, %c0_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.and %c17_i64, %c28_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.and %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg1, %c-38_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "slt" %c-26_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.or %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %c49_i64, %0 : i64
    %2 = llvm.icmp "sle" %1, %c23_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "ugt" %c6_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "ne" %arg1, %c28_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %true = arith.constant true
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %true, %c-47_i64, %0 : i1, i64
    %2 = llvm.urem %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "ugt" %arg0, %c14_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.or %c32_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.srem %0, %c10_i64 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.srem %c48_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.urem %c-8_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "eq" %c14_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %c38_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %c-14_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "eq" %c-2_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.and %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.ashr %c-28_i64, %c-9_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.ashr %0, %c-33_i64 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
