module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.or %arg0, %c-49_i64 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.trunc %c-12_i64 : i64 to i1
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.trunc %arg2 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "eq" %arg0, %c13_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %arg0 : i64 to i1
    %3 = llvm.select %2, %arg1, %arg2 : i1, i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %c-26_i64, %1 : i64
    %3 = llvm.lshr %c24_i64, %arg0 : i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-15_i32 = arith.constant -15 : i32
    %0 = llvm.sext %c-15_i32 : i32 to i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i32 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.select %arg1, %c46_i64, %arg0 : i1, i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.ashr %c35_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.urem %c4_i64, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    %c-48_i64 = arith.constant -48 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.udiv %c-48_i64, %c36_i64 : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %c-28_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.xor %c-16_i64, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c4_i64 = arith.constant 4 : i64
    %c17_i64 = arith.constant 17 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.xor %c44_i64, %arg0 : i64
    %1 = llvm.sdiv %c17_i64, %0 : i64
    %2 = llvm.xor %c4_i64, %1 : i64
    %3 = llvm.select %false, %arg1, %2 : i1, i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.udiv %c31_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.urem %c11_i64, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c12_i32 = arith.constant 12 : i32
    %0 = llvm.sext %c12_i32 : i32 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.srem %c14_i64, %c3_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.or %c-30_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.ashr %c4_i64, %arg0 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.urem %c-20_i64, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.trunc %c-7_i64 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %3, %arg0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i32 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.srem %c-14_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.icmp "sle" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-41_i32 = arith.constant -41 : i32
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sext %c-41_i32 : i32 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.and %c-27_i64, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.srem %c50_i64, %arg0 : i64
    %1 = llvm.lshr %c-13_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.udiv %c-3_i64, %arg1 : i64
    %4 = llvm.select %2, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c17_i64, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.srem %c30_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.trunc %c-10_i64 : i64 to i1
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.select %arg0, %arg1, %2 : i1, i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %c33_i64, %2 : i64
    %4 = llvm.icmp "ugt" %c25_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.udiv %arg0, %c-17_i64 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.urem %c-3_i64, %c29_i64 : i64
    %1 = llvm.trunc %arg0 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.srem %c-42_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c10_i64 = arith.constant 10 : i64
    %c33_i64 = arith.constant 33 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.ashr %arg0, %c40_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.udiv %c33_i64, %1 : i64
    %3 = llvm.and %2, %c10_i64 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.select %arg2, %arg1, %c4_i64 : i1, i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.lshr %c48_i64, %c-24_i64 : i64
    %1 = llvm.or %c7_i64, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.icmp "eq" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c37_i64 = arith.constant 37 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "ne" %c-37_i64, %c8_i64 : i64
    %1 = llvm.select %0, %c37_i64, %arg0 : i1, i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.ashr %c20_i64, %c1_i64 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.ashr %c-35_i64, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.ashr %c-5_i64, %arg2 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i32, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sext %arg1 : i32 to i64
    %2 = llvm.select %true, %1, %arg2 : i1, i64
    %3 = llvm.ashr %c9_i64, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.and %arg0, %c-37_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %false = arith.constant false
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.ashr %c-2_i64, %arg0 : i64
    %1 = llvm.select %false, %arg0, %arg0 : i1, i64
    %2 = llvm.xor %1, %c-45_i64 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.sdiv %1, %c-19_i64 : i64
    %3 = llvm.and %c42_i64, %2 : i64
    %4 = llvm.srem %3, %arg2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.udiv %c-15_i64, %c-35_i64 : i64
    %1 = llvm.trunc %c25_i64 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.xor %c22_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %arg1, %arg2 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.select %3, %c-22_i64, %c46_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.urem %c13_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.ashr %c-25_i64, %arg0 : i64
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "eq" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c15_i64 = arith.constant 15 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.xor %arg0, %c47_i64 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.sdiv %2, %c5_i64 : i64
    %4 = llvm.icmp "sgt" %c15_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.lshr %arg0, %c48_i64 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i32 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %c6_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.ashr %c-12_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.sdiv %2, %c27_i64 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c-1_i64 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-8_i32 = arith.constant -8 : i32
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ule" %c-13_i64, %arg0 : i64
    %1 = llvm.sext %c-8_i32 : i32 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.select %0, %2, %1 : i1, i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.urem %0, %0 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.xor %3, %c40_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %arg0, %0 : i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sle" %c17_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c48_i32 = arith.constant 48 : i32
    %0 = llvm.sext %c48_i32 : i32 to i64
    %1 = llvm.ashr %c-35_i64, %c-31_i64 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.udiv %0, %c28_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.select %arg1, %arg2, %c12_i64 : i1, i64
    %1 = llvm.lshr %0, %c-23_i64 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.udiv %2, %c-26_i64 : i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.ashr %arg0, %c-2_i64 : i64
    %1 = llvm.xor %0, %c7_i64 : i64
    %2 = llvm.ashr %c-42_i64, %1 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.urem %c-5_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %c14_i64, %0 : i64
    %2 = llvm.select %1, %c-8_i64, %arg0 : i1, i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.sdiv %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.xor %c44_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %c-35_i64, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-35_i64 = arith.constant -35 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sdiv %arg0, %c31_i64 : i64
    %1 = llvm.sdiv %0, %c-18_i64 : i64
    %2 = llvm.ashr %1, %c-35_i64 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.xor %c8_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.udiv %arg1, %c8_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %c-26_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "ult" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-14_i64 = arith.constant -14 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "eq" %c-14_i64, %c28_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.lshr %arg2, %c-33_i64 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.ashr %2, %c36_i64 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg0, %c-9_i64 : i1, i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.select %false, %2, %arg1 : i1, i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %c10_i64, %0 : i64
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c22_i64 = arith.constant 22 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.select %false, %c22_i64, %c31_i64 : i1, i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.trunc %c-10_i64 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.udiv %c16_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %c-10_i64 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.srem %arg1, %c-45_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %1, %c-30_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.urem %3, %c-29_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.xor %arg0, %c4_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg1, %arg1 : i1, i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-30_i32 = arith.constant -30 : i32
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.sext %c-30_i32 : i32 to i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    %c-48_i32 = arith.constant -48 : i32
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.sext %arg0 : i32 to i64
    %1 = llvm.icmp "sge" %0, %c-34_i64 : i64
    %2 = llvm.sext %c-48_i32 : i32 to i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i32 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.xor %c-36_i64, %1 : i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.trunc %c36_i64 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.or %1, %c-29_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-32_i32 = arith.constant -32 : i32
    %0 = llvm.sext %c-32_i32 : i32 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.select %3, %0, %1 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.xor %arg0, %c-9_i64 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %c-23_i64, %arg0 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.select %arg0, %c-50_i64, %c39_i64 : i1, i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.urem %arg2, %c48_i64 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
