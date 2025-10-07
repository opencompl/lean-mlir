module {
  func.func @main(%arg0: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "ne" %c35_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %c-6_i64, %1 : i64
    return %2 : i1
  }
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
    %c-50_i8 = arith.constant -50 : i8
    return %c-50_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %c-7_i64, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    return %2 : i64
  }
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
    %c-47_i64 = arith.constant -47 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.select %arg0, %arg1, %c10_i64 : i1, i64
    %1 = llvm.or %0, %c-47_i64 : i64
    %2 = llvm.icmp "sge" %c-43_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.sdiv %c-24_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "sle" %c-9_i64, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
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
    %c7_i8 = arith.constant 7 : i8
    return %c7_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.srem %c12_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.xor %c-18_i64, %c-19_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
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
    %c-27_i32 = arith.constant -27 : i32
    return %c-27_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "eq" %c5_i64, %c-8_i64 : i64
    %1 = llvm.select %0, %c20_i64, %arg0 : i1, i64
    %2 = llvm.or %1, %arg1 : i64
    return %2 : i64
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
    %c0_i8 = arith.constant 0 : i8
    return %c0_i8 : i8
  }
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
    %c31_i8 = arith.constant 31 : i8
    return %c31_i8 : i8
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
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.select %arg0, %c44_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ne" %0, %c46_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "slt" %c8_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.srem %c-34_i64, %c-12_i64 : i64
    %1 = llvm.urem %0, %c-19_i64 : i64
    %2 = llvm.and %c-4_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.or %c27_i64, %1 : i64
    return %2 : i64
  }
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
  }
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
  func.func @main() -> i8 {
    %c17_i8 = arith.constant 17 : i8
    return %c17_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.or %c3_i64, %0 : i64
    %2 = llvm.sdiv %c-30_i64, %1 : i64
    return %2 : i64
  }
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
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.and %c-28_i64, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.urem %1, %1 : i64
    return %2 : i64
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
    %c-11_i8 = arith.constant -11 : i8
    return %c-11_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.and %c30_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %c-38_i64 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
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
    %c-11_i64 = arith.constant -11 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.udiv %c-11_i64, %c42_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %0 : i64
    return %2 : i1
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
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    return %2 : i64
  }
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
  func.func @main(%arg0: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.lshr %c23_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.sdiv %1, %c20_i64 : i64
    return %2 : i64
  }
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
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "uge" %c-11_i64, %1 : i64
    return %2 : i1
  }
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
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %c-15_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
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
    %c26_i8 = arith.constant 26 : i8
    return %c26_i8 : i8
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
  func.func @main() -> i32 {
    %c-20_i32 = arith.constant -20 : i32
    return %c-20_i32 : i32
  }
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
  func.func @main() -> i32 {
    %c-50_i32 = arith.constant -50 : i32
    return %c-50_i32 : i32
  }
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
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.udiv %c-2_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.srem %c-9_i64, %arg0 : i64
    %1 = llvm.lshr %c27_i64, %c-23_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
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
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.sdiv %c-30_i64, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "slt" %c-19_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sdiv %arg0, %c28_i64 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
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
  func.func @main() -> i8 {
    %c22_i8 = arith.constant 22 : i8
    return %c22_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.udiv %c-32_i64, %c22_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %c-18_i64 : i1, i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
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
  func.func @main(%arg0: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.srem %c-13_i64, %arg0 : i64
    %1 = llvm.srem %0, %c-24_i64 : i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.srem %c-13_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %true = arith.constant true
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.select %arg0, %c-12_i64, %0 : i1, i64
    %2 = llvm.select %true, %1, %c43_i64 : i1, i64
    return %2 : i64
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
  func.func @main(%arg0: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.or %c48_i64, %arg0 : i64
    %1 = llvm.xor %0, %c38_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %c-39_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.srem %arg0, %c-30_i64 : i64
    %1 = llvm.srem %0, %c35_i64 : i64
    %2 = llvm.icmp "ne" %1, %c36_i64 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
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
    %c-11_i64 = arith.constant -11 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "slt" %c43_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %c-11_i64 : i64
    return %2 : i1
  }
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
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    return %2 : i1
  }
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
    %c-18_i32 = arith.constant -18 : i32
    return %c-18_i32 : i32
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
  func.func @main() -> i32 {
    %c36_i32 = arith.constant 36 : i32
    return %c36_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.and %arg0, %c22_i64 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "uge" %arg0, %c38_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c-9_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "slt" %arg0, %c23_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
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
    %c21_i64 = arith.constant 21 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "ule" %c21_i64, %c-17_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "ult" %c-3_i64, %c-5_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %c20_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.srem %c1_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
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
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.ashr %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %true = arith.constant true
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.select %true, %c-33_i64, %arg0 : i1, i64
    %1 = llvm.xor %arg1, %c-46_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
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
    %c-44_i32 = arith.constant -44 : i32
    return %c-44_i32 : i32
  }
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
  func.func @main() -> i32 {
    %c-2_i32 = arith.constant -2 : i32
    return %c-2_i32 : i32
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
    %c-35_i32 = arith.constant -35 : i32
    return %c-35_i32 : i32
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
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
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
  func.func @main(%arg0: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.or %c4_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %0 : i64
    return %2 : i1
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
  func.func @main(%arg0: i1) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c6_i64, %c-30_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.or %arg0, %c-2_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.select %1, %arg0, %arg1 : i1, i64
    return %2 : i64
  }
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
    %c30_i32 = arith.constant 30 : i32
    return %c30_i32 : i32
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
  func.func @main() -> i8 {
    %c-33_i8 = arith.constant -33 : i8
    return %c-33_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %c-38_i64, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.srem %c-48_i64, %arg0 : i64
    %1 = llvm.or %c19_i64, %arg0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
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
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.select %false, %arg0, %c-12_i64 : i1, i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.srem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
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
    %c34_i32 = arith.constant 34 : i32
    return %c34_i32 : i32
  }
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
  func.func @main() -> i32 {
    %c48_i32 = arith.constant 48 : i32
    return %c48_i32 : i32
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
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %c19_i64, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    return %2 : i1
  }
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
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg2 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.select %1, %arg2, %arg2 : i1, i64
    return %2 : i64
  }
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
    %c25_i8 = arith.constant 25 : i8
    return %c25_i8 : i8
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
    %c3_i32 = arith.constant 3 : i32
    return %c3_i32 : i32
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
    %c47_i32 = arith.constant 47 : i32
    return %c47_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "ule" %c-44_i64, %1 : i64
    return %2 : i1
  }
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
  func.func @main() -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "ugt" %c-17_i64, %c13_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.lshr %arg0, %c-19_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ule" %1, %c27_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sdiv %arg1, %c28_i64 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.xor %1, %c37_i64 : i64
    return %2 : i64
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
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %c-37_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.sdiv %c13_i64, %c-38_i64 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.lshr %arg0, %c9_i64 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
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
    %c25_i64 = arith.constant 25 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.urem %c25_i64, %c0_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
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
    %c37_i8 = arith.constant 37 : i8
    return %c37_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.xor %c-45_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
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
    %c15_i32 = arith.constant 15 : i32
    return %c15_i32 : i32
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
    %c10_i8 = arith.constant 10 : i8
    return %c10_i8 : i8
  }
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
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.sdiv %c43_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.srem %c-41_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
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
    %c22_i32 = arith.constant 22 : i32
    return %c22_i32 : i32
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
    %c17_i8 = arith.constant 17 : i8
    return %c17_i8 : i8
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
  func.func @main() -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c41_i64 = arith.constant 41 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "slt" %c41_i64, %c42_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %c12_i64, %1 : i64
    return %2 : i1
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
    %c-22_i32 = arith.constant -22 : i32
    return %c-22_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.ashr %c-39_i64, %c-50_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %c50_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %c-42_i64 : i64
    return %2 : i1
  }
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
    %c-19_i64 = arith.constant -19 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.ashr %c50_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %c-19_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %c40_i64 : i64
    return %2 : i1
  }
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
    %c-30_i8 = arith.constant -30 : i8
    return %c-30_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.or %c43_i64, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg2 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %arg1, %arg0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %arg1, %c18_i64 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c19_i64, %arg0 : i1, i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
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
    %c11_i8 = arith.constant 11 : i8
    return %c11_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "ugt" %c-2_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c-41_i64, %1 : i64
    return %2 : i64
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "slt" %c-20_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c20_i64 = arith.constant 20 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sdiv %c20_i64, %c33_i64 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.icmp "ugt" %1, %c20_i64 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
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
    %c-9_i64 = arith.constant -9 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.udiv %c13_i64, %arg0 : i64
    %1 = llvm.srem %c-9_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    return %2 : i1
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
  func.func @main() -> i8 {
    %c19_i8 = arith.constant 19 : i8
    return %c19_i8 : i8
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "sgt" %c-8_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %c49_i64 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    return %2 : i64
  }
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
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    return %2 : i64
  }
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
    %c-29_i64 = arith.constant -29 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %c-26_i64, %arg0 : i64
    %1 = llvm.or %0, %c-29_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
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
  func.func @main() -> i8 {
    %c-20_i8 = arith.constant -20 : i8
    return %c-20_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
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
  func.func @main() -> i32 {
    %c-1_i32 = arith.constant -1 : i32
    return %c-1_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %arg0, %c-27_i64 : i64
    %1 = llvm.icmp "ult" %0, %c-6_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
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
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.or %c-48_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %c42_i64 : i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
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
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "sgt" %c8_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %c2_i64 : i64
    return %2 : i1
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
  func.func @main() -> i32 {
    %c2_i32 = arith.constant 2 : i32
    return %c2_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
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
    %c45_i32 = arith.constant 45 : i32
    return %c45_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %c-44_i64, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "sle" %c47_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    return %2 : i1
  }
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
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.sdiv %c-35_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %c42_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.udiv %arg0, %c-28_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "ule" %1, %c6_i64 : i64
    return %2 : i1
  }
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
  func.func @main() -> i8 {
    %c25_i8 = arith.constant 25 : i8
    return %c25_i8 : i8
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.srem %c-2_i64, %c-10_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %c-17_i64 : i64
    return %2 : i1
  }
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
    %c11_i64 = arith.constant 11 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.srem %c48_i64, %c-5_i64 : i64
    %1 = llvm.lshr %0, %c11_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
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
    %c-44_i32 = arith.constant -44 : i32
    return %c-44_i32 : i32
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
  func.func @main() -> i8 {
    %c16_i8 = arith.constant 16 : i8
    return %c16_i8 : i8
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
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
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
    %c43_i32 = arith.constant 43 : i32
    return %c43_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %true = arith.constant true
    %c-42_i64 = arith.constant -42 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.select %true, %c-42_i64, %c36_i64 : i1, i64
    %1 = llvm.ashr %c29_i64, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    return %2 : i64
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
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.or %c5_i64, %arg0 : i64
    %1 = llvm.select %true, %0, %arg0 : i1, i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %c-33_i64, %0 : i64
    %2 = llvm.icmp "slt" %c-22_i64, %1 : i64
    return %2 : i1
  }
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
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.and %arg0, %c2_i64 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.sdiv %c19_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c1_i64 : i64
    %2 = llvm.xor %c-7_i64, %1 : i64
    return %2 : i64
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
    %c-47_i32 = arith.constant -47 : i32
    return %c-47_i32 : i32
  }
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "sle" %arg0, %c48_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
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
    %c17_i64 = arith.constant 17 : i64
    %c43_i64 = arith.constant 43 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "ugt" %c13_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c17_i64 : i1, i64
    %2 = llvm.and %c43_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.ashr %arg1, %c-48_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
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
    %c33_i8 = arith.constant 33 : i8
    return %c33_i8 : i8
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "ugt" %c29_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    return %2 : i1
  }
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
    %c21_i8 = arith.constant 21 : i8
    return %c21_i8 : i8
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
    %c-33_i32 = arith.constant -33 : i32
    return %c-33_i32 : i32
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
    %c-37_i32 = arith.constant -37 : i32
    return %c-37_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.ashr %c-34_i64, %c-20_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "sge" %c-25_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.xor %c-3_i64, %c-10_i64 : i64
    %1 = llvm.and %c-34_i64, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
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
    %c42_i32 = arith.constant 42 : i32
    return %c42_i32 : i32
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
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "eq" %1, %c-24_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "ule" %c0_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.lshr %c30_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.select %arg0, %arg1, %c16_i64 : i1, i64
    %1 = llvm.select %arg2, %c-31_i64, %c-20_i64 : i1, i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
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
    %c35_i32 = arith.constant 35 : i32
    return %c35_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "eq" %arg0, %c37_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %c-28_i64, %1 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i1) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.or %1, %c-43_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %true = arith.constant true
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.select %true, %c5_i64, %arg0 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ule" %c-20_i64, %1 : i64
    return %2 : i1
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
  func.func @main() -> i32 {
    %c-41_i32 = arith.constant -41 : i32
    return %c-41_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %c14_i64, %1 : i64
    return %2 : i64
  }
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
    %c-14_i8 = arith.constant -14 : i8
    return %c-14_i8 : i8
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c5_i64, %1 : i64
    return %2 : i64
  }
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
    %c44_i8 = arith.constant 44 : i8
    return %c44_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %c10_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
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
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.srem %c33_i64, %c-38_i64 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
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
    %c-40_i32 = arith.constant -40 : i32
    return %c-40_i32 : i32
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
    %c-37_i32 = arith.constant -37 : i32
    return %c-37_i32 : i32
  }
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
  func.func @main() -> i32 {
    %c-31_i32 = arith.constant -31 : i32
    return %c-31_i32 : i32
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
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
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
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.and %0, %c15_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "sge" %c2_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    return %2 : i64
  }
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "ugt" %c-4_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.srem %c50_i64, %c-19_i64 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i1) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.select %arg0, %c15_i64, %c-33_i64 : i1, i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ule" %c-34_i64, %1 : i64
    return %2 : i1
  }
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
    %false = arith.constant false
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
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
    %c10_i32 = arith.constant 10 : i32
    return %c10_i32 : i32
  }
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
  func.func @main() -> i8 {
    %c22_i8 = arith.constant 22 : i8
    return %c22_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
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
    %c18_i32 = arith.constant 18 : i32
    return %c18_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "eq" %c-35_i64, %c-26_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    return %2 : i64
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
    %c-33_i32 = arith.constant -33 : i32
    return %c-33_i32 : i32
  }
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
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    return %2 : i1
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
    %c-8_i32 = arith.constant -8 : i32
    return %c-8_i32 : i32
  }
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
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.urem %arg0, %c-28_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    return %2 : i64
  }
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
  func.func @main(%arg0: i1) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %c42_i64 : i64
    %2 = llvm.icmp "uge" %c17_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.urem %c-22_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
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
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %arg1, %arg1 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
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
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ule" %c17_i64, %c-13_i64 : i64
    %1 = llvm.select %0, %c2_i64, %c-46_i64 : i1, i64
    %2 = llvm.icmp "sle" %c-46_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.sdiv %c-39_i64, %c50_i64 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %0, %c4_i64 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.udiv %c-15_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
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
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.udiv %c6_i64, %c11_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %c-11_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "sge" %c14_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
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
  func.func @main() -> i32 {
    %c-17_i32 = arith.constant -17 : i32
    return %c-17_i32 : i32
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
  func.func @main(%arg0: i1) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %c38_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
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
    %c26_i64 = arith.constant 26 : i64
    %c16_i64 = arith.constant 16 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.srem %c16_i64, %c37_i64 : i64
    %1 = llvm.ashr %c26_i64, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    return %2 : i1
  }
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
    %c-45_i64 = arith.constant -45 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "ne" %arg0, %c24_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %c-45_i64, %1 : i64
    return %2 : i1
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
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
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
    %c-19_i8 = arith.constant -19 : i8
    return %c-19_i8 : i8
  }
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
  func.func @main() -> i32 {
    %c-21_i32 = arith.constant -21 : i32
    return %c-21_i32 : i32
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
  func.func @main() -> i32 {
    %c45_i32 = arith.constant 45 : i32
    return %c45_i32 : i32
  }
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
    %c10_i32 = arith.constant 10 : i32
    return %c10_i32 : i32
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
  func.func @main() -> i32 {
    %c-43_i32 = arith.constant -43 : i32
    return %c-43_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c13_i64 : i64
    %2 = llvm.srem %c-1_i64, %1 : i64
    return %2 : i64
  }
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
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.lshr %c50_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    return %2 : i64
  }
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
  func.func @main() -> i32 {
    %c-23_i32 = arith.constant -23 : i32
    return %c-23_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.and %c-30_i64, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.sdiv %c-6_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    return %2 : i1
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
    %c-37_i8 = arith.constant -37 : i8
    return %c-37_i8 : i8
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
  func.func @main() -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c15_i64 = arith.constant 15 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sdiv %c15_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %c13_i64 : i64
    return %2 : i1
  }
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
    %c41_i64 = arith.constant 41 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "ule" %c41_i64, %c-20_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.sdiv %c-25_i64, %c0_i64 : i64
    %1 = llvm.and %c-36_i64, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "sle" %c-48_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.and %arg0, %c-41_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    return %2 : i64
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
  func.func @main() -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.lshr %c40_i64, %c41_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg1, %arg0 : i1, i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %c-7_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    return %2 : i1
  }
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
  func.func @main() -> i32 {
    %c-39_i32 = arith.constant -39 : i32
    return %c-39_i32 : i32
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
    %c12_i32 = arith.constant 12 : i32
    return %c12_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.srem %c-36_i64, %arg0 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    return %2 : i64
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
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.xor %1, %0 : i64
    return %2 : i64
  }
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
    %c-17_i32 = arith.constant -17 : i32
    return %c-17_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    return %2 : i64
  }
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.xor %c2_i64, %c-2_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
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
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
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
  func.func @main(%arg0: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %c-40_i64, %1 : i64
    return %2 : i64
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.ashr %0, %c27_i64 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
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
    %c-35_i64 = arith.constant -35 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "eq" %c-35_i64, %c-38_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
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
  func.func @main() -> i32 {
    %c37_i32 = arith.constant 37 : i32
    return %c37_i32 : i32
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
  func.func @main() -> i32 {
    %c34_i32 = arith.constant 34 : i32
    return %c34_i32 : i32
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
  func.func @main() -> i8 {
    %c-7_i8 = arith.constant -7 : i8
    return %c-7_i8 : i8
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
    %c-45_i8 = arith.constant -45 : i8
    return %c-45_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "sge" %c-40_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    return %2 : i1
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
    %c26_i8 = arith.constant 26 : i8
    return %c26_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.udiv %c-41_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.srem %arg0, %c-5_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.and %c45_i64, %c-7_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
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
    %c15_i8 = arith.constant 15 : i8
    return %c15_i8 : i8
  }
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
  func.func @main(%arg0: i8) -> i8 {
    return %arg0 : i8
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.udiv %c-27_i64, %c-14_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
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
    %c9_i64 = arith.constant 9 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.sdiv %arg0, %c7_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c9_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.ashr %c36_i64, %arg0 : i64
    %1 = llvm.and %0, %c-46_i64 : i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.xor %c-29_i64, %c32_i64 : i64
    %1 = llvm.udiv %0, %c16_i64 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "ult" %c13_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c-20_i64, %1 : i64
    return %2 : i64
  }
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
  func.func @main() -> i32 {
    %c49_i32 = arith.constant 49 : i32
    return %c49_i32 : i32
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
  func.func @main(%arg0: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.or %arg0, %c-1_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
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
  func.func @main() -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c36_i64 = arith.constant 36 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.sdiv %c36_i64, %c35_i64 : i64
    %1 = llvm.urem %0, %c-12_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.urem %arg0, %c43_i64 : i64
    %1 = llvm.icmp "slt" %0, %c39_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
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
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %c22_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
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
    %c26_i8 = arith.constant 26 : i8
    return %c26_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c36_i64 = arith.constant 36 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.xor %c36_i64, %c42_i64 : i64
    %1 = llvm.urem %c43_i64, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
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
    %c17_i32 = arith.constant 17 : i32
    return %c17_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    return %2 : i64
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
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
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
  func.func @main() -> i32 {
    %c-28_i32 = arith.constant -28 : i32
    return %c-28_i32 : i32
  }
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
    %c-29_i64 = arith.constant -29 : i64
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.select %true, %0, %arg0 : i1, i64
    %2 = llvm.icmp "slt" %c-29_i64, %1 : i64
    return %2 : i1
  }
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
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    return %2 : i1
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
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "slt" %c-40_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c-39_i64 : i1, i64
    %2 = llvm.icmp "sge" %c-20_i64, %1 : i64
    return %2 : i1
  }
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
    %c-47_i8 = arith.constant -47 : i8
    return %c-47_i8 : i8
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
  func.func @main() -> i8 {
    %c-26_i8 = arith.constant -26 : i8
    return %c-26_i8 : i8
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
  func.func @main() -> i32 {
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c24_i64 = arith.constant 24 : i64
    %c39_i64 = arith.constant 39 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.xor %c39_i64, %c44_i64 : i64
    %1 = llvm.and %c24_i64, %c3_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.sdiv %c-35_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %c-23_i64, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.icmp "uge" %c-29_i64, %c7_i64 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c25_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
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
  func.func @main() -> i8 {
    %c-45_i8 = arith.constant -45 : i8
    return %c-45_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %c-44_i64, %0 : i64
    %2 = llvm.and %c20_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.udiv %c-18_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
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
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %c-21_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    return %2 : i1
  }
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
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c-38_i64 : i64
    %2 = llvm.icmp "ne" %c21_i64, %1 : i64
    return %2 : i1
  }
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
    %c-16_i8 = arith.constant -16 : i8
    return %c-16_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c37_i64, %arg1 : i1, i64
    %2 = llvm.icmp "ne" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "eq" %c-18_i64, %c33_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %c-37_i64, %1 : i64
    return %2 : i64
  }
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
    %c-34_i64 = arith.constant -34 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "sle" %c-34_i64, %c-37_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %arg0, %c-12_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ne" %c-30_i64, %1 : i64
    return %2 : i1
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
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.lshr %c21_i64, %arg0 : i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
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
  func.func @main() -> i32 {
    %c-4_i32 = arith.constant -4 : i32
    return %c-4_i32 : i32
  }
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
  func.func @main(%arg0: i1) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %c-15_i64, %c31_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "sge" %arg0, %c-35_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.srem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sdiv %c28_i64, %arg0 : i64
    %1 = llvm.lshr %c41_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %c-21_i64, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
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
    %c-8_i8 = arith.constant -8 : i8
    return %c-8_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.select %arg2, %arg1, %c-48_i64 : i1, i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.and %c-6_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.srem %c-11_i64, %c-17_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
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
    %c-17_i64 = arith.constant -17 : i64
    %c7_i64 = arith.constant 7 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.lshr %c7_i64, %c4_i64 : i64
    %1 = llvm.sdiv %c-17_i64, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
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
    %c-1_i32 = arith.constant -1 : i32
    return %c-1_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.or %c-50_i64, %arg0 : i64
    %1 = llvm.srem %c15_i64, %c20_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "slt" %c-21_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %c-17_i64, %1 : i64
    return %2 : i1
  }
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
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "uge" %1, %arg2 : i64
    return %2 : i1
  }
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
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
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
    %c10_i32 = arith.constant 10 : i32
    return %c10_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %false = arith.constant false
    %c-17_i64 = arith.constant -17 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %c-17_i64, %c48_i64 : i64
    %1 = llvm.select %false, %c-26_i64, %0 : i1, i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
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
  func.func @main() -> i32 {
    %c-10_i32 = arith.constant -10 : i32
    return %c-10_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.select %arg1, %arg2, %c13_i64 : i1, i64
    %1 = llvm.select %arg1, %c-11_i64, %0 : i1, i64
    %2 = llvm.and %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "ugt" %arg0, %c9_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
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
    %0 = llvm.or %arg0, %c34_i64 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
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
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.udiv %arg1, %c-43_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg2 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.udiv %c-37_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
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
    %c-3_i32 = arith.constant -3 : i32
    return %c-3_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
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
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg2 : i64
    return %2 : i1
  }
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
  func.func @main() -> i32 {
    %c4_i32 = arith.constant 4 : i32
    return %c4_i32 : i32
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
  func.func @main(%arg0: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c-45_i64 : i64
    %2 = llvm.icmp "ne" %1, %c-28_i64 : i64
    return %2 : i1
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
    %c45_i32 = arith.constant 45 : i32
    return %c45_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "uge" %c-4_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    return %2 : i1
  }
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
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %c-38_i64 : i64
    return %2 : i1
  }
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
    %c45_i32 = arith.constant 45 : i32
    return %c45_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %c-5_i64 : i64
    %2 = llvm.icmp "ne" %1, %0 : i64
    return %2 : i1
  }
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
  func.func @main() -> i32 {
    %c-4_i32 = arith.constant -4 : i32
    return %c-4_i32 : i32
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
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c26_i64 = arith.constant 26 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.select %arg1, %c26_i64, %c38_i64 : i1, i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.lshr %c19_i64, %1 : i64
    return %2 : i64
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
  func.func @main() -> i32 {
    %c-27_i32 = arith.constant -27 : i32
    return %c-27_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.sdiv %c-25_i64, %c-24_i64 : i64
    %1 = llvm.icmp "ule" %c7_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
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
  func.func @main(%arg0: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.or %0, %c-6_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
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
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
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
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.lshr %1, %c2_i64 : i64
    return %2 : i64
  }
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
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.and %arg2, %c0_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %c-5_i64, %c45_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.urem %c-9_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
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
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.udiv %c-42_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.urem %c-21_i64, %arg0 : i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
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
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.sdiv %c39_i64, %arg1 : i64
    %1 = llvm.select %arg0, %0, %c19_i64 : i1, i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
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
    %c-38_i8 = arith.constant -38 : i8
    return %c-38_i8 : i8
  }
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
    %c50_i32 = arith.constant 50 : i32
    return %c50_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.and %c-18_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
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
    %c-42_i32 = arith.constant -42 : i32
    return %c-42_i32 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c-2_i64 = arith.constant -2 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.udiv %c-2_i64, %c-18_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.urem %c7_i64, %c-20_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
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
    %c27_i8 = arith.constant 27 : i8
    return %c27_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
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
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.ashr %c22_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.lshr %c48_i64, %c-23_i64 : i64
    %1 = llvm.sdiv %c21_i64, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
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
  func.func @main() -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c33_i64 = arith.constant 33 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.ashr %c33_i64, %c20_i64 : i64
    %1 = llvm.icmp "sgt" %c39_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
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
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    return %2 : i64
  }
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
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.udiv %c38_i64, %c-2_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %1, %arg0 : i64
    return %2 : i64
  }
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
  func.func @main() -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %c-45_i64, %c-27_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
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
    %c-50_i64 = arith.constant -50 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.lshr %0, %c-50_i64 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "sle" %c-35_i64, %c-21_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    return %2 : i1
  }
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
    %c-39_i8 = arith.constant -39 : i8
    return %c-39_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
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
  func.func @main() -> i32 {
    %c-12_i32 = arith.constant -12 : i32
    return %c-12_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.xor %c31_i64, %c24_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %0 : i64
    return %2 : i1
  }
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
    %c40_i64 = arith.constant 40 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "slt" %c44_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %c40_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i8 {
    %c1_i8 = arith.constant 1 : i8
    return %c1_i8 : i8
  }
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
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
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
    %c4_i64 = arith.constant 4 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.srem %arg0, %c37_i64 : i64
    %1 = llvm.icmp "sgt" %c4_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
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
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.xor %c-23_i64, %arg0 : i64
    %1 = llvm.lshr %c10_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    return %2 : i1
  }
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
    %c-34_i8 = arith.constant -34 : i8
    return %c-34_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.srem %c-40_i64, %arg1 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
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
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.select %true, %arg0, %c-36_i64 : i1, i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
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
    %c48_i8 = arith.constant 48 : i8
    return %c48_i8 : i8
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %c-7_i64, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    return %2 : i1
  }
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
  func.func @main(%arg0: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c-6_i64 : i64
    %2 = llvm.or %1, %c-15_i64 : i64
    return %2 : i64
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
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.urem %arg0, %c1_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
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
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.icmp "ult" %arg0, %c7_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "eq" %c14_i64, %1 : i64
    return %2 : i1
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
    %c-22_i32 = arith.constant -22 : i32
    return %c-22_i32 : i32
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.udiv %c0_i64, %c20_i64 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
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
