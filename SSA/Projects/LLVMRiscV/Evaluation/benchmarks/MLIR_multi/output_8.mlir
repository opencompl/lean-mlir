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
    %c-1_i32 = arith.constant -1 : i32
    return %c-1_i32 : i32
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
  func.func @main() -> i8 {
    %c37_i8 = arith.constant 37 : i8
    return %c37_i8 : i8
  }
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
  func.func @main() -> i8 {
    %c0_i8 = arith.constant 0 : i8
    return %c0_i8 : i8
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
    %c-20_i8 = arith.constant -20 : i8
    return %c-20_i8 : i8
  }
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
    %c-37_i64 = arith.constant -37 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %0, %arg2 : i64
    %2 = llvm.select %1, %arg0, %c46_i64 : i1, i64
    %3 = llvm.icmp "sgt" %0, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %c-39_i64, %c-37_i64 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "sge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.srem %c42_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.urem %c-10_i64, %arg0 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    %5 = llvm.icmp "slt" %2, %arg2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.select %1, %4, %6 : i1, i64
    return %7 : i64
  }
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
  func.func @main() -> i32 {
    %c35_i32 = arith.constant 35 : i32
    return %c35_i32 : i32
  }
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "sge" %arg0, %c40_i64 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.select %0, %arg0, %3 : i1, i64
    %5 = llvm.icmp "uge" %arg2, %c21_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "sgt" %c-35_i64, %c38_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.urem %1, %arg0 : i64
    %4 = llvm.select %2, %c40_i64, %3 : i1, i64
    %5 = llvm.or %4, %arg0 : i64
    %6 = llvm.select %arg1, %5, %c-38_i64 : i1, i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c33_i8 = arith.constant 33 : i8
    return %c33_i8 : i8
  }
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
    %c-1_i32 = arith.constant -1 : i32
    return %c-1_i32 : i32
  }
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
  func.func @main() -> i8 {
    %c-16_i8 = arith.constant -16 : i8
    return %c-16_i8 : i8
  }
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
  func.func @main() -> i8 {
    %c-35_i8 = arith.constant -35 : i8
    return %c-35_i8 : i8
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
  func.func @main() -> i8 {
    %c34_i8 = arith.constant 34 : i8
    return %c34_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c48_i64 = arith.constant 48 : i64
    %c10_i64 = arith.constant 10 : i64
    %false = arith.constant false
    %c-49_i64 = arith.constant -49 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.ashr %arg0, %c-36_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %c-49_i64 : i64
    %2 = llvm.select %arg1, %c10_i64, %arg2 : i1, i64
    %3 = llvm.select %false, %2, %0 : i1, i64
    %4 = llvm.icmp "slt" %c48_i64, %c-21_i64 : i64
    %5 = llvm.select %4, %arg0, %c-19_i64 : i1, i64
    %6 = llvm.select %1, %3, %5 : i1, i64
    %7 = llvm.or %0, %6 : i64
    return %7 : i64
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
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c22_i64 = arith.constant 22 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %arg1, %c-16_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.icmp "uge" %c22_i64, %c15_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %5, %5 : i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
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
  func.func @main() -> i8 {
    %c31_i8 = arith.constant 31 : i8
    return %c31_i8 : i8
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
  func.func @main() -> i8 {
    %c-14_i8 = arith.constant -14 : i8
    return %c-14_i8 : i8
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c21_i64 = arith.constant 21 : i64
    %true = arith.constant true
    %c-15_i64 = arith.constant -15 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.select %true, %c-15_i64, %c30_i64 : i1, i64
    %1 = llvm.lshr %0, %c21_i64 : i64
    %2 = llvm.and %c-50_i64, %0 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "slt" %arg0, %c-4_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.and %c21_i64, %arg2 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.and %c-49_i64, %3 : i64
    %5 = llvm.or %3, %2 : i64
    %6 = llvm.xor %5, %c-45_i64 : i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
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
    %c42_i32 = arith.constant 42 : i32
    return %c42_i32 : i32
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
    %c-3_i8 = arith.constant -3 : i8
    return %c-3_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.udiv %arg0, %0 : i64
    %3 = llvm.select %1, %arg2, %2 : i1, i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.select %arg1, %2, %c-43_i64 : i1, i64
    %6 = llvm.select %1, %c4_i64, %5 : i1, i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "slt" %arg1, %arg0 : i64
    %1 = llvm.select %arg2, %c-38_i64, %c49_i64 : i1, i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.xor %2, %c-4_i64 : i64
    %4 = llvm.and %c-35_i64, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.sdiv %arg0, %6 : i64
    return %7 : i64
  }
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
    %c-14_i32 = arith.constant -14 : i32
    return %c-14_i32 : i32
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
  func.func @main() -> i32 {
    %c24_i32 = arith.constant 24 : i32
    return %c24_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c49_i64 = arith.constant 49 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.xor %c49_i64, %c14_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.urem %2, %c50_i64 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.select %4, %0, %3 : i1, i64
    %6 = llvm.and %0, %5 : i64
    %7 = llvm.xor %arg0, %6 : i64
    return %7 : i64
  }
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
    %c14_i64 = arith.constant 14 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.ashr %c42_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.ashr %0, %c36_i64 : i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.urem %3, %0 : i64
    %5 = llvm.and %4, %c14_i64 : i64
    %6 = llvm.or %1, %5 : i64
    %7 = llvm.icmp "ugt" %c-22_i64, %6 : i64
    return %7 : i1
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ult" %arg0, %c-49_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %c-30_i64, %c-39_i64 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "uge" %arg1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.udiv %4, %6 : i64
    return %7 : i64
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.icmp "ule" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %c25_i64, %arg1 : i64
    %6 = llvm.srem %arg0, %5 : i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.sdiv %c-18_i64, %c14_i64 : i64
    %4 = llvm.lshr %c14_i64, %3 : i64
    %5 = llvm.lshr %arg1, %4 : i64
    %6 = llvm.ashr %5, %c-9_i64 : i64
    %7 = llvm.icmp "ult" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %c49_i64 : i64
    %2 = llvm.lshr %c-13_i64, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.urem %arg0, %c26_i64 : i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
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
    %c12_i32 = arith.constant 12 : i32
    return %c12_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c16_i64 = arith.constant 16 : i64
    %c39_i64 = arith.constant 39 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg0, %c39_i64 : i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    %5 = llvm.select %4, %c16_i64, %c32_i64 : i1, i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.icmp "eq" %c49_i64, %6 : i64
    return %7 : i1
  }
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
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.or %5, %1 : i64
    %7 = llvm.icmp "sge" %c-44_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c40_i64 = arith.constant 40 : i64
    %false = arith.constant false
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.select %false, %0, %c40_i64 : i1, i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.urem %c-28_i64, %c20_i64 : i64
    %6 = llvm.sdiv %arg2, %5 : i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
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
  func.func @main() -> i8 {
    %c-18_i8 = arith.constant -18 : i8
    return %c-18_i8 : i8
  }
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
  func.func @main() -> i8 {
    %c-3_i8 = arith.constant -3 : i8
    return %c-3_i8 : i8
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
  func.func @main(%arg0: i1) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c-26_i64 = arith.constant -26 : i64
    %false = arith.constant false
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %false, %0, %c-26_i64 : i1, i64
    %4 = llvm.ashr %3, %c4_i64 : i64
    %5 = llvm.sdiv %4, %0 : i64
    %6 = llvm.udiv %0, %5 : i64
    %7 = llvm.or %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c36_i32 = arith.constant 36 : i32
    return %c36_i32 : i32
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.select %arg0, %c2_i64, %c-35_i64 : i1, i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.or %c-17_i64, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %4, %arg1 : i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c16_i64 = arith.constant 16 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-32_i64 = arith.constant -32 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %c-32_i64, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    %5 = llvm.select %4, %c16_i64, %c-48_i64 : i1, i64
    %6 = llvm.ashr %3, %5 : i64
    %7 = llvm.sdiv %c-5_i64, %6 : i64
    return %7 : i64
  }
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
    %c-20_i8 = arith.constant -20 : i8
    return %c-20_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c15_i64 = arith.constant 15 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.udiv %c15_i64, %c0_i64 : i64
    %1 = llvm.icmp "eq" %c-34_i64, %0 : i64
    %2 = llvm.and %arg0, %arg1 : i64
    %3 = llvm.select %1, %2, %arg2 : i1, i64
    %4 = llvm.and %3, %c-2_i64 : i64
    %5 = llvm.sext %1 : i1 to i64
    %6 = llvm.ashr %5, %arg2 : i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
  }
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
    %c-9_i64 = arith.constant -9 : i64
    %c2_i64 = arith.constant 2 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %c11_i64, %0 : i64
    %2 = llvm.icmp "sle" %arg1, %arg1 : i64
    %3 = llvm.select %2, %arg2, %arg0 : i1, i64
    %4 = llvm.srem %c-9_i64, %arg0 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.srem %c2_i64, %5 : i64
    %7 = llvm.icmp "slt" %1, %6 : i64
    return %7 : i1
  }
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
  func.func @main() -> i32 {
    %c-38_i32 = arith.constant -38 : i32
    return %c-38_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %false = arith.constant false
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %5, %c-31_i64 : i64
    %7 = llvm.select %0, %arg1, %6 : i1, i64
    return %7 : i64
  }
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c37_i64 = arith.constant 37 : i64
    %c2_i64 = arith.constant 2 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.srem %arg1, %c7_i64 : i64
    %1 = llvm.select %arg2, %0, %arg1 : i1, i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.select %2, %arg1, %1 : i1, i64
    %4 = llvm.icmp "ult" %c2_i64, %3 : i64
    %5 = llvm.lshr %c37_i64, %c36_i64 : i64
    %6 = llvm.select %4, %1, %5 : i1, i64
    %7 = llvm.icmp "eq" %arg0, %6 : i64
    return %7 : i1
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.ashr %4, %0 : i64
    %6 = llvm.trunc %false : i1 to i64
    %7 = llvm.icmp "ult" %5, %6 : i64
    return %7 : i1
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
  func.func @main() -> i8 {
    %c-42_i8 = arith.constant -42 : i8
    return %c-42_i8 : i8
  }
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
    %c-50_i32 = arith.constant -50 : i32
    return %c-50_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.sdiv %arg0, %c38_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.and %c-7_i64, %arg2 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.lshr %4, %arg0 : i64
    %7 = llvm.sdiv %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.srem %4, %c-28_i64 : i64
    %6 = llvm.or %4, %c30_i64 : i64
    %7 = llvm.urem %5, %6 : i64
    return %7 : i64
  }
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
    %c-40_i64 = arith.constant -40 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.urem %arg0, %c24_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.icmp "sle" %c-3_i64, %c-40_i64 : i64
    %4 = llvm.select %3, %1, %c-48_i64 : i1, i64
    %5 = llvm.sdiv %4, %2 : i64
    %6 = llvm.xor %arg1, %5 : i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
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
  func.func @main() -> i8 {
    %c10_i8 = arith.constant 10 : i8
    return %c10_i8 : i8
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
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
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "uge" %0, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "slt" %5, %3 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %arg2, %c38_i64 : i64
    %5 = llvm.select %2, %4, %c16_i64 : i1, i64
    %6 = llvm.urem %5, %arg2 : i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
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
    %c38_i8 = arith.constant 38 : i8
    return %c38_i8 : i8
  }
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
    %c-29_i32 = arith.constant -29 : i32
    return %c-29_i32 : i32
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
  func.func @main() -> i8 {
    %c-45_i8 = arith.constant -45 : i8
    return %c-45_i8 : i8
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
    %c35_i32 = arith.constant 35 : i32
    return %c35_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.srem %arg2, %0 : i64
    %2 = llvm.and %1, %c6_i64 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.and %arg0, %2 : i64
    %5 = llvm.and %c37_i64, %4 : i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
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
  func.func @main() -> i32 {
    %c-14_i32 = arith.constant -14 : i32
    return %c-14_i32 : i32
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
  func.func @main() -> i8 {
    %c24_i8 = arith.constant 24 : i8
    return %c24_i8 : i8
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
    %c7_i8 = arith.constant 7 : i8
    return %c7_i8 : i8
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
    %c14_i8 = arith.constant 14 : i8
    return %c14_i8 : i8
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
    %c-36_i8 = arith.constant -36 : i8
    return %c-36_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.sdiv %2, %c25_i64 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.xor %arg2, %2 : i64
    %6 = llvm.and %5, %c-20_i64 : i64
    %7 = llvm.select %0, %4, %6 : i1, i64
    return %7 : i64
  }
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg1, %arg2 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %c40_i64, %c-26_i64 : i64
    %6 = llvm.ashr %5, %c18_i64 : i64
    %7 = llvm.and %4, %6 : i64
    return %7 : i64
  }
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %c30_i64, %0 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    %3 = llvm.ashr %c-48_i64, %arg0 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "sge" %c39_i64, %3 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
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
    %c38_i8 = arith.constant 38 : i8
    return %c38_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg1, %arg1 : i64
    %3 = llvm.lshr %arg2, %arg0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "eq" %arg1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "uge" %1, %6 : i64
    return %7 : i1
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
  func.func @main() -> i32 {
    %c44_i32 = arith.constant 44 : i32
    return %c44_i32 : i32
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
  func.func @main() -> i32 {
    %c-33_i32 = arith.constant -33 : i32
    return %c-33_i32 : i32
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
    %c-18_i8 = arith.constant -18 : i8
    return %c-18_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c49_i64 = arith.constant 49 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %c10_i64, %c49_i64 : i64
    %2 = llvm.urem %c10_i64, %1 : i64
    %3 = llvm.select %arg1, %arg2, %c-31_i64 : i1, i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.udiv %2, %5 : i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
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
    %c6_i64 = arith.constant 6 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.and %c31_i64, %arg1 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.select %arg0, %2, %arg2 : i1, i64
    %4 = llvm.srem %c49_i64, %c6_i64 : i64
    %5 = llvm.sdiv %c-1_i64, %4 : i64
    %6 = llvm.icmp "sle" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
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
    %c-10_i64 = arith.constant -10 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.ashr %arg0, %c27_i64 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "ule" %c-32_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.urem %4, %c-10_i64 : i64
    %6 = llvm.udiv %4, %arg2 : i64
    %7 = llvm.icmp "slt" %5, %6 : i64
    return %7 : i1
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
    %c-11_i32 = arith.constant -11 : i32
    return %c-11_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.icmp "ugt" %arg0, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %1, %3, %c9_i64 : i1, i64
    %5 = llvm.udiv %arg0, %4 : i64
    %6 = llvm.trunc %false : i1 to i64
    %7 = llvm.or %5, %6 : i64
    return %7 : i64
  }
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
    %c-39_i32 = arith.constant -39 : i32
    return %c-39_i32 : i32
  }
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
    %c-48_i8 = arith.constant -48 : i8
    return %c-48_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.srem %arg2, %0 : i64
    %4 = llvm.or %3, %0 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c14_i64 = arith.constant 14 : i64
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.and %c14_i64, %c-14_i64 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.or %c34_i64, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.urem %c-43_i64, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.icmp "sgt" %arg2, %2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
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
    %c30_i8 = arith.constant 30 : i8
    return %c30_i8 : i8
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
  func.func @main() -> i32 {
    %c-30_i32 = arith.constant -30 : i32
    return %c-30_i32 : i32
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
  func.func @main(%arg0: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c39_i64 = arith.constant 39 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.ashr %c30_i64, %arg0 : i64
    %1 = llvm.and %arg0, %c-12_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %c39_i64, %c9_i64 : i64
    %5 = llvm.lshr %c-49_i64, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.icmp "sgt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c47_i64 = arith.constant 47 : i64
    %c50_i64 = arith.constant 50 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.select %arg2, %c50_i64, %c12_i64 : i1, i64
    %1 = llvm.icmp "slt" %arg1, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ne" %4, %arg0 : i64
    %6 = llvm.select %5, %c47_i64, %c13_i64 : i1, i64
    %7 = llvm.srem %3, %6 : i64
    return %7 : i64
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
  func.func @main() -> i8 {
    %c27_i8 = arith.constant 27 : i8
    return %c27_i8 : i8
  }
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
  func.func @main() -> i32 {
    %c27_i32 = arith.constant 27 : i32
    return %c27_i32 : i32
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
  func.func @main() -> i8 {
    %c48_i8 = arith.constant 48 : i8
    return %c48_i8 : i8
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
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
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.and %c1_i64, %c26_i64 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
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
  func.func @main() -> i32 {
    %c-36_i32 = arith.constant -36 : i32
    return %c-36_i32 : i32
  }
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
    %c-50_i32 = arith.constant -50 : i32
    return %c-50_i32 : i32
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
  func.func @main() -> i32 {
    %c43_i32 = arith.constant 43 : i32
    return %c43_i32 : i32
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
  func.func @main() -> i8 {
    %c24_i8 = arith.constant 24 : i8
    return %c24_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.or %arg0, %c-21_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.or %arg1, %c13_i64 : i64
    %3 = llvm.lshr %c-41_i64, %arg2 : i64
    %4 = llvm.and %c-23_i64, %3 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.ashr %5, %0 : i64
    %7 = llvm.lshr %1, %6 : i64
    return %7 : i64
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
  func.func @main() -> i8 {
    %c-34_i8 = arith.constant -34 : i8
    return %c-34_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c32_i64 = arith.constant 32 : i64
    %c33_i64 = arith.constant 33 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.xor %c33_i64, %c41_i64 : i64
    %1 = llvm.xor %c32_i64, %0 : i64
    %2 = llvm.urem %0, %arg0 : i64
    %3 = llvm.urem %c-28_i64, %arg0 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.icmp "ugt" %1, %6 : i64
    return %7 : i1
  }
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
  func.func @main() -> i8 {
    %c31_i8 = arith.constant 31 : i8
    return %c31_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.udiv %0, %c-22_i64 : i64
    %4 = llvm.ashr %c-11_i64, %3 : i64
    %5 = llvm.udiv %arg2, %4 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c33_i64 = arith.constant 33 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.lshr %arg0, %c17_i64 : i64
    %1 = llvm.icmp "slt" %c33_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.and %c49_i64, %arg0 : i64
    %5 = llvm.icmp "ne" %arg1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
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
    %c38_i8 = arith.constant 38 : i8
    return %c38_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %c42_i64, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.lshr %arg1, %arg2 : i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.or %3, %6 : i64
    return %7 : i64
  }
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
  func.func @main() -> i32 {
    %c31_i32 = arith.constant 31 : i32
    return %c31_i32 : i32
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
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
    %c41_i8 = arith.constant 41 : i8
    return %c41_i8 : i8
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
  func.func @main() -> i8 {
    %c27_i8 = arith.constant 27 : i8
    return %c27_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c42_i64 = arith.constant 42 : i64
    %c24_i64 = arith.constant 24 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.sdiv %c42_i64, %c-44_i64 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %c24_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %c36_i64, %4 : i64
    %6 = llvm.or %0, %5 : i64
    %7 = llvm.icmp "sgt" %arg0, %6 : i64
    return %7 : i1
  }
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c6_i64 = arith.constant 6 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.sdiv %c18_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c6_i64 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.icmp "sle" %c-41_i64, %2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %c-46_i64, %5 : i64
    %7 = llvm.select %3, %6, %5 : i1, i64
    return %7 : i64
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.srem %arg0, %arg0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %4, %c29_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.or %0, %c-37_i64 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.urem %c-8_i64, %0 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.xor %0, %c21_i64 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "uge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.lshr %3, %0 : i64
    %5 = llvm.sdiv %4, %3 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.udiv %3, %6 : i64
    return %7 : i64
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
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %c-43_i64, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.icmp "slt" %arg1, %3 : i64
    %5 = llvm.and %arg1, %1 : i64
    %6 = llvm.select %4, %c41_i64, %5 : i1, i64
    %7 = llvm.ashr %2, %6 : i64
    return %7 : i64
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
    %c39_i8 = arith.constant 39 : i8
    return %c39_i8 : i8
  }
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
  func.func @main() -> i8 {
    %c16_i8 = arith.constant 16 : i8
    return %c16_i8 : i8
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
  func.func @main(%arg0: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c29_i64 = arith.constant 29 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.udiv %c46_i64, %c-30_i64 : i64
    %1 = llvm.icmp "sgt" %0, %c29_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.or %arg0, %c33_i64 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.or %2, %6 : i64
    return %7 : i64
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c30_i64 = arith.constant 30 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.icmp "ugt" %c30_i64, %c-6_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.select %3, %5, %c50_i64 : i1, i64
    %7 = llvm.or %0, %6 : i64
    return %7 : i64
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "sgt" %c35_i64, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.select %0, %c10_i64, %arg1 : i1, i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "uge" %6, %arg2 : i64
    return %7 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c26_i64 = arith.constant 26 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %c-14_i64, %arg0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "ult" %c26_i64, %c-15_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %5, %arg1 : i64
    %7 = llvm.icmp "uge" %3, %6 : i64
    return %7 : i1
  }
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
    %true = arith.constant true
    %c19_i64 = arith.constant 19 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.sdiv %c11_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.srem %arg2, %c19_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.trunc %true : i1 to i64
    %7 = llvm.icmp "ult" %5, %6 : i64
    return %7 : i1
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
    %c-1_i8 = arith.constant -1 : i8
    return %c-1_i8 : i8
  }
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
  func.func @main() -> i8 {
    %c-1_i8 = arith.constant -1 : i8
    return %c-1_i8 : i8
  }
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
    %c27_i8 = arith.constant 27 : i8
    return %c27_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.lshr %arg0, %arg1 : i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.srem %3, %arg2 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "uge" %1, %6 : i64
    return %7 : i1
  }
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
  func.func @main() -> i32 {
    %c-9_i32 = arith.constant -9 : i32
    return %c-9_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-25_i64 = arith.constant -25 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %c-23_i64, %0 : i64
    %2 = llvm.urem %0, %arg1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.and %c-25_i64, %4 : i64
    %6 = llvm.sdiv %5, %1 : i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.xor %c-17_i64, %arg0 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.udiv %3, %6 : i64
    return %7 : i64
  }
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
    %c-49_i32 = arith.constant -49 : i32
    return %c-49_i32 : i32
  }
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
    %c-48_i8 = arith.constant -48 : i8
    return %c-48_i8 : i8
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
  func.func @main() -> i32 {
    %c48_i32 = arith.constant 48 : i32
    return %c48_i32 : i32
  }
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.urem %c-12_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg1, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %c36_i64 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %2, %arg2 : i64
    %7 = llvm.icmp "slt" %5, %6 : i64
    return %7 : i1
  }
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
    %c18_i64 = arith.constant 18 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.udiv %c-29_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg1, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c-7_i64, %arg2 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.lshr %3, %c18_i64 : i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.icmp "sle" %0, %6 : i64
    return %7 : i1
  }
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
  func.func @main(%arg0: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.sdiv %2, %c-5_i64 : i64
    %4 = llvm.xor %2, %0 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
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
    %c-8_i32 = arith.constant -8 : i32
    return %c-8_i32 : i32
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
    %c-35_i8 = arith.constant -35 : i8
    return %c-35_i8 : i8
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
  func.func @main() -> i8 {
    %c-4_i8 = arith.constant -4 : i8
    return %c-4_i8 : i8
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
    %c49_i8 = arith.constant 49 : i8
    return %c49_i8 : i8
  }
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
    %c-45_i64 = arith.constant -45 : i64
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.select %true, %arg0, %c-45_i64 : i1, i64
    %3 = llvm.lshr %2, %1 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.sext %false : i1 to i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c-41_i32 = arith.constant -41 : i32
    return %c-41_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %arg1 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.icmp "ult" %arg2, %c-23_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
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
  func.func @main() -> i8 {
    %c-32_i8 = arith.constant -32 : i8
    return %c-32_i8 : i8
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
  func.func @main() -> i8 {
    %c-13_i8 = arith.constant -13 : i8
    return %c-13_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-16_i64 = arith.constant -16 : i64
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.select %true, %arg1, %0 : i1, i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.sext %arg2 : i1 to i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    %6 = llvm.select %5, %c-16_i64, %c-40_i64 : i1, i64
    %7 = llvm.xor %arg0, %6 : i64
    return %7 : i64
  }
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
    %c0_i8 = arith.constant 0 : i8
    return %c0_i8 : i8
  }
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
    %c16_i32 = arith.constant 16 : i32
    return %c16_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c0_i64 : i64
    %2 = llvm.icmp "ule" %c-39_i64, %arg0 : i64
    %3 = llvm.udiv %arg2, %0 : i64
    %4 = llvm.or %3, %c44_i64 : i64
    %5 = llvm.select %2, %arg2, %4 : i1, i64
    %6 = llvm.urem %arg1, %5 : i64
    %7 = llvm.lshr %1, %6 : i64
    return %7 : i64
  }
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
    %c29_i32 = arith.constant 29 : i32
    return %c29_i32 : i32
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.select %arg1, %c-3_i64, %arg2 : i1, i64
    %3 = llvm.lshr %c11_i64, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.sdiv %arg0, %6 : i64
    return %7 : i64
  }
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
    %c-21_i8 = arith.constant -21 : i8
    return %c-21_i8 : i8
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
  func.func @main() -> i32 {
    %c20_i32 = arith.constant 20 : i32
    return %c20_i32 : i32
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
  func.func @main() -> i32 {
    %c22_i32 = arith.constant 22 : i32
    return %c22_i32 : i32
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
  func.func @main() -> i32 {
    %c49_i32 = arith.constant 49 : i32
    return %c49_i32 : i32
  }
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
  func.func @main() -> i32 {
    %c13_i32 = arith.constant 13 : i32
    return %c13_i32 : i32
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
  func.func @main() -> i32 {
    %c41_i32 = arith.constant 41 : i32
    return %c41_i32 : i32
  }
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
    %c11_i32 = arith.constant 11 : i32
    return %c11_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.udiv %c-18_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.sdiv %4, %c-15_i64 : i64
    %6 = llvm.trunc %2 : i1 to i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
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
    %c1_i64 = arith.constant 1 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.xor %c1_i64, %2 : i64
    %4 = llvm.udiv %c-36_i64, %3 : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.icmp "ne" %c-42_i64, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
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
  func.func @main() -> i32 {
    %c47_i32 = arith.constant 47 : i32
    return %c47_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sdiv %c20_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %0, %0 : i64
    %3 = llvm.select %arg1, %1, %2 : i1, i64
    %4 = llvm.srem %3, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.xor %c-42_i64, %6 : i64
    return %7 : i64
  }
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
  func.func @main() -> i8 {
    %c-27_i8 = arith.constant -27 : i8
    return %c-27_i8 : i8
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
  func.func @main() -> i32 {
    %c-12_i32 = arith.constant -12 : i32
    return %c-12_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.ashr %arg0, %c-37_i64 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "sge" %c41_i64, %c12_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %arg2, %4 : i64
    %6 = llvm.and %2, %5 : i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
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
  func.func @main() -> i8 {
    %c4_i8 = arith.constant 4 : i8
    return %c4_i8 : i8
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
  func.func @main() -> i32 {
    %c-46_i32 = arith.constant -46 : i32
    return %c-46_i32 : i32
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
  func.func @main() -> i32 {
    %c27_i32 = arith.constant 27 : i32
    return %c27_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "eq" %c41_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c-22_i64 : i1, i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %2, %arg0, %3 : i1, i64
    %5 = llvm.and %arg1, %c-5_i64 : i64
    %6 = llvm.urem %c-25_i64, %5 : i64
    %7 = llvm.and %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c38_i64 = arith.constant 38 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.and %arg0, %c23_i64 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.sdiv %arg2, %c38_i64 : i64
    %4 = llvm.icmp "ule" %3, %c-27_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %5, %c44_i64 : i64
    %7 = llvm.icmp "slt" %2, %6 : i64
    return %7 : i1
  }
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
    %c-29_i32 = arith.constant -29 : i32
    return %c-29_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.and %c-8_i64, %c-46_i64 : i64
    %1 = llvm.lshr %0, %c-28_i64 : i64
    %2 = llvm.and %1, %c-4_i64 : i64
    %3 = llvm.icmp "sgt" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
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
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg2, %c48_i64 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %2, %arg1 : i64
    %6 = llvm.udiv %1, %5 : i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
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
    %c27_i32 = arith.constant 27 : i32
    return %c27_i32 : i32
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
  func.func @main() -> i32 {
    %c47_i32 = arith.constant 47 : i32
    return %c47_i32 : i32
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
    %c48_i8 = arith.constant 48 : i8
    return %c48_i8 : i8
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
  func.func @main() -> i8 {
    %c17_i8 = arith.constant 17 : i8
    return %c17_i8 : i8
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
    %c34_i8 = arith.constant 34 : i8
    return %c34_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.and %c20_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "ugt" %c-43_i64, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.xor %5, %c2_i64 : i64
    %7 = llvm.or %6, %0 : i64
    return %7 : i64
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.or %c-9_i64, %1 : i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.lshr %arg2, %c-42_i64 : i64
    %5 = llvm.sdiv %4, %c37_i64 : i64
    %6 = llvm.or %arg2, %5 : i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
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
    %c-43_i32 = arith.constant -43 : i32
    return %c-43_i32 : i32
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
    %c16_i8 = arith.constant 16 : i8
    return %c16_i8 : i8
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
    %c-4_i8 = arith.constant -4 : i8
    return %c-4_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c44_i64 = arith.constant 44 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %c34_i64, %0 : i64
    %2 = llvm.lshr %c44_i64, %1 : i64
    %3 = llvm.icmp "slt" %c-20_i64, %2 : i64
    %4 = llvm.xor %arg0, %2 : i64
    %5 = llvm.select %3, %4, %1 : i1, i64
    %6 = llvm.or %c-13_i64, %5 : i64
    %7 = llvm.xor %6, %c26_i64 : i64
    return %7 : i64
  }
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
    %c-34_i8 = arith.constant -34 : i8
    return %c-34_i8 : i8
  }
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
    %c9_i32 = arith.constant 9 : i32
    return %c9_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.and %arg1, %c38_i64 : i64
    %4 = llvm.icmp "sle" %3, %0 : i64
    %5 = llvm.select %4, %c25_i64, %2 : i1, i64
    %6 = llvm.udiv %arg0, %5 : i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
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
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.ashr %1, %c48_i64 : i64
    %3 = llvm.sdiv %arg1, %arg1 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "sle" %4, %2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ult" %0, %6 : i64
    return %7 : i1
  }
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
    %c-17_i64 = arith.constant -17 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sdiv %c6_i64, %arg0 : i64
    %1 = llvm.and %c-31_i64, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.srem %arg0, %1 : i64
    %4 = llvm.ashr %3, %c-17_i64 : i64
    %5 = llvm.icmp "ugt" %4, %arg1 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.xor %2, %6 : i64
    return %7 : i64
  }
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
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
  func.func @main() -> i8 {
    %c49_i8 = arith.constant 49 : i8
    return %c49_i8 : i8
  }
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
    %c-39_i64 = arith.constant -39 : i64
    %false = arith.constant false
    %c5_i64 = arith.constant 5 : i64
    %c38_i64 = arith.constant 38 : i64
    %c6_i64 = arith.constant 6 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.urem %c6_i64, %c22_i64 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.icmp "uge" %1, %c38_i64 : i64
    %3 = llvm.select %2, %c5_i64, %arg2 : i1, i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.sdiv %5, %c-39_i64 : i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c-47_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %arg1, %c40_i64 : i64
    %4 = llvm.srem %c-1_i64, %0 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.or %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-34_i8 = arith.constant -34 : i8
    return %c-34_i8 : i8
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
    %c-44_i8 = arith.constant -44 : i8
    return %c-44_i8 : i8
  }
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
  func.func @main() -> i32 {
    %c-29_i32 = arith.constant -29 : i32
    return %c-29_i32 : i32
  }
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
    %c-36_i8 = arith.constant -36 : i8
    return %c-36_i8 : i8
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
    %c-26_i32 = arith.constant -26 : i32
    return %c-26_i32 : i32
  }
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
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %false, %c36_i64, %3 : i1, i64
    %5 = llvm.or %1, %0 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
  }
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
    %c-27_i64 = arith.constant -27 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c21_i64 = arith.constant 21 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.lshr %c-33_i64, %arg1 : i64
    %2 = llvm.select %arg0, %arg2, %c-27_i64 : i1, i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.or %c21_i64, %3 : i64
    %5 = llvm.ashr %4, %arg2 : i64
    %6 = llvm.xor %0, %5 : i64
    %7 = llvm.icmp "slt" %c42_i64, %6 : i64
    return %7 : i1
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
  func.func @main(%arg0: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c39_i64 = arith.constant 39 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "sle" %c-32_i64, %c11_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %c39_i64, %c-13_i64 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.or %6, %4 : i64
    return %7 : i64
  }
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
    %c47_i8 = arith.constant 47 : i8
    return %c47_i8 : i8
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "slt" %c-43_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg1, %c21_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.urem %4, %arg1 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.icmp "ule" %1, %6 : i64
    return %7 : i1
  }
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
  func.func @main() -> i32 {
    %c35_i32 = arith.constant 35 : i32
    return %c35_i32 : i32
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
  func.func @main() -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c8_i64 = arith.constant 8 : i64
    %c1_i64 = arith.constant 1 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "sgt" %c-24_i64, %c41_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %c1_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %0, %c8_i64, %1 : i1, i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.select %0, %3, %5 : i1, i64
    %7 = llvm.ashr %6, %c-41_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %false = arith.constant false
    %c-1_i64 = arith.constant -1 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.select %arg2, %c-1_i64, %arg1 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.urem %c16_i64, %6 : i64
    return %7 : i64
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
  func.func @main() -> i8 {
    %c21_i8 = arith.constant 21 : i8
    return %c21_i8 : i8
  }
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
    %c46_i32 = arith.constant 46 : i32
    return %c46_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sdiv %arg0, %c6_i64 : i64
    %1 = llvm.icmp "ule" %0, %c-26_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.udiv %3, %2 : i64
    %5 = llvm.ashr %4, %c-44_i64 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.ashr %0, %6 : i64
    return %7 : i64
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
  func.func @main() -> i32 {
    %c-2_i32 = arith.constant -2 : i32
    return %c-2_i32 : i32
  }
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
  func.func @main() -> i32 {
    %c42_i32 = arith.constant 42 : i32
    return %c42_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %c5_i64, %c-43_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %1, %c-31_i64 : i64
    %3 = llvm.xor %c19_i64, %arg0 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
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
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.srem %c14_i64, %arg0 : i64
    %1 = llvm.udiv %c-34_i64, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.or %1, %0 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "uge" %6, %2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c31_i64 = arith.constant 31 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.udiv %arg0, %c-14_i64 : i64
    %1 = llvm.ashr %arg0, %c21_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "sle" %c31_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %2, %arg1 : i64
    %6 = llvm.urem %0, %5 : i64
    %7 = llvm.udiv %4, %6 : i64
    return %7 : i64
  }
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
    %c-16_i8 = arith.constant -16 : i8
    return %c-16_i8 : i8
  }
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
    %c21_i64 = arith.constant 21 : i64
    %c20_i64 = arith.constant 20 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "ult" %0, %c20_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.or %c21_i64, %4 : i64
    %7 = llvm.icmp "sge" %5, %6 : i64
    return %7 : i1
  }
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
    %c25_i64 = arith.constant 25 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c43_i64 = arith.constant 43 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.icmp "eq" %c43_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %c-12_i64, %arg1 : i64
    %4 = llvm.lshr %arg2, %3 : i64
    %5 = llvm.icmp "ult" %4, %c25_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
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
    %c13_i8 = arith.constant 13 : i8
    return %c13_i8 : i8
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.sdiv %c-28_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %c-9_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %4 = llvm.lshr %arg1, %0 : i64
    %5 = llvm.xor %4, %arg2 : i64
    %6 = llvm.select %3, %5, %c49_i64 : i1, i64
    %7 = llvm.icmp "sge" %2, %6 : i64
    return %7 : i1
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
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
  func.func @main() -> i8 {
    %c40_i8 = arith.constant 40 : i8
    return %c40_i8 : i8
  }
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
    %c-2_i32 = arith.constant -2 : i32
    return %c-2_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i32 {
    %c36_i32 = arith.constant 36 : i32
    return %c36_i32 : i32
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
    %c21_i8 = arith.constant 21 : i8
    return %c21_i8 : i8
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
  func.func @main() -> i32 {
    %c49_i32 = arith.constant 49 : i32
    return %c49_i32 : i32
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.lshr %c8_i64, %c-42_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.lshr %0, %0 : i64
    %3 = llvm.icmp "slt" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %arg0, %4 : i64
    %6 = llvm.icmp "sgt" %1, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
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
  func.func @main() -> i8 {
    %c-44_i8 = arith.constant -44 : i8
    return %c-44_i8 : i8
  }
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
  func.func @main(%arg0: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c1_i64 = arith.constant 1 : i64
    %c33_i64 = arith.constant 33 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.xor %c22_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %c1_i64, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.sdiv %c33_i64, %5 : i64
    %7 = llvm.or %6, %c-24_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.and %c26_i64, %0 : i64
    %3 = llvm.icmp "sge" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %4, %c-18_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.lshr %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %c14_i64, %0 : i64
    %2 = llvm.ashr %c-13_i64, %c48_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.ashr %2, %c49_i64 : i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
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
  func.func @main() -> i32 {
    %c40_i32 = arith.constant 40 : i32
    return %c40_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.srem %arg0, %c33_i64 : i64
    %1 = llvm.lshr %c-17_i64, %arg0 : i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.icmp "ne" %c11_i64, %3 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.udiv %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c0_i64 = arith.constant 0 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.ashr %c48_i64, %c-5_i64 : i64
    %1 = llvm.ashr %0, %c0_i64 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.udiv %2, %c28_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "ule" %4, %2 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.and %1, %6 : i64
    return %7 : i64
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
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.xor %c-19_i64, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.sdiv %3, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.ashr %5, %3 : i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
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
    %c-13_i32 = arith.constant -13 : i32
    return %c-13_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ule" %c-8_i64, %c15_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %arg1, %arg1 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %1, %6 : i64
    return %7 : i1
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.srem %c-31_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %c5_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %c-31_i64, %2 : i64
    %4 = llvm.srem %2, %arg1 : i64
    %5 = llvm.or %arg0, %4 : i64
    %6 = llvm.sdiv %5, %c-38_i64 : i64
    %7 = llvm.srem %3, %6 : i64
    return %7 : i64
  }
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
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
  func.func @main() -> i32 {
    %c-24_i32 = arith.constant -24 : i32
    return %c-24_i32 : i32
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
  func.func @main() -> i8 {
    %c36_i8 = arith.constant 36 : i8
    return %c36_i8 : i8
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
  func.func @main() -> i32 {
    %c-24_i32 = arith.constant -24 : i32
    return %c-24_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.xor %c-15_i64, %1 : i64
    %3 = llvm.or %c43_i64, %2 : i64
    %4 = llvm.icmp "ult" %3, %arg2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.udiv %1, %arg1 : i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
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
    %c-4_i8 = arith.constant -4 : i8
    return %c-4_i8 : i8
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
  func.func @main() -> i32 {
    %c-16_i32 = arith.constant -16 : i32
    return %c-16_i32 : i32
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
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
    %c45_i8 = arith.constant 45 : i8
    return %c45_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.zext %0 : i1 to i64
    %5 = llvm.lshr %4, %arg2 : i64
    %6 = llvm.icmp "ule" %3, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
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
    %c-17_i32 = arith.constant -17 : i32
    return %c-17_i32 : i32
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
    %c10_i8 = arith.constant 10 : i8
    return %c10_i8 : i8
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
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
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %c43_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "eq" %c-49_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %2, %arg1 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c18_i64 = arith.constant 18 : i64
    %c28_i64 = arith.constant 28 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "uge" %arg0, %c-12_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c28_i64, %c18_i64 : i64
    %3 = llvm.xor %2, %c33_i64 : i64
    %4 = llvm.srem %3, %arg1 : i64
    %5 = llvm.and %4, %1 : i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
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
    %c45_i8 = arith.constant 45 : i8
    return %c45_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c22_i64 = arith.constant 22 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.xor %arg0, %c-6_i64 : i64
    %1 = llvm.icmp "ult" %arg1, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %c-20_i64 : i64
    %4 = llvm.udiv %c22_i64, %c-46_i64 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %0, %6 : i64
    return %7 : i1
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
    %c-11_i32 = arith.constant -11 : i32
    return %c-11_i32 : i32
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
  func.func @main() -> i32 {
    %c26_i32 = arith.constant 26 : i32
    return %c26_i32 : i32
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
  func.func @main() -> i32 {
    %c40_i32 = arith.constant 40 : i32
    return %c40_i32 : i32
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
  func.func @main() -> i32 {
    %c-42_i32 = arith.constant -42 : i32
    return %c-42_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.select %0, %arg0, %1 : i1, i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.select %arg2, %2, %c8_i64 : i1, i64
    %7 = llvm.icmp "ult" %5, %6 : i64
    return %7 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.urem %0, %c-9_i64 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.ashr %c-14_i64, %1 : i64
    %4 = llvm.icmp "sge" %3, %1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %2, %5 : i64
    %7 = llvm.icmp "sle" %c20_i64, %6 : i64
    return %7 : i1
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
  func.func @main() -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "sge" %c-17_i64, %c-40_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %c-25_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %3, %1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
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
    %c34_i32 = arith.constant 34 : i32
    return %c34_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.ashr %c-8_i64, %c31_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.or %c13_i64, %2 : i64
    %5 = llvm.icmp "sge" %4, %2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.and %3, %6 : i64
    return %7 : i64
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
  func.func @main() -> i32 {
    %c32_i32 = arith.constant 32 : i32
    return %c32_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c18_i64 = arith.constant 18 : i64
    %c38_i64 = arith.constant 38 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.xor %c38_i64, %c-14_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.udiv %0, %arg1 : i64
    %5 = llvm.ashr %4, %1 : i64
    %6 = llvm.udiv %c18_i64, %c-36_i64 : i64
    %7 = llvm.select %3, %5, %6 : i1, i64
    return %7 : i64
  }
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
    %c-15_i32 = arith.constant -15 : i32
    return %c-15_i32 : i32
  }
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
  func.func @main() -> i8 {
    %c-21_i8 = arith.constant -21 : i8
    return %c-21_i8 : i8
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
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.lshr %c-22_i64, %arg0 : i64
    %1 = llvm.sdiv %c-10_i64, %0 : i64
    %2 = llvm.udiv %c44_i64, %1 : i64
    %3 = llvm.and %c25_i64, %1 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "eq" %4, %1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.sdiv %c-23_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "eq" %arg1, %c-31_i64 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.icmp "ne" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sge" %arg0, %6 : i64
    return %7 : i1
  }
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
    %c-34_i8 = arith.constant -34 : i8
    return %c-34_i8 : i8
  }
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
    %c-4_i32 = arith.constant -4 : i32
    return %c-4_i32 : i32
  }
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
    %c-16_i8 = arith.constant -16 : i8
    return %c-16_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.urem %0, %0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %4, %c-20_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %c-1_i64, %6 : i64
    return %7 : i1
  }
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
    %c-13_i8 = arith.constant -13 : i8
    return %c-13_i8 : i8
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
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
  func.func @main() -> i8 {
    %c-31_i8 = arith.constant -31 : i8
    return %c-31_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c17_i64 = arith.constant 17 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %c-48_i64, %c17_i64 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.or %2, %5 : i64
    %7 = llvm.icmp "sge" %0, %6 : i64
    return %7 : i1
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
    %c-42_i8 = arith.constant -42 : i8
    return %c-42_i8 : i8
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
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.sdiv %c-11_i64, %arg0 : i64
    %1 = llvm.or %c25_i64, %0 : i64
    %2 = llvm.or %1, %c-30_i64 : i64
    %3 = llvm.icmp "sle" %2, %c18_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %c-49_i64, %4 : i64
    %6 = llvm.urem %0, %5 : i64
    %7 = llvm.icmp "slt" %c17_i64, %6 : i64
    return %7 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.lshr %c48_i64, %arg0 : i64
    %1 = llvm.lshr %c-40_i64, %arg1 : i64
    %2 = llvm.icmp "sle" %c-20_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %3, %c39_i64 : i64
    %5 = llvm.srem %4, %arg0 : i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
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
    %c-34_i8 = arith.constant -34 : i8
    return %c-34_i8 : i8
  }
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
  func.func @main() -> i32 {
    %c-17_i32 = arith.constant -17 : i32
    return %c-17_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.ashr %c-25_i64, %c25_i64 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.or %c3_i64, %5 : i64
    %7 = llvm.ashr %1, %6 : i64
    return %7 : i64
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
  func.func @main() -> i32 {
    %c15_i32 = arith.constant 15 : i32
    return %c15_i32 : i32
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
  func.func @main() -> i32 {
    %c-1_i32 = arith.constant -1 : i32
    return %c-1_i32 : i32
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
  func.func @main() -> i8 {
    %c-43_i8 = arith.constant -43 : i8
    return %c-43_i8 : i8
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
  func.func @main() -> i32 {
    %c-41_i32 = arith.constant -41 : i32
    return %c-41_i32 : i32
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
    %c-32_i8 = arith.constant -32 : i8
    return %c-32_i8 : i8
  }
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
    %c-10_i8 = arith.constant -10 : i8
    return %c-10_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c-34_i8 = arith.constant -34 : i8
    return %c-34_i8 : i8
  }
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
    %c-43_i32 = arith.constant -43 : i32
    return %c-43_i32 : i32
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
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
    %c-1_i8 = arith.constant -1 : i8
    return %c-1_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.urem %c-48_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %c14_i64 : i64
    %2 = llvm.lshr %arg1, %0 : i64
    %3 = llvm.udiv %0, %0 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.and %4, %arg1 : i64
    %6 = llvm.ashr %5, %c-27_i64 : i64
    %7 = llvm.select %1, %2, %6 : i1, i64
    return %7 : i64
  }
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
    %c-23_i64 = arith.constant -23 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.lshr %c1_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %1, %c-4_i64 : i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.select %4, %c-23_i64, %3 : i1, i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.icmp "uge" %1, %6 : i64
    return %7 : i1
  }
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
    %false = arith.constant false
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.select %false, %c-4_i64, %arg0 : i1, i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.icmp "ult" %arg1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.ashr %0, %6 : i64
    return %7 : i64
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
  func.func @main() -> i32 {
    %c-11_i32 = arith.constant -11 : i32
    return %c-11_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sdiv %c45_i64, %arg0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %arg1, %arg1 : i64
    %6 = llvm.select %5, %1, %arg2 : i1, i64
    %7 = llvm.select %0, %4, %6 : i1, i64
    return %7 : i64
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
  func.func @main() -> i8 {
    %c-30_i8 = arith.constant -30 : i8
    return %c-30_i8 : i8
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
  func.func @main(%arg0: i1) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c39_i64 = arith.constant 39 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "sgt" %c39_i64, %c38_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.xor %c-7_i64, %3 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.trunc %0 : i1 to i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
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
  func.func @main() -> i32 {
    %c-7_i32 = arith.constant -7 : i32
    return %c-7_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.urem %c-36_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ult" %4, %c17_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %2, %6 : i64
    return %7 : i1
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.xor %arg2, %c48_i64 : i64
    %4 = llvm.urem %arg1, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.trunc %false : i1 to i64
    %7 = llvm.icmp "slt" %5, %6 : i64
    return %7 : i1
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
    %c41_i8 = arith.constant 41 : i8
    return %c41_i8 : i8
  }
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
    %c-50_i8 = arith.constant -50 : i8
    return %c-50_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %c44_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %2, %arg1 : i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.icmp "slt" %6, %c-7_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "ule" %1, %2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %c17_i64, %5 : i64
    %7 = llvm.and %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.urem %c-17_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "ne" %c-47_i64, %3 : i64
    %5 = llvm.select %arg1, %c48_i64, %arg2 : i1, i64
    %6 = llvm.select %4, %2, %5 : i1, i64
    %7 = llvm.icmp "sgt" %6, %c16_i64 : i64
    return %7 : i1
  }
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
    %c-18_i8 = arith.constant -18 : i8
    return %c-18_i8 : i8
  }
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
    %c-39_i8 = arith.constant -39 : i8
    return %c-39_i8 : i8
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
    %c3_i8 = arith.constant 3 : i8
    return %c3_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.lshr %arg2, %0 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.urem %c-6_i64, %c-2_i64 : i64
    %7 = llvm.icmp "sle" %5, %6 : i64
    return %7 : i1
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
    %c-26_i8 = arith.constant -26 : i8
    return %c-26_i8 : i8
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
  func.func @main() -> i32 {
    %c16_i32 = arith.constant 16 : i32
    return %c16_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.lshr %c-21_i64, %0 : i64
    %2 = llvm.urem %0, %c38_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sext %4 : i1 to i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
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
    %c45_i64 = arith.constant 45 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.srem %c7_i64, %1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sle" %c45_i64, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c7_i64 = arith.constant 7 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "sgt" %c-22_i64, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c7_i64, %arg1 : i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %arg0, %1, %4 : i1, i64
    %6 = llvm.trunc %true : i1 to i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
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
  func.func @main() -> i32 {
    %c14_i32 = arith.constant 14 : i32
    return %c14_i32 : i32
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
  func.func @main() -> i8 {
    %c28_i8 = arith.constant 28 : i8
    return %c28_i8 : i8
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
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %true = arith.constant true
    %c-27_i64 = arith.constant -27 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.lshr %c-27_i64, %c12_i64 : i64
    %1 = llvm.select %true, %0, %c-1_i64 : i1, i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.zext %arg0 : i1 to i64
    %6 = llvm.ashr %5, %arg1 : i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
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
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c8_i64 = arith.constant 8 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %c16_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.lshr %2, %c8_i64 : i64
    %4 = llvm.icmp "ugt" %arg1, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.xor %5, %c-37_i64 : i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %c-45_i64 : i64
    %3 = llvm.select %arg2, %arg1, %2 : i1, i64
    %4 = llvm.select %arg2, %3, %arg1 : i1, i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
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
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
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
    %c28_i8 = arith.constant 28 : i8
    return %c28_i8 : i8
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
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %c31_i64 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.lshr %3, %2 : i64
    %5 = llvm.udiv %4, %c1_i64 : i64
    %6 = llvm.urem %0, %5 : i64
    %7 = llvm.icmp "eq" %6, %2 : i64
    return %7 : i1
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
  func.func @main() -> i8 {
    %c36_i8 = arith.constant 36 : i8
    return %c36_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.xor %c30_i64, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.lshr %arg2, %c-2_i64 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.icmp "uge" %6, %5 : i64
    return %7 : i1
  }
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
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.srem %arg1, %arg2 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %4, %c-24_i64 : i64
    %6 = llvm.lshr %5, %c-26_i64 : i64
    %7 = llvm.srem %1, %6 : i64
    return %7 : i64
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
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
