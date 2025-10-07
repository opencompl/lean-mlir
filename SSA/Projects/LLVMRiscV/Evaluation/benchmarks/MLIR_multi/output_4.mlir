module {
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.and %c27_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %c-45_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %c11_i64, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "ule" %arg1, %c4_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "sge" %c-17_i64, %2 : i64
    return %3 : i1
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
    %c27_i8 = arith.constant 27 : i8
    return %c27_i8 : i8
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
    %c21_i8 = arith.constant 21 : i8
    return %c21_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "sle" %arg0, %c10_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
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
    %c26_i32 = arith.constant 26 : i32
    return %c26_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "ule" %c37_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
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
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.ashr %c-16_i64, %c-31_i64 : i64
    %1 = llvm.ashr %c11_i64, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
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
    %c35_i32 = arith.constant 35 : i32
    return %c35_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c44_i64 = arith.constant 44 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.or %c36_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.xor %c44_i64, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
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
  func.func @main(%arg0: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
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
    %c38_i8 = arith.constant 38 : i8
    return %c38_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c17_i64 = arith.constant 17 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sdiv %c17_i64, %c33_i64 : i64
    %1 = llvm.ashr %c-48_i64, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ult" %2, %c-34_i64 : i64
    return %3 : i1
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
  func.func @main() -> i8 {
    %c15_i8 = arith.constant 15 : i8
    return %c15_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.ashr %arg0, %c-17_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
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
    %c12_i8 = arith.constant 12 : i8
    return %c12_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %c16_i64, %c-7_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
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
    %c-10_i32 = arith.constant -10 : i32
    return %c-10_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %c24_i64, %0 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.xor %2, %0 : i64
    return %3 : i64
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
    %c15_i64 = arith.constant 15 : i64
    %true = arith.constant true
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.select %true, %arg0, %c-7_i64 : i1, i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.lshr %2, %c15_i64 : i64
    return %3 : i64
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
    %c-35_i32 = arith.constant -35 : i32
    return %c-35_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %true = arith.constant true
    %c10_i64 = arith.constant 10 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.xor %c10_i64, %c-1_i64 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.select %true, %c36_i64, %1 : i1, i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ugt" %c48_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %c37_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.ashr %c-24_i64, %c-14_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %c16_i64, %2 : i64
    return %3 : i1
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
    %c-40_i32 = arith.constant -40 : i32
    return %c-40_i32 : i32
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
    %c27_i32 = arith.constant 27 : i32
    return %c27_i32 : i32
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
    %c45_i32 = arith.constant 45 : i32
    return %c45_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c17_i32 = arith.constant 17 : i32
    return %c17_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %2, %c30_i64 : i64
    return %3 : i64
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.urem %arg1, %c23_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %c15_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c29_i8 = arith.constant 29 : i8
    return %c29_i8 : i8
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
  func.func @main() -> i8 {
    %c-39_i8 = arith.constant -39 : i8
    return %c-39_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "uge" %c-19_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
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
    %c44_i8 = arith.constant 44 : i8
    return %c44_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.ashr %arg1, %c2_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
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
  func.func @main() -> i8 {
    %c-38_i8 = arith.constant -38 : i8
    return %c-38_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %arg1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
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
  func.func @main() -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.urem %c-5_i64, %c-12_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg2 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
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
    %c47_i32 = arith.constant 47 : i32
    return %c47_i32 : i32
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
    %c16_i32 = arith.constant 16 : i32
    return %c16_i32 : i32
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
    %c43_i64 = arith.constant 43 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.and %c5_i64, %c-49_i64 : i64
    %1 = llvm.sdiv %c-13_i64, %0 : i64
    %2 = llvm.udiv %arg0, %c43_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
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
  func.func @main() -> i8 {
    %c-10_i8 = arith.constant -10 : i8
    return %c-10_i8 : i8
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
    %c48_i8 = arith.constant 48 : i8
    return %c48_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "eq" %arg0, %c-2_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %arg0, %arg1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-38_i8 = arith.constant -38 : i8
    return %c-38_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.xor %c48_i64, %1 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.icmp "sgt" %c32_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
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
  func.func @main() -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.and %c-9_i64, %c-25_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.and %c-40_i64, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
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
  func.func @main() -> i32 {
    %c14_i32 = arith.constant 14 : i32
    return %c14_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.urem %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.udiv %c27_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %c-27_i64 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c1_i32 = arith.constant 1 : i32
    return %c1_i32 : i32
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
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %c-31_i64, %c43_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.select %true, %c-34_i64, %0 : i1, i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %arg1 : i1, i64
    %3 = llvm.icmp "eq" %c-1_i64, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.or %c-7_i64, %1 : i64
    %3 = llvm.or %2, %c-18_i64 : i64
    return %3 : i64
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
    %c-42_i8 = arith.constant -42 : i8
    return %c-42_i8 : i8
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
    %c-13_i32 = arith.constant -13 : i32
    return %c-13_i32 : i32
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
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %false = arith.constant false
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.select %false, %c33_i64, %arg0 : i1, i64
    %1 = llvm.icmp "ule" %c47_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
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
    %c39_i32 = arith.constant 39 : i32
    return %c39_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "ugt" %arg0, %c49_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %c12_i64 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %false = arith.constant false
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg1, %arg1 : i64
    %2 = llvm.select %false, %1, %c-49_i64 : i1, i64
    %3 = llvm.select %0, %2, %arg1 : i1, i64
    return %3 : i64
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
  func.func @main() -> i8 {
    %c39_i8 = arith.constant 39 : i8
    return %c39_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-38_i32 = arith.constant -38 : i32
    return %c-38_i32 : i32
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
    %c43_i64 = arith.constant 43 : i64
    %c34_i64 = arith.constant 34 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.urem %arg0, %c30_i64 : i64
    %1 = llvm.icmp "sge" %c34_i64, %c43_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
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
    %c-30_i8 = arith.constant -30 : i8
    return %c-30_i8 : i8
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
  func.func @main() -> i32 {
    %c12_i32 = arith.constant 12 : i32
    return %c12_i32 : i32
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
  func.func @main() -> i8 {
    %c-44_i8 = arith.constant -44 : i8
    return %c-44_i8 : i8
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
  func.func @main() -> i8 {
    %c30_i8 = arith.constant 30 : i8
    return %c30_i8 : i8
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
    %c-6_i8 = arith.constant -6 : i8
    return %c-6_i8 : i8
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
    %c-17_i32 = arith.constant -17 : i32
    return %c-17_i32 : i32
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
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.or %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.and %c-45_i64, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
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
    %c-28_i32 = arith.constant -28 : i32
    return %c-28_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-38_i32 = arith.constant -38 : i32
    return %c-38_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-38_i32 = arith.constant -38 : i32
    return %c-38_i32 : i32
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
  func.func @main(%arg0: i1) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %c-45_i64, %2 : i64
    return %3 : i1
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
    %c38_i32 = arith.constant 38 : i32
    return %c38_i32 : i32
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
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.and %arg0, %c33_i64 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
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
    %c-30_i64 = arith.constant -30 : i64
    %c38_i64 = arith.constant 38 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ugt" %c38_i64, %c-6_i64 : i64
    %1 = llvm.select %0, %arg0, %c-30_i64 : i1, i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %false = arith.constant false
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.srem %arg0, %c48_i64 : i64
    %1 = llvm.select %false, %arg1, %c5_i64 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.and %c-29_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
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
    %c11_i32 = arith.constant 11 : i32
    return %c11_i32 : i32
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
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %c-43_i64, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.or %2, %1 : i64
    return %3 : i64
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
    %c-8_i64 = arith.constant -8 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %c18_i64, %c-8_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
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
    %c36_i8 = arith.constant 36 : i8
    return %c36_i8 : i8
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
    %c9_i64 = arith.constant 9 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.and %c-42_i64, %c-44_i64 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %c9_i64, %2 : i64
    return %3 : i64
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.srem %c-39_i64, %c-36_i64 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ne" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "eq" %2, %arg2 : i64
    return %3 : i1
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
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %0, %c-47_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.and %arg0, %c-12_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.select %arg2, %arg0, %0 : i1, i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
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
  func.func @main() -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-27_i64 = arith.constant -27 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ugt" %0, %c-16_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %c-27_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-14_i32 = arith.constant -14 : i32
    return %c-14_i32 : i32
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
  func.func @main() -> i32 {
    %c-7_i32 = arith.constant -7 : i32
    return %c-7_i32 : i32
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
    %c-39_i8 = arith.constant -39 : i8
    return %c-39_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-7_i8 = arith.constant -7 : i8
    return %c-7_i8 : i8
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
  func.func @main() -> i32 {
    %c6_i32 = arith.constant 6 : i32
    return %c6_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    return %3 : i1
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
  func.func @main() -> i8 {
    %c-28_i8 = arith.constant -28 : i8
    return %c-28_i8 : i8
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
    %c30_i32 = arith.constant 30 : i32
    return %c30_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.srem %c-18_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %arg1 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %c8_i64, %0 : i64
    %2 = llvm.lshr %arg1, %c3_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %arg2, %c47_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.lshr %c-38_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %c-41_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.udiv %c-44_i64, %arg1 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %2 : i64
    return %3 : i1
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
    %c2_i8 = arith.constant 2 : i8
    return %c2_i8 : i8
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
  func.func @main() -> i8 {
    %c-13_i8 = arith.constant -13 : i8
    return %c-13_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %false = arith.constant false
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.select %false, %arg1, %c-5_i64 : i1, i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %c19_i64 : i64
    return %3 : i1
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
    %c32_i64 = arith.constant 32 : i64
    %c25_i64 = arith.constant 25 : i64
    %c28_i64 = arith.constant 28 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.srem %c28_i64, %c46_i64 : i64
    %1 = llvm.xor %c25_i64, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.urem %c32_i64, %2 : i64
    return %3 : i64
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
  func.func @main() -> i8 {
    %c-41_i8 = arith.constant -41 : i8
    return %c-41_i8 : i8
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.or %1, %c18_i64 : i64
    %3 = llvm.ashr %2, %1 : i64
    return %3 : i64
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
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %2, %c-27_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
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
    %c-37_i64 = arith.constant -37 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "ne" %c-37_i64, %c11_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.lshr %c36_i64, %0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %c-34_i64, %0 : i64
    %2 = llvm.ashr %1, %c6_i64 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    return %3 : i64
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
  func.func @main() -> i32 {
    %c32_i32 = arith.constant 32 : i32
    return %c32_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.urem %c-25_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ule" %c14_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
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
    %c3_i8 = arith.constant 3 : i8
    return %c3_i8 : i8
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
    %c-23_i32 = arith.constant -23 : i32
    return %c-23_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.udiv %c14_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg2, %0 : i1, i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.srem %arg0, %c49_i64 : i64
    %1 = llvm.icmp "sge" %arg1, %arg1 : i64
    %2 = llvm.select %1, %arg1, %arg0 : i1, i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.ashr %arg0, %c0_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
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
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "ult" %c47_i64, %c-17_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %arg0 : i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-38_i32 = arith.constant -38 : i32
    return %c-38_i32 : i32
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
    %c45_i64 = arith.constant 45 : i64
    %c25_i64 = arith.constant 25 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "slt" %c25_i64, %c31_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %c45_i64, %1 : i1, i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.or %arg0, %c-4_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    return %3 : i64
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
    %c47_i32 = arith.constant 47 : i32
    return %c47_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %c44_i64, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
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
    %c-8_i8 = arith.constant -8 : i8
    return %c-8_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
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
    %c49_i32 = arith.constant 49 : i32
    return %c49_i32 : i32
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
  func.func @main(%arg0: i1) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.and %c-45_i64, %c-22_i64 : i64
    %1 = llvm.urem %c32_i64, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
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
  func.func @main() -> i8 {
    %c-18_i8 = arith.constant -18 : i8
    return %c-18_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.lshr %c27_i64, %c22_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    return %3 : i64
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
    %c6_i32 = arith.constant 6 : i32
    return %c6_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.ashr %c4_i64, %arg0 : i64
    %1 = llvm.and %arg2, %c43_i64 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg1, %c32_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
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
  func.func @main() -> i32 {
    %c4_i32 = arith.constant 4 : i32
    return %c4_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.xor %c-30_i64, %c-36_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.sdiv %2, %2 : i64
    return %3 : i64
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
    %c38_i32 = arith.constant 38 : i32
    return %c38_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "ule" %arg0, %c-31_i64 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.and %c27_i64, %1 : i64
    %3 = llvm.icmp "ule" %c44_i64, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c44_i64 = arith.constant 44 : i64
    %false = arith.constant false
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.select %false, %0, %c-13_i64 : i1, i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.srem %c44_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.urem %0, %arg0 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %arg1 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %c-24_i64, %c-44_i64 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.and %arg2, %c-23_i64 : i64
    %1 = llvm.select %arg1, %c39_i64, %0 : i1, i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "eq" %2, %arg2 : i64
    return %3 : i1
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
    %c-27_i8 = arith.constant -27 : i8
    return %c-27_i8 : i8
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
    %c19_i8 = arith.constant 19 : i8
    return %c19_i8 : i8
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
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
  func.func @main() -> i32 {
    %c50_i32 = arith.constant 50 : i32
    return %c50_i32 : i32
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
    %c34_i32 = arith.constant 34 : i32
    return %c34_i32 : i32
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
  func.func @main() -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c46_i64 = arith.constant 46 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.ashr %c46_i64, %c11_i64 : i64
    %1 = llvm.icmp "sgt" %0, %c-33_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.udiv %c-41_i64, %c13_i64 : i64
    %1 = llvm.icmp "eq" %c25_i64, %arg0 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "ule" %c-45_i64, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c43_i32 = arith.constant 43 : i32
    return %c43_i32 : i32
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
  func.func @main() -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.ashr %c29_i64, %c-27_i64 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
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
    %c-28_i32 = arith.constant -28 : i32
    return %c-28_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.ashr %c-31_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
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
  func.func @main() -> i32 {
    %c4_i32 = arith.constant 4 : i32
    return %c4_i32 : i32
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
    %c24_i8 = arith.constant 24 : i8
    return %c24_i8 : i8
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
  func.func @main() -> i8 {
    %c44_i8 = arith.constant 44 : i8
    return %c44_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.xor %arg0, %c6_i64 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
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
    %c46_i64 = arith.constant 46 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.ashr %arg0, %c40_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.sdiv %c46_i64, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
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
    %c49_i8 = arith.constant 49 : i8
    return %c49_i8 : i8
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
  func.func @main() -> i8 {
    %c8_i8 = arith.constant 8 : i8
    return %c8_i8 : i8
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
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
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "ugt" %c-25_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.and %c-49_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %c17_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    return %3 : i1
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
    %c-42_i8 = arith.constant -42 : i8
    return %c-42_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c50_i64 = arith.constant 50 : i64
    %c32_i64 = arith.constant 32 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.ashr %c32_i64, %c42_i64 : i64
    %1 = llvm.sdiv %c50_i64, %0 : i64
    %2 = llvm.or %c-48_i64, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
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
  func.func @main() -> i8 {
    %c16_i8 = arith.constant 16 : i8
    return %c16_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
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
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.ashr %arg1, %c50_i64 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %2, %arg1 : i64
    return %3 : i64
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.udiv %c-36_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.srem %1, %c26_i64 : i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.ashr %c34_i64, %arg0 : i64
    %1 = llvm.srem %c24_i64, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
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
  func.func @main() -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.lshr %c32_i64, %1 : i64
    %3 = llvm.icmp "sge" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.udiv %arg0, %c-16_i64 : i64
    %1 = llvm.icmp "slt" %c45_i64, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.select %1, %c26_i64, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.lshr %c6_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sle" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.srem %arg0, %c26_i64 : i64
    %1 = llvm.icmp "ugt" %c-8_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    return %3 : i1
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
    %c-15_i8 = arith.constant -15 : i8
    return %c-15_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "eq" %arg0, %c16_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %arg2, %arg1 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.and %c47_i64, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    return %3 : i64
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %true = arith.constant true
    %c-9_i64 = arith.constant -9 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.select %true, %c-9_i64, %c-7_i64 : i1, i64
    %1 = llvm.icmp "ule" %c34_i64, %0 : i64
    %2 = llvm.select %1, %arg0, %arg1 : i1, i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %c-30_i64, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-10_i32 = arith.constant -10 : i32
    return %c-10_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.and %c44_i64, %c-14_i64 : i64
    %1 = llvm.udiv %0, %c48_i64 : i64
    %2 = llvm.trunc %arg0 : i1 to i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.or %0, %c3_i64 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c7_i64 = arith.constant 7 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.sdiv %c7_i64, %c36_i64 : i64
    %1 = llvm.or %c-10_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.udiv %c23_i64, %arg0 : i64
    %1 = llvm.sdiv %c5_i64, %arg0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "slt" %c-18_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    return %3 : i64
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
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.select %1, %c-6_i64, %arg2 : i1, i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sdiv %c20_i64, %0 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c28_i64 = arith.constant 28 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.xor %arg0, %c3_i64 : i64
    %1 = llvm.lshr %c-27_i64, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ule" %c28_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "slt" %c-35_i64, %c46_i64 : i64
    %1 = llvm.xor %arg0, %c13_i64 : i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.icmp "sge" %c-10_i64, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.lshr %c42_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %2, %arg2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.xor %c-50_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %c21_i64 : i64
    return %3 : i1
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
  func.func @main() -> i32 {
    %c-30_i32 = arith.constant -30 : i32
    return %c-30_i32 : i32
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
    %c8_i64 = arith.constant 8 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.ashr %c18_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %c8_i64, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "eq" %c-21_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.or %arg2, %c48_i64 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.udiv %c-35_i64, %c-31_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "ugt" %c-9_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.icmp "sgt" %c38_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
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
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %c32_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ugt" %arg0, %c48_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %c-9_i64 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
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
    %c18_i32 = arith.constant 18 : i32
    return %c18_i32 : i32
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
    %c-29_i8 = arith.constant -29 : i8
    return %c-29_i8 : i8
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
  func.func @main() -> i32 {
    %c-40_i32 = arith.constant -40 : i32
    return %c-40_i32 : i32
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
  func.func @main() -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.sdiv %arg0, %c11_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    return %3 : i1
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
  func.func @main() -> i8 {
    %c-42_i8 = arith.constant -42 : i8
    return %c-42_i8 : i8
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
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %c-20_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    return %3 : i64
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.srem %1, %c30_i64 : i64
    %3 = llvm.icmp "ne" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "slt" %2, %c-18_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c10_i32 = arith.constant 10 : i32
    return %c10_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %arg1, %c30_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ugt" %arg0, %c-40_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg0, %arg1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
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
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %arg0, %c22_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.lshr %c48_i64, %arg0 : i64
    %1 = llvm.and %0, %c-24_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ne" %c-32_i64, %2 : i64
    return %3 : i1
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
    %c5_i32 = arith.constant 5 : i32
    return %c5_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
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
  func.func @main() -> i8 {
    %c-27_i8 = arith.constant -27 : i8
    return %c-27_i8 : i8
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
  func.func @main(%arg0: i1) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c14_i64 = arith.constant 14 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %c14_i64, %c50_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.lshr %c41_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c43_i32 = arith.constant 43 : i32
    return %c43_i32 : i32
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
    %c25_i8 = arith.constant 25 : i8
    return %c25_i8 : i8
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
  func.func @main() -> i8 {
    %c43_i8 = arith.constant 43 : i8
    return %c43_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %c-30_i64, %2 : i64
    return %3 : i1
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
    %c24_i32 = arith.constant 24 : i32
    return %c24_i32 : i32
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
    %c-12_i64 = arith.constant -12 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.lshr %c24_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %arg1, %arg1 : i64
    %2 = llvm.select %1, %arg0, %c-12_i64 : i1, i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
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
    %c29_i8 = arith.constant 29 : i8
    return %c29_i8 : i8
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
  func.func @main() -> i32 {
    %c15_i32 = arith.constant 15 : i32
    return %c15_i32 : i32
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
    %c28_i32 = arith.constant 28 : i32
    return %c28_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.urem %c-27_i64, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
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
    %c18_i8 = arith.constant 18 : i8
    return %c18_i8 : i8
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
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "slt" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %c27_i64 : i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
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
    %c-21_i8 = arith.constant -21 : i8
    return %c-21_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-10_i32 = arith.constant -10 : i32
    return %c-10_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-15_i32 = arith.constant -15 : i32
    return %c-15_i32 : i32
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
  func.func @main() -> i32 {
    %c-20_i32 = arith.constant -20 : i32
    return %c-20_i32 : i32
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
    %c-44_i32 = arith.constant -44 : i32
    return %c-44_i32 : i32
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
  func.func @main() -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c7_i64 = arith.constant 7 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %c7_i64, %c10_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "ule" %c31_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg1, %arg2 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
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
    %c-39_i8 = arith.constant -39 : i8
    return %c-39_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.srem %arg0, %c13_i64 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.select %1, %c-13_i64, %0 : i1, i64
    %3 = llvm.icmp "ugt" %2, %arg1 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.ashr %c41_i64, %arg0 : i64
    %1 = llvm.ashr %c-6_i64, %0 : i64
    %2 = llvm.and %arg0, %0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
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
    %c-48_i32 = arith.constant -48 : i32
    return %c-48_i32 : i32
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
    %c-25_i32 = arith.constant -25 : i32
    return %c-25_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c14_i64 = arith.constant 14 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "sgt" %c46_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %c-35_i64 : i64
    %3 = llvm.icmp "ule" %c14_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c3_i64 = arith.constant 3 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.and %c3_i64, %c39_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.urem %c-50_i64, %1 : i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    return %3 : i1
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
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
  func.func @main() -> i32 {
    %c16_i32 = arith.constant 16 : i32
    return %c16_i32 : i32
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
    %c-23_i64 = arith.constant -23 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %0, %c-2_i64 : i64
    %2 = llvm.or %c-23_i64, %1 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c2_i32 = arith.constant 2 : i32
    return %c2_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "ule" %2, %2 : i64
    return %3 : i1
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
  func.func @main() -> i32 {
    %c3_i32 = arith.constant 3 : i32
    return %c3_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.or %c36_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %c-16_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.lshr %c6_i64, %c-35_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
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
    %c39_i8 = arith.constant 39 : i8
    return %c39_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
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
    %c-14_i8 = arith.constant -14 : i8
    return %c-14_i8 : i8
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
  func.func @main(%arg0: i1) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %c-36_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ne" %2, %c-30_i64 : i64
    return %3 : i1
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
    %c-34_i32 = arith.constant -34 : i32
    return %c-34_i32 : i32
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
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "eq" %c45_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.lshr %arg0, %c-39_i64 : i64
    %1 = llvm.lshr %0, %c-29_i64 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-50_i32 = arith.constant -50 : i32
    return %c-50_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.urem %c26_i64, %c25_i64 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
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
    %c-30_i64 = arith.constant -30 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %c49_i64, %c-30_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    %3 = llvm.icmp "sge" %c-13_i64, %2 : i64
    return %3 : i1
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
    %c8_i32 = arith.constant 8 : i32
    return %c8_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %c-34_i64, %0 : i64
    %2 = llvm.select %1, %arg0, %c10_i64 : i1, i64
    %3 = llvm.icmp "ne" %2, %c-50_i64 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.or %c-19_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c47_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.sdiv %c-12_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    return %3 : i1
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
    %c-25_i64 = arith.constant -25 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.ashr %c-25_i64, %c-21_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "sgt" %arg0, %c-46_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.xor %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %arg2 : i64
    %2 = llvm.select %1, %c-26_i64, %arg2 : i1, i64
    %3 = llvm.icmp "ugt" %c36_i64, %2 : i64
    return %3 : i1
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
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %arg2, %c-27_i64 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
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
    %0 = llvm.icmp "slt" %arg1, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.or %c-27_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
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
    %c49_i32 = arith.constant 49 : i32
    return %c49_i32 : i32
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
    %c-33_i32 = arith.constant -33 : i32
    return %c-33_i32 : i32
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
    %c13_i64 = arith.constant 13 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.xor %c13_i64, %c-37_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %c-4_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %c46_i64, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
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
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.ashr %arg0, %c-32_i64 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.urem %c-45_i64, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c43_i32 = arith.constant 43 : i32
    return %c43_i32 : i32
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
  func.func @main() -> i8 {
    %c-18_i8 = arith.constant -18 : i8
    return %c-18_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.udiv %c16_i64, %arg0 : i64
    %1 = llvm.srem %c15_i64, %0 : i64
    %2 = llvm.urem %c15_i64, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c35_i64 = arith.constant 35 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.srem %c7_i64, %c-13_i64 : i64
    %1 = llvm.or %0, %c35_i64 : i64
    %2 = llvm.ashr %1, %c-6_i64 : i64
    %3 = llvm.icmp "sge" %2, %arg0 : i64
    return %3 : i1
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
    %c49_i64 = arith.constant 49 : i64
    %c20_i64 = arith.constant 20 : i64
    %c4_i64 = arith.constant 4 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.lshr %c4_i64, %c23_i64 : i64
    %1 = llvm.icmp "ugt" %c20_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ult" %c49_i64, %2 : i64
    return %3 : i1
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
    %c10_i8 = arith.constant 10 : i8
    return %c10_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.ashr %arg0, %c5_i64 : i64
    %1 = llvm.select %false, %arg1, %arg0 : i1, i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
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
    %c21_i32 = arith.constant 21 : i32
    return %c21_i32 : i32
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
  func.func @main() -> i8 {
    %c37_i8 = arith.constant 37 : i8
    return %c37_i8 : i8
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.urem %c-29_i64, %arg0 : i64
    %1 = llvm.srem %c-8_i64, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "eq" %2, %arg1 : i64
    return %3 : i1
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
    %false = arith.constant false
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.select %false, %c28_i64, %arg2 : i1, i64
    %1 = llvm.icmp "ule" %arg1, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ne" %c50_i64, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %1, %c39_i64 : i1, i64
    %3 = llvm.udiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "eq" %c-15_i64, %c15_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.sdiv %c-46_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %c-14_i64 : i64
    %2 = llvm.select %arg1, %0, %c42_i64 : i1, i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.urem %arg0, %c46_i64 : i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %2, %c-46_i64 : i64
    return %3 : i64
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
    %c31_i32 = arith.constant 31 : i32
    return %c31_i32 : i32
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
    %c-37_i64 = arith.constant -37 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "ne" %arg0, %c-45_i64 : i64
    %1 = llvm.select %0, %c-40_i64, %c-37_i64 : i1, i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.urem %c7_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg1 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
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
  func.func @main(%arg0: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "uge" %c-28_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %c14_i64, %c-37_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.lshr %c-45_i64, %arg0 : i64
    %1 = llvm.ashr %c-44_i64, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "eq" %c-8_i64, %2 : i64
    return %3 : i1
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
    %c50_i8 = arith.constant 50 : i8
    return %c50_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.xor %c3_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-46_i32 = arith.constant -46 : i32
    return %c-46_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.or %arg0, %c22_i64 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %c-10_i64 = arith.constant -10 : i64
    %c37_i64 = arith.constant 37 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.udiv %c37_i64, %c1_i64 : i64
    %1 = llvm.and %c-10_i64, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-38_i32 = arith.constant -38 : i32
    return %c-38_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
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
  func.func @main() -> i32 {
    %c28_i32 = arith.constant 28 : i32
    return %c28_i32 : i32
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
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.urem %1, %c-43_i64 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i1) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.urem %c-15_i64, %c22_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ne" %2, %c29_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c-42_i64 = arith.constant -42 : i64
    %true = arith.constant true
    %c32_i64 = arith.constant 32 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.select %true, %c32_i64, %c-34_i64 : i1, i64
    %1 = llvm.select %false, %c-42_i64, %0 : i1, i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    return %3 : i1
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
  func.func @main() -> i8 {
    %c-47_i8 = arith.constant -47 : i8
    return %c-47_i8 : i8
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
  func.func @main() -> i8 {
    %c39_i8 = arith.constant 39 : i8
    return %c39_i8 : i8
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
    %c40_i8 = arith.constant 40 : i8
    return %c40_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %c-5_i64, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.xor %arg0, %c-10_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
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
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.sdiv %arg0, %c39_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.udiv %c9_i64, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c10_i32 = arith.constant 10 : i32
    return %c10_i32 : i32
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
    %c39_i32 = arith.constant 39 : i32
    return %c39_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.xor %0, %c21_i64 : i64
    %2 = llvm.icmp "ule" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %arg1 : i1, i64
    %3 = llvm.icmp "ugt" %c-32_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.ashr %arg0, %c-26_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
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
    %c-8_i8 = arith.constant -8 : i8
    return %c-8_i8 : i8
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
    %c12_i8 = arith.constant 12 : i8
    return %c12_i8 : i8
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
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c-40_i64, %arg1 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
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
    %c-21_i64 = arith.constant -21 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %c-29_i64, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "ule" %2, %c-21_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.ashr %c16_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c45_i64 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
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
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c20_i64 = arith.constant 20 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.srem %c-15_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %c20_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %c29_i64, %2 : i64
    return %3 : i64
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.xor %c-24_i64, %c1_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
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
  func.func @main() -> i32 {
    %c-37_i32 = arith.constant -37 : i32
    return %c-37_i32 : i32
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
  func.func @main(%arg0: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "ult" %c-1_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
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
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.select %true, %arg0, %arg2 : i1, i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    return %3 : i64
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
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.ashr %arg1, %c-8_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.urem %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-47_i8 = arith.constant -47 : i8
    return %c-47_i8 : i8
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
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.urem %c5_i64, %arg0 : i64
    %1 = llvm.ashr %0, %c1_i64 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    return %3 : i64
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
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.xor %arg2, %arg2 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.or %arg1, %c13_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %c-45_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
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
    %c-21_i32 = arith.constant -21 : i32
    return %c-21_i32 : i32
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
    %c-40_i32 = arith.constant -40 : i32
    return %c-40_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %arg0, %c45_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    return %3 : i64
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
    %c-46_i64 = arith.constant -46 : i64
    %c29_i64 = arith.constant 29 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.xor %c33_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c29_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %c-46_i64, %2 : i64
    return %3 : i1
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
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    return %3 : i64
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
  func.func @main() -> i8 {
    %c-31_i8 = arith.constant -31 : i8
    return %c-31_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.urem %c-43_i64, %c19_i64 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.and %c-15_i64, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    return %3 : i64
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
    %c-7_i8 = arith.constant -7 : i8
    return %c-7_i8 : i8
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
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    return %3 : i1
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
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
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
    %c-32_i8 = arith.constant -32 : i8
    return %c-32_i8 : i8
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
  func.func @main() -> i32 {
    %c15_i32 = arith.constant 15 : i32
    return %c15_i32 : i32
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
    %c6_i8 = arith.constant 6 : i8
    return %c6_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.and %c34_i64, %c-19_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.udiv %0, %arg0 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
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
    %c8_i32 = arith.constant 8 : i32
    return %c8_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %c28_i64, %0 : i64
    %2 = llvm.xor %c-45_i64, %1 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    return %3 : i64
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
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
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c20_i64 = arith.constant 20 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.xor %c20_i64, %c7_i64 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c34_i64, %2 : i64
    return %3 : i1
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
    %c50_i32 = arith.constant 50 : i32
    return %c50_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %c42_i64, %0 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
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
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %c-5_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
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
    %c-46_i64 = arith.constant -46 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.select %0, %c18_i64, %c-46_i64 : i1, i64
    %2 = llvm.udiv %arg0, %arg2 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
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
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.sdiv %c-20_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %true = arith.constant true
    %c-49_i64 = arith.constant -49 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.select %true, %c-49_i64, %c11_i64 : i1, i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.srem %c-42_i64, %1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
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
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.and %1, %c41_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
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
  func.func @main() -> i32 {
    %c-23_i32 = arith.constant -23 : i32
    return %c-23_i32 : i32
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
    %c4_i8 = arith.constant 4 : i8
    return %c4_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-27_i32 = arith.constant -27 : i32
    return %c-27_i32 : i32
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
    %c43_i64 = arith.constant 43 : i64
    %c9_i64 = arith.constant 9 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.srem %c37_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.lshr %c9_i64, %1 : i64
    %3 = llvm.icmp "ugt" %c43_i64, %2 : i64
    return %3 : i1
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
    %c-47_i8 = arith.constant -47 : i8
    return %c-47_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c10_i32 = arith.constant 10 : i32
    return %c10_i32 : i32
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
    %c-41_i64 = arith.constant -41 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %arg0, %c23_i64, %0 : i1, i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "slt" %c-41_i64, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.udiv %arg1, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
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
    %c6_i32 = arith.constant 6 : i32
    return %c6_i32 : i32
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
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %arg1, %arg2 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %c10_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
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
    %c-19_i8 = arith.constant -19 : i8
    return %c-19_i8 : i8
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
    %c-19_i8 = arith.constant -19 : i8
    return %c-19_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.srem %arg0, %c45_i64 : i64
    %1 = llvm.or %arg2, %c36_i64 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.lshr %arg0, %c-15_i64 : i64
    %1 = llvm.ashr %0, %c26_i64 : i64
    %2 = llvm.and %arg1, %arg0 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
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
    %c-9_i32 = arith.constant -9 : i32
    return %c-9_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.select %1, %c10_i64, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.or %c-17_i64, %arg0 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %arg0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
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
    %c-26_i8 = arith.constant -26 : i8
    return %c-26_i8 : i8
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
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c10_i32 = arith.constant 10 : i32
    return %c10_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.select %false, %arg0, %c37_i64 : i1, i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
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
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.urem %c25_i64, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
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
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.select %1, %arg2, %c-41_i64 : i1, i64
    %3 = llvm.lshr %2, %arg2 : i64
    return %3 : i64
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "sgt" %arg1, %arg1 : i64
    %1 = llvm.srem %arg2, %c2_i64 : i64
    %2 = llvm.select %0, %1, %c-43_i64 : i1, i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %c-8_i64, %arg0 : i64
    %1 = llvm.or %0, %c-16_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %c5_i64 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %arg0, %c35_i64 : i64
    %1 = llvm.and %0, %c-41_i64 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
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
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.lshr %c-50_i64, %arg0 : i64
    %1 = llvm.ashr %c-48_i64, %0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
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
    %c-22_i32 = arith.constant -22 : i32
    return %c-22_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %arg1, %c6_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
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
  func.func @main(%arg0: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.udiv %arg0, %c-1_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ult" %c-49_i64, %2 : i64
    return %3 : i1
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
  func.func @main() -> i8 {
    %c43_i8 = arith.constant 43 : i8
    return %c43_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.udiv %c10_i64, %arg1 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.sdiv %0, %arg2 : i64
    %3 = llvm.select %arg0, %1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c17_i32 = arith.constant 17 : i32
    return %c17_i32 : i32
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
  func.func @main() -> i8 {
    %c-47_i8 = arith.constant -47 : i8
    return %c-47_i8 : i8
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
    %c26_i8 = arith.constant 26 : i8
    return %c26_i8 : i8
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
  func.func @main() -> i32 {
    %c35_i32 = arith.constant 35 : i32
    return %c35_i32 : i32
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
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.udiv %c38_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.and %c-8_i64, %arg0 : i64
    %1 = llvm.srem %c45_i64, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %c-49_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c48_i64 = arith.constant 48 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.ashr %c48_i64, %c42_i64 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %c9_i64, %2 : i64
    return %3 : i64
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
    %c50_i64 = arith.constant 50 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.lshr %arg0, %c-23_i64 : i64
    %1 = llvm.xor %arg0, %c-1_i64 : i64
    %2 = llvm.ashr %1, %c50_i64 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %c22_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %2, %arg2 : i64
    return %3 : i64
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
  func.func @main() -> i32 {
    %c-30_i32 = arith.constant -30 : i32
    return %c-30_i32 : i32
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.xor %c-34_i64, %c-21_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.or %arg0, %arg0 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
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
    %c-11_i8 = arith.constant -11 : i8
    return %c-11_i8 : i8
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
    %c-30_i32 = arith.constant -30 : i32
    return %c-30_i32 : i32
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
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %c39_i64, %1 : i64
    %3 = llvm.ashr %2, %c-49_i64 : i64
    return %3 : i64
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
    %c-31_i64 = arith.constant -31 : i64
    %c48_i64 = arith.constant 48 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.urem %c48_i64, %c16_i64 : i64
    %1 = llvm.and %c-31_i64, %0 : i64
    %2 = llvm.icmp "ult" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.xor %arg0, %c1_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.lshr %arg1, %arg1 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.udiv %arg0, %c-50_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
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
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.icmp "ne" %0, %c-15_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %c31_i64, %arg1 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
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
    %c6_i32 = arith.constant 6 : i32
    return %c6_i32 : i32
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.select %arg0, %c-19_i64, %0 : i1, i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
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
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c47_i64 = arith.constant 47 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "ne" %c47_i64, %c42_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.urem %c-44_i64, %2 : i64
    return %3 : i64
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
    %c48_i32 = arith.constant 48 : i32
    return %c48_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %0 = llvm.select %arg2, %arg0, %arg0 : i1, i64
    %1 = llvm.select %arg1, %0, %0 : i1, i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.srem %2, %1 : i64
    return %3 : i64
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
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.ashr %c49_i64, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-38_i8 = arith.constant -38 : i8
    return %c-38_i8 : i8
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
    %c-3_i64 = arith.constant -3 : i64
    %false = arith.constant false
    %c-26_i64 = arith.constant -26 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "slt" %c-26_i64, %c-17_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %false, %1, %1 : i1, i64
    %3 = llvm.icmp "slt" %c-3_i64, %2 : i64
    return %3 : i1
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
    %c-40_i8 = arith.constant -40 : i8
    return %c-40_i8 : i8
  }
}
// -----
