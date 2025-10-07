module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "ult" %c39_i64, %0 : i64
    %2 = llvm.select %1, %arg1, %0 : i1, i64
    %3 = llvm.icmp "slt" %c32_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.udiv %c3_i64, %c-18_i64 : i64
    %1 = llvm.icmp "ugt" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.sdiv %c-8_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg1 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %1, %c9_i64 : i64
    %3 = llvm.srem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.or %c-16_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c11_i64 = arith.constant 11 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.srem %c8_i64, %arg0 : i64
    %1 = llvm.ashr %c11_i64, %0 : i64
    %2 = llvm.or %c-25_i64, %1 : i64
    %3 = llvm.and %c18_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.lshr %c-8_i64, %arg0 : i64
    %1 = llvm.sdiv %c23_i64, %0 : i64
    %2 = llvm.lshr %c-18_i64, %1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.lshr %c20_i64, %c-2_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "sge" %arg0, %c12_i64 : i64
    %1 = llvm.select %0, %c48_i64, %c40_i64 : i1, i64
    %2 = llvm.icmp "slt" %c-22_i64, %1 : i64
    %3 = llvm.select %2, %arg0, %arg1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "eq" %c-14_i64, %c-36_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "slt" %c42_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.select %1, %c46_i64, %arg0 : i1, i64
    %3 = llvm.icmp "ult" %2, %c-39_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %false = arith.constant false
    %c21_i64 = arith.constant 21 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.select %false, %c21_i64, %c-12_i64 : i1, i64
    %1 = llvm.select %arg0, %c12_i64, %arg1 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.srem %0, %c23_i64 : i64
    %2 = llvm.or %c6_i64, %1 : i64
    %3 = llvm.icmp "sge" %c-48_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-44_i64 = arith.constant -44 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.ashr %1, %c-29_i64 : i64
    %3 = llvm.icmp "eq" %c-44_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %c-45_i64, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c23_i64 = arith.constant 23 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.udiv %c23_i64, %c22_i64 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %c-40_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %c43_i64, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %true = arith.constant true
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.select %true, %arg1, %arg1 : i1, i64
    %2 = llvm.urem %1, %c-17_i64 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.udiv %c21_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %1, %c-39_i64 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "uge" %c-37_i64, %c23_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %c2_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "sge" %c35_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %false = arith.constant false
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.ashr %arg0, %c-15_i64 : i64
    %1 = llvm.select %false, %c7_i64, %0 : i1, i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %c2_i64, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.lshr %c21_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "slt" %c-9_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sdiv %c33_i64, %arg0 : i64
    %1 = llvm.urem %c-14_i64, %0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.icmp "uge" %c45_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.and %arg0, %c30_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "uge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.or %c30_i64, %arg1 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.or %arg0, %c37_i64 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.and %c-30_i64, %1 : i64
    %3 = llvm.icmp "ne" %c-37_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.lshr %arg0, %c-20_i64 : i64
    %1 = llvm.and %c-8_i64, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "eq" %c-16_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %c-23_i64, %1 : i64
    %3 = llvm.icmp "ule" %c39_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.urem %arg0, %c4_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.udiv %1, %c-40_i64 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.urem %arg0, %c43_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.and %1, %c35_i64 : i64
    %3 = llvm.ashr %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg1, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.zext %arg2 : i1 to i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "ult" %2, %c-10_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c10_i64 = arith.constant 10 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.xor %c46_i64, %arg1 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.select %arg0, %1, %c10_i64 : i1, i64
    %3 = llvm.icmp "ugt" %2, %c-12_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.icmp "ule" %c14_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "ne" %arg1, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c42_i64 : i1, i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %c25_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.and %c22_i64, %arg0 : i64
    %1 = llvm.ashr %0, %c15_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.select %2, %c-22_i64, %1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.xor %arg2, %c41_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %c37_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.lshr %c-49_i64, %1 : i64
    %3 = llvm.icmp "ne" %2, %c11_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c33_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.ashr %1, %c7_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %arg0, %c29_i64 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c-29_i64, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.select %arg0, %c2_i64, %arg1 : i1, i64
    %1 = llvm.and %0, %c26_i64 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.xor %0, %c24_i64 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %c13_i64 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %c22_i64, %arg1 : i64
    %2 = llvm.or %c34_i64, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.urem %1, %c50_i64 : i64
    %3 = llvm.srem %2, %arg2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.udiv %c-8_i64, %c12_i64 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.select %1, %c12_i64, %0 : i1, i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.udiv %arg0, %c-36_i64 : i64
    %1 = llvm.ashr %c44_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c-45_i64 : i64
    %2 = llvm.icmp "ugt" %1, %c37_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg1, %arg2 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.sdiv %c-40_i64, %arg0 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %c18_i64, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.select %2, %arg1, %arg1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.srem %c34_i64, %arg0 : i64
    %1 = llvm.xor %c-43_i64, %0 : i64
    %2 = llvm.lshr %arg1, %0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c-34_i64 = arith.constant -34 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "uge" %c-34_i64, %c9_i64 : i64
    %1 = llvm.select %false, %arg1, %arg2 : i1, i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.select %0, %2, %arg1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sdiv %arg1, %c44_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.select %1, %arg2, %arg2 : i1, i64
    %3 = llvm.lshr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.urem %c26_i64, %arg0 : i64
    %1 = llvm.and %arg1, %c-10_i64 : i64
    %2 = llvm.urem %1, %c-28_i64 : i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c-36_i64 = arith.constant -36 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.select %arg1, %c-36_i64, %c-22_i64 : i1, i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.urem %arg0, %c16_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "ule" %c46_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %false = arith.constant false
    %c-31_i64 = arith.constant -31 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.sdiv %c-31_i64, %c40_i64 : i64
    %1 = llvm.select %false, %0, %c12_i64 : i1, i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.xor %arg0, %c8_i64 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %c-11_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %c21_i64 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %true = arith.constant true
    %c-19_i64 = arith.constant -19 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.srem %c-6_i64, %c49_i64 : i64
    %1 = llvm.select %true, %c-19_i64, %0 : i1, i64
    %2 = llvm.icmp "sgt" %c8_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.or %c6_i64, %arg1 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "eq" %c-17_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.or %c-36_i64, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %true = arith.constant true
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.select %true, %arg0, %c44_i64 : i1, i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.or %c-25_i64, %1 : i64
    %3 = llvm.and %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ult" %arg2, %c-6_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %arg1, %arg2, %1 : i1, i64
    %3 = llvm.lshr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.srem %arg0, %c-10_i64 : i64
    %1 = llvm.sdiv %0, %c1_i64 : i64
    %2 = llvm.lshr %c-26_i64, %1 : i64
    %3 = llvm.icmp "ule" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %arg1, %c32_i64 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.urem %c-26_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.xor %c-41_i64, %arg1 : i64
    %1 = llvm.ashr %c-36_i64, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %c23_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.sdiv %c33_i64, %c-20_i64 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "sgt" %arg0, %c-19_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.lshr %2, %c2_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.xor %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %c-5_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %c-12_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.xor %c-19_i64, %c-43_i64 : i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %2, %c26_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.ashr %c19_i64, %arg0 : i64
    %1 = llvm.urem %c-23_i64, %0 : i64
    %2 = llvm.srem %1, %c48_i64 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.ashr %arg0, %c38_i64 : i64
    %1 = llvm.lshr %arg0, %c-32_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.select %false, %arg0, %arg1 : i1, i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.sdiv %c26_i64, %arg0 : i64
    %1 = llvm.select %false, %0, %arg1 : i1, i64
    %2 = llvm.and %arg2, %c-34_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "ule" %c-35_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c-17_i64 = arith.constant -17 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.udiv %c38_i64, %arg0 : i64
    %1 = llvm.select %false, %c-17_i64, %0 : i1, i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %arg0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.lshr %arg2, %c-24_i64 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "ult" %c-10_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.srem %c-32_i64, %arg0 : i64
    %2 = llvm.xor %c32_i64, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c40_i64 = arith.constant 40 : i64
    %c33_i64 = arith.constant 33 : i64
    %false = arith.constant false
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.select %false, %c50_i64, %arg0 : i1, i64
    %1 = llvm.udiv %c33_i64, %0 : i64
    %2 = llvm.or %c40_i64, %1 : i64
    %3 = llvm.icmp "sle" %2, %c17_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %false = arith.constant false
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.select %false, %arg0, %c-11_i64 : i1, i64
    %1 = llvm.sdiv %arg0, %c38_i64 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.ashr %c-20_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %c-26_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.or %c-11_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.icmp "ule" %2, %c48_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.srem %0, %c13_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %c-28_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %c-10_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.and %c-21_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.ashr %c22_i64, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.icmp "ugt" %0, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.or %0, %c-40_i64 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c2_i64 = arith.constant 2 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.and %c2_i64, %c24_i64 : i64
    %1 = llvm.icmp "slt" %c6_i64, %0 : i64
    %2 = llvm.select %1, %arg0, %arg1 : i1, i64
    %3 = llvm.icmp "ugt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c5_i64 = arith.constant 5 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "sge" %c5_i64, %c3_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %c22_i64, %arg0 : i1, i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %arg2, %c-13_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.urem %c-34_i64, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.xor %c37_i64, %c37_i64 : i64
    %1 = llvm.and %c25_i64, %arg0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %c-27_i64, %0 : i64
    %2 = llvm.lshr %1, %c49_i64 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "ne" %c36_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %true = arith.constant true
    %c-49_i64 = arith.constant -49 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.select %true, %c-49_i64, %c-36_i64 : i1, i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.udiv %1, %c9_i64 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.ashr %c9_i64, %c-47_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.or %c13_i64, %arg0 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.and %c-17_i64, %c39_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.urem %c-40_i64, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.xor %c3_i64, %1 : i64
    %3 = llvm.urem %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "ule" %c-22_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c1_i64 = arith.constant 1 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.select %false, %c1_i64, %c-17_i64 : i1, i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "sge" %c34_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.lshr %c-1_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %c-47_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg2, %arg0 : i1, i64
    %2 = llvm.or %1, %c41_i64 : i64
    %3 = llvm.icmp "ne" %c31_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %0, %arg0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.xor %arg0, %c43_i64 : i64
    %1 = llvm.udiv %c-47_i64, %0 : i64
    %2 = llvm.and %c15_i64, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.udiv %arg0, %c-4_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.icmp "uge" %c3_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "eq" %c-5_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "ult" %2, %c29_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.sdiv %c-25_i64, %1 : i64
    %3 = llvm.icmp "uge" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %c22_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.xor %arg0, %c18_i64 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg2, %arg0 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.sdiv %0, %0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.udiv %c24_i64, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.urem %c24_i64, %1 : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.lshr %c6_i64, %c-33_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c16_i64 = arith.constant 16 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.udiv %c-31_i64, %arg0 : i64
    %1 = llvm.ashr %c-19_i64, %c-5_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sgt" %c16_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %c-12_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %c10_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %c-22_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "eq" %c36_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %c18_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.or %arg0, %c-19_i64 : i64
    %1 = llvm.sdiv %c42_i64, %0 : i64
    %2 = llvm.and %arg0, %arg0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c36_i64 = arith.constant 36 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "uge" %c44_i64, %c-13_i64 : i64
    %1 = llvm.udiv %c36_i64, %arg0 : i64
    %2 = llvm.select %0, %1, %c29_i64 : i1, i64
    %3 = llvm.and %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %arg2, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "slt" %c20_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.lshr %c-1_i64, %arg0 : i64
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c33_i64 = arith.constant 33 : i64
    %c1_i64 = arith.constant 1 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "ule" %c1_i64, %c-23_i64 : i64
    %1 = llvm.select %0, %c33_i64, %c39_i64 : i1, i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.lshr %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c40_i64 = arith.constant 40 : i64
    %true = arith.constant true
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.select %true, %c-39_i64, %arg0 : i1, i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.xor %c40_i64, %1 : i64
    %3 = llvm.icmp "ugt" %c0_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.xor %2, %c-5_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %c19_i64, %arg1 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.udiv %c37_i64, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c17_i64 = arith.constant 17 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sdiv %c17_i64, %c6_i64 : i64
    %1 = llvm.icmp "ult" %c21_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %0, %c12_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.srem %arg0, %c33_i64 : i64
    %1 = llvm.urem %arg0, %c47_i64 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.sdiv %c32_i64, %c-3_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %2, %c36_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %false = arith.constant false
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.or %c-31_i64, %arg0 : i64
    %1 = llvm.select %false, %arg1, %c-49_i64 : i1, i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.and %c-45_i64, %arg0 : i64
    %1 = llvm.or %c21_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.or %c8_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %c47_i64 : i64
    %2 = llvm.udiv %c-28_i64, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.select %arg0, %c-40_i64, %arg1 : i1, i64
    %1 = llvm.select %true, %0, %arg1 : i1, i64
    %2 = llvm.trunc %arg0 : i1 to i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.udiv %arg2, %c24_i64 : i64
    %1 = llvm.icmp "eq" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.xor %arg1, %c49_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.select %false, %arg2, %1 : i1, i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %c3_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.srem %arg0, %arg0 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %c44_i64 : i64
    %2 = llvm.udiv %1, %c1_i64 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "ne" %c-43_i64, %arg0 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.sdiv %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c-44_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ne" %c25_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.or %arg0, %c-33_i64 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.and %c4_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.urem %c21_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %false = arith.constant false
    %c33_i64 = arith.constant 33 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.select %false, %c33_i64, %c-29_i64 : i1, i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.lshr %c43_i64, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.urem %arg0, %c20_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.sdiv %0, %c0_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.urem %arg0, %c31_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.urem %c-10_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.xor %c-28_i64, %1 : i64
    %3 = llvm.icmp "uge" %c44_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.udiv %c8_i64, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.select %arg1, %c-50_i64, %arg2 : i1, i64
    %1 = llvm.ashr %0, %c42_i64 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "ult" %2, %c32_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.sdiv %c-48_i64, %arg1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %c36_i64 = arith.constant 36 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.ashr %c36_i64, %c-10_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.sdiv %c-34_i64, %c-4_i64 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.lshr %c43_i64, %arg0 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.or %0, %c-36_i64 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %arg1, %c37_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.xor %c-7_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %c-36_i64 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %c20_i64, %arg1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.srem %2, %c12_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.icmp "eq" %c-33_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.urem %arg0, %c32_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.and %c27_i64, %arg1 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sdiv %c-8_i64, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.udiv %c6_i64, %0 : i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.xor %c-1_i64, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %c-31_i64, %1 : i64
    %3 = llvm.icmp "eq" %2, %c-7_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c-47_i64 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %arg1, %c-19_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %c6_i64 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.or %arg2, %arg0 : i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c22_i64 = arith.constant 22 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "ugt" %c0_i64, %c-33_i64 : i64
    %1 = llvm.select %0, %c22_i64, %c38_i64 : i1, i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.icmp "sle" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.lshr %arg0, %c8_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.urem %arg0, %c36_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "sgt" %c5_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg1, %c42_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.urem %c-46_i64, %arg0 : i64
    %1 = llvm.srem %c14_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %c30_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.sdiv %c-37_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.xor %0, %arg1 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %c18_i64 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.xor %c-13_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "uge" %c21_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.and %c-6_i64, %c-28_i64 : i64
    %1 = llvm.icmp "ult" %c-2_i64, %c47_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.udiv %2, %c2_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %c40_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.and %2, %c49_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.or %c-37_i64, %arg1 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.srem %c-24_i64, %c11_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.xor %c-43_i64, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.udiv %arg0, %c2_i64 : i64
    %1 = llvm.icmp "ule" %arg1, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "ult" %c42_i64, %c-37_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c16_i64 = arith.constant 16 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.lshr %c16_i64, %c-22_i64 : i64
    %1 = llvm.lshr %c37_i64, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %c13_i64, %arg1 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.xor %c-43_i64, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.xor %arg0, %c2_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.urem %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.xor %c-33_i64, %c-47_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.urem %c32_i64, %c42_i64 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sle" %2, %c-44_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %c27_i64 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %true = arith.constant true
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.xor %c-30_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.srem %1, %c-16_i64 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %false = arith.constant false
    %c21_i64 = arith.constant 21 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.srem %c21_i64, %c-40_i64 : i64
    %1 = llvm.sdiv %c-14_i64, %arg0 : i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.select %arg0, %c32_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.sdiv %c-32_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.xor %0, %c-3_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.lshr %2, %c41_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.icmp "ult" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.lshr %c44_i64, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "ule" %arg1, %c45_i64 : i64
    %1 = llvm.select %0, %c-47_i64, %arg0 : i1, i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ule" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.urem %c-46_i64, %0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %c3_i64, %c-17_i64 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.srem %c10_i64, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.icmp "sle" %2, %c-42_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.urem %c-50_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "sge" %c-39_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.urem %c3_i64, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "ult" %c-49_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.select %arg1, %c-33_i64, %arg0 : i1, i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.ashr %0, %0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c22_i64 = arith.constant 22 : i64
    %c12_i64 = arith.constant 12 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.lshr %c12_i64, %c23_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.srem %c22_i64, %1 : i64
    %3 = llvm.icmp "ugt" %c5_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %arg1, %c20_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.udiv %c-20_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.or %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.srem %2, %c12_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.srem %arg1, %arg1 : i64
    %3 = llvm.select %1, %c-5_i64, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.select %true, %c-46_i64, %0 : i1, i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    %3 = llvm.icmp "sle" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.ashr %c48_i64, %c33_i64 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %c-32_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.lshr %arg0, %c-40_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-18_i64 = arith.constant -18 : i64
    %false = arith.constant false
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.select %false, %arg0, %c-22_i64 : i1, i64
    %1 = llvm.sdiv %0, %c-18_i64 : i64
    %2 = llvm.select %arg1, %c42_i64, %arg2 : i1, i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.select %arg0, %0, %0 : i1, i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.udiv %arg1, %c-50_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.srem %0, %arg2 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.urem %arg1, %arg2 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "sgt" %0, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c46_i64, %1 : i64
    %3 = llvm.icmp "sgt" %2, %c42_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.sdiv %c50_i64, %arg0 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.or %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.xor %c-13_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %c1_i64, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "ult" %c27_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %c-4_i64 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.or %c-14_i64, %0 : i64
    %2 = llvm.udiv %c-28_i64, %c-50_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.or %arg0, %c-7_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %c-44_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %c27_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "ult" %c-12_i64, %c0_i64 : i64
    %1 = llvm.select %0, %arg0, %c-21_i64 : i1, i64
    %2 = llvm.icmp "eq" %1, %c-20_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.urem %c-47_i64, %c-48_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.ashr %arg0, %c-24_i64 : i64
    %1 = llvm.or %0, %c-24_i64 : i64
    %2 = llvm.udiv %1, %c4_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %c-47_i64, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.select %arg1, %arg2, %arg2 : i1, i64
    %1 = llvm.udiv %0, %c-41_i64 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.select %arg0, %2, %c-18_i64 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c38_i64 = arith.constant 38 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.udiv %c38_i64, %c-7_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.lshr %c-19_i64, %c-11_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "eq" %c-20_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-33_i64 = arith.constant -33 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.srem %c-33_i64, %c19_i64 : i64
    %1 = llvm.select %false, %arg0, %arg0 : i1, i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.ashr %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c-3_i64, %0 : i64
    %2 = llvm.and %arg0, %arg1 : i64
    %3 = llvm.select %1, %2, %arg2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.sdiv %c15_i64, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.urem %c-42_i64, %1 : i64
    %3 = llvm.and %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.xor %c-11_i64, %c-25_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.and %c-21_i64, %arg2 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.or %c-31_i64, %arg2 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "sle" %c-26_i64, %c42_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %arg0 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.lshr %c50_i64, %c27_i64 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c43_i64 = arith.constant 43 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.srem %c-27_i64, %c-42_i64 : i64
    %1 = llvm.urem %c43_i64, %0 : i64
    %2 = llvm.lshr %c50_i64, %1 : i64
    %3 = llvm.icmp "slt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %c5_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.xor %c6_i64, %0 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.select %arg1, %arg2, %c-3_i64 : i1, i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %arg1, %arg1 : i64
    %2 = llvm.sdiv %1, %c-25_i64 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %c6_i64, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c45_i64 = arith.constant 45 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.srem %c42_i64, %arg1 : i64
    %1 = llvm.select %arg0, %0, %c45_i64 : i1, i64
    %2 = llvm.udiv %arg2, %c19_i64 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "sle" %arg0, %c-12_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %c34_i64, %c26_i64 : i1, i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %arg0, %c-9_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.or %c-39_i64, %arg1 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.or %c36_i64, %1 : i64
    %3 = llvm.select %arg0, %0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "slt" %arg0, %c-17_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "sle" %c-27_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.select %arg1, %c21_i64, %arg0 : i1, i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.select %arg2, %0, %c-39_i64 : i1, i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %c42_i64, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.srem %c23_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "sge" %arg0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %arg1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %true = arith.constant true
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.sdiv %1, %c-31_i64 : i64
    %3 = llvm.select %true, %arg0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.select %2, %c24_i64, %arg0 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.or %c21_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "ne" %c-49_i64, %c-47_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "slt" %c-27_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %0, %arg1, %arg2 : i1, i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %false = arith.constant false
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.ashr %c-33_i64, %arg1 : i64
    %1 = llvm.select %false, %arg1, %0 : i1, i64
    %2 = llvm.ashr %c-30_i64, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.udiv %c-9_i64, %c-50_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.or %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "sgt" %c48_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.or %c-30_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.xor %c-29_i64, %c1_i64 : i64
    %1 = llvm.xor %c-5_i64, %arg0 : i64
    %2 = llvm.ashr %c-18_i64, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.lshr %c-39_i64, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.lshr %c34_i64, %arg0 : i64
    %1 = llvm.and %arg1, %c-38_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "uge" %2, %c21_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "ule" %c30_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.lshr %c-50_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %0, %0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.srem %1, %c17_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c-14_i64, %c30_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.sdiv %c50_i64, %c-23_i64 : i64
    %1 = llvm.icmp "ule" %c-38_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %c14_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.xor %c18_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.ashr %c-33_i64, %1 : i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.sdiv %c-6_i64, %arg1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.udiv %c7_i64, %c-32_i64 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %c-27_i64 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.icmp "uge" %2, %c-47_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.urem %c-4_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.and %c-26_i64, %c-18_i64 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c44_i64 : i64
    %2 = llvm.sdiv %c-35_i64, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %c6_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ult" %arg1, %c-11_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c34_i64, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %c17_i64, %0 : i64
    %2 = llvm.lshr %arg0, %arg1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.select %arg0, %c-3_i64, %c-11_i64 : i1, i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "slt" %arg0, %c40_i64 : i64
    %1 = llvm.select %0, %arg0, %c26_i64 : i1, i64
    %2 = llvm.or %arg0, %arg1 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %arg0, %c47_i64 : i1, i64
    %2 = llvm.urem %1, %c-1_i64 : i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.and %arg2, %0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %c22_i64, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.and %c-39_i64, %c-30_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %c9_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.lshr %arg0, %c-39_i64 : i64
    %1 = llvm.icmp "eq" %c25_i64, %c10_i64 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %c-6_i64, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %c-22_i64, %arg1 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.urem %c18_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.lshr %c-46_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ne" %arg0, %c-11_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c15_i64, %arg1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.udiv %c-23_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %c-38_i64, %c11_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "sle" %c-12_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg1, %arg1 : i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.urem %1, %c7_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %c25_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.udiv %c-38_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg1 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %false = arith.constant false
    %true = arith.constant true
    %c35_i64 = arith.constant 35 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %true, %c35_i64, %c20_i64 : i1, i64
    %1 = llvm.select %false, %c-33_i64, %0 : i1, i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %arg2, %c-7_i64 : i64
    %2 = llvm.and %1, %c-15_i64 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.ashr %c-3_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.urem %arg1, %c-17_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ne" %2, %c-7_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %c-4_i64, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "ule" %c44_i64, %c34_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "slt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.icmp "ult" %c7_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %c43_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.lshr %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %c-12_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "sgt" %arg0, %c-8_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "ult" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.select %arg0, %c-6_i64, %c-50_i64 : i1, i64
    %1 = llvm.select %arg0, %c-7_i64, %0 : i1, i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.and %c31_i64, %0 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.and %arg0, %c-41_i64 : i64
    %1 = llvm.srem %c14_i64, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.ashr %arg0, %c-15_i64 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.ashr %c-17_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.lshr %c-31_i64, %c-43_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "uge" %arg0, %c-5_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %c26_i64, %arg0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.urem %c29_i64, %c34_i64 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.ashr %c18_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.xor %c-28_i64, %c50_i64 : i64
    %1 = llvm.select %arg0, %0, %c14_i64 : i1, i64
    %2 = llvm.and %c-15_i64, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "sge" %c-44_i64, %c-2_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.udiv %c-20_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %c23_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %c22_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.srem %c19_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.udiv %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %c-21_i64, %0 : i64
    %2 = llvm.select %arg1, %1, %0 : i1, i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c19_i64 = arith.constant 19 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.lshr %c19_i64, %c4_i64 : i64
    %1 = llvm.lshr %c-12_i64, %c-12_i64 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.ashr %c31_i64, %c48_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.udiv %arg1, %arg0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %c28_i64, %0 : i64
    %2 = llvm.sdiv %arg0, %0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.and %c-22_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.lshr %c28_i64, %arg1 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.lshr %c-38_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %c-10_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "ult" %c46_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %arg1, %c23_i64 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.sdiv %c-18_i64, %c-4_i64 : i64
    %1 = llvm.xor %0, %c2_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "slt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.srem %c-50_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "sge" %c10_i64, %1 : i64
    %3 = llvm.select %2, %0, %0 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "sle" %arg0, %c-32_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %c-33_i64, %1 : i64
    %3 = llvm.icmp "ult" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.select %true, %c26_i64, %arg0 : i1, i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.urem %c-30_i64, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.or %c-48_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.ashr %arg0, %c35_i64 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.xor %arg0, %c-20_i64 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %c14_i64, %0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "eq" %arg0, %c38_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.and %c-5_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %0 : i1, i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c41_i64 = arith.constant 41 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %c41_i64, %c38_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.urem %c11_i64, %c-43_i64 : i64
    %1 = llvm.xor %0, %c12_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %c3_i64, %c31_i64 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "ule" %arg1, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %arg0, %1, %arg1 : i1, i64
    %3 = llvm.icmp "eq" %2, %c-25_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %arg2, %arg1 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "ule" %c3_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %c-44_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.ashr %c23_i64, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.srem %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c-42_i64 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "uge" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.srem %arg0, %c-9_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "sle" %c32_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.ashr %c16_i64, %c-35_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.and %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.urem %arg0, %c49_i64 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.or %c-44_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %0 : i1, i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sgt" %c28_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "sle" %arg0, %c12_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "slt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.srem %c18_i64, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "uge" %c0_i64, %c-39_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %c-10_i64, %c9_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "ne" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "sge" %arg0, %c1_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %c-32_i64 : i64
    %3 = llvm.urem %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.udiv %arg0, %c26_i64 : i64
    %1 = llvm.select %false, %arg0, %arg0 : i1, i64
    %2 = llvm.select %arg1, %1, %1 : i1, i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "ugt" %c-1_i64, %arg1 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.ashr %c-47_i64, %c23_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.srem %c15_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %c-36_i64 = arith.constant -36 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.lshr %c-36_i64, %c-16_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c1_i64 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.icmp "eq" %c32_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.and %c-35_i64, %arg0 : i64
    %1 = llvm.select %arg1, %c-49_i64, %arg0 : i1, i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.urem %c38_i64, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.srem %c23_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c25_i64 = arith.constant 25 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.lshr %c25_i64, %c10_i64 : i64
    %1 = llvm.urem %0, %c-37_i64 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c-33_i64, %1 : i64
    %3 = llvm.icmp "slt" %c21_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.srem %0, %c5_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c12_i64 = arith.constant 12 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.sdiv %c21_i64, %arg0 : i64
    %1 = llvm.xor %c12_i64, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ule" %c8_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.urem %c-9_i64, %c-2_i64 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.ashr %c-18_i64, %c-50_i64 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.xor %c22_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.lshr %1, %c-31_i64 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.srem %c10_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %arg1, %arg1 : i64
    %2 = llvm.select %1, %arg0, %arg2 : i1, i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c24_i64 = arith.constant 24 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.udiv %c24_i64, %c1_i64 : i64
    %1 = llvm.lshr %c-43_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "uge" %arg0, %c-14_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.or %arg1, %arg0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.ashr %arg0, %c-29_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.and %c40_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.or %c34_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.urem %c36_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "ugt" %c-37_i64, %c25_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %arg0, %c11_i64, %1 : i1, i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %c-4_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.or %arg0, %c-1_i64 : i64
    %1 = llvm.icmp "eq" %arg1, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "ule" %c-46_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.xor %c40_i64, %c-22_i64 : i64
    %1 = llvm.ashr %c-14_i64, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.srem %c-49_i64, %c-46_i64 : i64
    %1 = llvm.srem %c-42_i64, %c50_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.or %c-14_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.and %c-47_i64, %c5_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "ult" %arg0, %c-37_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %c-6_i64, %arg0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %c-2_i64 = arith.constant -2 : i64
    %c3_i64 = arith.constant 3 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.lshr %c3_i64, %c0_i64 : i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ult" %c-2_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.ashr %c35_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c-9_i64 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "eq" %c43_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %c-43_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c35_i64 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.ashr %1, %c-7_i64 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.udiv %c28_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.urem %c-33_i64, %arg1 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.select %arg0, %c7_i64, %1 : i1, i64
    %3 = llvm.xor %c-49_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.ashr %arg0, %c-12_i64 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "ule" %1, %c-12_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %false = arith.constant false
    %c-48_i64 = arith.constant -48 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.select %arg1, %arg0, %c25_i64 : i1, i64
    %1 = llvm.select %false, %c-48_i64, %0 : i1, i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "eq" %2, %c43_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.ashr %0, %arg1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "slt" %c33_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.select %1, %c9_i64, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %arg1, %c-12_i64 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "ugt" %c33_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %c-43_i64 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ult" %arg1, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %1, %c-27_i64 : i64
    %3 = llvm.srem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %c11_i64, %0 : i64
    %2 = llvm.srem %c-49_i64, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.udiv %arg0, %c11_i64 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.or %2, %c-1_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %c-38_i64, %c42_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.select %1, %c35_i64, %arg0 : i1, i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.srem %c-25_i64, %arg0 : i64
    %1 = llvm.xor %c-16_i64, %0 : i64
    %2 = llvm.icmp "ule" %c-33_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.sdiv %arg0, %c-14_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.or %c8_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %c44_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %1, %c4_i64, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.sdiv %arg1, %arg1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c35_i64 = arith.constant 35 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.or %c35_i64, %0 : i64
    %2 = llvm.sdiv %c-15_i64, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ne" %c20_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %false, %arg1, %0 : i1, i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.urem %c27_i64, %arg1 : i64
    %1 = llvm.icmp "ne" %c-9_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.sdiv %c-27_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c35_i64 = arith.constant 35 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c38_i64, %0 : i64
    %2 = llvm.select %1, %arg0, %c6_i64 : i1, i64
    %3 = llvm.ashr %c35_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c-9_i64 = arith.constant -9 : i64
    %true = arith.constant true
    %c-25_i64 = arith.constant -25 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.select %true, %c-25_i64, %c-19_i64 : i1, i64
    %1 = llvm.icmp "sgt" %c-9_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %c24_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "uge" %arg1, %c6_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %c32_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "ult" %c45_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c36_i64, %arg0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.sdiv %c-8_i64, %arg0 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.urem %c9_i64, %c-27_i64 : i64
    %1 = llvm.lshr %arg1, %c32_i64 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %c-34_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.udiv %c21_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.urem %c-48_i64, %1 : i64
    %3 = llvm.icmp "sge" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.lshr %0, %c8_i64 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "sle" %c-33_i64, %c-2_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg2, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.or %c5_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %arg1, %c39_i64 : i64
    %2 = llvm.select %1, %0, %arg1 : i1, i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "sge" %arg0, %c25_i64 : i64
    %1 = llvm.urem %arg1, %arg0 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.lshr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.sdiv %arg0, %c-46_i64 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c-25_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "eq" %c48_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg2, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %0, %arg1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "sle" %c10_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %arg1 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %c-27_i64, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.srem %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "ule" %c18_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "ult" %c-37_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %0, %c39_i64 : i64
    %2 = llvm.xor %0, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "uge" %0, %c-13_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-11_i64 = arith.constant -11 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "sle" %c-25_i64, %arg0 : i64
    %1 = llvm.select %0, %c-11_i64, %arg1 : i1, i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "sle" %c-30_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %c-10_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "ult" %c-1_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.icmp "sle" %c47_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c18_i64 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.urem %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.icmp "uge" %0, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "sge" %c11_i64, %c45_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-37_i64 = arith.constant -37 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ugt" %c-37_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c13_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "sle" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "sge" %c0_i64, %c-39_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %arg1 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.urem %c-48_i64, %arg1 : i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.sdiv %arg1, %0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.lshr %c8_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c-21_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    %3 = llvm.srem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ne" %c-11_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %arg1, %arg2 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "uge" %c-17_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.sdiv %2, %c27_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %c-40_i64, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.lshr %2, %c14_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %1, %c-23_i64 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.and %arg1, %c-7_i64 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg0, %arg1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.xor %arg0, %c9_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.udiv %c36_i64, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "sgt" %c17_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c16_i64 = arith.constant 16 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.sdiv %c16_i64, %c25_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.udiv %c-44_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c10_i64 = arith.constant 10 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %c10_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %c-23_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c-47_i64 = arith.constant -47 : i64
    %false = arith.constant false
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.udiv %c36_i64, %arg1 : i64
    %1 = llvm.select %false, %c-47_i64, %c27_i64 : i1, i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %c49_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c22_i64 = arith.constant 22 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.urem %c22_i64, %c-17_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.and %c-8_i64, %1 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.srem %c-19_i64, %c3_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %c-40_i64, %c26_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.and %c-26_i64, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "ule" %c-31_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %c-30_i64 : i64
    %2 = llvm.lshr %c-31_i64, %1 : i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %true = arith.constant true
    %c33_i64 = arith.constant 33 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.select %true, %c33_i64, %c-20_i64 : i1, i64
    %1 = llvm.icmp "ugt" %0, %c-33_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.udiv %arg0, %c44_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.srem %c-15_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c20_i64, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %c28_i64, %0 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.and %arg0, %c-8_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "ult" %c8_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg1, %c-30_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.udiv %c-24_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %c6_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c41_i64 = arith.constant 41 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "sge" %c41_i64, %c14_i64 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.select %0, %c-15_i64, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ugt" %c14_i64, %c-27_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %arg0, %c-2_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.xor %c-9_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "uge" %1, %c9_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "uge" %c1_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.udiv %c-49_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %c-12_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "sle" %c1_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %c7_i64, %1 : i64
    %3 = llvm.icmp "eq" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.icmp "sgt" %c7_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.udiv %arg0, %c41_i64 : i64
    %1 = llvm.lshr %c-16_i64, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.srem %c-27_i64, %arg0 : i64
    %1 = llvm.srem %c13_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.sdiv %c-22_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.sdiv %c6_i64, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c17_i64 : i64
    %2 = llvm.icmp "ne" %c31_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %c34_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c33_i64 = arith.constant 33 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.udiv %c33_i64, %c50_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.select %true, %0, %arg0 : i1, i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c6_i64 = arith.constant 6 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %0, %c6_i64 : i64
    %2 = llvm.select %1, %c29_i64, %arg1 : i1, i64
    %3 = llvm.lshr %c40_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %c-10_i64, %c35_i64 : i64
    %1 = llvm.icmp "slt" %c18_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.srem %c34_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c-31_i64 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "ule" %c21_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %c-5_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %c-41_i64, %arg2 : i64
    %2 = llvm.and %arg2, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c13_i64 = arith.constant 13 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.and %c13_i64, %c25_i64 : i64
    %1 = llvm.icmp "ule" %0, %c-20_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.srem %c-46_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.lshr %arg1, %0 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c37_i64 = arith.constant 37 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "ule" %c37_i64, %c-48_i64 : i64
    %1 = llvm.select %0, %arg0, %c-47_i64 : i1, i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.select %0, %c-49_i64, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.icmp "ult" %1, %c-31_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ugt" %c48_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ult" %arg1, %arg2 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.or %2, %c-27_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "sge" %c-40_i64, %c20_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %c-8_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.select %arg0, %c26_i64, %c39_i64 : i1, i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "ult" %c-18_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.xor %c30_i64, %1 : i64
    %3 = llvm.icmp "eq" %c15_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %c18_i64, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c42_i64 = arith.constant 42 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.select %true, %c42_i64, %c5_i64 : i1, i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "ugt" %c24_i64, %c18_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.icmp "sge" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.lshr %arg2, %c-20_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.udiv %arg2, %arg1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.xor %c-36_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %0 : i1, i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.and %c21_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.srem %arg0, %c-16_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.ashr %arg0, %arg0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %c15_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c15_i64 = arith.constant 15 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "eq" %c15_i64, %0 : i64
    %2 = llvm.xor %c0_i64, %arg0 : i64
    %3 = llvm.select %1, %c-48_i64, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.srem %1, %c-12_i64 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %c-40_i64, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.udiv %arg0, %c-32_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "slt" %c-13_i64, %c50_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.ashr %c2_i64, %1 : i64
    %3 = llvm.select %0, %2, %c43_i64 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sdiv %c-43_i64, %arg0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %c-1_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "uge" %c-26_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.icmp "slt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "slt" %1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.srem %c-38_i64, %c29_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.and %c41_i64, %1 : i64
    %3 = llvm.udiv %2, %c-27_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %c18_i64 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.sext %arg2 : i1 to i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c-12_i64 = arith.constant -12 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %c-12_i64, %c-35_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.urem %c-15_i64, %arg0 : i64
    %1 = llvm.udiv %arg2, %arg2 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "slt" %c-30_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %c3_i64, %0 : i64
    %2 = llvm.urem %c-1_i64, %c-31_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c37_i64, %c1_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "ule" %c-9_i64, %c49_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.icmp "ne" %c37_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.and %arg2, %arg1 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %c-21_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ult" %c-34_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.or %c30_i64, %arg0 : i64
    %1 = llvm.or %arg1, %c41_i64 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %false, %c36_i64, %arg1 : i1, i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.srem %c-42_i64, %c29_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %false = arith.constant false
    %c-44_i64 = arith.constant -44 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.urem %c-44_i64, %c28_i64 : i64
    %1 = llvm.or %c37_i64, %0 : i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c26_i64, %arg0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %c49_i64 : i64
    %3 = llvm.icmp "sgt" %2, %c39_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.urem %c39_i64, %c7_i64 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %c-38_i64 = arith.constant -38 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.select %false, %c-38_i64, %c36_i64 : i1, i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.srem %c43_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.srem %c-2_i64, %arg0 : i64
    %1 = llvm.xor %c-2_i64, %0 : i64
    %2 = llvm.and %1, %c-1_i64 : i64
    %3 = llvm.srem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.or %arg0, %c32_i64 : i64
    %1 = llvm.and %0, %c-29_i64 : i64
    %2 = llvm.xor %1, %c14_i64 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ule" %c17_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "sle" %0, %c-19_i64 : i64
    %2 = llvm.select %1, %arg2, %c20_i64 : i1, i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.srem %c16_i64, %c-7_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.sdiv %arg0, %arg0 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "eq" %c31_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c-28_i64, %1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %c47_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %arg1, %c-14_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "ule" %c-37_i64, %c-24_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.sdiv %c-12_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %c-48_i64 = arith.constant -48 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.ashr %c-9_i64, %c25_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.xor %c-48_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.urem %1, %c-32_i64 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "uge" %c-17_i64, %c25_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %c46_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "ult" %c42_i64, %c-28_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %c-29_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "sge" %c-38_i64, %c-49_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.srem %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.srem %arg0, %c-44_i64 : i64
    %1 = llvm.icmp "eq" %arg1, %arg2 : i64
    %2 = llvm.select %1, %c-49_i64, %c45_i64 : i1, i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.sdiv %arg0, %c4_i64 : i64
    %1 = llvm.udiv %0, %c-27_i64 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.udiv %c-48_i64, %c32_i64 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.sdiv %c-7_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %c-42_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.icmp "eq" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.sdiv %c40_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.lshr %1, %c-2_i64 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "sgt" %c-36_i64, %c-20_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.ashr %c-25_i64, %c-15_i64 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "sge" %c17_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.srem %c-6_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %c37_i64 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c-24_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %c-3_i64, %arg2 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "ule" %c16_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %c0_i64, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "ne" %c31_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.xor %c-31_i64, %c-7_i64 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %2, %c2_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c35_i64, %0 : i64
    %2 = llvm.srem %1, %c-48_i64 : i64
    %3 = llvm.icmp "sgt" %2, %c41_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.lshr %c25_i64, %c-30_i64 : i64
    %1 = llvm.urem %c-33_i64, %0 : i64
    %2 = llvm.urem %c-6_i64, %arg0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c33_i64 = arith.constant 33 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "eq" %c-21_i64, %c37_i64 : i64
    %1 = llvm.select %0, %c33_i64, %c35_i64 : i1, i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-25_i64 = arith.constant -25 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "eq" %c-25_i64, %c-22_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %true, %1, %arg0 : i1, i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %c10_i64 : i64
    %2 = llvm.lshr %arg2, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c8_i64 = arith.constant 8 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.lshr %c10_i64, %arg0 : i64
    %1 = llvm.lshr %c8_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.lshr %c-20_i64, %arg0 : i64
    %1 = llvm.srem %c-38_i64, %0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.and %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.urem %c-20_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.or %0, %c40_i64 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c8_i64 : i64
    %2 = llvm.or %arg0, %0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.xor %c4_i64, %arg1 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.sdiv %c-26_i64, %0 : i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %false = arith.constant false
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.select %false, %c3_i64, %arg0 : i1, i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "ule" %c-8_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %c-35_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "ugt" %c45_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.and %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c49_i64 = arith.constant 49 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.select %arg0, %c49_i64, %c47_i64 : i1, i64
    %1 = llvm.icmp "sge" %c40_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c9_i64 : i64
    %2 = llvm.sdiv %1, %c-4_i64 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg1, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.select %arg1, %arg0, %c-47_i64 : i1, i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %c-24_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.udiv %c48_i64, %c49_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.select %false, %c34_i64, %arg0 : i1, i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c29_i64 = arith.constant 29 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "ne" %arg0, %c-8_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %c29_i64 : i64
    %3 = llvm.icmp "ne" %2, %c48_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "ne" %c7_i64, %c-8_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %c-35_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %false = arith.constant false
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.select %false, %arg0, %c-1_i64 : i1, i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %arg1 : i1, i64
    %3 = llvm.icmp "uge" %2, %c50_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.and %c19_i64, %c-7_i64 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.srem %c4_i64, %arg1 : i64
    %1 = llvm.urem %0, %c-7_i64 : i64
    %2 = llvm.lshr %1, %c-43_i64 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.xor %c-19_i64, %c49_i64 : i64
    %1 = llvm.icmp "sgt" %0, %c36_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %c-50_i64 = arith.constant -50 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.udiv %c-43_i64, %c42_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.ashr %c-50_i64, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %c16_i64 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.srem %c8_i64, %c8_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.lshr %c-40_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.udiv %1, %c24_i64 : i64
    %3 = llvm.icmp "ne" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "sgt" %arg1, %c47_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %c46_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.udiv %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.or %arg0, %c1_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c31_i64 = arith.constant 31 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.or %c31_i64, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "eq" %2, %c-39_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.lshr %c-7_i64, %c23_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "uge" %c45_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.sdiv %arg2, %1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    %3 = llvm.icmp "ne" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.sdiv %arg0, %c-38_i64 : i64
    %1 = llvm.ashr %0, %c8_i64 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "ult" %arg0, %c-3_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.urem %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %c4_i64 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c36_i64 = arith.constant 36 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.sdiv %c1_i64, %arg1 : i64
    %1 = llvm.select %arg0, %0, %c36_i64 : i1, i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.icmp "ne" %2, %c2_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c12_i64 = arith.constant 12 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "ne" %c12_i64, %c11_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c-23_i64, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.select %arg2, %c-7_i64, %c40_i64 : i1, i64
    %1 = llvm.icmp "ule" %arg1, %0 : i64
    %2 = llvm.select %1, %arg1, %0 : i1, i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "uge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %c19_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.urem %c41_i64, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.urem %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.ashr %c5_i64, %c-26_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.udiv %c-46_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sge" %c-38_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.select %false, %c-22_i64, %arg0 : i1, i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.srem %c18_i64, %arg0 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.xor %c-6_i64, %0 : i64
    %2 = llvm.udiv %c-10_i64, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.lshr %c30_i64, %c-22_i64 : i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.ashr %arg0, %c-1_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %c-42_i64, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "sge" %2, %c49_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.srem %arg0, %c-40_i64 : i64
    %1 = llvm.and %c5_i64, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "slt" %arg0, %c33_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %arg0 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c33_i64 = arith.constant 33 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.lshr %c33_i64, %c36_i64 : i64
    %1 = llvm.srem %arg0, %c-18_i64 : i64
    %2 = llvm.udiv %1, %c-13_i64 : i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.srem %c-30_i64, %c44_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.ashr %c46_i64, %1 : i64
    %3 = llvm.icmp "sle" %2, %c-49_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg1 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "ne" %c17_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.and %c-47_i64, %c2_i64 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.lshr %c-10_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %arg1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.icmp "sgt" %0, %c7_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.and %c-14_i64, %c42_i64 : i64
    %1 = llvm.xor %0, %c-49_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.sdiv %c44_i64, %c-37_i64 : i64
    %1 = llvm.urem %0, %c13_i64 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c-25_i64 = arith.constant -25 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %c-25_i64, %c50_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.udiv %arg2, %c-4_i64 : i64
    %1 = llvm.icmp "eq" %arg1, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.select %true, %c-6_i64, %0 : i1, i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %c43_i64, %1 : i64
    %3 = llvm.sdiv %c5_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "uge" %c36_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.icmp "uge" %c40_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.ashr %arg1, %c-41_i64 : i64
    %1 = llvm.and %c-4_i64, %arg2 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.icmp "ne" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %c44_i64, %0 : i64
    %2 = llvm.icmp "ule" %c-9_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %c-31_i64, %c-16_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.xor %arg0, %c3_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-3_i64 = arith.constant -3 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.ashr %c-3_i64, %c40_i64 : i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.sdiv %c-8_i64, %c2_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "slt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c-32_i64, %arg0 : i1, i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "ugt" %c-18_i64, %arg2 : i64
    %1 = llvm.select %0, %arg2, %c-27_i64 : i1, i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.select %arg0, %2, %c48_i64 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.icmp "sle" %2, %c6_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.lshr %c11_i64, %c-7_i64 : i64
    %1 = llvm.xor %c-10_i64, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.icmp "sge" %0, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-4_i64 = arith.constant -4 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.xor %c-4_i64, %c7_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.select %true, %arg0, %arg1 : i1, i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %c20_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c10_i64 = arith.constant 10 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "eq" %c0_i64, %c-42_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.icmp "sgt" %c10_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %true = arith.constant true
    %c31_i64 = arith.constant 31 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.select %true, %c31_i64, %c22_i64 : i1, i64
    %1 = llvm.icmp "eq" %0, %c-23_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "slt" %c-6_i64, %c26_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %c-38_i64, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "ult" %c-33_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %true = arith.constant true
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.select %true, %c-31_i64, %arg0 : i1, i64
    %1 = llvm.icmp "sgt" %c50_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "ule" %c-39_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg1, %arg1 : i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %true = arith.constant true
    %c-13_i64 = arith.constant -13 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.select %true, %c-13_i64, %c48_i64 : i1, i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.icmp "uge" %2, %c13_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.urem %c46_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.srem %1, %c-40_i64 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.urem %arg0, %c36_i64 : i64
    %1 = llvm.ashr %0, %c19_i64 : i64
    %2 = llvm.urem %arg0, %arg0 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.icmp "ne" %c-36_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.srem %c31_i64, %c-48_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.icmp "sge" %c-8_i64, %c-10_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.select %2, %1, %c-18_i64 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.or %arg0, %arg0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.and %2, %c32_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.udiv %c-27_i64, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "sle" %2, %c-1_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.srem %c-44_i64, %0 : i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "sgt" %c-21_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.icmp "sgt" %c-40_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "eq" %arg1, %arg2 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %c29_i64 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.select %arg0, %1, %c-8_i64 : i1, i64
    %3 = llvm.icmp "eq" %c-7_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.select %arg0, %c13_i64, %arg1 : i1, i64
    %1 = llvm.udiv %c-4_i64, %0 : i64
    %2 = llvm.lshr %c-37_i64, %c-42_i64 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "ult" %c13_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.select %0, %2, %c-13_i64 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c30_i64 = arith.constant 30 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.srem %c30_i64, %c-17_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.sdiv %c17_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.lshr %c-32_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.ashr %arg1, %0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "ne" %arg0, %c23_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %c43_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.ashr %c-26_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.select %true, %arg1, %arg0 : i1, i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.srem %c48_i64, %arg0 : i64
    %1 = llvm.xor %0, %c-45_i64 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.ashr %c46_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %arg1, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %true = arith.constant true
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.select %true, %c-38_i64, %0 : i1, i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.lshr %c21_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "slt" %c-17_i64, %c23_i64 : i64
    %1 = llvm.select %0, %c35_i64, %arg0 : i1, i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.lshr %c-6_i64, %c-37_i64 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %c27_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.udiv %arg0, %c-17_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.ashr %arg0, %c-36_i64 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.and %c49_i64, %0 : i64
    %2 = llvm.udiv %arg0, %c-30_i64 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c2_i64 = arith.constant 2 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "eq" %0, %c19_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %c2_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "sgt" %c24_i64, %c10_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.urem %c-50_i64, %arg0 : i64
    %1 = llvm.and %c-10_i64, %c23_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.select %arg0, %c36_i64, %c-37_i64 : i1, i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.select %1, %c-23_i64, %0 : i1, i64
    %3 = llvm.icmp "uge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.lshr %c41_i64, %arg0 : i64
    %1 = llvm.or %0, %c19_i64 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.or %c47_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "ule" %c38_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %true = arith.constant true
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.and %arg0, %c34_i64 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.select %true, %1, %c18_i64 : i1, i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.srem %c-28_i64, %arg1 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.select %arg0, %0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.udiv %c4_i64, %c-48_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.or %2, %c-16_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.urem %c-16_i64, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.or %1, %c50_i64 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %c-16_i64 = arith.constant -16 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.urem %c-44_i64, %c0_i64 : i64
    %1 = llvm.select %true, %c-16_i64, %0 : i1, i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.srem %arg0, %c-16_i64 : i64
    %1 = llvm.icmp "eq" %0, %c-41_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.sdiv %c-15_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %c26_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "sle" %arg1, %arg2 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "slt" %2, %c-46_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %c-12_i64, %0 : i64
    %2 = llvm.srem %0, %c41_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.lshr %c20_i64, %c12_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.udiv %arg0, %c13_i64 : i64
    %1 = llvm.and %c-10_i64, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %c24_i64, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c45_i64 = arith.constant 45 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.and %arg0, %c11_i64 : i64
    %1 = llvm.xor %0, %c45_i64 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %c-5_i64 = arith.constant -5 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.srem %c-5_i64, %c46_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.select %1, %2, %c23_i64 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.or %c-44_i64, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %c-43_i64, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.icmp "sle" %2, %c49_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c29_i64 = arith.constant 29 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.ashr %c29_i64, %c-39_i64 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %c45_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.lshr %arg0, %c5_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.srem %c12_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.and %c-31_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "slt" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.srem %1, %c44_i64 : i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.lshr %arg0, %c40_i64 : i64
    %1 = llvm.icmp "sle" %c36_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c27_i64 = arith.constant 27 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.udiv %c27_i64, %c36_i64 : i64
    %1 = llvm.icmp "ugt" %c-5_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-12_i64 = arith.constant -12 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.select %arg0, %arg1, %c-7_i64 : i1, i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sge" %c-12_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %false = arith.constant false
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.select %false, %arg1, %c-10_i64 : i1, i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.sdiv %c18_i64, %c-18_i64 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.sdiv %1, %c-34_i64 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "sle" %c21_i64, %c-42_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg0, %c27_i64 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %0, %c45_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.ashr %c14_i64, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-10_i64 = arith.constant -10 : i64
    %true = arith.constant true
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.select %true, %arg1, %c-22_i64 : i1, i64
    %1 = llvm.icmp "sge" %0, %c-10_i64 : i64
    %2 = llvm.select %1, %arg2, %c43_i64 : i1, i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %c47_i64, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c38_i64 = arith.constant 38 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.xor %c38_i64, %c41_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.ashr %arg1, %c43_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c17_i64 = arith.constant 17 : i64
    %c41_i64 = arith.constant 41 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "ne" %c41_i64, %c1_i64 : i64
    %1 = llvm.select %0, %arg0, %c33_i64 : i1, i64
    %2 = llvm.srem %c17_i64, %1 : i64
    %3 = llvm.urem %c-47_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %c-45_i64 : i64
    %2 = llvm.lshr %arg1, %c-30_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.sdiv %c21_i64, %arg0 : i64
    %1 = llvm.urem %c-20_i64, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "eq" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.xor %c25_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.udiv %arg1, %0 : i64
    %3 = llvm.select %1, %2, %arg1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %arg0, %c20_i64 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.and %1, %c15_i64 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.lshr %c-21_i64, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.icmp "ule" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %true = arith.constant true
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.select %true, %c-18_i64, %arg0 : i1, i64
    %1 = llvm.xor %c50_i64, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.srem %c-45_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.ashr %c-37_i64, %1 : i64
    %3 = llvm.icmp "sle" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.xor %arg0, %arg2 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.icmp "sge" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %c25_i64, %c20_i64 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ule" %0, %c-15_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %c25_i64 : i64
    %2 = llvm.sdiv %1, %c-37_i64 : i64
    %3 = llvm.icmp "sge" %2, %c38_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.sdiv %c18_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %c-50_i64, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.urem %arg0, %c-27_i64 : i64
    %1 = llvm.icmp "uge" %0, %c-16_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %c-34_i64 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.sdiv %2, %c-18_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c21_i64 = arith.constant 21 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %c21_i64, %c40_i64 : i64
    %1 = llvm.icmp "sgt" %c-44_i64, %0 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.or %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "slt" %arg0, %c19_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c-10_i64, %arg0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.and %c-47_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.udiv %arg0, %c2_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %0, %c-45_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %c50_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.urem %c38_i64, %arg0 : i64
    %1 = llvm.and %c-20_i64, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "sge" %2, %c-27_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %c10_i64, %c-35_i64 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.and %arg0, %c-33_i64 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.select %arg0, %c-41_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ne" %arg2, %c-17_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.select %1, %c20_i64, %0 : i1, i64
    %3 = llvm.select %1, %c10_i64, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.sdiv %c9_i64, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.srem %1, %c-30_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %c46_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %c42_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c25_i64 = arith.constant 25 : i64
    %c9_i64 = arith.constant 9 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.sdiv %c9_i64, %c49_i64 : i64
    %1 = llvm.select %arg0, %c34_i64, %arg1 : i1, i64
    %2 = llvm.lshr %c25_i64, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.urem %c25_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c25_i64 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.srem %c-38_i64, %c6_i64 : i64
    %1 = llvm.and %c25_i64, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %c-24_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.urem %c-50_i64, %arg0 : i64
    %1 = llvm.and %0, %c14_i64 : i64
    %2 = llvm.or %0, %arg1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.urem %c32_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "slt" %c50_i64, %c41_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.icmp "ule" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "uge" %c-34_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c37_i64, %1 : i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.udiv %c-20_i64, %arg0 : i64
    %1 = llvm.or %c1_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %c-14_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.select %false, %0, %arg0 : i1, i64
    %2 = llvm.urem %c-6_i64, %1 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "sgt" %c27_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %c-12_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.lshr %c18_i64, %c30_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.ashr %arg0, %c44_i64 : i64
    %1 = llvm.ashr %arg1, %c16_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.ashr %arg1, %c-30_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.ashr %arg0, %c38_i64 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "slt" %c0_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.lshr %c-34_i64, %c-40_i64 : i64
    %1 = llvm.icmp "eq" %c-28_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.urem %c-22_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.sdiv %c5_i64, %0 : i64
    %2 = llvm.lshr %c-26_i64, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %c42_i64, %0 : i64
    %2 = llvm.xor %c10_i64, %1 : i64
    %3 = llvm.icmp "ugt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.and %arg0, %c-33_i64 : i64
    %1 = llvm.icmp "eq" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg1, %arg2 : i1, i64
    %1 = llvm.srem %c46_i64, %arg2 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.select %true, %arg0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %false = arith.constant false
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.xor %arg0, %c-38_i64 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.and %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.srem %c-31_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "sgt" %arg0, %c-14_i64 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %c25_i64 : i1, i64
    %3 = llvm.xor %c-3_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c24_i64 = arith.constant 24 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.sdiv %c24_i64, %c-50_i64 : i64
    %1 = llvm.and %0, %c-18_i64 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.srem %c45_i64, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.ashr %c-48_i64, %c-5_i64 : i64
    %1 = llvm.icmp "ult" %c19_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %c-33_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "ule" %c-35_i64, %c-50_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %c36_i64, %c37_i64 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %c3_i64, %arg0 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.srem %0, %c16_i64 : i64
    %2 = llvm.select %arg2, %arg1, %arg1 : i1, i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.ashr %c15_i64, %arg0 : i64
    %1 = llvm.lshr %c17_i64, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.or %c-33_i64, %arg1 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c25_i64 = arith.constant 25 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.ashr %c25_i64, %c40_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.lshr %1, %c-19_i64 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.urem %c15_i64, %1 : i64
    %3 = llvm.icmp "sle" %2, %c-40_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %c-9_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "ule" %c1_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %c-6_i64, %0 : i1, i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.xor %c-2_i64, %c-34_i64 : i64
    %1 = llvm.xor %arg0, %c1_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.icmp "ult" %2, %c-45_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %c-15_i64, %c-11_i64 : i64
    %1 = llvm.lshr %c14_i64, %arg0 : i64
    %2 = llvm.srem %c11_i64, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
