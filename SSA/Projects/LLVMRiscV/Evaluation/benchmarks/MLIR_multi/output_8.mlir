module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i32 {
    %c24_i64 = arith.constant 24 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c36_i64 = arith.constant 36 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.select %arg0, %arg1, %c33_i64 : i1, i64
    %1 = llvm.xor %0, %c-4_i64 : i64
    %2 = llvm.srem %c36_i64, %1 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.srem %0, %arg2 : i64
    %5 = llvm.udiv %c24_i64, %4 : i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.select %arg0, %c-2_i64, %arg1 : i1, i64
    %1 = llvm.srem %arg1, %c23_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.or %3, %arg2 : i64
    %5 = llvm.zext %arg0 : i1 to i64
    %6 = llvm.srem %c33_i64, %5 : i64
    %7 = llvm.ashr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i32 {
    %c0_i64 = arith.constant 0 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.select %2, %arg1, %c-32_i64 : i1, i64
    %4 = llvm.lshr %c0_i64, %arg1 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %arg2, %arg0 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    %6 = llvm.and %c-34_i64, %arg1 : i64
    %7 = llvm.select %5, %6, %c-17_i64 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %c40_i64, %c13_i64 : i64
    %2 = llvm.sdiv %arg2, %arg2 : i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c13_i64 = arith.constant 13 : i64
    %c34_i32 = arith.constant 34 : i32
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.sext %c34_i32 : i32 to i64
    %2 = llvm.lshr %c13_i64, %0 : i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %0, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.urem %arg1, %arg0 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.lshr %arg2, %c-42_i64 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c33_i64 = arith.constant 33 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.ashr %c2_i64, %c-7_i64 : i64
    %1 = llvm.select %arg0, %c33_i64, %0 : i1, i64
    %2 = llvm.udiv %c-4_i64, %1 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.udiv %arg1, %arg1 : i64
    %5 = llvm.lshr %4, %4 : i64
    %6 = llvm.select %arg0, %4, %5 : i1, i64
    %7 = llvm.udiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c14_i64 = arith.constant 14 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.and %arg0, %arg1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.sdiv %c14_i64, %arg2 : i64
    %6 = llvm.srem %arg0, %c-39_i64 : i64
    %7 = llvm.select %4, %5, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.xor %c-18_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %c-48_i64 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.or %c-43_i64, %5 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c1_i64 = arith.constant 1 : i64
    %c-27_i64 = arith.constant -27 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sdiv %c-27_i64, %1 : i64
    %3 = llvm.srem %arg1, %arg2 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.or %2, %c1_i64 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.or %2, %c48_i64 : i64
    %4 = llvm.sdiv %c-14_i64, %3 : i64
    %5 = llvm.icmp "ugt" %4, %arg1 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.xor %c34_i64, %arg0 : i64
    %1 = llvm.udiv %c-3_i64, %0 : i64
    %2 = llvm.select %arg2, %arg0, %c-2_i64 : i1, i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.or %1, %0 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.trunc %c41_i64 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.icmp "sge" %c-8_i64, %4 : i64
    %6 = llvm.select %5, %c31_i64, %0 : i1, i64
    %7 = llvm.xor %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c48_i64 = arith.constant 48 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.trunc %c15_i64 : i64 to i1
    %1 = llvm.or %c48_i64, %arg0 : i64
    %2 = llvm.select %0, %1, %c-13_i64 : i1, i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.or %c16_i64, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.udiv %2, %5 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.trunc %c11_i64 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.xor %arg1, %c4_i64 : i64
    %4 = llvm.trunc %arg2 : i64 to i1
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i32) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.trunc %c-18_i64 : i64 to i1
    %1 = llvm.select %0, %arg0, %c50_i64 : i1, i64
    %2 = llvm.zext %arg2 : i32 to i64
    %3 = llvm.or %2, %c-50_i64 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.urem %arg1, %5 : i64
    %7 = llvm.icmp "sle" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.udiv %arg0, %c32_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.select %false, %1, %1 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.lshr %0, %arg0 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.or %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %c19_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.or %arg1, %arg1 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.sdiv %arg2, %c-24_i64 : i64
    %6 = llvm.srem %5, %c24_i64 : i64
    %7 = llvm.udiv %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.urem %c-46_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.select %false, %arg0, %1 : i1, i64
    %3 = llvm.trunc %arg2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.udiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %3, %c9_i64 : i64
    %5 = llvm.ashr %4, %arg1 : i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-31_i64 = arith.constant -31 : i64
    %c-29_i64 = arith.constant -29 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.select %3, %0, %arg1 : i1, i64
    %5 = llvm.and %c-29_i64, %4 : i64
    %6 = llvm.xor %c-31_i64, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c46_i64 = arith.constant 46 : i64
    %false = arith.constant false
    %c-16_i64 = arith.constant -16 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.select %arg2, %c-43_i64, %c17_i64 : i1, i64
    %1 = llvm.select %false, %c-16_i64, %0 : i1, i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.sdiv %c46_i64, %c30_i64 : i64
    %6 = llvm.or %arg1, %5 : i64
    %7 = llvm.icmp "sle" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c10_i64 = arith.constant 10 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c2_i64 = arith.constant 2 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.urem %arg0, %c25_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.sdiv %c2_i64, %0 : i64
    %3 = llvm.urem %arg0, %c-32_i64 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.lshr %4, %c10_i64 : i64
    %6 = llvm.lshr %1, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-28_i64 = arith.constant -28 : i64
    %false = arith.constant false
    %c-32_i64 = arith.constant -32 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.udiv %arg2, %c-32_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.srem %c-39_i64, %3 : i64
    %5 = llvm.select %false, %c-28_i64, %c-28_i64 : i1, i64
    %6 = llvm.or %5, %c15_i64 : i64
    %7 = llvm.icmp "uge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c24_i64 = arith.constant 24 : i64
    %c33_i64 = arith.constant 33 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.srem %c-9_i64, %arg0 : i64
    %1 = llvm.ashr %c33_i64, %0 : i64
    %2 = llvm.icmp "slt" %c24_i64, %1 : i64
    %3 = llvm.sdiv %arg1, %arg1 : i64
    %4 = llvm.urem %c-13_i64, %3 : i64
    %5 = llvm.lshr %c-19_i64, %arg1 : i64
    %6 = llvm.xor %0, %5 : i64
    %7 = llvm.select %2, %4, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "sgt" %c16_i64, %c-8_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %c41_i64, %c37_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.xor %c-8_i64, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.sext %6 : i32 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.urem %4, %1 : i64
    %6 = llvm.sdiv %3, %5 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c31_i64 = arith.constant 31 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c26_i64 = arith.constant 26 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "slt" %arg2, %c40_i64 : i64
    %2 = llvm.select %1, %arg0, %c26_i64 : i1, i64
    %3 = llvm.lshr %c-26_i64, %c31_i64 : i64
    %4 = llvm.udiv %3, %c14_i64 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.sdiv %0, %5 : i64
    %7 = llvm.ashr %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i32, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.and %c50_i64, %c13_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.zext %arg1 : i32 to i64
    %5 = llvm.ashr %arg2, %0 : i64
    %6 = llvm.select %arg0, %4, %5 : i1, i64
    %7 = llvm.icmp "slt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.trunc %c-1_i64 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.xor %arg0, %arg1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.ashr %c14_i64, %arg2 : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.sext %5 : i32 to i64
    %7 = llvm.sdiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.xor %c5_i64, %c-3_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.trunc %0 : i64 to i1
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %3, %arg0 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.udiv %3, %arg1 : i64
    %7 = llvm.udiv %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-13_i64 = arith.constant -13 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.urem %c-13_i64, %c-20_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.and %arg1, %arg1 : i64
    %5 = llvm.sdiv %4, %2 : i64
    %6 = llvm.ashr %3, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c16_i64 = arith.constant 16 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.lshr %c-11_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %c16_i64, %0 : i64
    %2 = llvm.or %0, %c-40_i64 : i64
    %3 = llvm.and %arg0, %arg0 : i64
    %4 = llvm.select %1, %arg0, %arg1 : i1, i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.select %1, %2, %5 : i1, i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.and %3, %0 : i64
    %5 = llvm.xor %4, %c-32_i64 : i64
    %6 = llvm.urem %5, %arg2 : i64
    %7 = llvm.icmp "uge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-36_i32 = arith.constant -36 : i32
    %c3_i64 = arith.constant 3 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.urem %0, %arg2 : i64
    %3 = llvm.or %2, %c36_i64 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.sext %c-36_i32 : i32 to i64
    %6 = llvm.lshr %c3_i64, %5 : i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.ashr %c-33_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.trunc %c6_i64 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.ashr %5, %c-19_i64 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i1) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.select %arg1, %0, %2 : i1, i64
    %4 = llvm.and %c22_i64, %c-4_i64 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.xor %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "uge" %c-50_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.icmp "ugt" %3, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.select %arg2, %c-18_i64, %arg0 : i1, i64
    %7 = llvm.lshr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c34_i64 = arith.constant 34 : i64
    %c6_i64 = arith.constant 6 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.urem %c6_i64, %c34_i64 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.srem %arg0, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c23_i64 = arith.constant 23 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-4_i32 = arith.constant -4 : i32
    %0 = llvm.sext %c-4_i32 : i32 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.and %arg0, %arg0 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.ashr %c32_i64, %c23_i64 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.select %2, %1, %0 : i1, i64
    %4 = llvm.xor %c-43_i64, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.sext %5 : i32 to i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.ashr %c18_i64, %c-5_i64 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %arg0, %arg0 : i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.udiv %5, %0 : i64
    %7 = llvm.lshr %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.urem %c-10_i64, %arg1 : i64
    %1 = llvm.urem %0, %c33_i64 : i64
    %2 = llvm.sdiv %arg2, %1 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.or %1, %5 : i64
    %7 = llvm.icmp "sgt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.trunc %c-13_i64 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-31_i64 = arith.constant -31 : i64
    %c27_i64 = arith.constant 27 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.urem %arg0, %c28_i64 : i64
    %1 = llvm.udiv %c27_i64, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.select %3, %arg0, %1 : i1, i64
    %5 = llvm.xor %4, %c-31_i64 : i64
    %6 = llvm.srem %5, %0 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %c-19_i64, %0 : i64
    %2 = llvm.icmp "sle" %c0_i64, %1 : i64
    %3 = llvm.select %2, %0, %arg1 : i1, i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.select %2, %arg2, %arg0 : i1, i64
    %6 = llvm.or %5, %arg1 : i64
    %7 = llvm.icmp "eq" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.srem %c-15_i64, %c-27_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.ashr %c-10_i64, %arg0 : i64
    %4 = llvm.ashr %c27_i64, %3 : i64
    %5 = llvm.srem %4, %arg1 : i64
    %6 = llvm.ashr %5, %5 : i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %0, %c15_i64 : i64
    %2 = llvm.trunc %arg2 : i64 to i1
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.sext %1 : i1 to i64
    %6 = llvm.select %1, %4, %5 : i1, i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.trunc %5 : i64 to i1
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.icmp "sgt" %0, %c-7_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.select %1, %0, %c48_i64 : i1, i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.sext %5 : i32 to i64
    %7 = llvm.and %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c29_i64 = arith.constant 29 : i64
    %c26_i64 = arith.constant 26 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.urem %c-17_i64, %arg0 : i64
    %1 = llvm.and %c26_i64, %arg2 : i64
    %2 = llvm.select %arg1, %c29_i64, %arg0 : i1, i64
    %3 = llvm.xor %arg0, %c12_i64 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.select %arg1, %1, %4 : i1, i64
    %6 = llvm.or %c30_i64, %5 : i64
    %7 = llvm.icmp "slt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %true = arith.constant true
    %c-3_i64 = arith.constant -3 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "sge" %c-27_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c-3_i64 : i1, i64
    %2 = llvm.xor %arg0, %arg1 : i64
    %3 = llvm.select %true, %2, %1 : i1, i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.or %1, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "slt" %c-8_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.udiv %6, %1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %false = arith.constant false
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.ashr %c-26_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.select %false, %0, %2 : i1, i64
    %5 = llvm.urem %c18_i64, %arg1 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32) -> i1 {
    %true = arith.constant true
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %c-27_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %true, %3, %0 : i1, i64
    %5 = llvm.zext %arg1 : i32 to i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.sext %arg0 : i32 to i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.urem %c-38_i64, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.sext %5 : i32 to i64
    %7 = llvm.udiv %c38_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c41_i32 = arith.constant 41 : i32
    %c-6_i64 = arith.constant -6 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.urem %c-6_i64, %c8_i64 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.sext %c41_i32 : i32 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.and %4, %0 : i64
    %6 = llvm.ashr %arg0, %c-16_i64 : i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %false = arith.constant false
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.icmp "sge" %1, %c1_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.xor %1, %arg1 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i32 {
    %c-21_i64 = arith.constant -21 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %c43_i64, %0 : i1, i64
    %2 = llvm.udiv %arg1, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.udiv %arg2, %c-21_i64 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.or %1, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.xor %c-43_i64, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.and %c-27_i64, %c39_i64 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i32 {
    %c-17_i64 = arith.constant -17 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.select %arg1, %arg0, %c41_i64 : i1, i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %c-17_i64 : i64
    %4 = llvm.select %3, %arg0, %0 : i1, i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-5_i64 = arith.constant -5 : i64
    %false = arith.constant false
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.select %false, %c24_i64, %arg0 : i1, i64
    %1 = llvm.udiv %c-5_i64, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.select %arg1, %c34_i64, %0 : i1, i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.xor %5, %c-41_i64 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.sdiv %arg0, %c-18_i64 : i64
    %1 = llvm.urem %c-12_i64, %0 : i64
    %2 = llvm.and %c38_i64, %1 : i64
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.urem %arg1, %1 : i64
    %7 = llvm.icmp "sle" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32, %arg2: i64) -> i32 {
    %0 = llvm.zext %arg1 : i32 to i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.udiv %3, %0 : i64
    %5 = llvm.urem %arg2, %0 : i64
    %6 = llvm.select %1, %4, %5 : i1, i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c8_i64 = arith.constant 8 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.lshr %c-33_i64, %arg0 : i64
    %1 = llvm.trunc %c8_i64 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.xor %0, %arg2 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.xor %0, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c1_i64 = arith.constant 1 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg1, %arg2 : i64
    %3 = llvm.ashr %c-14_i64, %2 : i64
    %4 = llvm.lshr %c1_i64, %3 : i64
    %5 = llvm.xor %4, %c-31_i64 : i64
    %6 = llvm.ashr %3, %5 : i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i32 {
    %c29_i64 = arith.constant 29 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.udiv %c31_i64, %arg1 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.sdiv %3, %0 : i64
    %5 = llvm.srem %4, %c29_i64 : i64
    %6 = llvm.select %arg0, %1, %5 : i1, i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i32 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.srem %0, %arg1 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.ashr %2, %5 : i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %true = arith.constant true
    %c-50_i64 = arith.constant -50 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.or %c-36_i64, %arg2 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.xor %0, %c-50_i64 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.select %true, %2, %c-13_i64 : i1, i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.sext %arg0 : i32 to i64
    %1 = llvm.sdiv %c-29_i64, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.sext %arg0 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.lshr %5, %1 : i64
    %7 = llvm.and %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i32 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.zext %3 : i1 to i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i32 {
    %0 = llvm.trunc %arg1 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32) -> i32 {
    %c-12_i64 = arith.constant -12 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.sext %arg1 : i32 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %c46_i64, %1 : i64
    %3 = llvm.urem %c-12_i64, %2 : i64
    %4 = llvm.sext %arg1 : i32 to i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %c6_i64 : i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.select %3, %c41_i64, %1 : i1, i64
    %5 = llvm.trunc %4 : i64 to i1
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-24_i64 = arith.constant -24 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %c-24_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %c14_i64, %2 : i64
    %4 = llvm.or %2, %arg0 : i64
    %5 = llvm.select %true, %0, %arg0 : i1, i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.sdiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c24_i64 = arith.constant 24 : i64
    %c4_i64 = arith.constant 4 : i64
    %c22_i64 = arith.constant 22 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.udiv %c19_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.xor %c22_i64, %1 : i64
    %3 = llvm.xor %c24_i64, %arg1 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.srem %c4_i64, %4 : i64
    %6 = llvm.urem %2, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.xor %c4_i64, %c-48_i64 : i64
    %1 = llvm.srem %c-18_i64, %0 : i64
    %2 = llvm.icmp "slt" %arg1, %c-29_i64 : i64
    %3 = llvm.select %2, %c-36_i64, %0 : i1, i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.urem %arg0, %c50_i64 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.select %arg1, %arg2, %c44_i64 : i1, i64
    %4 = llvm.xor %3, %arg2 : i64
    %5 = llvm.srem %c-4_i64, %4 : i64
    %6 = llvm.urem %5, %2 : i64
    %7 = llvm.ashr %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "sge" %c17_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.lshr %3, %c1_i64 : i64
    %6 = llvm.select %4, %1, %5 : i1, i64
    %7 = llvm.icmp "ult" %6, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c31_i64 = arith.constant 31 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.trunc %c12_i64 : i64 to i1
    %1 = llvm.select %0, %c31_i64, %arg0 : i1, i64
    %2 = llvm.urem %c35_i64, %1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.udiv %3, %3 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.and %arg0, %5 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %true = arith.constant true
    %c-10_i64 = arith.constant -10 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.ashr %arg0, %c7_i64 : i64
    %1 = llvm.xor %c-10_i64, %0 : i64
    %2 = llvm.sdiv %0, %0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.select %true, %2, %arg1 : i1, i64
    %5 = llvm.sdiv %4, %4 : i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c32_i64 = arith.constant 32 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.xor %c32_i64, %arg0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.select %0, %c-40_i64, %2 : i1, i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.udiv %c-25_i64, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.srem %c38_i64, %arg0 : i64
    %1 = llvm.select %arg2, %arg0, %0 : i1, i64
    %2 = llvm.icmp "ugt" %arg1, %1 : i64
    %3 = llvm.and %c-32_i64, %c32_i64 : i64
    %4 = llvm.or %1, %arg1 : i64
    %5 = llvm.lshr %c19_i64, %4 : i64
    %6 = llvm.select %2, %3, %5 : i1, i64
    %7 = llvm.and %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.srem %c-47_i64, %c24_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.urem %c-43_i64, %1 : i64
    %3 = llvm.sdiv %2, %c23_i64 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.ashr %arg0, %c-17_i64 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.sdiv %c-33_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.sdiv %arg1, %arg2 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.select %0, %c49_i64, %arg0 : i1, i64
    %2 = llvm.xor %1, %c-50_i64 : i64
    %3 = llvm.udiv %c-34_i64, %2 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.urem %5, %c10_i64 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %c-35_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %1, %c-27_i64, %c17_i64 : i1, i64
    %4 = llvm.and %0, %c43_i64 : i64
    %5 = llvm.sdiv %c-23_i64, %4 : i64
    %6 = llvm.or %3, %5 : i64
    %7 = llvm.icmp "sge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %c-36_i64, %c-31_i64 : i1, i64
    %2 = llvm.lshr %1, %c-9_i64 : i64
    %3 = llvm.lshr %2, %arg2 : i64
    %4 = llvm.select %0, %arg0, %3 : i1, i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-24_i64 = arith.constant -24 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.urem %c-25_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.udiv %c-24_i64, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i32 {
    %c-44_i64 = arith.constant -44 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.select %arg0, %c-36_i64, %arg1 : i1, i64
    %1 = llvm.udiv %c-11_i64, %0 : i64
    %2 = llvm.xor %arg2, %arg1 : i64
    %3 = llvm.and %2, %c-44_i64 : i64
    %4 = llvm.urem %arg1, %3 : i64
    %5 = llvm.srem %4, %arg1 : i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "ugt" %arg1, %arg2 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.xor %c19_i64, %2 : i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.urem %arg0, %5 : i64
    %7 = llvm.icmp "sge" %c46_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-45_i32 = arith.constant -45 : i32
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.and %arg0, %c38_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.urem %arg1, %arg1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %1, %4, %arg0 : i1, i64
    %6 = llvm.sext %c-45_i32 : i32 to i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i32 {
    %c-48_i64 = arith.constant -48 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.sdiv %c-48_i64, %c30_i64 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.udiv %0, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i32 {
    %c-12_i64 = arith.constant -12 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.sdiv %arg0, %c48_i64 : i64
    %1 = llvm.select %arg2, %c-12_i64, %arg0 : i1, i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.ashr %4, %4 : i64
    %6 = llvm.sdiv %0, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-30_i32 = arith.constant -30 : i32
    %c-45_i64 = arith.constant -45 : i64
    %c-26_i64 = arith.constant -26 : i64
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.select %false, %arg2, %c-26_i64 : i1, i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %c-45_i64, %arg0 : i64
    %5 = llvm.sext %c-30_i32 : i32 to i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.and %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32) -> i32 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.and %c-14_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.sext %arg1 : i32 to i64
    %3 = llvm.select %1, %2, %arg0 : i1, i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c41_i64 = arith.constant 41 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.ashr %arg0, %c31_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.sdiv %c41_i64, %arg0 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.trunc %c-17_i64 : i64 to i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.urem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.trunc %c-3_i64 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.or %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.sdiv %c24_i64, %0 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.udiv %1, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
