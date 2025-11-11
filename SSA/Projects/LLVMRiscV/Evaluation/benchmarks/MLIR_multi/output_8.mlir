module {
  func.func @main(%arg0: i64) -> i32 {
    %c20_i64 = arith.constant 20 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.or %c-9_i64, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.srem %arg0, %c20_i64 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.select %2, %arg0, %5 : i1, i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-14_i64 = arith.constant -14 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.xor %arg0, %c-4_i64 : i64
    %1 = llvm.xor %c5_i64, %0 : i64
    %2 = llvm.select %false, %arg0, %1 : i1, i64
    %3 = llvm.trunc %c5_i64 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.udiv %1, %5 : i64
    %7 = llvm.udiv %c-14_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c23_i64 = arith.constant 23 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.lshr %c23_i64, %1 : i64
    %3 = llvm.xor %c-26_i64, %2 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.select %arg2, %c-13_i64, %1 : i1, i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.ashr %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32, %arg2: i64) -> i32 {
    %c17_i64 = arith.constant 17 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sext %arg1 : i32 to i64
    %1 = llvm.urem %0, %c41_i64 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.select %2, %arg2, %c17_i64 : i1, i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.udiv %4, %arg2 : i64
    %6 = llvm.udiv %arg0, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.lshr %c-21_i64, %c25_i64 : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.sdiv %1, %c-8_i64 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.srem %0, %arg1 : i64
    %5 = llvm.xor %c-7_i64, %4 : i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i32 {
    %c-50_i64 = arith.constant -50 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.xor %c24_i64, %arg0 : i64
    %1 = llvm.srem %0, %c-43_i64 : i64
    %2 = llvm.sdiv %c-50_i64, %arg1 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.xor %arg1, %arg2 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.sext %5 : i32 to i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c15_i64 = arith.constant 15 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.lshr %arg2, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.ashr %4, %c-8_i64 : i64
    %6 = llvm.and %5, %c15_i64 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i32 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.select %arg0, %c-13_i64, %arg1 : i1, i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.urem %0, %arg2 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.or %0, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.udiv %arg0, %c-21_i64 : i64
    %1 = llvm.ashr %0, %c-36_i64 : i64
    %2 = llvm.sdiv %arg0, %arg1 : i64
    %3 = llvm.udiv %arg0, %1 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.ashr %5, %c-31_i64 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i32 {
    %c4_i64 = arith.constant 4 : i64
    %c24_i64 = arith.constant 24 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.select %arg0, %c46_i64, %arg1 : i1, i64
    %1 = llvm.srem %0, %c24_i64 : i64
    %2 = llvm.ashr %c-35_i64, %1 : i64
    %3 = llvm.select %arg0, %c-36_i64, %2 : i1, i64
    %4 = llvm.srem %3, %0 : i64
    %5 = llvm.sdiv %c4_i64, %4 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.trunc %c-7_i64 : i64 to i1
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.udiv %5, %c-21_i64 : i64
    %7 = llvm.lshr %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i32 {
    %c-1_i64 = arith.constant -1 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.and %c-26_i64, %arg0 : i64
    %1 = llvm.lshr %c-1_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.or %arg2, %4 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i32) -> i64 {
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.select %true, %2, %3 : i1, i64
    %5 = llvm.zext %arg2 : i32 to i64
    %6 = llvm.and %1, %5 : i64
    %7 = llvm.ashr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-8_i64 = arith.constant -8 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.sdiv %c-29_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.urem %c44_i64, %c-8_i64 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.urem %0, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %false = arith.constant false
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "sge" %c-24_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.icmp "sge" %c-18_i64, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %false, %2, %4 : i1, i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.icmp "ule" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.or %arg0, %c7_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.sdiv %1, %c-15_i64 : i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.lshr %c-16_i64, %5 : i64
    %7 = llvm.icmp "eq" %6, %c36_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %false = arith.constant false
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %c-14_i64 : i64
    %4 = llvm.select %false, %2, %c8_i64 : i1, i64
    %5 = llvm.select %3, %4, %4 : i1, i64
    %6 = llvm.sdiv %2, %5 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.urem %arg0, %c26_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.zext %6 : i32 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-9_i64 = arith.constant -9 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c-9_i64 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.udiv %c48_i64, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-47_i64 = arith.constant -47 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.urem %c-35_i64, %arg0 : i64
    %1 = llvm.udiv %c-13_i64, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.srem %c-47_i64, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %arg2 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %c-14_i64, %4 : i64
    %6 = llvm.urem %2, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %c26_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.select %arg1, %1, %arg2 : i1, i64
    %4 = llvm.urem %3, %c17_i64 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i32 {
    %c9_i64 = arith.constant 9 : i64
    %c17_i64 = arith.constant 17 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.xor %c47_i64, %arg2 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.select %arg0, %c17_i64, %1 : i1, i64
    %3 = llvm.ashr %c9_i64, %2 : i64
    %4 = llvm.sext %arg0 : i1 to i64
    %5 = llvm.xor %4, %3 : i64
    %6 = llvm.ashr %3, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.or %c-11_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.srem %2, %c14_i64 : i64
    %4 = llvm.lshr %3, %2 : i64
    %5 = llvm.or %4, %4 : i64
    %6 = llvm.srem %c-40_i64, %3 : i64
    %7 = llvm.or %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c37_i64 = arith.constant 37 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c-24_i64 : i64
    %2 = llvm.trunc %arg1 : i64 to i1
    %3 = llvm.lshr %c37_i64, %arg2 : i64
    %4 = llvm.select %2, %arg2, %3 : i1, i64
    %5 = llvm.udiv %c-16_i64, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i32) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.xor %2, %0 : i64
    %4 = llvm.sext %arg2 : i32 to i64
    %5 = llvm.select %true, %2, %c-2_i64 : i1, i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "uge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-42_i64 = arith.constant -42 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %c-42_i64, %c-32_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.select %true, %1, %arg0 : i1, i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-44_i64 = arith.constant -44 : i64
    %c39_i64 = arith.constant 39 : i64
    %c28_i64 = arith.constant 28 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %c-28_i64, %arg0 : i64
    %1 = llvm.ashr %c4_i64, %0 : i64
    %2 = llvm.icmp "slt" %c39_i64, %arg0 : i64
    %3 = llvm.and %c-44_i64, %1 : i64
    %4 = llvm.select %2, %arg0, %3 : i1, i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.xor %c28_i64, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c29_i64 = arith.constant 29 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.sdiv %c29_i64, %c-42_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.and %c6_i64, %arg2 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.sext %6 : i32 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.udiv %c42_i64, %arg0 : i64
    %1 = llvm.srem %arg2, %arg2 : i64
    %2 = llvm.udiv %c-21_i64, %c-16_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.sdiv %0, %4 : i64
    %6 = llvm.urem %c-13_i64, %5 : i64
    %7 = llvm.icmp "ult" %c8_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i32) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c26_i64 = arith.constant 26 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %c-12_i64, %c48_i64 : i64
    %1 = llvm.ashr %c26_i64, %0 : i64
    %2 = llvm.or %0, %arg0 : i64
    %3 = llvm.sdiv %c-37_i64, %2 : i64
    %4 = llvm.icmp "ugt" %3, %c-23_i64 : i64
    %5 = llvm.sext %arg2 : i32 to i64
    %6 = llvm.select %4, %arg1, %5 : i1, i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c-48_i32 = arith.constant -48 : i32
    %0 = llvm.sext %c-48_i32 : i32 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.lshr %arg1, %c-11_i64 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.lshr %0, %5 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c29_i64 = arith.constant 29 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.and %arg0, %c-33_i64 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.select %1, %arg1, %c-36_i64 : i1, i64
    %3 = llvm.ashr %arg1, %arg1 : i64
    %4 = llvm.sdiv %3, %c29_i64 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.and %5, %arg0 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i32 {
    %c29_i64 = arith.constant 29 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.urem %c26_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %arg2, %c29_i64, %0 : i1, i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.or %0, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.xor %arg0, %c-42_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %0, %c-31_i64 : i64
    %6 = llvm.urem %5, %4 : i64
    %7 = llvm.udiv %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.trunc %c10_i64 : i64 to i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "sle" %arg0, %c13_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %c39_i64, %1 : i64
    %3 = llvm.urem %1, %arg0 : i64
    %4 = llvm.sdiv %arg1, %arg2 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.urem %6, %arg0 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c20_i64 = arith.constant 20 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c1_i64 : i64
    %2 = llvm.or %c12_i64, %0 : i64
    %3 = llvm.urem %c20_i64, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.urem %4, %3 : i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.trunc %c-41_i64 : i64 to i1
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.lshr %c40_i64, %2 : i64
    %5 = llvm.and %arg1, %4 : i64
    %6 = llvm.select %0, %3, %5 : i1, i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.udiv %c-36_i64, %arg0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.xor %1, %arg1 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.and %3, %c43_i64 : i64
    %6 = llvm.udiv %c-25_i64, %5 : i64
    %7 = llvm.select %0, %4, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.xor %0, %c-25_i64 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.sdiv %c-11_i64, %5 : i64
    %7 = llvm.udiv %6, %c-4_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-50_i64 = arith.constant -50 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sdiv %c-8_i64, %0 : i64
    %2 = llvm.ashr %c-50_i64, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %1, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64, %arg2: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.sext %arg0 : i32 to i64
    %2 = llvm.icmp "eq" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.udiv %arg1, %c-20_i64 : i64
    %6 = llvm.select %4, %5, %arg2 : i1, i64
    %7 = llvm.or %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %0, %1 : i64
    %5 = llvm.ashr %arg2, %arg0 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.udiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c37_i64 = arith.constant 37 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.or %c37_i64, %arg1 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    %5 = llvm.select %4, %arg1, %arg1 : i1, i64
    %6 = llvm.ashr %c32_i64, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %arg1, %c29_i64 : i64
    %2 = llvm.urem %c-44_i64, %0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.srem %arg1, %c-44_i64 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.xor %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32, %arg2: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %true = arith.constant true
    %0 = llvm.zext %arg1 : i32 to i64
    %1 = llvm.udiv %arg2, %c-5_i64 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %3, %arg0 : i64
    %5 = llvm.select %true, %0, %4 : i1, i64
    %6 = llvm.srem %arg0, %5 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.srem %arg1, %arg2 : i64
    %6 = llvm.srem %5, %c39_i64 : i64
    %7 = llvm.sdiv %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c36_i64 = arith.constant 36 : i64
    %c28_i64 = arith.constant 28 : i64
    %c18_i64 = arith.constant 18 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.lshr %c18_i64, %c45_i64 : i64
    %1 = llvm.ashr %c28_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.select %2, %c36_i64, %arg0 : i1, i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.sdiv %c12_i64, %1 : i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %false = arith.constant false
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.select %false, %c1_i64, %3 : i1, i64
    %5 = llvm.xor %arg1, %arg2 : i64
    %6 = llvm.and %5, %c25_i64 : i64
    %7 = llvm.icmp "sle" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.ashr %3, %arg0 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.udiv %5, %2 : i64
    %7 = llvm.urem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-17_i64 = arith.constant -17 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c40_i64 = arith.constant 40 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.lshr %c5_i64, %c-18_i64 : i64
    %1 = llvm.ashr %c40_i64, %c-26_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.and %c-17_i64, %arg0 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.trunc %arg0 : i64 to i1
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.and %arg1, %arg2 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.and %c30_i64, %c-29_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.xor %c40_i64, %arg0 : i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c37_i64 = arith.constant 37 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c21_i32 = arith.constant 21 : i32
    %0 = llvm.sext %c21_i32 : i32 to i64
    %1 = llvm.xor %c-26_i64, %0 : i64
    %2 = llvm.xor %1, %c37_i64 : i64
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.ashr %0, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c13_i32 = arith.constant 13 : i32
    %0 = llvm.sext %c13_i32 : i32 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.udiv %1, %c-3_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.srem %arg0, %arg1 : i64
    %5 = llvm.or %arg0, %4 : i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.icmp "sgt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.select %arg1, %0, %arg2 : i1, i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.sext %5 : i32 to i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.or %arg0, %c15_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.urem %arg2, %2 : i64
    %4 = llvm.ashr %3, %0 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.and %arg0, %5 : i64
    %7 = llvm.lshr %c-3_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.ashr %arg0, %c-2_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.or %3, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    %6 = llvm.select %5, %arg0, %arg1 : i1, i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i32 {
    %c-28_i64 = arith.constant -28 : i64
    %c3_i64 = arith.constant 3 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.ashr %c-49_i64, %c32_i64 : i64
    %1 = llvm.trunc %arg0 : i64 to i1
    %2 = llvm.sdiv %arg2, %c3_i64 : i64
    %3 = llvm.select %arg1, %2, %c-28_i64 : i1, i64
    %4 = llvm.and %2, %arg2 : i64
    %5 = llvm.select %1, %3, %4 : i1, i64
    %6 = llvm.or %0, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c47_i64 = arith.constant 47 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.udiv %arg0, %c8_i64 : i64
    %1 = llvm.and %c47_i64, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.urem %arg2, %c31_i64 : i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c-50_i64 = arith.constant -50 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "uge" %arg1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %3, %c-41_i64 : i64
    %5 = llvm.ashr %4, %c-50_i64 : i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c20_i64 = arith.constant 20 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.lshr %c-36_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c20_i64 : i64
    %2 = llvm.trunc %arg2 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.select %1, %arg1, %5 : i1, i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.select %3, %arg1, %c5_i64 : i1, i64
    %5 = llvm.urem %arg1, %4 : i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %c-1_i64, %0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.and %c34_i64, %3 : i64
    %5 = llvm.select %arg0, %2, %c28_i64 : i1, i64
    %6 = llvm.sdiv %5, %0 : i64
    %7 = llvm.sdiv %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c34_i64 = arith.constant 34 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "sge" %c-3_i64, %c21_i64 : i64
    %1 = llvm.select %0, %arg0, %c14_i64 : i1, i64
    %2 = llvm.ashr %arg0, %arg0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.trunc %c34_i64 : i64 to i1
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c37_i64 = arith.constant 37 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.ashr %c40_i64, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.udiv %c37_i64, %1 : i64
    %3 = llvm.udiv %arg2, %c-3_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "ule" %arg1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c12_i64 = arith.constant 12 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.xor %c-24_i64, %c34_i64 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.lshr %arg0, %arg1 : i64
    %3 = llvm.select %1, %c12_i64, %2 : i1, i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.urem %0, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.xor %arg0, %c-2_i64 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.trunc %c13_i64 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.sdiv %c-20_i64, %4 : i64
    %6 = llvm.or %2, %5 : i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c-32_i32 = arith.constant -32 : i32
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %c-32_i32 : i32 to i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.and %c14_i64, %1 : i64
    %6 = llvm.xor %5, %1 : i64
    %7 = llvm.lshr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c1_i64 = arith.constant 1 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %c-33_i64, %arg1 : i64
    %3 = llvm.sdiv %c1_i64, %arg0 : i64
    %4 = llvm.urem %3, %c-27_i64 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.trunc %arg2 : i64 to i1
    %3 = llvm.udiv %c29_i64, %c25_i64 : i64
    %4 = llvm.or %arg0, %arg1 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.select %2, %5, %arg2 : i1, i64
    %7 = llvm.lshr %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c34_i64 = arith.constant 34 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.xor %c34_i64, %c4_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %c50_i64, %0 : i64
    %3 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c2_i64 = arith.constant 2 : i64
    %true = arith.constant true
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %arg1, %c-27_i64 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.select %true, %c2_i64, %2 : i1, i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.or %5, %c49_i64 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %c39_i64 = arith.constant 39 : i64
    %c37_i64 = arith.constant 37 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.urem %arg2, %c4_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.xor %c37_i64, %c39_i64 : i64
    %5 = llvm.select %false, %c36_i64, %arg2 : i1, i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.urem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.or %arg0, %c-8_i64 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.select %arg1, %c-13_i64, %0 : i1, i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.select %1, %3, %arg0 : i1, i64
    %5 = llvm.srem %c-7_i64, %0 : i64
    %6 = llvm.or %5, %3 : i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "ne" %arg0, %c-34_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.trunc %c3_i64 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.srem %c-14_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.xor %c12_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.sdiv %0, %arg1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.or %arg1, %arg2 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.urem %arg0, %c6_i64 : i64
    %1 = llvm.xor %c15_i64, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.ashr %5, %2 : i64
    %7 = llvm.udiv %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.or %1, %c31_i64 : i64
    %3 = llvm.xor %c-37_i64, %arg2 : i64
    %4 = llvm.or %3, %1 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.select %arg0, %c34_i64, %c-12_i64 : i1, i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-32_i64 = arith.constant -32 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.sdiv %c17_i64, %arg0 : i64
    %1 = llvm.srem %c-32_i64, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.trunc %arg1 : i64 to i1
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    %3 = llvm.urem %c-26_i64, %c-50_i64 : i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.sext %6 : i32 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-5_i64 = arith.constant -5 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.srem %c25_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.or %3, %c-5_i64 : i64
    %5 = llvm.urem %4, %arg1 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.and %c27_i64, %c-46_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ule" %c37_i64, %3 : i64
    %5 = llvm.sext %arg0 : i32 to i64
    %6 = llvm.select %4, %5, %5 : i1, i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c-25_i32 = arith.constant -25 : i32
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sext %c-25_i32 : i32 to i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    %6 = llvm.select %5, %arg2, %0 : i1, i64
    %7 = llvm.icmp "ule" %6, %c9_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %c-38_i64, %0 : i64
    %2 = llvm.urem %c47_i64, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.urem %arg1, %0 : i64
    %5 = llvm.sdiv %4, %c-29_i64 : i64
    %6 = llvm.sdiv %3, %5 : i64
    %7 = llvm.icmp "ule" %c-33_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-7_i64 = arith.constant -7 : i64
    %c-22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %arg0, %arg1 : i1, i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.ashr %c-22_i64, %2 : i64
    %5 = llvm.ashr %4, %c-7_i64 : i64
    %6 = llvm.select %true, %3, %5 : i1, i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c37_i64 = arith.constant 37 : i64
    %c30_i64 = arith.constant 30 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.urem %arg0, %c49_i64 : i64
    %1 = llvm.sdiv %c30_i64, %0 : i64
    %2 = llvm.or %c37_i64, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.ashr %2, %5 : i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c-48_i64 = arith.constant -48 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.sdiv %arg0, %c8_i64 : i64
    %1 = llvm.ashr %c-42_i64, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "ugt" %2, %1 : i64
    %4 = llvm.lshr %c-48_i64, %arg0 : i64
    %5 = llvm.select %3, %4, %arg2 : i1, i64
    %6 = llvm.or %1, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i32 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.sdiv %arg0, %c-19_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.or %1, %0 : i64
    %6 = llvm.select %4, %5, %0 : i1, i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.udiv %c-5_i64, %c27_i64 : i64
    %1 = llvm.trunc %c-4_i64 : i64 to i1
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.sdiv %c-25_i64, %arg0 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.sdiv %2, %5 : i64
    %7 = llvm.icmp "slt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.select %false, %arg0, %arg1 : i1, i64
    %3 = llvm.lshr %c-14_i64, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.select %false, %1, %1 : i1, i64
    %6 = llvm.select %false, %arg2, %5 : i1, i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i32 {
    %c18_i64 = arith.constant 18 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %c18_i64 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.and %c-22_i64, %2 : i64
    %4 = llvm.udiv %3, %1 : i64
    %5 = llvm.sdiv %arg1, %arg2 : i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.srem %c50_i64, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.lshr %0, %1 : i64
    %5 = llvm.urem %arg1, %4 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.icmp "ule" %c-38_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c21_i32 = arith.constant 21 : i32
    %c23_i64 = arith.constant 23 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %c48_i64, %arg1 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.udiv %1, %c23_i64 : i64
    %3 = llvm.sext %c21_i32 : i32 to i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.urem %4, %c9_i64 : i64
    %6 = llvm.select %arg0, %0, %5 : i1, i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.urem %c-37_i64, %0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.ashr %3, %arg1 : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.sext %5 : i32 to i64
    %7 = llvm.trunc %6 : i64 to i1
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.sdiv %c-3_i64, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.trunc %6 : i64 to i32
    return %7 : i32
  }
}
// -----
