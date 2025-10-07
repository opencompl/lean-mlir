module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-17_i32 = arith.constant -17 : i32
    return %c-17_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.srem %c-42_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ule" %arg1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "uge" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-30_i8 = arith.constant -30 : i8
    return %c-30_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.udiv %arg0, %c8_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.sdiv %0, %c-7_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c31_i32 = arith.constant 31 : i32
    return %c31_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c36_i8 = arith.constant 36 : i8
    return %c36_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c46_i32 = arith.constant 46 : i32
    return %c46_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c47_i32 = arith.constant 47 : i32
    return %c47_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-5_i8 = arith.constant -5 : i8
    return %c-5_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-48_i8 = arith.constant -48 : i8
    return %c-48_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-21_i8 = arith.constant -21 : i8
    return %c-21_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c31_i8 = arith.constant 31 : i8
    return %c31_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "ne" %arg2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.lshr %arg0, %c-4_i64 : i64
    %1 = llvm.urem %arg1, %c37_i64 : i64
    %2 = llvm.or %c-13_i64, %1 : i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.lshr %c3_i64, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "uge" %arg2, %1 : i64
    %4 = llvm.select %3, %1, %2 : i1, i64
    %5 = llvm.lshr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.xor %arg0, %0 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.lshr %3, %c-34_i64 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-18_i32 = arith.constant -18 : i32
    return %c-18_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c30_i32 = arith.constant 30 : i32
    return %c30_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-43_i8 = arith.constant -43 : i8
    return %c-43_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c22_i8 = arith.constant 22 : i8
    return %c22_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.or %c42_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.icmp "slt" %1, %c-46_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c-41_i64 = arith.constant -41 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "sgt" %c-41_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.select %3, %c-3_i64, %arg1 : i1, i64
    %5 = llvm.udiv %4, %arg2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-22_i8 = arith.constant -22 : i8
    return %c-22_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c37_i64 = arith.constant 37 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "eq" %c37_i64, %c-17_i64 : i64
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.icmp "ule" %arg2, %c-34_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    %5 = llvm.lshr %4, %c-11_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c27_i8 = arith.constant 27 : i8
    return %c27_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-20_i8 = arith.constant -20 : i8
    return %c-20_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c4_i32 = arith.constant 4 : i32
    return %c4_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %arg0, %arg1 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c6_i8 = arith.constant 6 : i8
    return %c6_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.urem %c-42_i64, %c-3_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %c-4_i64, %3 : i64
    %5 = llvm.udiv %4, %arg0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %c-4_i64, %0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.icmp "ule" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %c-47_i64 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %3, %3 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c42_i8 = arith.constant 42 : i8
    return %c42_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c34_i32 = arith.constant 34 : i32
    return %c34_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "eq" %c49_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.srem %c46_i64, %2 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.icmp "eq" %1, %c18_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %3, %c-17_i64 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-5_i32 = arith.constant -5 : i32
    return %c-5_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.xor %c-30_i64, %0 : i64
    %4 = llvm.and %c30_i64, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c35_i32 = arith.constant 35 : i32
    return %c35_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %false = arith.constant false
    %c-29_i64 = arith.constant -29 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.and %c-29_i64, %c28_i64 : i64
    %1 = llvm.select %false, %c-11_i64, %0 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %4, %c-29_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c26_i32 = arith.constant 26 : i32
    return %c26_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c48_i8 = arith.constant 48 : i8
    return %c48_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.sdiv %c-3_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "ule" %c38_i64, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.srem %c-39_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-31_i8 = arith.constant -31 : i8
    return %c-31_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "ugt" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c45_i8 = arith.constant 45 : i8
    return %c45_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c11_i8 = arith.constant 11 : i8
    return %c11_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c9_i32 = arith.constant 9 : i32
    return %c9_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.ashr %arg0, %c16_i64 : i64
    %1 = llvm.udiv %0, %c-39_i64 : i64
    %2 = llvm.icmp "slt" %c49_i64, %c38_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c47_i8 = arith.constant 47 : i8
    return %c47_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c25_i32 = arith.constant 25 : i32
    return %c25_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c20_i32 = arith.constant 20 : i32
    return %c20_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c13_i8 = arith.constant 13 : i8
    return %c13_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c25_i32 = arith.constant 25 : i32
    return %c25_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c37_i32 = arith.constant 37 : i32
    return %c37_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c50_i8 = arith.constant 50 : i8
    return %c50_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-13_i8 = arith.constant -13 : i8
    return %c-13_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-19_i32 = arith.constant -19 : i32
    return %c-19_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-2_i8 = arith.constant -2 : i8
    return %c-2_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %true = arith.constant true
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.select %true, %arg2, %c31_i64 : i1, i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %c41_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c26_i64 = arith.constant 26 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %c-2_i64, %0 : i64
    %2 = llvm.icmp "uge" %1, %c18_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %c26_i64, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-20_i8 = arith.constant -20 : i8
    return %c-20_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.select %arg0, %c8_i64, %arg1 : i1, i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.sdiv %arg2, %1 : i64
    %3 = llvm.select %true, %c22_i64, %c-25_i64 : i1, i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.urem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-44_i32 = arith.constant -44 : i32
    return %c-44_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "ule" %c-44_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %3, %c-40_i64 : i64
    %5 = llvm.icmp "uge" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-31_i32 = arith.constant -31 : i32
    return %c-31_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "ugt" %c-2_i64, %c14_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "ult" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %0, %c-45_i64 : i64
    %2 = llvm.icmp "ugt" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.or %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-13_i32 = arith.constant -13 : i32
    return %c-13_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c20_i32 = arith.constant 20 : i32
    return %c20_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c0_i8 = arith.constant 0 : i8
    return %c0_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c14_i32 = arith.constant 14 : i32
    return %c14_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c45_i32 = arith.constant 45 : i32
    return %c45_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-9_i32 = arith.constant -9 : i32
    return %c-9_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c25_i8 = arith.constant 25 : i8
    return %c25_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c-26_i64 = arith.constant -26 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %c-26_i64, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "eq" %c-38_i64, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %3, %c-49_i64 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-43_i8 = arith.constant -43 : i8
    return %c-43_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "eq" %4, %c17_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ugt" %arg2, %c-22_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-10_i8 = arith.constant -10 : i8
    return %c-10_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c25_i8 = arith.constant 25 : i8
    return %c25_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c20_i8 = arith.constant 20 : i8
    return %c20_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.urem %c-14_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-8_i32 = arith.constant -8 : i32
    return %c-8_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c11_i32 = arith.constant 11 : i32
    return %c11_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-16_i8 = arith.constant -16 : i8
    return %c-16_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-25_i8 = arith.constant -25 : i8
    return %c-25_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c23_i32 = arith.constant 23 : i32
    return %c23_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c26_i32 = arith.constant 26 : i32
    return %c26_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c24_i32 = arith.constant 24 : i32
    return %c24_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-26_i8 = arith.constant -26 : i8
    return %c-26_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %c35_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %c-2_i64, %arg1 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.lshr %c-49_i64, %c-31_i64 : i64
    %1 = llvm.xor %c34_i64, %arg0 : i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.srem %4, %3 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-22_i32 = arith.constant -22 : i32
    return %c-22_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c9_i32 = arith.constant 9 : i32
    return %c9_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c40_i32 = arith.constant 40 : i32
    return %c40_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-1_i32 = arith.constant -1 : i32
    return %c-1_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-40_i8 = arith.constant -40 : i8
    return %c-40_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-24_i32 = arith.constant -24 : i32
    return %c-24_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %c32_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %c-10_i64, %c33_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c13_i32 = arith.constant 13 : i32
    return %c13_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-36_i32 = arith.constant -36 : i32
    return %c-36_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-33_i32 = arith.constant -33 : i32
    return %c-33_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %false = arith.constant false
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %0, %c32_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.trunc %arg0 : i1 to i64
    %4 = llvm.select %false, %0, %3 : i1, i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c9_i32 = arith.constant 9 : i32
    return %c9_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c25_i8 = arith.constant 25 : i8
    return %c25_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c7_i8 = arith.constant 7 : i8
    return %c7_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c12_i8 = arith.constant 12 : i8
    return %c12_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c14_i32 = arith.constant 14 : i32
    return %c14_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-5_i32 = arith.constant -5 : i32
    return %c-5_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c4_i32 = arith.constant 4 : i32
    return %c4_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c43_i8 = arith.constant 43 : i8
    return %c43_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-2_i32 = arith.constant -2 : i32
    return %c-2_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-3_i32 = arith.constant -3 : i32
    return %c-3_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.or %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.ashr %c6_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c2_i64, %0 : i64
    %4 = llvm.sdiv %3, %2 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c15_i32 = arith.constant 15 : i32
    return %c15_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %arg1, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %c-4_i64, %2 : i64
    %4 = llvm.or %c27_i64, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c5_i8 = arith.constant 5 : i8
    return %c5_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c39_i64 = arith.constant 39 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ne" %1, %c-38_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "ugt" %c39_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c40_i8 = arith.constant 40 : i8
    return %c40_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c9_i64 = arith.constant 9 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.or %arg0, %c20_i64 : i64
    %1 = llvm.and %arg2, %arg2 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.select %3, %c9_i64, %c8_i64 : i1, i64
    %5 = llvm.icmp "eq" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.ashr %c0_i64, %2 : i64
    %4 = llvm.or %0, %arg1 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c37_i8 = arith.constant 37 : i8
    return %c37_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-33_i8 = arith.constant -33 : i8
    return %c-33_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %0, %1 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %c13_i64, %c-5_i64 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.sdiv %c-6_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg2, %c-7_i64 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sle" %2, %c-3_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c21_i8 = arith.constant 21 : i8
    return %c21_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %c14_i64 : i64
    %2 = llvm.icmp "ult" %1, %c-3_i64 : i64
    %3 = llvm.srem %c-45_i64, %1 : i64
    %4 = llvm.select %2, %0, %3 : i1, i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c43_i8 = arith.constant 43 : i8
    return %c43_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-9_i32 = arith.constant -9 : i32
    return %c-9_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-6_i32 = arith.constant -6 : i32
    return %c-6_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %arg0, %arg0 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "sle" %4, %c-19_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "sle" %c-5_i64, %c30_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.xor %1, %c-2_i64 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c31_i32 = arith.constant 31 : i32
    return %c31_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sdiv %c-30_i64, %c44_i64 : i64
    %1 = llvm.ashr %c32_i64, %0 : i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %c-7_i64, %3 : i64
    %5 = llvm.icmp "ult" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg2, %c13_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.sdiv %c27_i64, %arg0 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c45_i32 = arith.constant 45 : i32
    return %c45_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-17_i32 = arith.constant -17 : i32
    return %c-17_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-15_i8 = arith.constant -15 : i8
    return %c-15_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c22_i8 = arith.constant 22 : i8
    return %c22_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c2_i64 = arith.constant 2 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %c2_i64 : i64
    %2 = llvm.urem %c18_i64, %1 : i64
    %3 = llvm.ashr %arg1, %arg2 : i64
    %4 = llvm.or %c7_i64, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-15_i8 = arith.constant -15 : i8
    return %c-15_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c8_i8 = arith.constant 8 : i8
    return %c8_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c19_i32 = arith.constant 19 : i32
    return %c19_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c49_i32 = arith.constant 49 : i32
    return %c49_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c32_i32 = arith.constant 32 : i32
    return %c32_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "sge" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.urem %3, %c9_i64 : i64
    %5 = llvm.icmp "slt" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c26_i64 = arith.constant 26 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %c48_i64, %0 : i64
    %2 = llvm.udiv %c48_i64, %1 : i64
    %3 = llvm.and %2, %c26_i64 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    %5 = llvm.select %4, %c44_i64, %arg1 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-25_i32 = arith.constant -25 : i32
    return %c-25_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c20_i8 = arith.constant 20 : i8
    return %c20_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-9_i8 = arith.constant -9 : i8
    return %c-9_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-20_i32 = arith.constant -20 : i32
    return %c-20_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-22_i8 = arith.constant -22 : i8
    return %c-22_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.select %arg0, %c-15_i64, %c27_i64 : i1, i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg2, %c-40_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.srem %c-1_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.select %arg1, %c23_i64, %c-4_i64 : i1, i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-44_i8 = arith.constant -44 : i8
    return %c-44_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c15_i8 = arith.constant 15 : i8
    return %c15_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c25_i64 = arith.constant 25 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.select %arg1, %arg2, %c38_i64 : i1, i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "eq" %c25_i64, %c-42_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-8_i8 = arith.constant -8 : i8
    return %c-8_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c7_i32 = arith.constant 7 : i32
    return %c7_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c7_i32 = arith.constant 7 : i32
    return %c7_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-4_i8 = arith.constant -4 : i8
    return %c-4_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ult" %c-40_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg0, %arg0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "eq" %c-40_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c29_i32 = arith.constant 29 : i32
    return %c29_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-3_i8 = arith.constant -3 : i8
    return %c-3_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c33_i64 = arith.constant 33 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %c-3_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %c33_i64, %c-40_i64 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "sgt" %4, %c-38_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c26_i8 = arith.constant 26 : i8
    return %c26_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-12_i32 = arith.constant -12 : i32
    return %c-12_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "slt" %c6_i64, %c-1_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %c-4_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.select %arg1, %c0_i64, %arg0 : i1, i64
    %1 = llvm.or %c33_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-5_i8 = arith.constant -5 : i8
    return %c-5_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c13_i8 = arith.constant 13 : i8
    return %c13_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-46_i8 = arith.constant -46 : i8
    return %c-46_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c13_i32 = arith.constant 13 : i32
    return %c13_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c6_i32 = arith.constant 6 : i32
    return %c6_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-7_i32 = arith.constant -7 : i32
    return %c-7_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c14_i32 = arith.constant 14 : i32
    return %c14_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-42_i32 = arith.constant -42 : i32
    return %c-42_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.lshr %c8_i64, %arg1 : i64
    %4 = llvm.sext %2 : i1 to i64
    %5 = llvm.select %2, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c47_i32 = arith.constant 47 : i32
    return %c47_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-5_i8 = arith.constant -5 : i8
    return %c-5_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c15_i8 = arith.constant 15 : i8
    return %c15_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c-36_i64, %arg0 : i1, i64
    %2 = llvm.ashr %c-31_i64, %1 : i64
    %3 = llvm.sext %0 : i1 to i64
    %4 = llvm.and %3, %2 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c10_i8 = arith.constant 10 : i8
    return %c10_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-31_i8 = arith.constant -31 : i8
    return %c-31_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-5_i32 = arith.constant -5 : i32
    return %c-5_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "slt" %c42_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %c-28_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-18_i32 = arith.constant -18 : i32
    return %c-18_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-34_i32 = arith.constant -34 : i32
    return %c-34_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-19_i32 = arith.constant -19 : i32
    return %c-19_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c4_i8 = arith.constant 4 : i8
    return %c4_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c40_i8 = arith.constant 40 : i8
    return %c40_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-22_i8 = arith.constant -22 : i8
    return %c-22_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-29_i8 = arith.constant -29 : i8
    return %c-29_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c38_i8 = arith.constant 38 : i8
    return %c38_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-50_i8 = arith.constant -50 : i8
    return %c-50_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c15_i8 = arith.constant 15 : i8
    return %c15_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-9_i32 = arith.constant -9 : i32
    return %c-9_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c8_i8 = arith.constant 8 : i8
    return %c8_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c5_i8 = arith.constant 5 : i8
    return %c5_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c16_i8 = arith.constant 16 : i8
    return %c16_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c18_i8 = arith.constant 18 : i8
    return %c18_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.xor %c2_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.srem %arg1, %c-34_i64 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-9_i32 = arith.constant -9 : i32
    return %c-9_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c46_i8 = arith.constant 46 : i8
    return %c46_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-50_i8 = arith.constant -50 : i8
    return %c-50_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-48_i8 = arith.constant -48 : i8
    return %c-48_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "sle" %c-35_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %c-20_i64 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.udiv %arg2, %c44_i64 : i64
    %5 = llvm.select %0, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c34_i8 = arith.constant 34 : i8
    return %c34_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "ult" %arg0, %c2_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg1, %arg1 : i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.or %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-22_i8 = arith.constant -22 : i8
    return %c-22_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c23_i32 = arith.constant 23 : i32
    return %c23_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-21_i8 = arith.constant -21 : i8
    return %c-21_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.ashr %c29_i64, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.sext %arg2 : i1 to i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-19_i8 = arith.constant -19 : i8
    return %c-19_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.sdiv %c-47_i64, %c6_i64 : i64
    %2 = llvm.and %1, %c0_i64 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c12_i64 = arith.constant 12 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.and %c-50_i64, %0 : i64
    %2 = llvm.icmp "ule" %arg2, %c12_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %3, %c3_i64 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-3_i8 = arith.constant -3 : i8
    return %c-3_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %c-49_i64, %0 : i64
    %2 = llvm.or %0, %arg1 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %c48_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-14_i8 = arith.constant -14 : i8
    return %c-14_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.or %arg0, %c-43_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.and %arg0, %0 : i64
    %3 = llvm.lshr %2, %c37_i64 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-10_i8 = arith.constant -10 : i8
    return %c-10_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c42_i32 = arith.constant 42 : i32
    return %c42_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c43_i64 = arith.constant 43 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "eq" %c43_i64, %c-45_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.xor %3, %c-48_i64 : i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %c-40_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %1, %arg2, %arg0 : i1, i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-45_i32 = arith.constant -45 : i32
    return %c-45_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-6_i32 = arith.constant -6 : i32
    return %c-6_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c46_i32 = arith.constant 46 : i32
    return %c46_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-6_i32 = arith.constant -6 : i32
    return %c-6_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %c18_i64, %3 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-20_i8 = arith.constant -20 : i8
    return %c-20_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c26_i8 = arith.constant 26 : i8
    return %c26_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-5_i32 = arith.constant -5 : i32
    return %c-5_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c16_i8 = arith.constant 16 : i8
    return %c16_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-28_i8 = arith.constant -28 : i8
    return %c-28_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c45_i8 = arith.constant 45 : i8
    return %c45_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-9_i8 = arith.constant -9 : i8
    return %c-9_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-8_i8 = arith.constant -8 : i8
    return %c-8_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c19_i8 = arith.constant 19 : i8
    return %c19_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-37_i8 = arith.constant -37 : i8
    return %c-37_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c48_i8 = arith.constant 48 : i8
    return %c48_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-22_i8 = arith.constant -22 : i8
    return %c-22_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c44_i32 = arith.constant 44 : i32
    return %c44_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-40_i64 = arith.constant -40 : i64
    %false = arith.constant false
    %c-10_i64 = arith.constant -10 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.srem %c-10_i64, %c-18_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.ashr %c-40_i64, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.select %false, %3, %c-7_i64 : i1, i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %c47_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c36_i64 = arith.constant 36 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.xor %c-29_i64, %c49_i64 : i64
    %1 = llvm.udiv %0, %c36_i64 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.select %true, %arg0, %3 : i1, i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c24_i8 = arith.constant 24 : i8
    return %c24_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c20_i64 = arith.constant 20 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %c4_i64, %c20_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.srem %c-20_i64, %arg1 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %arg1, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.srem %4, %3 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-1_i32 = arith.constant -1 : i32
    return %c-1_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-42_i8 = arith.constant -42 : i8
    return %c-42_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c5_i64 = arith.constant 5 : i64
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.ashr %c5_i64, %c-46_i64 : i64
    %4 = llvm.select %false, %3, %c1_i64 : i1, i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-22_i32 = arith.constant -22 : i32
    return %c-22_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c23_i8 = arith.constant 23 : i8
    return %c23_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.ashr %c-38_i64, %c1_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.and %c-39_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-40_i32 = arith.constant -40 : i32
    return %c-40_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %c15_i64 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.udiv %arg1, %0 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-22_i32 = arith.constant -22 : i32
    return %c-22_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.or %arg0, %c41_i64 : i64
    %1 = llvm.lshr %c-6_i64, %0 : i64
    %2 = llvm.icmp "ult" %c-8_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-23_i8 = arith.constant -23 : i8
    return %c-23_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-49_i32 = arith.constant -49 : i32
    return %c-49_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg1, %arg1 : i64
    %3 = llvm.lshr %c-17_i64, %2 : i64
    %4 = llvm.srem %3, %c5_i64 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c28_i32 = arith.constant 28 : i32
    return %c28_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c15_i32 = arith.constant 15 : i32
    return %c15_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.ashr %c7_i64, %c5_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-18_i8 = arith.constant -18 : i8
    return %c-18_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c20_i8 = arith.constant 20 : i8
    return %c20_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.urem %c42_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg1, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sdiv %c-5_i64, %1 : i64
    %3 = llvm.ashr %arg1, %arg0 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "sge" %c8_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c4_i64 = arith.constant 4 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.lshr %c42_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c4_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-11_i32 = arith.constant -11 : i32
    return %c-11_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.xor %arg0, %c-39_i64 : i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %c13_i64, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-11_i32 = arith.constant -11 : i32
    return %c-11_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.urem %c45_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %c19_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.zext %arg1 : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "eq" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-18_i8 = arith.constant -18 : i8
    return %c-18_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-29_i32 = arith.constant -29 : i32
    return %c-29_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-28_i8 = arith.constant -28 : i8
    return %c-28_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "slt" %arg0, %c2_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg1, %c-19_i64 : i64
    %3 = llvm.icmp "slt" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.srem %c-37_i64, %c-33_i64 : i64
    %4 = llvm.xor %3, %c7_i64 : i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-26_i8 = arith.constant -26 : i8
    return %c-26_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c31_i8 = arith.constant 31 : i8
    return %c31_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c41_i32 = arith.constant 41 : i32
    return %c41_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.udiv %c-39_i64, %arg2 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.ashr %arg1, %c-36_i64 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "ugt" %c9_i64, %c15_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.urem %3, %2 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-11_i8 = arith.constant -11 : i8
    return %c-11_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-12_i64 = arith.constant -12 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.select %arg2, %c-12_i64, %0 : i1, i64
    %2 = llvm.icmp "ugt" %c23_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %arg1, %3, %c19_i64 : i1, i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c7_i8 = arith.constant 7 : i8
    return %c7_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.srem %c-40_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    %5 = llvm.select %4, %0, %c10_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-37_i32 = arith.constant -37 : i32
    return %c-37_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c12_i8 = arith.constant 12 : i8
    return %c12_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c32_i8 = arith.constant 32 : i8
    return %c32_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-35_i32 = arith.constant -35 : i32
    return %c-35_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-10_i8 = arith.constant -10 : i8
    return %c-10_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c43_i8 = arith.constant 43 : i8
    return %c43_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c26_i8 = arith.constant 26 : i8
    return %c26_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-33_i32 = arith.constant -33 : i32
    return %c-33_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c38_i32 = arith.constant 38 : i32
    return %c38_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.ashr %c-31_i64, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.sdiv %c-31_i64, %arg0 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c30_i8 = arith.constant 30 : i8
    return %c30_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-31_i32 = arith.constant -31 : i32
    return %c-31_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.sdiv %arg2, %0 : i64
    %4 = llvm.and %c-4_i64, %3 : i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %c-8_i64 : i64
    %2 = llvm.sdiv %c4_i64, %arg1 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.sdiv %3, %3 : i64
    %5 = llvm.and %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c11_i32 = arith.constant 11 : i32
    return %c11_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-30_i32 = arith.constant -30 : i32
    return %c-30_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c49_i8 = arith.constant 49 : i8
    return %c49_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-2_i8 = arith.constant -2 : i8
    return %c-2_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-4_i32 = arith.constant -4 : i32
    return %c-4_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c3_i8 = arith.constant 3 : i8
    return %c3_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-35_i32 = arith.constant -35 : i32
    return %c-35_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-2_i8 = arith.constant -2 : i8
    return %c-2_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %false = arith.constant false
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.urem %c-45_i64, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.and %c31_i64, %1 : i64
    %3 = llvm.select %false, %0, %2 : i1, i64
    %4 = llvm.sdiv %3, %1 : i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c8_i64 = arith.constant 8 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.select %true, %c8_i64, %c-5_i64 : i1, i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.ashr %arg0, %0 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c45_i8 = arith.constant 45 : i8
    return %c45_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-37_i8 = arith.constant -37 : i8
    return %c-37_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.select %arg0, %c-9_i64, %c-17_i64 : i1, i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sdiv %2, %c-49_i64 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.or %c-24_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c3_i8 = arith.constant 3 : i8
    return %c3_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c22_i32 = arith.constant 22 : i32
    return %c22_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %true = arith.constant true
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.select %true, %0, %c42_i64 : i1, i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.urem %1, %arg1 : i64
    %4 = llvm.xor %arg2, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c25_i8 = arith.constant 25 : i8
    return %c25_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c35_i32 = arith.constant 35 : i32
    return %c35_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c50_i8 = arith.constant 50 : i8
    return %c50_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-9_i32 = arith.constant -9 : i32
    return %c-9_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "uge" %c45_i64, %arg0 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.select %false, %arg2, %1 : i1, i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c19_i32 = arith.constant 19 : i32
    return %c19_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c3_i32 = arith.constant 3 : i32
    return %c3_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c39_i32 = arith.constant 39 : i32
    return %c39_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.lshr %c-41_i64, %0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c43_i8 = arith.constant 43 : i8
    return %c43_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg2, %1 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.xor %4, %c2_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-37_i32 = arith.constant -37 : i32
    return %c-37_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-8_i32 = arith.constant -8 : i32
    return %c-8_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c41_i8 = arith.constant 41 : i8
    return %c41_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c13_i8 = arith.constant 13 : i8
    return %c13_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-5_i8 = arith.constant -5 : i8
    return %c-5_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c5_i8 = arith.constant 5 : i8
    return %c5_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.zext %1 : i1 to i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c28_i32 = arith.constant 28 : i32
    return %c28_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-12_i32 = arith.constant -12 : i32
    return %c-12_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c32_i32 = arith.constant 32 : i32
    return %c32_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-5_i32 = arith.constant -5 : i32
    return %c-5_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c23_i8 = arith.constant 23 : i8
    return %c23_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c44_i8 = arith.constant 44 : i8
    return %c44_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c47_i8 = arith.constant 47 : i8
    return %c47_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c8_i8 = arith.constant 8 : i8
    return %c8_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-24_i8 = arith.constant -24 : i8
    return %c-24_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-44_i32 = arith.constant -44 : i32
    return %c-44_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c19_i8 = arith.constant 19 : i8
    return %c19_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c26_i8 = arith.constant 26 : i8
    return %c26_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c15_i8 = arith.constant 15 : i8
    return %c15_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c13_i8 = arith.constant 13 : i8
    return %c13_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c47_i32 = arith.constant 47 : i32
    return %c47_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-24_i32 = arith.constant -24 : i32
    return %c-24_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-11_i8 = arith.constant -11 : i8
    return %c-11_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.sdiv %c31_i64, %c-7_i64 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c7_i32 = arith.constant 7 : i32
    return %c7_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.xor %c10_i64, %1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %c1_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-21_i32 = arith.constant -21 : i32
    return %c-21_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c34_i32 = arith.constant 34 : i32
    return %c34_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c9_i64 = arith.constant 9 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.srem %c9_i64, %c3_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %c46_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-35_i8 = arith.constant -35 : i8
    return %c-35_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %true = arith.constant true
    %c-32_i64 = arith.constant -32 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.srem %c13_i64, %arg0 : i64
    %1 = llvm.select %arg1, %c-32_i64, %arg0 : i1, i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.select %true, %0, %2 : i1, i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-2_i8 = arith.constant -2 : i8
    return %c-2_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-11_i32 = arith.constant -11 : i32
    return %c-11_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %c-42_i64, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.and %3, %c7_i64 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %arg0, %arg1 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.udiv %c-19_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c21_i8 = arith.constant 21 : i8
    return %c21_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.lshr %c-21_i64, %c28_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c34_i32 = arith.constant 34 : i32
    return %c34_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-39_i8 = arith.constant -39 : i8
    return %c-39_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-12_i32 = arith.constant -12 : i32
    return %c-12_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %false = arith.constant false
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %false, %arg1, %c20_i64 : i1, i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.select %1, %c-46_i64, %arg2 : i1, i64
    %3 = llvm.icmp "ugt" %arg2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c21_i32 = arith.constant 21 : i32
    return %c21_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-12_i8 = arith.constant -12 : i8
    return %c-12_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c8_i8 = arith.constant 8 : i8
    return %c8_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.sdiv %arg0, %arg1 : i64
    %4 = llvm.lshr %3, %1 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "eq" %c2_i64, %c18_i64 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.select %arg2, %arg1, %arg1 : i1, i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.select %0, %4, %arg0 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-41_i8 = arith.constant -41 : i8
    return %c-41_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c34_i64 = arith.constant 34 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.udiv %c34_i64, %c14_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.sdiv %c-8_i64, %1 : i64
    %3 = llvm.lshr %c13_i64, %arg0 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-6_i8 = arith.constant -6 : i8
    return %c-6_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %c21_i64, %c-50_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.sdiv %3, %c-13_i64 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-27_i8 = arith.constant -27 : i8
    return %c-27_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c32_i8 = arith.constant 32 : i8
    return %c32_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %c21_i64 = arith.constant 21 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.and %c-16_i64, %c-39_i64 : i64
    %1 = llvm.and %0, %c21_i64 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c42_i8 = arith.constant 42 : i8
    return %c42_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-26_i8 = arith.constant -26 : i8
    return %c-26_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c27_i32 = arith.constant 27 : i32
    return %c27_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.udiv %c-42_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.urem %4, %c-42_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-3_i32 = arith.constant -3 : i32
    return %c-3_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c32_i8 = arith.constant 32 : i8
    return %c32_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %c-38_i64, %0 : i64
    %2 = llvm.select %arg2, %arg1, %1 : i1, i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c39_i8 = arith.constant 39 : i8
    return %c39_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "sle" %c5_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c36_i64, %arg1 : i64
    %3 = llvm.or %2, %1 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c50_i32 = arith.constant 50 : i32
    return %c50_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-45_i8 = arith.constant -45 : i8
    return %c-45_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c8_i8 = arith.constant 8 : i8
    return %c8_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-26_i8 = arith.constant -26 : i8
    return %c-26_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c12_i32 = arith.constant 12 : i32
    return %c12_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %true = arith.constant true
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.lshr %c-49_i64, %arg0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.select %true, %0, %2 : i1, i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.srem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-33_i8 = arith.constant -33 : i8
    return %c-33_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c26_i64 = arith.constant 26 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %c-24_i64, %arg0 : i1, i64
    %2 = llvm.lshr %1, %c26_i64 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.select %3, %c-50_i64, %2 : i1, i64
    %5 = llvm.ashr %4, %c-32_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c16_i8 = arith.constant 16 : i8
    return %c16_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c7_i64 = arith.constant 7 : i64
    %c22_i64 = arith.constant 22 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.xor %c-14_i64, %arg1 : i64
    %1 = llvm.udiv %c-44_i64, %0 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.urem %c7_i64, %c23_i64 : i64
    %4 = llvm.select %arg0, %2, %3 : i1, i64
    %5 = llvm.icmp "ugt" %c22_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "ugt" %c-15_i64, %c-37_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.select %0, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.urem %c2_i64, %c-39_i64 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c24_i64, %0 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-48_i32 = arith.constant -48 : i32
    return %c-48_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-7_i32 = arith.constant -7 : i32
    return %c-7_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-20_i32 = arith.constant -20 : i32
    return %c-20_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-4_i32 = arith.constant -4 : i32
    return %c-4_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c48_i32 = arith.constant 48 : i32
    return %c48_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-5_i64 = arith.constant -5 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.lshr %c-14_i64, %c44_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.srem %1, %c-5_i64 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c28_i32 = arith.constant 28 : i32
    return %c28_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.ashr %c-43_i64, %0 : i64
    %2 = llvm.icmp "sle" %c-35_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %c-36_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.urem %0, %arg2 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %c-21_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %c36_i64, %0 : i64
    %2 = llvm.ashr %1, %c42_i64 : i64
    %3 = llvm.sdiv %arg1, %1 : i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-49_i8 = arith.constant -49 : i8
    return %c-49_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c23_i8 = arith.constant 23 : i8
    return %c23_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c47_i64 = arith.constant 47 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.lshr %2, %c47_i64 : i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.and %arg0, %c-43_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.and %3, %arg2 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-19_i32 = arith.constant -19 : i32
    return %c-19_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-21_i8 = arith.constant -21 : i8
    return %c-21_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-35_i8 = arith.constant -35 : i8
    return %c-35_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg2, %c-23_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-44_i8 = arith.constant -44 : i8
    return %c-44_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c23_i8 = arith.constant 23 : i8
    return %c23_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.urem %arg1, %arg2 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c41_i32 = arith.constant 41 : i32
    return %c41_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-17_i8 = arith.constant -17 : i8
    return %c-17_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c38_i8 = arith.constant 38 : i8
    return %c38_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-20_i8 = arith.constant -20 : i8
    return %c-20_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.and %c-12_i64, %2 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.ashr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c34_i32 = arith.constant 34 : i32
    return %c34_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-32_i8 = arith.constant -32 : i8
    return %c-32_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-11_i32 = arith.constant -11 : i32
    return %c-11_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-21_i8 = arith.constant -21 : i8
    return %c-21_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c20_i64 = arith.constant 20 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.srem %c-23_i64, %arg0 : i64
    %1 = llvm.srem %c30_i64, %arg0 : i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "ult" %c20_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c45_i8 = arith.constant 45 : i8
    return %c45_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-1_i8 = arith.constant -1 : i8
    return %c-1_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %0, %0 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-20_i8 = arith.constant -20 : i8
    return %c-20_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.lshr %2, %1 : i64
    %4 = llvm.udiv %arg2, %c-25_i64 : i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-44_i32 = arith.constant -44 : i32
    return %c-44_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-49_i8 = arith.constant -49 : i8
    return %c-49_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %c-22_i64, %arg0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.ashr %3, %arg1 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %c-3_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %c-42_i64, %1 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.and %4, %arg0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %c-11_i64 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.ashr %arg0, %arg0 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c48_i32 = arith.constant 48 : i32
    return %c48_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c38_i32 = arith.constant 38 : i32
    return %c38_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %true = arith.constant true
    %c47_i64 = arith.constant 47 : i64
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.select %false, %0, %c47_i64 : i1, i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.sdiv %2, %c-19_i64 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c32_i32 = arith.constant 32 : i32
    return %c32_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-40_i32 = arith.constant -40 : i32
    return %c-40_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c7_i32 = arith.constant 7 : i32
    return %c7_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c28_i8 = arith.constant 28 : i8
    return %c28_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-43_i8 = arith.constant -43 : i8
    return %c-43_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c22_i8 = arith.constant 22 : i8
    return %c22_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.udiv %arg0, %c36_i64 : i64
    %1 = llvm.icmp "ne" %c-42_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c26_i32 = arith.constant 26 : i32
    return %c26_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c5_i32 = arith.constant 5 : i32
    return %c5_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c24_i8 = arith.constant 24 : i8
    return %c24_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-47_i32 = arith.constant -47 : i32
    return %c-47_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "ult" %c6_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.lshr %arg1, %arg1 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "uge" %c-18_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "sge" %c31_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %1, %c-19_i64 : i64
    %3 = llvm.icmp "sge" %1, %c49_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.urem %arg0, %c-13_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c8_i8 = arith.constant 8 : i8
    return %c8_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-30_i8 = arith.constant -30 : i8
    return %c-30_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c27_i8 = arith.constant 27 : i8
    return %c27_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c15_i32 = arith.constant 15 : i32
    return %c15_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-11_i8 = arith.constant -11 : i8
    return %c-11_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-48_i8 = arith.constant -48 : i8
    return %c-48_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-7_i32 = arith.constant -7 : i32
    return %c-7_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-33_i8 = arith.constant -33 : i8
    return %c-33_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c14_i8 = arith.constant 14 : i8
    return %c14_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c44_i32 = arith.constant 44 : i32
    return %c44_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ult" %c-17_i64, %c-27_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.urem %c-36_i64, %arg0 : i64
    %4 = llvm.select %2, %3, %3 : i1, i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %c-33_i64, %arg2 : i64
    %4 = llvm.select %arg0, %arg1, %3 : i1, i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-25_i32 = arith.constant -25 : i32
    return %c-25_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c19_i32 = arith.constant 19 : i32
    return %c19_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %arg2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "uge" %c1_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %false = arith.constant false
    %c42_i64 = arith.constant 42 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.lshr %c-5_i64, %c-23_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.srem %c42_i64, %1 : i64
    %3 = llvm.select %false, %0, %c35_i64 : i1, i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "sge" %c-4_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.select %4, %arg1, %arg2 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c25_i32 = arith.constant 25 : i32
    return %c25_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-43_i32 = arith.constant -43 : i32
    return %c-43_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "eq" %arg1, %arg2 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %c2_i64 : i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-25_i32 = arith.constant -25 : i32
    return %c-25_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-23_i8 = arith.constant -23 : i8
    return %c-23_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c2_i8 = arith.constant 2 : i8
    return %c2_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c30_i64, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %c28_i64, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.icmp "ugt" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.srem %c-45_i64, %0 : i64
    %2 = llvm.icmp "ne" %arg2, %0 : i64
    %3 = llvm.select %2, %c-47_i64, %arg2 : i1, i64
    %4 = llvm.and %arg2, %3 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c41_i8 = arith.constant 41 : i8
    return %c41_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.srem %c41_i64, %c-11_i64 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.icmp "ult" %c-12_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c23_i32 = arith.constant 23 : i32
    return %c23_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c16_i8 = arith.constant 16 : i8
    return %c16_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-44_i8 = arith.constant -44 : i8
    return %c-44_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "ne" %c-20_i64, %c40_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %c49_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %1, %arg0 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c10_i8 = arith.constant 10 : i8
    return %c10_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-45_i32 = arith.constant -45 : i32
    return %c-45_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-13_i32 = arith.constant -13 : i32
    return %c-13_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.select %arg0, %arg1, %c-48_i64 : i1, i64
    %1 = llvm.lshr %0, %c-20_i64 : i64
    %2 = llvm.icmp "sgt" %c-42_i64, %c11_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %arg2, %3 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c-42_i64 = arith.constant -42 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.srem %1, %c34_i64 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.or %c-42_i64, %3 : i64
    %5 = llvm.or %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c8_i8 = arith.constant 8 : i8
    return %c8_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c15_i8 = arith.constant 15 : i8
    return %c15_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c12_i32 = arith.constant 12 : i32
    return %c12_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c49_i8 = arith.constant 49 : i8
    return %c49_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.or %arg0, %arg2 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.and %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c14_i8 = arith.constant 14 : i8
    return %c14_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.select %arg1, %arg0, %c38_i64 : i1, i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.or %c-12_i64, %1 : i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c47_i32 = arith.constant 47 : i32
    return %c47_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c42_i32 = arith.constant 42 : i32
    return %c42_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c9_i8 = arith.constant 9 : i8
    return %c9_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.and %c40_i64, %c-1_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.trunc %arg1 : i1 to i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.ashr %c4_i64, %c10_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %0, %arg1 : i64
    %3 = llvm.select %2, %c10_i64, %arg1 : i1, i64
    %4 = llvm.select %1, %3, %arg1 : i1, i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-12_i8 = arith.constant -12 : i8
    return %c-12_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-6_i32 = arith.constant -6 : i32
    return %c-6_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.and %c-39_i64, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.ashr %arg0, %c-17_i64 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.xor %3, %2 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c33_i32 = arith.constant 33 : i32
    return %c33_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c9_i32 = arith.constant 9 : i32
    return %c9_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-39_i32 = arith.constant -39 : i32
    return %c-39_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c13_i8 = arith.constant 13 : i8
    return %c13_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-12_i8 = arith.constant -12 : i8
    return %c-12_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.udiv %arg2, %c41_i64 : i64
    %1 = llvm.xor %arg1, %c-26_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.urem %3, %arg0 : i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.udiv %0, %arg2 : i64
    %4 = llvm.xor %c-8_i64, %3 : i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-17_i8 = arith.constant -17 : i8
    return %c-17_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.select %true, %c-27_i64, %arg2 : i1, i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-26_i32 = arith.constant -26 : i32
    return %c-26_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.select %arg0, %c-16_i64, %c-4_i64 : i1, i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.sdiv %1, %c48_i64 : i64
    %3 = llvm.sdiv %0, %arg1 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "sgt" %4, %c-43_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c9_i32 = arith.constant 9 : i32
    return %c9_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-32_i32 = arith.constant -32 : i32
    return %c-32_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c4_i32 = arith.constant 4 : i32
    return %c4_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-18_i8 = arith.constant -18 : i8
    return %c-18_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-43_i32 = arith.constant -43 : i32
    return %c-43_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.udiv %arg0, %c-32_i64 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-11_i8 = arith.constant -11 : i8
    return %c-11_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c-19_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.icmp "sle" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-12_i8 = arith.constant -12 : i8
    return %c-12_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-15_i8 = arith.constant -15 : i8
    return %c-15_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "sge" %c46_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.select %0, %2, %arg1 : i1, i64
    %4 = llvm.or %2, %arg2 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.urem %c-46_i64, %c4_i64 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-28_i32 = arith.constant -28 : i32
    return %c-28_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-3_i32 = arith.constant -3 : i32
    return %c-3_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-39_i8 = arith.constant -39 : i8
    return %c-39_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.udiv %arg2, %c1_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ugt" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c20_i32 = arith.constant 20 : i32
    return %c20_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.udiv %c-28_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %arg1, %arg2 : i64
    %3 = llvm.select %true, %2, %c22_i64 : i1, i64
    %4 = llvm.sdiv %3, %c33_i64 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.srem %2, %c2_i64 : i64
    %4 = llvm.xor %3, %c24_i64 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c15_i8 = arith.constant 15 : i8
    return %c15_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-17_i64 = arith.constant -17 : i64
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.select %true, %c-17_i64, %arg0 : i1, i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.urem %arg2, %c-28_i64 : i64
    %5 = llvm.select %3, %4, %c12_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-16_i32 = arith.constant -16 : i32
    return %c-16_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.sdiv %c-19_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %0, %0 : i64
    %3 = llvm.icmp "sge" %arg2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c27_i32 = arith.constant 27 : i32
    return %c27_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c44_i32 = arith.constant 44 : i32
    return %c44_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-13_i8 = arith.constant -13 : i8
    return %c-13_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-24_i8 = arith.constant -24 : i8
    return %c-24_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-43_i8 = arith.constant -43 : i8
    return %c-43_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %arg2 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.and %c-34_i64, %c-41_i64 : i64
    %5 = llvm.srem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.urem %c28_i64, %2 : i64
    %4 = llvm.srem %3, %arg2 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-36_i8 = arith.constant -36 : i8
    return %c-36_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.and %c19_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "ne" %arg0, %c-17_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c35_i8 = arith.constant 35 : i8
    return %c35_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-15_i8 = arith.constant -15 : i8
    return %c-15_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-23_i8 = arith.constant -23 : i8
    return %c-23_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c11_i8 = arith.constant 11 : i8
    return %c11_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ne" %4, %c-25_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %arg1, %c41_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %c36_i64, %c10_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-31_i8 = arith.constant -31 : i8
    return %c-31_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %c35_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.sdiv %c47_i64, %arg0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "sge" %c-31_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %c-22_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-46_i8 = arith.constant -46 : i8
    return %c-46_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c17_i8 = arith.constant 17 : i8
    return %c17_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.select %true, %arg0, %1 : i1, i64
    %3 = llvm.icmp "uge" %1, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c35_i32 = arith.constant 35 : i32
    return %c35_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-24_i32 = arith.constant -24 : i32
    return %c-24_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c7_i8 = arith.constant 7 : i8
    return %c7_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-5_i8 = arith.constant -5 : i8
    return %c-5_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c19_i8 = arith.constant 19 : i8
    return %c19_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-32_i32 = arith.constant -32 : i32
    return %c-32_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-3_i8 = arith.constant -3 : i8
    return %c-3_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c24_i32 = arith.constant 24 : i32
    return %c24_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c38_i8 = arith.constant 38 : i8
    return %c38_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-40_i32 = arith.constant -40 : i32
    return %c-40_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.urem %c-47_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.sdiv %2, %c36_i64 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-41_i8 = arith.constant -41 : i8
    return %c-41_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-32_i32 = arith.constant -32 : i32
    return %c-32_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-49_i8 = arith.constant -49 : i8
    return %c-49_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c8_i32 = arith.constant 8 : i32
    return %c8_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c13_i8 = arith.constant 13 : i8
    return %c13_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-26_i32 = arith.constant -26 : i32
    return %c-26_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-48_i64 = arith.constant -48 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.sdiv %c-29_i64, %c43_i64 : i64
    %1 = llvm.srem %c-48_i64, %0 : i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.icmp "uge" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c11_i8 = arith.constant 11 : i8
    return %c11_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-43_i32 = arith.constant -43 : i32
    return %c-43_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c44_i8 = arith.constant 44 : i8
    return %c44_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c5_i8 = arith.constant 5 : i8
    return %c5_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c5_i8 = arith.constant 5 : i8
    return %c5_i8 : i8
  }
}
// -----
