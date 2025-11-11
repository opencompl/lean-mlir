module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %c15_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.or %c-50_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.lshr %c5_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.sdiv %0, %c-7_i64 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.xor %c40_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.srem %1, %c49_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %c-15_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.sdiv %c-21_i64, %arg1 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "ugt" %c16_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %c11_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.and %c-43_i64, %c-35_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %arg0, %c14_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.srem %1, %c-48_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.lshr %c-6_i64, %arg0 : i64
    %1 = llvm.urem %0, %c-4_i64 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "sle" %c-44_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.sdiv %arg0, %c30_i64 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.or %arg0, %c-48_i64 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.udiv %arg2, %c-41_i64 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.or %0, %c11_i64 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.and %c-48_i64, %arg0 : i64
    %1 = llvm.select %true, %0, %arg0 : i1, i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %c6_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "ult" %arg0, %c-9_i64 : i64
    %1 = llvm.select %0, %arg1, %c-40_i64 : i1, i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c22_i64, %arg1 : i1, i64
    %2 = llvm.icmp "sge" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i32 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %c-39_i64 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg1, %arg1 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c-27_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "eq" %c18_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %c-41_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.urem %c-21_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c31_i64 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64) -> i32 {
    %0 = llvm.sext %arg0 : i32 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i32 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %c-30_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "sgt" %c-24_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %c-43_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %c-15_i64, %arg0 : i64
    %1 = llvm.ashr %c-40_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-12_i64 = arith.constant -12 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.and %c-19_i64, %arg0 : i64
    %1 = llvm.xor %c-12_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %c9_i64, %c-34_i64 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "sgt" %arg0, %c-6_i64 : i64
    %1 = llvm.ashr %c-26_i64, %c15_i64 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.xor %c-50_i64, %arg0 : i64
    %1 = llvm.sdiv %c8_i64, %0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.and %c25_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c45_i64 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.xor %c-37_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.and %c-49_i64, %c10_i64 : i64
    %1 = llvm.sext %arg0 : i32 to i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.and %c-29_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "sgt" %c-8_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.srem %arg0, %c-37_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.srem %c36_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %c-7_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.srem %c7_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c46_i64 = arith.constant 46 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.lshr %arg0, %c-48_i64 : i64
    %1 = llvm.lshr %c46_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %c-45_i64, %0 : i64
    %2 = llvm.select %1, %arg1, %c18_i64 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.or %c47_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.udiv %c15_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %c-1_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.ashr %1, %c30_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.xor %arg0, %c-20_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ult" %c-20_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %c12_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.ashr %arg0, %c45_i64 : i64
    %1 = llvm.udiv %0, %c7_i64 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.lshr %arg0, %c36_i64 : i64
    %1 = llvm.ashr %c-25_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.sdiv %arg0, %c-41_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.select %arg0, %c-39_i64, %arg1 : i1, i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.and %c-24_i64, %c19_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.and %arg0, %c-6_i64 : i64
    %1 = llvm.sdiv %arg1, %arg1 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.sdiv %arg0, %c-38_i64 : i64
    %1 = llvm.sdiv %arg1, %arg1 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "ult" %arg0, %c1_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i32 {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.srem %c-19_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.select %arg0, %c-24_i64, %arg1 : i1, i64
    %1 = llvm.urem %c-11_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.udiv %c-42_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.ashr %c-38_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.sext %arg0 : i32 to i64
    %1 = llvm.and %c-44_i64, %c-40_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.and %arg0, %c19_i64 : i64
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %arg1, %c4_i64 : i1, i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %c41_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %false = arith.constant false
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c-12_i64, %arg0 : i1, i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.ashr %arg1, %c33_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
