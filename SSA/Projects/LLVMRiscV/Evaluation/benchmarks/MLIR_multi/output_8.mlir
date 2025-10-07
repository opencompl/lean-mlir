module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c10_i64 = arith.constant 10 : i64
    %c21_i64 = arith.constant 21 : i64
    %c26_i64 = arith.constant 26 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %c-35_i64 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.sdiv %c21_i64, %c10_i64 : i64
    %4 = llvm.ashr %3, %c-39_i64 : i64
    %5 = llvm.ashr %4, %4 : i64
    %6 = llvm.lshr %c26_i64, %5 : i64
    %7 = llvm.select %0, %2, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.and %arg2, %c-50_i64 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.icmp "ne" %arg1, %1 : i64
    %3 = llvm.xor %c8_i64, %arg2 : i64
    %4 = llvm.select %2, %1, %3 : i1, i64
    %5 = llvm.sdiv %arg0, %4 : i64
    %6 = llvm.lshr %arg0, %5 : i64
    %7 = llvm.ashr %6, %1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c22_i64 = arith.constant 22 : i64
    %c-37_i64 = arith.constant -37 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.srem %c-37_i64, %c22_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %c-26_i64, %c-47_i64 : i64
    %5 = llvm.urem %4, %1 : i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.ashr %c23_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.srem %c-29_i64, %1 : i64
    %3 = llvm.icmp "slt" %2, %c-12_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.zext %3 : i1 to i64
    %6 = llvm.xor %5, %1 : i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.xor %arg2, %c-17_i64 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    %5 = llvm.select %4, %2, %c30_i64 : i1, i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.and %c-22_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.urem %2, %c-39_i64 : i64
    %4 = llvm.icmp "sgt" %1, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.urem %5, %0 : i64
    %7 = llvm.icmp "slt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %c-13_i64, %c20_i64 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.icmp "ugt" %c-4_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.ashr %c36_i64, %3 : i64
    %5 = llvm.xor %arg2, %4 : i64
    %6 = llvm.sdiv %3, %5 : i64
    %7 = llvm.icmp "sgt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.select %true, %0, %arg2 : i1, i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %c7_i64, %1 : i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.icmp "sgt" %arg2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %c-43_i64, %c-37_i64 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.select %2, %4, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.udiv %c-2_i64, %c-47_i64 : i64
    %3 = llvm.udiv %arg2, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.srem %5, %c26_i64 : i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c28_i64 = arith.constant 28 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "slt" %c28_i64, %c-42_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.udiv %2, %c-9_i64 : i64
    %4 = llvm.ashr %3, %c20_i64 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.and %6, %arg1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c9_i64 = arith.constant 9 : i64
    %c6_i64 = arith.constant 6 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.srem %c7_i64, %arg1 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.icmp "slt" %c6_i64, %c9_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.icmp "ne" %6, %c22_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.srem %c-35_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg1, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %c-42_i64, %arg1 : i64
    %4 = llvm.udiv %c-39_i64, %3 : i64
    %5 = llvm.urem %4, %c2_i64 : i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.icmp "sle" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "sgt" %c-8_i64, %c50_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %arg0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.srem %6, %arg1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.urem %arg1, %c-6_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %arg2, %c-47_i64, %arg0 : i1, i64
    %4 = llvm.srem %c35_i64, %0 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "slt" %c9_i64, %c-18_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    %4 = llvm.urem %c-45_i64, %c10_i64 : i64
    %5 = llvm.icmp "eq" %4, %arg2 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %arg0, %c-36_i64 : i64
    %5 = llvm.xor %arg0, %c24_i64 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.and %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.udiv %arg2, %arg1 : i64
    %1 = llvm.icmp "ule" %arg2, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.xor %3, %c-42_i64 : i64
    %5 = llvm.ashr %arg0, %4 : i64
    %6 = llvm.trunc %true : i1 to i64
    %7 = llvm.icmp "ult" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %0, %2 : i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.srem %6, %arg0 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "ugt" %c30_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.zext %0 : i1 to i64
    %5 = llvm.icmp "sgt" %4, %c42_i64 : i64
    %6 = llvm.select %5, %arg0, %arg1 : i1, i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.sdiv %c31_i64, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.udiv %3, %0 : i64
    %5 = llvm.icmp "slt" %4, %c-4_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.or %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c41_i64 = arith.constant 41 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.lshr %c41_i64, %c24_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.srem %1, %c14_i64 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.udiv %1, %c44_i64 : i64
    %3 = llvm.or %2, %c-32_i64 : i64
    %4 = llvm.icmp "ne" %3, %c-37_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.ashr %5, %2 : i64
    %7 = llvm.udiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %c42_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.or %2, %arg1 : i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %true = arith.constant true
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.and %arg2, %3 : i64
    %5 = llvm.srem %4, %c32_i64 : i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.xor %arg0, %c-16_i64 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %arg2, %c23_i64 : i64
    %6 = llvm.sdiv %5, %c35_i64 : i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c33_i64 = arith.constant 33 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "sle" %c7_i64, %c-30_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %c-44_i64 : i64
    %3 = llvm.and %c33_i64, %2 : i64
    %4 = llvm.or %arg0, %c47_i64 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.udiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.urem %arg0, %c-42_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %arg1, %4 : i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %c7_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c-45_i64, %arg2 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "slt" %arg0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c26_i64 = arith.constant 26 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "ugt" %c-17_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.udiv %c26_i64, %3 : i64
    %5 = llvm.select %arg2, %1, %c-34_i64 : i1, i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.udiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c23_i64 = arith.constant 23 : i64
    %true = arith.constant true
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.urem %c-2_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.select %true, %arg2, %c23_i64 : i1, i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "ule" %c-8_i64, %c43_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %c-36_i64, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %arg0, %4 : i64
    %6 = llvm.icmp "uge" %arg0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "ule" %arg1, %c-14_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "slt" %arg1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.or %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "sle" %c-34_i64, %c-49_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.or %3, %c17_i64 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %true = arith.constant true
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.srem %c-45_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %4, %c30_i64 : i64
    %6 = llvm.ashr %1, %2 : i64
    %7 = llvm.icmp "slt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sdiv %c12_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %c-19_i64, %arg1 : i64
    %2 = llvm.and %arg0, %0 : i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.srem %3, %arg1 : i64
    %5 = llvm.srem %4, %2 : i64
    %6 = llvm.select %1, %5, %5 : i1, i64
    %7 = llvm.icmp "sle" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c10_i64 = arith.constant 10 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "slt" %c42_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %c10_i64, %1 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.or %3, %c-15_i64 : i64
    %5 = llvm.and %4, %2 : i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c31_i64 = arith.constant 31 : i64
    %c18_i64 = arith.constant 18 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "sgt" %c18_i64, %c8_i64 : i64
    %1 = llvm.select %0, %arg0, %c31_i64 : i1, i64
    %2 = llvm.icmp "eq" %arg1, %1 : i64
    %3 = llvm.select %2, %arg2, %c-36_i64 : i1, i64
    %4 = llvm.and %arg2, %3 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c12_i64 = arith.constant 12 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "sgt" %c12_i64, %c-23_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.srem %1, %arg0 : i64
    %4 = llvm.or %c0_i64, %arg0 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.select %2, %c-50_i64, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %true = arith.constant true
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.select %true, %3, %c-25_i64 : i1, i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ult" %c34_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %true = arith.constant true
    %c-41_i64 = arith.constant -41 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.select %arg0, %c-41_i64, %c15_i64 : i1, i64
    %1 = llvm.sdiv %c41_i64, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.select %true, %5, %2 : i1, i64
    %7 = llvm.icmp "slt" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-39_i64 = arith.constant -39 : i64
    %false = arith.constant false
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.urem %arg0, %c38_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.and %arg1, %arg2 : i64
    %4 = llvm.select %false, %c-39_i64, %c-40_i64 : i1, i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.ashr %4, %4 : i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.or %c34_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.sdiv %arg0, %arg1 : i64
    %4 = llvm.sdiv %3, %c-41_i64 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.srem %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c-42_i64 = arith.constant -42 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.urem %arg1, %c-10_i64 : i64
    %2 = llvm.icmp "eq" %arg2, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %c-42_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.srem %0, %5 : i64
    %7 = llvm.icmp "ne" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.sdiv %3, %arg1 : i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %true = arith.constant true
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.ashr %c17_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.lshr %3, %2 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "slt" %6, %c30_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %c-21_i64 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.sdiv %c-50_i64, %c26_i64 : i64
    %5 = llvm.sext %arg1 : i1 to i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.icmp "slt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.srem %c-2_i64, %c-18_i64 : i64
    %1 = llvm.lshr %c36_i64, %0 : i64
    %2 = llvm.lshr %1, %c31_i64 : i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.udiv %3, %2 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ule" %6, %4 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "sle" %c22_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c18_i64, %1 : i64
    %3 = llvm.icmp "eq" %arg1, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.zext %arg2 : i1 to i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %c-29_i64, %0 : i64
    %2 = llvm.icmp "sgt" %c-1_i64, %c0_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %arg2, %3 : i64
    %5 = llvm.srem %arg1, %4 : i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c40_i64 = arith.constant 40 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.lshr %arg1, %c29_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.sdiv %c40_i64, %3 : i64
    %5 = llvm.icmp "ugt" %4, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.xor %c-44_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.srem %c-29_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %arg1, %c5_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.xor %arg2, %0 : i64
    %5 = llvm.lshr %arg2, %3 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.urem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.and %c-37_i64, %c49_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.lshr %c22_i64, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.ashr %5, %1 : i64
    %7 = llvm.sdiv %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %c-5_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %0, %c-11_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.sext %arg1 : i1 to i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.udiv %c11_i64, %arg0 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.or %arg2, %arg1 : i64
    %3 = llvm.ashr %c15_i64, %arg0 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c9_i64 = arith.constant 9 : i64
    %true = arith.constant true
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.select %arg0, %arg1, %c-10_i64 : i1, i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg2 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.select %2, %3, %1 : i1, i64
    %5 = llvm.sdiv %c-33_i64, %3 : i64
    %6 = llvm.or %c9_i64, %5 : i64
    %7 = llvm.srem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.srem %c-49_i64, %c-6_i64 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.lshr %0, %5 : i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.urem %arg1, %3 : i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.srem %5, %arg2 : i64
    %7 = llvm.icmp "sle" %6, %c48_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg0, %arg1 : i64
    %3 = llvm.urem %2, %c-35_i64 : i64
    %4 = llvm.urem %arg2, %c49_i64 : i64
    %5 = llvm.urem %4, %c12_i64 : i64
    %6 = llvm.or %3, %5 : i64
    %7 = llvm.ashr %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %c-32_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.icmp "eq" %2, %c26_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.udiv %2, %5 : i64
    %7 = llvm.icmp "uge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %arg2, %arg1 : i64
    %3 = llvm.icmp "sle" %1, %c47_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %c25_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.urem %5, %arg2 : i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.and %c-36_i64, %c-5_i64 : i64
    %1 = llvm.and %c42_i64, %c32_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %arg1, %1 : i64
    %6 = llvm.lshr %5, %arg1 : i64
    %7 = llvm.ashr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "ugt" %c-43_i64, %c-14_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c-46_i64, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "sge" %3, %arg0 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.lshr %1, %5 : i64
    %7 = llvm.ashr %6, %arg1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c-30_i64 = arith.constant -30 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.ashr %c17_i64, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %c-30_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-35_i64 = arith.constant -35 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %c-35_i64, %0 : i64
    %2 = llvm.sdiv %1, %c0_i64 : i64
    %3 = llvm.udiv %arg0, %0 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.or %c-30_i64, %2 : i64
    %6 = llvm.select %arg1, %arg2, %5 : i1, i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c26_i64 = arith.constant 26 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "eq" %c26_i64, %c25_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %arg1 : i64
    %3 = llvm.srem %c11_i64, %arg0 : i64
    %4 = llvm.select %2, %arg2, %3 : i1, i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c43_i64 = arith.constant 43 : i64
    %c25_i64 = arith.constant 25 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.and %c25_i64, %c14_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.srem %arg0, %arg1 : i64
    %4 = llvm.and %3, %c-12_i64 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.and %c43_i64, %5 : i64
    %7 = llvm.icmp "sge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c-47_i64 = arith.constant -47 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.icmp "sge" %c-47_i64, %c0_i64 : i64
    %3 = llvm.sdiv %arg0, %0 : i64
    %4 = llvm.select %2, %arg0, %3 : i1, i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-33_i64 = arith.constant -33 : i64
    %true = arith.constant true
    %c-26_i64 = arith.constant -26 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.select %true, %c-26_i64, %c-49_i64 : i1, i64
    %1 = llvm.icmp "slt" %arg0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.udiv %c-33_i64, %c-26_i64 : i64
    %6 = llvm.select %4, %5, %c-36_i64 : i1, i64
    %7 = llvm.icmp "sle" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.udiv %0, %arg0 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.and %arg0, %1 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.select %5, %c-8_i64, %arg2 : i1, i64
    %7 = llvm.udiv %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.sdiv %arg1, %arg0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.ashr %4, %arg2 : i64
    %6 = llvm.lshr %1, %5 : i64
    %7 = llvm.xor %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.sdiv %arg0, %c47_i64 : i64
    %1 = llvm.icmp "sgt" %0, %c39_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.ashr %arg1, %4 : i64
    %6 = llvm.xor %0, %5 : i64
    %7 = llvm.srem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %arg1 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.sdiv %c36_i64, %1 : i64
    %5 = llvm.and %arg2, %4 : i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.icmp "sge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.icmp "uge" %c-49_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %c-17_i64 : i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "ne" %c24_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.xor %6, %arg2 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.lshr %c-28_i64, %arg1 : i64
    %5 = llvm.ashr %c30_i64, %4 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %c-23_i64, %0 : i64
    %2 = llvm.urem %arg1, %arg0 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.xor %3, %1 : i64
    %6 = llvm.select %4, %arg2, %5 : i1, i64
    %7 = llvm.icmp "sge" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c11_i64 = arith.constant 11 : i64
    %c49_i64 = arith.constant 49 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sdiv %arg0, %c20_i64 : i64
    %1 = llvm.udiv %c49_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %c11_i64 : i64
    %3 = llvm.ashr %c-14_i64, %c-19_i64 : i64
    %4 = llvm.select %2, %arg1, %3 : i1, i64
    %5 = llvm.urem %arg1, %4 : i64
    %6 = llvm.ashr %0, %5 : i64
    %7 = llvm.icmp "slt" %6, %c-17_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c-38_i64 = arith.constant -38 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.urem %1, %c-38_i64 : i64
    %3 = llvm.icmp "uge" %2, %c24_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c25_i64 = arith.constant 25 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "slt" %c25_i64, %c49_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %c-29_i64, %arg0 : i64
    %3 = llvm.sdiv %c14_i64, %arg0 : i64
    %4 = llvm.select %2, %arg1, %3 : i1, i64
    %5 = llvm.xor %arg1, %arg1 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-5_i64 = arith.constant -5 : i64
    %true = arith.constant true
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.and %c-22_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c-5_i64 : i64
    %2 = llvm.srem %c-43_i64, %c-17_i64 : i64
    %3 = llvm.select %true, %1, %2 : i1, i64
    %4 = llvm.icmp "ult" %arg1, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %5, %c38_i64 : i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %c42_i64 : i64
    %2 = llvm.lshr %0, %0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.lshr %arg1, %3 : i64
    %6 = llvm.xor %1, %5 : i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-34_i64 = arith.constant -34 : i64
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.select %true, %arg2, %arg1 : i1, i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.ashr %2, %c-3_i64 : i64
    %4 = llvm.udiv %c-34_i64, %3 : i64
    %5 = llvm.udiv %c29_i64, %arg1 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c19_i64 = arith.constant 19 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %c19_i64, %0 : i64
    %4 = llvm.icmp "ult" %3, %c37_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c46_i64 = arith.constant 46 : i64
    %c3_i64 = arith.constant 3 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %0, %c46_i64 : i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.ashr %3, %1 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.xor %c3_i64, %5 : i64
    %7 = llvm.icmp "sle" %6, %c-25_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-38_i64 = arith.constant -38 : i64
    %true = arith.constant true
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.and %c42_i64, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.sdiv %arg1, %arg0 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.udiv %c-38_i64, %c16_i64 : i64
    %6 = llvm.select %true, %4, %5 : i1, i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.udiv %c37_i64, %c3_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.xor %arg0, %arg1 : i64
    %4 = llvm.and %arg1, %3 : i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.urem %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c-43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.urem %0, %c6_i64 : i64
    %3 = llvm.ashr %c-43_i64, %2 : i64
    %4 = llvm.srem %2, %2 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.urem %5, %1 : i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c43_i64 = arith.constant 43 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c30_i64, %arg1 : i1, i64
    %2 = llvm.udiv %arg1, %arg0 : i64
    %3 = llvm.xor %c43_i64, %arg2 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.ashr %2, %c19_i64 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg0, %arg0 : i64
    %3 = llvm.ashr %arg1, %arg0 : i64
    %4 = llvm.icmp "ule" %c-21_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %2, %5 : i64
    %7 = llvm.icmp "slt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %c-23_i64, %c14_i64 : i64
    %1 = llvm.or %arg0, %c-17_i64 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.urem %arg1, %0 : i64
    %5 = llvm.srem %1, %arg2 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sdiv %c-49_i64, %0 : i64
    %2 = llvm.icmp "ult" %arg2, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %c25_i64 : i64
    %5 = llvm.trunc %2 : i1 to i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.lshr %arg0, %c28_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.lshr %0, %arg0 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.xor %arg1, %2 : i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.xor %c-2_i64, %c-47_i64 : i64
    %1 = llvm.icmp "sgt" %c-26_i64, %0 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.icmp "sge" %arg1, %c34_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.udiv %2, %5 : i64
    %7 = llvm.icmp "uge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c42_i64 = arith.constant 42 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %c-4_i64, %c-11_i64 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.ashr %c42_i64, %2 : i64
    %4 = llvm.or %c31_i64, %3 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.ashr %arg2, %arg2 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.xor %1, %5 : i64
    %7 = llvm.icmp "sge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.or %c21_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.zext %3 : i1 to i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.icmp "slt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.udiv %c10_i64, %arg1 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %c-36_i64, %arg2 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %arg0, %5 : i64
    %7 = llvm.icmp "eq" %6, %c-47_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.and %c-1_i64, %arg2 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "sge" %6, %c-34_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.or %c34_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.select %arg2, %1, %1 : i1, i64
    %4 = llvm.and %arg1, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.urem %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c16_i64 = arith.constant 16 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.select %arg0, %arg1, %c-5_i64 : i1, i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sdiv %1, %c-42_i64 : i64
    %3 = llvm.icmp "sle" %c-37_i64, %2 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.srem %c16_i64, %4 : i64
    %6 = llvm.select %3, %2, %5 : i1, i64
    %7 = llvm.srem %c-29_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %0 : i64
    %4 = llvm.icmp "sle" %3, %2 : i64
    %5 = llvm.select %4, %3, %0 : i1, i64
    %6 = llvm.and %5, %3 : i64
    %7 = llvm.icmp "ult" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %c-45_i64, %3 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.sdiv %arg1, %3 : i64
    %7 = llvm.select %5, %6, %4 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %c-13_i64, %arg0 : i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.srem %c37_i64, %0 : i64
    %2 = llvm.xor %arg2, %c-30_i64 : i64
    %3 = llvm.icmp "ne" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %4, %c-35_i64 : i64
    %6 = llvm.or %5, %arg2 : i64
    %7 = llvm.icmp "uge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.udiv %arg0, %c-20_i64 : i64
    %1 = llvm.or %0, %c-28_i64 : i64
    %2 = llvm.ashr %c-41_i64, %0 : i64
    %3 = llvm.icmp "slt" %2, %c-37_i64 : i64
    %4 = llvm.trunc %arg1 : i1 to i64
    %5 = llvm.urem %arg2, %2 : i64
    %6 = llvm.select %3, %4, %5 : i1, i64
    %7 = llvm.xor %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c32_i64 = arith.constant 32 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.udiv %c-22_i64, %arg0 : i64
    %1 = llvm.srem %c23_i64, %0 : i64
    %2 = llvm.ashr %c32_i64, %arg1 : i64
    %3 = llvm.ashr %c-27_i64, %c46_i64 : i64
    %4 = llvm.xor %arg2, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.srem %5, %c-9_i64 : i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %c30_i64, %c-26_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "slt" %6, %2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.sext %arg1 : i1 to i64
    %6 = llvm.and %1, %5 : i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c32_i64 = arith.constant 32 : i64
    %c20_i64 = arith.constant 20 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.sdiv %arg2, %c23_i64 : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    %2 = llvm.ashr %c-22_i64, %c30_i64 : i64
    %3 = llvm.urem %2, %c20_i64 : i64
    %4 = llvm.select %1, %3, %c32_i64 : i1, i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sge" %6, %c3_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.icmp "sge" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.trunc %false : i1 to i64
    %7 = llvm.or %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %c-37_i64 : i64
    %2 = llvm.sdiv %c-16_i64, %1 : i64
    %3 = llvm.icmp "eq" %c-6_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %arg0, %c42_i64, %c37_i64 : i1, i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "sge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c18_i64 = arith.constant 18 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "sge" %c18_i64, %c13_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "eq" %2, %c27_i64 : i64
    %4 = llvm.select %3, %c2_i64, %arg1 : i1, i64
    %5 = llvm.srem %4, %1 : i64
    %6 = llvm.or %2, %5 : i64
    %7 = llvm.icmp "slt" %c-18_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %true = arith.constant true
    %c-13_i64 = arith.constant -13 : i64
    %c41_i64 = arith.constant 41 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.xor %c41_i64, %c7_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.or %2, %c-5_i64 : i64
    %4 = llvm.select %true, %3, %arg0 : i1, i64
    %5 = llvm.icmp "ne" %c-13_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.xor %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.xor %c-30_i64, %c-29_i64 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.and %c0_i64, %c-14_i64 : i64
    %1 = llvm.udiv %0, %c23_i64 : i64
    %2 = llvm.xor %arg0, %0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.lshr %3, %0 : i64
    %5 = llvm.icmp "uge" %4, %arg1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.and %6, %0 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c34_i64 = arith.constant 34 : i64
    %false = arith.constant false
    %c-17_i64 = arith.constant -17 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "ugt" %c27_i64, %c-34_i64 : i64
    %1 = llvm.select %false, %c34_i64, %arg0 : i1, i64
    %2 = llvm.select %0, %c-17_i64, %1 : i1, i64
    %3 = llvm.icmp "sle" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %arg1, %c-29_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "sgt" %c-23_i64, %c31_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg0, %c-27_i64 : i64
    %3 = llvm.select %2, %c8_i64, %arg0 : i1, i64
    %4 = llvm.sdiv %c-39_i64, %1 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c-34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "eq" %c-34_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %c-14_i64, %0 : i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c38_i64 = arith.constant 38 : i64
    %true = arith.constant true
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.select %true, %0, %arg2 : i1, i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.xor %3, %c38_i64 : i64
    %5 = llvm.udiv %c-44_i64, %c-20_i64 : i64
    %6 = llvm.select %true, %5, %c-23_i64 : i1, i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "uge" %c-26_i64, %arg0 : i64
    %1 = llvm.urem %c-2_i64, %arg0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.select %0, %2, %arg1 : i1, i64
    %4 = llvm.select %arg2, %2, %c-9_i64 : i1, i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "ne" %5, %c23_i64 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "ne" %arg1, %c4_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    %3 = llvm.ashr %arg2, %arg2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c44_i64 = arith.constant 44 : i64
    %c3_i64 = arith.constant 3 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.lshr %c3_i64, %c18_i64 : i64
    %1 = llvm.lshr %0, %c44_i64 : i64
    %2 = llvm.lshr %c-37_i64, %c-28_i64 : i64
    %3 = llvm.ashr %c-14_i64, %2 : i64
    %4 = llvm.lshr %c29_i64, %arg0 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.ashr %2, %5 : i64
    %7 = llvm.icmp "sle" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "slt" %arg0, %c-20_i64 : i64
    %1 = llvm.lshr %c-22_i64, %c-11_i64 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.urem %arg0, %2 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c22_i64 = arith.constant 22 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %0, %c41_i64 : i64
    %2 = llvm.udiv %c22_i64, %c24_i64 : i64
    %3 = llvm.or %arg1, %0 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.select %1, %2, %5 : i1, i64
    %7 = llvm.icmp "ult" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c-44_i64 = arith.constant -44 : i64
    %false = arith.constant false
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.select %false, %arg0, %c-44_i64 : i1, i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.sdiv %arg0, %c-20_i64 : i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %c-40_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.sdiv %5, %c45_i64 : i64
    %7 = llvm.lshr %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %true = arith.constant true
    %c41_i64 = arith.constant 41 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.and %c-20_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.select %arg2, %arg1, %c41_i64 : i1, i64
    %4 = llvm.select %true, %1, %2 : i1, i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.or %5, %c29_i64 : i64
    %7 = llvm.udiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.or %c-24_i64, %0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.srem %4, %c32_i64 : i64
    %6 = llvm.urem %arg2, %5 : i64
    %7 = llvm.sdiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %arg1, %0, %c-40_i64 : i1, i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.xor %4, %c-2_i64 : i64
    %6 = llvm.urem %5, %5 : i64
    %7 = llvm.sdiv %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.udiv %arg0, %c40_i64 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "uge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.xor %c-18_i64, %0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %4, %c-44_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.srem %6, %c-50_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %true = arith.constant true
    %c-37_i64 = arith.constant -37 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "ult" %c16_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.lshr %c-37_i64, %arg1 : i64
    %4 = llvm.select %arg2, %arg1, %3 : i1, i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.sext %true : i1 to i64
    %7 = llvm.icmp "sge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "sge" %arg0, %c-7_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c-13_i64, %arg1 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.ashr %c-41_i64, %4 : i64
    %6 = llvm.sdiv %5, %c5_i64 : i64
    %7 = llvm.icmp "sle" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c12_i64 = arith.constant 12 : i64
    %true = arith.constant true
    %c-5_i64 = arith.constant -5 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %c-5_i64, %c-12_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.select %true, %1, %1 : i1, i64
    %3 = llvm.udiv %c12_i64, %c-48_i64 : i64
    %4 = llvm.or %c-29_i64, %3 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.select %5, %c-50_i64, %c-21_i64 : i1, i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c40_i64 = arith.constant 40 : i64
    %c35_i64 = arith.constant 35 : i64
    %c33_i64 = arith.constant 33 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.select %arg0, %c27_i64, %arg1 : i1, i64
    %1 = llvm.icmp "slt" %c35_i64, %arg1 : i64
    %2 = llvm.select %1, %c40_i64, %0 : i1, i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.or %5, %c-16_i64 : i64
    %7 = llvm.and %c33_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c25_i64, %c-37_i64 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.select %arg2, %3, %arg0 : i1, i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.or %5, %1 : i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c33_i64 = arith.constant 33 : i64
    %false = arith.constant false
    %c34_i64 = arith.constant 34 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.udiv %c34_i64, %c-32_i64 : i64
    %1 = llvm.srem %0, %c33_i64 : i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.srem %3, %arg1 : i64
    %6 = llvm.xor %5, %c8_i64 : i64
    %7 = llvm.urem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c9_i64 = arith.constant 9 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.or %c-25_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.or %c9_i64, %3 : i64
    %5 = llvm.udiv %arg2, %4 : i64
    %6 = llvm.lshr %c18_i64, %5 : i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %true = arith.constant true
    %false = arith.constant false
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.select %false, %arg0, %c-5_i64 : i1, i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.select %true, %arg1, %1 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.or %arg2, %c-20_i64 : i64
    %5 = llvm.sdiv %2, %arg2 : i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.srem %arg1, %c-29_i64 : i64
    %4 = llvm.srem %arg2, %3 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "uge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %c-29_i64, %c-10_i64 : i64
    %2 = llvm.udiv %1, %c35_i64 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.urem %3, %2 : i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.icmp "sgt" %5, %c44_i64 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.sdiv %c7_i64, %arg0 : i64
    %1 = llvm.urem %0, %c-24_i64 : i64
    %2 = llvm.icmp "sle" %c-6_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "uge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c-16_i64 = arith.constant -16 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c-8_i64 : i64
    %2 = llvm.urem %c-43_i64, %arg1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.sdiv %arg2, %c-16_i64 : i64
    %5 = llvm.trunc %true : i1 to i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.urem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.trunc %arg0 : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ult" %4, %1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %arg2 : i64
    %2 = llvm.icmp "ult" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %3, %1 : i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.select %2, %c-45_i64, %0 : i1, i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "sgt" %arg0, %c20_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg2, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.icmp "ult" %4, %arg2 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.xor %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "sgt" %c-48_i64, %c-7_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c-50_i64, %1 : i64
    %3 = llvm.udiv %2, %c-28_i64 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.xor %arg0, %arg1 : i64
    %6 = llvm.and %5, %5 : i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.icmp "sge" %c-47_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %0, %4 : i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.icmp "ult" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.lshr %1, %1 : i64
    %4 = llvm.icmp "slt" %3, %2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sdiv %2, %5 : i64
    %7 = llvm.ashr %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.srem %c-29_i64, %0 : i64
    %2 = llvm.xor %c-49_i64, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %arg1 : i64
    %4 = llvm.udiv %c27_i64, %2 : i64
    %5 = llvm.xor %arg2, %4 : i64
    %6 = llvm.select %3, %4, %5 : i1, i64
    %7 = llvm.icmp "uge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c37_i64 = arith.constant 37 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.lshr %c11_i64, %arg1 : i64
    %1 = llvm.icmp "ult" %c37_i64, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.and %arg2, %c-49_i64 : i64
    %5 = llvm.select %3, %4, %2 : i1, i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %arg2, %c-37_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %2, %4, %1 : i1, i64
    %6 = llvm.ashr %c-40_i64, %c-33_i64 : i64
    %7 = llvm.ashr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.select %1, %2, %c-39_i64 : i1, i64
    %4 = llvm.or %arg0, %0 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "eq" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "sge" %c-41_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c-46_i64, %arg1 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.select %3, %arg0, %1 : i1, i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.lshr %2, %arg0 : i64
    %7 = llvm.icmp "slt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %c6_i64, %0 : i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.sdiv %arg1, %5 : i64
    %7 = llvm.lshr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.lshr %arg0, %c17_i64 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %c-43_i64, %0 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "ult" %arg1, %c40_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.sdiv %arg0, %c-37_i64 : i64
    %1 = llvm.and %0, %c6_i64 : i64
    %2 = llvm.and %1, %c25_i64 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.and %3, %2 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.ashr %arg1, %4 : i64
    %7 = llvm.icmp "sle" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.urem %c-49_i64, %c43_i64 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c13_i64 = arith.constant 13 : i64
    %c24_i64 = arith.constant 24 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.and %c24_i64, %c-41_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.icmp "ule" %c13_i64, %c-14_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.sdiv %2, %5 : i64
    %7 = llvm.icmp "slt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c45_i64 = arith.constant 45 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.ashr %arg0, %c50_i64 : i64
    %1 = llvm.icmp "sge" %0, %c45_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %c29_i64, %2 : i64
    %4 = llvm.xor %3, %arg0 : i64
    %5 = llvm.udiv %4, %arg0 : i64
    %6 = llvm.or %2, %5 : i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.srem %arg0, %c-23_i64 : i64
    %1 = llvm.or %c-14_i64, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.xor %c46_i64, %c25_i64 : i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.icmp "uge" %4, %0 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.select %arg0, %arg1, %c32_i64 : i1, i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.select %arg2, %c-19_i64, %c-2_i64 : i1, i64
    %5 = llvm.and %4, %0 : i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.icmp "sge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c45_i64 = arith.constant 45 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "sge" %c45_i64, %c34_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %c-13_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %c-42_i64, %3 : i64
    %5 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %6 = llvm.urem %5, %1 : i64
    %7 = llvm.ashr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c13_i64 = arith.constant 13 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %0, %c13_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.urem %2, %c39_i64 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.ashr %5, %5 : i64
    %7 = llvm.icmp "slt" %6, %3 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "uge" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg2, %c23_i64 : i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ne" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg1, %c34_i64 : i64
    %3 = llvm.select %arg2, %c48_i64, %2 : i1, i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.ashr %1, %arg1 : i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %c49_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %4, %2 : i64
    %6 = llvm.icmp "ult" %4, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "eq" %3, %1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.udiv %0, %5 : i64
    %7 = llvm.icmp "ule" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.udiv %c-38_i64, %c-19_i64 : i64
    %1 = llvm.icmp "eq" %c-36_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.and %arg0, %c-49_i64 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.zext %1 : i1 to i64
    %7 = llvm.lshr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c24_i64 = arith.constant 24 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.xor %c24_i64, %c-43_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %c-36_i64, %arg0 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.sext %1 : i1 to i64
    %6 = llvm.select %4, %arg0, %5 : i1, i64
    %7 = llvm.and %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.select %false, %c-11_i64, %arg1 : i1, i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.sdiv %arg2, %arg1 : i64
    %3 = llvm.udiv %arg2, %0 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.urem %arg2, %5 : i64
    %7 = llvm.udiv %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.udiv %arg0, %c0_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.or %c-24_i64, %5 : i64
    %7 = llvm.icmp "sge" %6, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %true = arith.constant true
    %c21_i64 = arith.constant 21 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %c-18_i64, %c21_i64 : i1, i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c38_i64 = arith.constant 38 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.srem %c-39_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %c38_i64, %2 : i64
    %4 = llvm.or %3, %c49_i64 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.and %5, %arg0 : i64
    %7 = llvm.icmp "uge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %c-46_i64 = arith.constant -46 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %c4_i64 : i64
    %3 = llvm.select %2, %c-46_i64, %arg0 : i1, i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.urem %4, %0 : i64
    %6 = llvm.ashr %5, %arg0 : i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.ashr %2, %c39_i64 : i64
    %4 = llvm.icmp "slt" %3, %c-34_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %5, %2 : i64
    %7 = llvm.icmp "sgt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c42_i64 = arith.constant 42 : i64
    %false = arith.constant false
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.lshr %arg0, %c-31_i64 : i64
    %1 = llvm.or %c27_i64, %arg1 : i64
    %2 = llvm.udiv %c42_i64, %1 : i64
    %3 = llvm.select %false, %arg0, %2 : i1, i64
    %4 = llvm.and %arg2, %3 : i64
    %5 = llvm.and %arg1, %4 : i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %c49_i64, %arg0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.icmp "ult" %c34_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.xor %0, %5 : i64
    %7 = llvm.ashr %6, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %c41_i64, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.icmp "sle" %0, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.select %5, %arg1, %arg0 : i1, i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.udiv %1, %c10_i64 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.and %3, %arg0 : i64
    %5 = llvm.icmp "eq" %arg1, %arg2 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.urem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.lshr %arg0, %c6_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %arg1, %c-16_i64 : i64
    %3 = llvm.icmp "sge" %1, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %4, %1 : i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.and %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "sge" %arg0, %c4_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %arg1 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "ne" %c1_i64, %1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %c34_i64, %arg0 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.icmp "eq" %4, %c-38_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.or %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "ule" %c-6_i64, %2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sle" %3, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %false = arith.constant false
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %c-27_i64, %c-27_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.select %3, %arg1, %0 : i1, i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.xor %5, %c42_i64 : i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.xor %c-10_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c-20_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %arg1, %arg1 : i64
    %4 = llvm.lshr %3, %2 : i64
    %5 = llvm.icmp "eq" %arg1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.srem %arg0, %c10_i64 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.udiv %1, %c-4_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.or %2, %c-22_i64 : i64
    %7 = llvm.icmp "sge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c26_i64 = arith.constant 26 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.xor %c26_i64, %c-48_i64 : i64
    %5 = llvm.udiv %4, %0 : i64
    %6 = llvm.ashr %3, %5 : i64
    %7 = llvm.icmp "slt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.sdiv %c-47_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %arg2, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    %6 = llvm.xor %0, %c2_i64 : i64
    %7 = llvm.urem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %arg0, %c-27_i64 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.urem %1, %c-11_i64 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.zext %3 : i1 to i64
    %6 = llvm.lshr %5, %c-23_i64 : i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.srem %c-42_i64, %c-1_i64 : i64
    %1 = llvm.lshr %c-48_i64, %c-33_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %2, %c-40_i64 : i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.lshr %1, %1 : i64
    %6 = llvm.xor %5, %0 : i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %c47_i64 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %arg2, %4 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "eq" %6, %c-28_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-7_i64 = arith.constant -7 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.xor %arg0, %c-5_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %c15_i64, %1 : i64
    %3 = llvm.srem %c-7_i64, %2 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.lshr %5, %arg0 : i64
    %7 = llvm.sdiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "ne" %c3_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %arg2, %3 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.xor %arg1, %5 : i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c17_i64 = arith.constant 17 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c8_i64 : i64
    %2 = llvm.urem %arg2, %c17_i64 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.icmp "sge" %arg1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %5, %c37_i64 : i64
    %7 = llvm.icmp "sle" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.icmp "sge" %c-28_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %c-25_i64 = arith.constant -25 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.srem %c-42_i64, %c-30_i64 : i64
    %1 = llvm.lshr %0, %c-25_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.xor %2, %0 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c3_i64 = arith.constant 3 : i64
    %true = arith.constant true
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.ashr %0, %arg2 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.udiv %4, %c3_i64 : i64
    %6 = llvm.select %3, %5, %c29_i64 : i1, i64
    %7 = llvm.lshr %6, %0 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.or %0, %c8_i64 : i64
    %2 = llvm.or %c-42_i64, %1 : i64
    %3 = llvm.or %c-43_i64, %arg2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.icmp "ne" %arg0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.ashr %0, %5 : i64
    %7 = llvm.urem %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ule" %0, %0 : i64
    %3 = llvm.select %2, %arg1, %0 : i1, i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.srem %1, %5 : i64
    %7 = llvm.icmp "ult" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c37_i64 = arith.constant 37 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %arg1, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %c-40_i64 : i64
    %4 = llvm.sdiv %c37_i64, %c-45_i64 : i64
    %5 = llvm.srem %4, %c39_i64 : i64
    %6 = llvm.select %3, %4, %5 : i1, i64
    %7 = llvm.urem %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.lshr %arg2, %3 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.urem %5, %c-30_i64 : i64
    %7 = llvm.icmp "ult" %6, %c13_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.or %c1_i64, %1 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "uge" %4, %c-38_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c24_i64 = arith.constant 24 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.select %false, %c24_i64, %c-22_i64 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.select %4, %0, %2 : i1, i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %true = arith.constant true
    %c-43_i64 = arith.constant -43 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.sdiv %c34_i64, %c-24_i64 : i64
    %1 = llvm.select %true, %c-43_i64, %0 : i1, i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    %3 = llvm.srem %0, %arg0 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.lshr %arg1, %arg1 : i64
    %6 = llvm.and %c-41_i64, %5 : i64
    %7 = llvm.select %2, %4, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.ashr %c4_i64, %c-22_i64 : i64
    %1 = llvm.ashr %0, %c-9_i64 : i64
    %2 = llvm.xor %c-49_i64, %c30_i64 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.or %3, %arg0 : i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.zext %arg1 : i1 to i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.ashr %c-6_i64, %2 : i64
    %4 = llvm.srem %3, %2 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.udiv %2, %3 : i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.udiv %arg0, %c14_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ult" %c-6_i64, %c4_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sdiv %c44_i64, %arg0 : i64
    %1 = llvm.ashr %arg2, %arg2 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.sdiv %0, %1 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c30_i64 = arith.constant 30 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.lshr %c16_i64, %arg0 : i64
    %1 = llvm.lshr %c30_i64, %0 : i64
    %2 = llvm.lshr %c-22_i64, %arg0 : i64
    %3 = llvm.sdiv %arg0, %arg1 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %5, %5 : i64
    %7 = llvm.icmp "slt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c7_i64 = arith.constant 7 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "eq" %c50_i64, %c-2_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %c7_i64, %1 : i64
    %3 = llvm.sdiv %c-7_i64, %1 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.udiv %2, %5 : i64
    %7 = llvm.icmp "eq" %c-9_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.udiv %arg0, %c-28_i64 : i64
    %1 = llvm.select %arg1, %arg2, %0 : i1, i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.udiv %1, %5 : i64
    %7 = llvm.icmp "sgt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %c10_i64, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.srem %0, %2 : i64
    %5 = llvm.lshr %4, %2 : i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.and %c-15_i64, %c37_i64 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.urem %0, %c-16_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.icmp "slt" %5, %c40_i64 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.urem %c32_i64, %c-50_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %c30_i64, %arg1 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.urem %6, %1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %arg2, %c35_i64 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.udiv %3, %1 : i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "ugt" %c47_i64, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %3, %0 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "sle" %arg0, %c-9_i64 : i64
    %1 = llvm.icmp "slt" %arg1, %arg1 : i64
    %2 = llvm.sdiv %arg2, %arg0 : i64
    %3 = llvm.select %1, %c-27_i64, %2 : i1, i64
    %4 = llvm.select %0, %arg1, %3 : i1, i64
    %5 = llvm.icmp "ne" %4, %c8_i64 : i64
    %6 = llvm.select %5, %2, %arg0 : i1, i64
    %7 = llvm.icmp "ule" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.sdiv %1, %0 : i64
    %6 = llvm.lshr %c35_i64, %5 : i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.urem %c-15_i64, %c28_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.lshr %arg0, %c-21_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %arg0, %c-47_i64 : i64
    %1 = llvm.icmp "eq" %arg1, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.icmp "ule" %3, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.urem %5, %arg2 : i64
    %7 = llvm.urem %6, %c44_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ule" %arg0, %c-13_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.xor %c-1_i64, %2 : i64
    %4 = llvm.ashr %arg1, %2 : i64
    %5 = llvm.sdiv %c22_i64, %4 : i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.icmp "sle" %c-5_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.urem %0, %5 : i64
    %7 = llvm.srem %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c-22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %c-22_i64, %arg1 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.lshr %2, %arg2 : i64
    %4 = llvm.select %true, %0, %3 : i1, i64
    %5 = llvm.icmp "uge" %0, %c34_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.lshr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.urem %c-4_i64, %c34_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.lshr %0, %arg1 : i64
    %5 = llvm.select %3, %4, %arg2 : i1, i64
    %6 = llvm.udiv %arg1, %5 : i64
    %7 = llvm.select %3, %c-38_i64, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c50_i64 = arith.constant 50 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %c50_i64 : i64
    %3 = llvm.select %2, %c-10_i64, %arg0 : i1, i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "eq" %4, %arg0 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "eq" %6, %c45_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.or %arg0, %arg2 : i64
    %4 = llvm.select %arg1, %3, %0 : i1, i64
    %5 = llvm.select %true, %3, %c31_i64 : i1, i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "slt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.and %c-36_i64, %0 : i64
    %3 = llvm.udiv %c-5_i64, %2 : i64
    %4 = llvm.or %1, %0 : i64
    %5 = llvm.and %4, %arg1 : i64
    %6 = llvm.ashr %3, %5 : i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.or %3, %c-13_i64 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "slt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.ashr %arg0, %c1_i64 : i64
    %1 = llvm.sdiv %0, %c36_i64 : i64
    %2 = llvm.udiv %c-31_i64, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.udiv %c41_i64, %3 : i64
    %5 = llvm.udiv %0, %arg2 : i64
    %6 = llvm.select %arg1, %4, %5 : i1, i64
    %7 = llvm.lshr %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c46_i64 = arith.constant 46 : i64
    %c0_i64 = arith.constant 0 : i64
    %c2_i64 = arith.constant 2 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.xor %arg0, %c40_i64 : i64
    %1 = llvm.ashr %arg1, %c2_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %c0_i64 : i64
    %4 = llvm.select %3, %c46_i64, %0 : i1, i64
    %5 = llvm.select %2, %4, %c-30_i64 : i1, i64
    %6 = llvm.select %3, %5, %arg0 : i1, i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c-38_i64 = arith.constant -38 : i64
    %true = arith.constant true
    %c-34_i64 = arith.constant -34 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.select %true, %c-34_i64, %c29_i64 : i1, i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %1, %c-38_i64 : i64
    %3 = llvm.icmp "sgt" %c-8_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "ult" %5, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.zext %arg0 : i1 to i64
    %5 = llvm.trunc %arg0 : i1 to i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "uge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.lshr %c-44_i64, %c-11_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %c45_i64, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.udiv %3, %c-32_i64 : i64
    %5 = llvm.ashr %arg1, %4 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.icmp "slt" %6, %3 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %c-19_i64, %c20_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sdiv %arg1, %arg0 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.ashr %2, %arg2 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %c1_i64, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.ashr %3, %3 : i64
    %5 = llvm.urem %4, %4 : i64
    %6 = llvm.srem %5, %1 : i64
    %7 = llvm.lshr %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.icmp "sgt" %c9_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.lshr %2, %c29_i64 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.icmp "ule" %arg0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %arg1, %c37_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.ashr %arg0, %c-33_i64 : i64
    %6 = llvm.and %0, %5 : i64
    %7 = llvm.and %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "ugt" %4, %c-15_i64 : i64
    %6 = llvm.xor %3, %3 : i64
    %7 = llvm.select %5, %6, %arg2 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c28_i64 = arith.constant 28 : i64
    %false = arith.constant false
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.or %arg0, %c39_i64 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.select %false, %c28_i64, %c-45_i64 : i1, i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.xor %c30_i64, %1 : i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    %7 = llvm.select %6, %c-3_i64, %0 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %c-6_i64, %0 : i64
    %2 = llvm.ashr %c48_i64, %1 : i64
    %3 = llvm.udiv %0, %0 : i64
    %4 = llvm.icmp "ule" %3, %1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.lshr %5, %arg1 : i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c-20_i64 = arith.constant -20 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "ult" %c-20_i64, %c-8_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.lshr %3, %1 : i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.udiv %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.select %arg2, %2, %1 : i1, i64
    %4 = llvm.icmp "slt" %3, %arg0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %1, %5 : i64
    %7 = llvm.icmp "sgt" %c38_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.udiv %c-44_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c-12_i64 : i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.icmp "ule" %3, %arg2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %1, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c24_i64 = arith.constant 24 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.select %true, %c24_i64, %c-14_i64 : i1, i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %0, %arg2 : i64
    %5 = llvm.xor %arg1, %4 : i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c8_i64 = arith.constant 8 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.urem %2, %c8_i64 : i64
    %6 = llvm.select %4, %5, %c-16_i64 : i1, i64
    %7 = llvm.xor %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c43_i64 = arith.constant 43 : i64
    %c38_i64 = arith.constant 38 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %c42_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %c38_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %2, %c43_i64 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.icmp "ugt" %4, %c24_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.srem %c27_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %c38_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "eq" %3, %arg0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sdiv %5, %arg1 : i64
    %7 = llvm.lshr %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %true = arith.constant true
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "sge" %c30_i64, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %arg0, %1, %arg1 : i1, i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.select %true, %arg1, %c2_i64 : i1, i64
    %5 = llvm.sdiv %4, %3 : i64
    %6 = llvm.lshr %5, %2 : i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c44_i64 = arith.constant 44 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.srem %c17_i64, %c-15_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.select %2, %c44_i64, %arg1 : i1, i64
    %4 = llvm.sdiv %3, %arg2 : i64
    %5 = llvm.sext %2 : i1 to i64
    %6 = llvm.sdiv %5, %c-45_i64 : i64
    %7 = llvm.xor %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %true = arith.constant true
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.select %true, %c47_i64, %arg0 : i1, i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.icmp "ule" %4, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.xor %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.xor %arg0, %c-16_i64 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.xor %arg1, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.ashr %c-22_i64, %4 : i64
    %6 = llvm.select %arg2, %c-11_i64, %c12_i64 : i1, i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.ashr %arg2, %2 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %c26_i64 = arith.constant 26 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sdiv %c26_i64, %c41_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.ashr %2, %5 : i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sext %0 : i1 to i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c20_i64 = arith.constant 20 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.sdiv %c20_i64, %c37_i64 : i64
    %1 = llvm.select %arg0, %c47_i64, %0 : i1, i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sdiv %0, %5 : i64
    %7 = llvm.icmp "sle" %c-46_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.xor %arg0, %arg1 : i64
    %5 = llvm.ashr %1, %0 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.lshr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c10_i64 = arith.constant 10 : i64
    %c31_i64 = arith.constant 31 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "sle" %c31_i64, %c-15_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c10_i64, %1 : i64
    %3 = llvm.sdiv %c35_i64, %arg1 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %5, %arg0 : i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ugt" %c-10_i64, %c-27_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %c-12_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %3, %1 : i64
    %5 = llvm.urem %4, %arg0 : i64
    %6 = llvm.ashr %3, %5 : i64
    %7 = llvm.lshr %6, %1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "ugt" %arg0, %c-26_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg1, %arg2 : i64
    %3 = llvm.select %2, %c-18_i64, %arg1 : i1, i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.ashr %c9_i64, %c-37_i64 : i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %c47_i64 : i64
    %3 = llvm.lshr %2, %arg2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.sdiv %5, %5 : i64
    %7 = llvm.or %c36_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c4_i64 = arith.constant 4 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "uge" %arg0, %c42_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %c4_i64, %1 : i64
    %3 = llvm.ashr %arg1, %arg0 : i64
    %4 = llvm.srem %c-20_i64, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ne" %c-10_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %arg1, %3 : i64
    %5 = llvm.icmp "eq" %4, %c10_i64 : i64
    %6 = llvm.select %5, %c35_i64, %arg1 : i1, i64
    %7 = llvm.icmp "ugt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.urem %c30_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %c-19_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.xor %0, %arg1 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.icmp "eq" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c2_i64 = arith.constant 2 : i64
    %false = arith.constant false
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.lshr %arg1, %c47_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %false, %3, %c-10_i64 : i1, i64
    %5 = llvm.udiv %c2_i64, %4 : i64
    %6 = llvm.sext %2 : i1 to i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.lshr %c45_i64, %arg0 : i64
    %1 = llvm.and %c4_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.select %arg0, %c-23_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ne" %0, %c-49_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %arg2, %2 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.sdiv %4, %arg1 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.icmp "slt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c11_i64 = arith.constant 11 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "ule" %c-25_i64, %c41_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c4_i64, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %c11_i64 : i64
    %4 = llvm.select %3, %c-16_i64, %2 : i1, i64
    %5 = llvm.ashr %4, %1 : i64
    %6 = llvm.and %5, %c44_i64 : i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c9_i64 = arith.constant 9 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.ashr %c24_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.srem %c9_i64, %arg1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.select %3, %c44_i64, %2 : i1, i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    %6 = llvm.select %5, %0, %arg2 : i1, i64
    %7 = llvm.icmp "ult" %6, %1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-13_i64 = arith.constant -13 : i64
    %c22_i64 = arith.constant 22 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.sdiv %c22_i64, %c-3_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.sdiv %c-13_i64, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.or %4, %3 : i64
    %6 = llvm.or %4, %arg0 : i64
    %7 = llvm.urem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.and %c-17_i64, %arg1 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.trunc %false : i1 to i64
    %6 = llvm.urem %0, %5 : i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "uge" %c-46_i64, %arg0 : i64
    %1 = llvm.select %0, %c-45_i64, %arg0 : i1, i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.lshr %c17_i64, %c-21_i64 : i64
    %7 = llvm.lshr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.xor %c-33_i64, %0 : i64
    %3 = llvm.udiv %c-50_i64, %2 : i64
    %4 = llvm.icmp "sge" %3, %arg1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.lshr %c-36_i64, %c48_i64 : i64
    %1 = llvm.lshr %0, %c-22_i64 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %4, %2 : i64
    %6 = llvm.udiv %1, %c-9_i64 : i64
    %7 = llvm.and %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c45_i64 = arith.constant 45 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.srem %c45_i64, %c29_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.xor %1, %c4_i64 : i64
    %3 = llvm.icmp "sle" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.icmp "eq" %5, %1 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.or %c-3_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %3, %1 : i64
    %5 = llvm.icmp "ne" %c-6_i64, %arg0 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.select %2, %4, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.select %arg1, %c-8_i64, %1 : i1, i64
    %3 = llvm.and %arg2, %c43_i64 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.icmp "ult" %c-34_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.urem %c-3_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.select %arg1, %arg0, %1 : i1, i64
    %3 = llvm.and %c47_i64, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %0, %5 : i64
    %7 = llvm.sdiv %c6_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c19_i64 = arith.constant 19 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.lshr %c47_i64, %c-30_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.xor %c-8_i64, %c6_i64 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.xor %c-1_i64, %arg0 : i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.or %3, %5 : i64
    %7 = llvm.select %1, %c19_i64, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.sdiv %arg0, %c43_i64 : i64
    %1 = llvm.icmp "sle" %c-19_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c45_i64, %0 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.urem %4, %4 : i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.lshr %6, %0 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c12_i64 = arith.constant 12 : i64
    %c9_i64 = arith.constant 9 : i64
    %c14_i64 = arith.constant 14 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "slt" %c14_i64, %c19_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %c9_i64, %c12_i64 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %5, %c-19_i64 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %arg0, %c-28_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.srem %0, %arg0 : i64
    %6 = llvm.srem %5, %c37_i64 : i64
    %7 = llvm.icmp "eq" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %c36_i64, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.or %c-17_i64, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %c-8_i64, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.lshr %2, %arg0 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "sle" %1, %c43_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.urem %1, %c-34_i64 : i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.ashr %c-29_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "sge" %c-8_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %c47_i64, %1 : i64
    %3 = llvm.icmp "sge" %1, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %4, %c45_i64 : i64
    %6 = llvm.udiv %2, %5 : i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c44_i64 = arith.constant 44 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.or %c27_i64, %arg0 : i64
    %1 = llvm.urem %0, %c44_i64 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %2, %c-47_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "uge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c46_i64 = arith.constant 46 : i64
    %false = arith.constant false
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.srem %3, %c46_i64 : i64
    %5 = llvm.urem %1, %4 : i64
    %6 = llvm.or %3, %c48_i64 : i64
    %7 = llvm.srem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.udiv %c-9_i64, %c32_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %5, %arg1 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %arg1, %arg2 : i64
    %5 = llvm.icmp "sgt" %4, %1 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.udiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %c-29_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.udiv %c33_i64, %3 : i64
    %5 = llvm.urem %c-47_i64, %4 : i64
    %6 = llvm.lshr %c-37_i64, %5 : i64
    %7 = llvm.icmp "uge" %6, %c-36_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c37_i64 = arith.constant 37 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.icmp "eq" %c-38_i64, %c32_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %c37_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %5, %c-35_i64 : i64
    %7 = llvm.lshr %c-29_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c41_i64 = arith.constant 41 : i64
    %false = arith.constant false
    %c-12_i64 = arith.constant -12 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.srem %c18_i64, %c-44_i64 : i64
    %1 = llvm.ashr %c-12_i64, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.select %false, %c41_i64, %0 : i1, i64
    %5 = llvm.srem %4, %c-27_i64 : i64
    %6 = llvm.ashr %3, %5 : i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.xor %c-32_i64, %arg0 : i64
    %1 = llvm.urem %0, %c-21_i64 : i64
    %2 = llvm.and %c-8_i64, %arg0 : i64
    %3 = llvm.icmp "eq" %c-39_i64, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.select %arg1, %2, %5 : i1, i64
    %7 = llvm.sdiv %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.sdiv %arg0, %c35_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.urem %4, %4 : i64
    %6 = llvm.xor %arg2, %5 : i64
    %7 = llvm.and %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.icmp "ult" %arg1, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %c18_i64, %2 : i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.lshr %c-44_i64, %4 : i64
    %6 = llvm.select %1, %3, %5 : i1, i64
    %7 = llvm.icmp "ult" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.xor %c-47_i64, %0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.or %3, %5 : i64
    %7 = llvm.icmp "sle" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %c44_i64, %c-45_i64 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %arg1, %arg0 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c14_i64 = arith.constant 14 : i64
    %c22_i64 = arith.constant 22 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.sdiv %c38_i64, %arg0 : i64
    %1 = llvm.urem %c22_i64, %0 : i64
    %2 = llvm.srem %c-44_i64, %0 : i64
    %3 = llvm.xor %c14_i64, %2 : i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.icmp "slt" %5, %c-22_i64 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "sge" %arg0, %c-9_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %c-3_i64 : i64
    %3 = llvm.lshr %arg2, %c-45_i64 : i64
    %4 = llvm.icmp "ule" %arg1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c12_i64 = arith.constant 12 : i64
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %true, %c12_i64, %0 : i1, i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %arg1, %arg0, %2 : i1, i64
    %6 = llvm.lshr %c23_i64, %5 : i64
    %7 = llvm.udiv %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.xor %arg0, %arg1 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.udiv %arg2, %0 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %c38_i64, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %3, %c10_i64 : i64
    %5 = llvm.select %2, %arg1, %3 : i1, i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.icmp "ule" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c12_i64 = arith.constant 12 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c-4_i64 : i64
    %2 = llvm.icmp "ugt" %c12_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.ashr %4, %1 : i64
    %6 = llvm.sdiv %3, %c-32_i64 : i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c11_i64 = arith.constant 11 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "ugt" %arg0, %c47_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %c11_i64, %1 : i64
    %3 = llvm.zext %0 : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.srem %arg1, %c46_i64 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.ashr %c-45_i64, %c35_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "sge" %arg1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %1 : i64
    %5 = llvm.select %4, %3, %arg2 : i1, i64
    %6 = llvm.icmp "sgt" %1, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.udiv %arg1, %c-5_i64 : i64
    %2 = llvm.icmp "slt" %1, %c-49_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %arg1, %0 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.lshr %5, %c-48_i64 : i64
    %7 = llvm.icmp "uge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c42_i64 = arith.constant 42 : i64
    %true = arith.constant true
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.ashr %c11_i64, %arg0 : i64
    %1 = llvm.select %true, %arg1, %c42_i64 : i1, i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "sgt" %2, %c31_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %5, %3 : i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %c-28_i64, %arg0 : i64
    %1 = llvm.udiv %c-23_i64, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "uge" %arg1, %2 : i64
    %5 = llvm.zext %arg2 : i1 to i64
    %6 = llvm.select %4, %arg0, %5 : i1, i64
    %7 = llvm.or %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.udiv %c-32_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg1 : i64
    %2 = llvm.udiv %arg1, %c40_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.sdiv %arg0, %arg1 : i64
    %5 = llvm.udiv %4, %c10_i64 : i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.srem %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %0, %c-21_i64 : i64
    %2 = llvm.lshr %arg0, %arg1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %arg2, %arg1 : i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c-43_i64, %arg1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    %6 = llvm.udiv %c47_i64, %2 : i64
    %7 = llvm.select %5, %arg1, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %c-1_i64, %2 : i64
    %4 = llvm.lshr %0, %2 : i64
    %5 = llvm.select %3, %0, %4 : i1, i64
    %6 = llvm.select %arg1, %4, %4 : i1, i64
    %7 = llvm.icmp "sge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "eq" %c-24_i64, %c-28_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "sgt" %3, %1 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c12_i64 = arith.constant 12 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.lshr %c-32_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %c12_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %arg1, %c23_i64 : i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    %5 = llvm.sdiv %0, %arg2 : i64
    %6 = llvm.select %4, %arg1, %5 : i1, i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "sle" %0, %c46_i64 : i64
    %2 = llvm.xor %0, %0 : i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.select %1, %3, %c-45_i64 : i1, i64
    %5 = llvm.srem %c-2_i64, %4 : i64
    %6 = llvm.or %0, %arg0 : i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.select %2, %c-5_i64, %0 : i1, i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.and %arg1, %3 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.and %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.sdiv %arg1, %c-18_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.trunc %arg2 : i1 to i64
    %6 = llvm.urem %2, %5 : i64
    %7 = llvm.xor %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c26_i64 = arith.constant 26 : i64
    %c6_i64 = arith.constant 6 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.urem %c6_i64, %c42_i64 : i64
    %1 = llvm.srem %c26_i64, %0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.lshr %2, %1 : i64
    %4 = llvm.and %1, %arg1 : i64
    %5 = llvm.sdiv %4, %arg2 : i64
    %6 = llvm.srem %5, %c41_i64 : i64
    %7 = llvm.icmp "ult" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %c-43_i64, %2 : i64
    %4 = llvm.icmp "sge" %0, %c0_i64 : i64
    %5 = llvm.select %4, %c48_i64, %3 : i1, i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.icmp "ule" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %c-42_i64, %c-25_i64 : i64
    %2 = llvm.lshr %0, %arg2 : i64
    %3 = llvm.ashr %c-49_i64, %c-6_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.sdiv %5, %arg1 : i64
    %7 = llvm.ashr %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c28_i64 = arith.constant 28 : i64
    %c21_i64 = arith.constant 21 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "slt" %c21_i64, %c5_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %c28_i64, %arg0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.ashr %c6_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.lshr %1, %c-2_i64 : i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %4, %1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "uge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %c30_i64, %0 : i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.sdiv %3, %c-1_i64 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.xor %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c21_i64 = arith.constant 21 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.select %arg2, %c49_i64, %c21_i64 : i1, i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.trunc %arg2 : i1 to i64
    %5 = llvm.icmp "ne" %4, %c18_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.or %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c37_i64 = arith.constant 37 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.sdiv %arg0, %c-46_i64 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.lshr %arg2, %c37_i64 : i64
    %5 = llvm.select %1, %c-28_i64, %arg0 : i1, i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.and %c2_i64, %c28_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.zext %arg0 : i1 to i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "ule" %c25_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %4, %arg1 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.sdiv %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c6_i64 = arith.constant 6 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %c20_i64 : i64
    %2 = llvm.select %arg0, %1, %0 : i1, i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.sdiv %c6_i64, %c-32_i64 : i64
    %6 = llvm.udiv %arg1, %5 : i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %false = arith.constant false
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.sdiv %c-12_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.lshr %c37_i64, %arg2 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "slt" %arg1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.urem %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.or %0, %c0_i64 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.icmp "ule" %c49_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.icmp "sge" %c-5_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c35_i64 = arith.constant 35 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.srem %c-49_i64, %arg0 : i64
    %1 = llvm.sdiv %c48_i64, %0 : i64
    %2 = llvm.lshr %c35_i64, %c-47_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.xor %0, %1 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.ashr %5, %0 : i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.lshr %0, %c-46_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %c-46_i64, %0 : i64
    %2 = llvm.lshr %arg1, %0 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.xor %arg2, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.sdiv %5, %5 : i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c7_i64 = arith.constant 7 : i64
    %c43_i64 = arith.constant 43 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "ule" %c43_i64, %c0_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c7_i64, %c-26_i64 : i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %4, %arg1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c12_i64 = arith.constant 12 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %c0_i64 : i64
    %2 = llvm.urem %c12_i64, %arg0 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %c-7_i64, %2 : i64
    %6 = llvm.udiv %5, %arg0 : i64
    %7 = llvm.select %3, %4, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c40_i64 = arith.constant 40 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.ashr %c40_i64, %c21_i64 : i64
    %1 = llvm.urem %0, %c5_i64 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.or %3, %2 : i64
    %5 = llvm.ashr %c-29_i64, %0 : i64
    %6 = llvm.sdiv %2, %5 : i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c15_i64 = arith.constant 15 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.urem %c-30_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %c15_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.trunc %true : i1 to i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.udiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c19_i64 = arith.constant 19 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %c2_i64 : i64
    %2 = llvm.select %arg0, %1, %c19_i64 : i1, i64
    %3 = llvm.icmp "sle" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %0, %4 : i64
    %6 = llvm.ashr %c-2_i64, %arg1 : i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "uge" %c18_i64, %c8_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %c-30_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %c35_i64 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.xor %4, %c-2_i64 : i64
    %7 = llvm.icmp "sle" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.lshr %1, %1 : i64
    %4 = llvm.select %2, %arg0, %3 : i1, i64
    %5 = llvm.ashr %arg0, %4 : i64
    %6 = llvm.icmp "uge" %arg0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c3_i64 = arith.constant 3 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.srem %c3_i64, %c7_i64 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %c-24_i64 : i64
    %3 = llvm.srem %arg1, %0 : i64
    %4 = llvm.xor %3, %2 : i64
    %5 = llvm.select %1, %2, %4 : i1, i64
    %6 = llvm.udiv %5, %0 : i64
    %7 = llvm.srem %6, %0 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c18_i64 = arith.constant 18 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.urem %c13_i64, %c-15_i64 : i64
    %1 = llvm.udiv %c18_i64, %0 : i64
    %2 = llvm.urem %0, %arg0 : i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.trunc %false : i1 to i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.icmp "sge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c31_i64 = arith.constant 31 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "uge" %c35_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg0, %arg0 : i64
    %3 = llvm.icmp "ugt" %c31_i64, %c-2_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.lshr %5, %arg0 : i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-15_i64 = arith.constant -15 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.xor %c22_i64, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.urem %c-15_i64, %arg2 : i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.urem %0, %c8_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "ule" %2, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.udiv %5, %c-41_i64 : i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.urem %c-37_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c25_i64, %0 : i64
    %2 = llvm.select %1, %arg0, %arg1 : i1, i64
    %3 = llvm.and %arg1, %arg0 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.sdiv %5, %arg0 : i64
    %7 = llvm.icmp "ult" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.select %true, %2, %0 : i1, i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.and %4, %c28_i64 : i64
    %6 = llvm.xor %5, %4 : i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.and %c26_i64, %1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.udiv %3, %0 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.urem %c-43_i64, %5 : i64
    %7 = llvm.icmp "ult" %c37_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c44_i64 = arith.constant 44 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "ult" %arg0, %c27_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.udiv %arg1, %c44_i64 : i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.icmp "ugt" %4, %c12_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "slt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c31_i64 = arith.constant 31 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.and %c31_i64, %c21_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "sge" %c-16_i64, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.udiv %1, %5 : i64
    %7 = llvm.icmp "ult" %6, %4 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %true = arith.constant true
    %c44_i64 = arith.constant 44 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.and %arg0, %c22_i64 : i64
    %1 = llvm.urem %arg0, %c-21_i64 : i64
    %2 = llvm.select %true, %0, %c27_i64 : i1, i64
    %3 = llvm.or %c44_i64, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.ashr %4, %2 : i64
    %6 = llvm.or %0, %5 : i64
    %7 = llvm.udiv %6, %c44_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %3 = llvm.srem %arg2, %2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.sdiv %4, %1 : i64
    %6 = llvm.and %1, %5 : i64
    %7 = llvm.icmp "sge" %6, %c3_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c12_i64 = arith.constant 12 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %c12_i64, %5 : i64
    %7 = llvm.icmp "sle" %6, %c31_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c24_i64 = arith.constant 24 : i64
    %c15_i64 = arith.constant 15 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.sdiv %c37_i64, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %c15_i64, %3 : i64
    %5 = llvm.icmp "ugt" %c-27_i64, %c-17_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.select %4, %c24_i64, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %3, %c-4_i64 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %arg2 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.lshr %c-43_i64, %4 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.srem %c40_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.icmp "ugt" %c-32_i64, %arg1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    %5 = llvm.select %4, %c-20_i64, %3 : i1, i64
    %6 = llvm.udiv %5, %2 : i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %c-34_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.xor %2, %c23_i64 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "ult" %4, %arg1 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c24_i64 = arith.constant 24 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.and %c24_i64, %c-24_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.icmp "ugt" %3, %0 : i64
    %5 = llvm.lshr %arg1, %arg0 : i64
    %6 = llvm.sext %true : i1 to i64
    %7 = llvm.select %4, %5, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c8_i64 = arith.constant 8 : i64
    %c22_i64 = arith.constant 22 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.xor %arg0, %c-4_i64 : i64
    %1 = llvm.ashr %c-26_i64, %c-8_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.xor %c22_i64, %4 : i64
    %6 = llvm.icmp "ule" %c8_i64, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.xor %c-46_i64, %arg2 : i64
    %6 = llvm.srem %5, %2 : i64
    %7 = llvm.ashr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c49_i64 = arith.constant 49 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.and %c47_i64, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.and %c49_i64, %4 : i64
    %6 = llvm.icmp "ult" %c-28_i64, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %c33_i64 : i64
    %2 = llvm.or %arg1, %0 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.sdiv %c-33_i64, %3 : i64
    %5 = llvm.sdiv %arg1, %4 : i64
    %6 = llvm.udiv %5, %c50_i64 : i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.ashr %c5_i64, %c5_i64 : i64
    %1 = llvm.or %c-18_i64, %0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.lshr %c17_i64, %arg0 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.xor %arg1, %5 : i64
    %7 = llvm.icmp "sge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.select %arg0, %arg1, %c-12_i64 : i1, i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %c-42_i64, %0 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %c-3_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %arg2, %arg1 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sdiv %0, %5 : i64
    %7 = llvm.icmp "ugt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %c12_i64, %arg1 : i64
    %2 = llvm.lshr %arg2, %arg1 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.urem %c48_i64, %3 : i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %c-43_i64, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "uge" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ugt" %1, %arg1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.and %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.and %c-50_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.udiv %c21_i64, %c18_i64 : i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.xor %0, %arg1 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.icmp "slt" %1, %c-17_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.select %2, %arg1, %arg1 : i1, i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.urem %c32_i64, %4 : i64
    %6 = llvm.sdiv %3, %5 : i64
    %7 = llvm.icmp "slt" %6, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.and %0, %1 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.srem %1, %5 : i64
    %7 = llvm.icmp "sge" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c-2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.select %false, %c-19_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %2, %c-2_i64 : i64
    %4 = llvm.ashr %3, %c-6_i64 : i64
    %5 = llvm.or %arg1, %arg0 : i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.select %1, %arg2, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c40_i64 = arith.constant 40 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %c49_i64, %arg0 : i64
    %1 = llvm.and %c40_i64, %0 : i64
    %2 = llvm.urem %c-13_i64, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.and %1, %arg2 : i64
    %5 = llvm.and %4, %0 : i64
    %6 = llvm.and %arg2, %5 : i64
    %7 = llvm.icmp "sgt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-35_i64 = arith.constant -35 : i64
    %true = arith.constant true
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %c48_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg1 : i64
    %2 = llvm.select %true, %c-35_i64, %c-7_i64 : i1, i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %arg0, %c-42_i64 : i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.and %c5_i64, %c-15_i64 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.srem %c18_i64, %arg0 : i64
    %3 = llvm.xor %c-20_i64, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.sdiv %5, %arg2 : i64
    %7 = llvm.icmp "ult" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-50_i64 = arith.constant -50 : i64
    %true = arith.constant true
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %arg0, %c-11_i64 : i64
    %1 = llvm.select %true, %0, %arg1 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "ule" %0, %c-50_i64 : i64
    %5 = llvm.select %4, %c30_i64, %c-8_i64 : i1, i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.ashr %c2_i64, %c-16_i64 : i64
    %1 = llvm.xor %0, %c28_i64 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.xor %0, %1 : i64
    %6 = llvm.select %4, %5, %arg2 : i1, i64
    %7 = llvm.ashr %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.udiv %1, %c31_i64 : i64
    %3 = llvm.or %0, %c-15_i64 : i64
    %4 = llvm.trunc %arg0 : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.urem %2, %5 : i64
    %7 = llvm.ashr %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.xor %c-29_i64, %c12_i64 : i64
    %1 = llvm.and %c-42_i64, %0 : i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %0, %c7_i64 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.urem %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.udiv %arg0, %c-34_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.and %arg1, %4 : i64
    %6 = llvm.urem %5, %5 : i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c29_i64 = arith.constant 29 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.srem %c10_i64, %c-34_i64 : i64
    %1 = llvm.or %0, %c29_i64 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.lshr %1, %arg1 : i64
    %5 = llvm.or %4, %3 : i64
    %6 = llvm.ashr %c48_i64, %5 : i64
    %7 = llvm.icmp "ult" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c28_i64 = arith.constant 28 : i64
    %true = arith.constant true
    %0 = llvm.icmp "slt" %arg2, %arg2 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.udiv %arg2, %1 : i64
    %3 = llvm.select %0, %arg2, %2 : i1, i64
    %4 = llvm.select %arg0, %arg1, %3 : i1, i64
    %5 = llvm.urem %c28_i64, %c-17_i64 : i64
    %6 = llvm.or %5, %c-14_i64 : i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c20_i64 = arith.constant 20 : i64
    %c21_i64 = arith.constant 21 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.select %arg0, %2, %arg2 : i1, i64
    %4 = llvm.and %c21_i64, %c20_i64 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.sdiv %5, %c44_i64 : i64
    %7 = llvm.lshr %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %true = arith.constant true
    %c-28_i64 = arith.constant -28 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.lshr %c-7_i64, %c4_i64 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.icmp "eq" %arg2, %c21_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %true, %1, %3 : i1, i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "uge" %c-28_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.urem %arg0, %c-6_i64 : i64
    %1 = llvm.icmp "ugt" %c-43_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %4 = llvm.select %3, %arg0, %0 : i1, i64
    %5 = llvm.sdiv %4, %0 : i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.udiv %0, %arg0 : i64
    %4 = llvm.lshr %3, %1 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.ashr %0, %5 : i64
    %7 = llvm.icmp "slt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.and %c-20_i64, %c50_i64 : i64
    %1 = llvm.xor %0, %c42_i64 : i64
    %2 = llvm.udiv %1, %c30_i64 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.and %5, %arg0 : i64
    %7 = llvm.icmp "ult" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c41_i64 = arith.constant 41 : i64
    %c11_i64 = arith.constant 11 : i64
    %c9_i64 = arith.constant 9 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.or %c50_i64, %arg0 : i64
    %1 = llvm.xor %0, %c9_i64 : i64
    %2 = llvm.xor %c41_i64, %arg1 : i64
    %3 = llvm.lshr %c11_i64, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "sle" %arg0, %c-29_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c25_i64 = arith.constant 25 : i64
    %c9_i64 = arith.constant 9 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "ule" %c9_i64, %c41_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.lshr %c25_i64, %c-10_i64 : i64
    %4 = llvm.icmp "ugt" %3, %c40_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.ashr %2, %5 : i64
    %7 = llvm.srem %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c18_i64 = arith.constant 18 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "uge" %c13_i64, %c-49_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %c-28_i64, %1 : i64
    %3 = llvm.urem %c18_i64, %2 : i64
    %4 = llvm.zext %arg0 : i1 to i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c26_i64 = arith.constant 26 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.srem %arg0, %c-47_i64 : i64
    %1 = llvm.sdiv %c26_i64, %arg2 : i64
    %2 = llvm.and %1, %c-36_i64 : i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.srem %5, %c1_i64 : i64
    %7 = llvm.icmp "ne" %6, %1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.select %true, %0, %c-27_i64 : i1, i64
    %2 = llvm.xor %1, %c4_i64 : i64
    %3 = llvm.ashr %c-21_i64, %arg2 : i64
    %4 = llvm.ashr %3, %3 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.urem %5, %c0_i64 : i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "slt" %arg2, %c34_i64 : i64
    %2 = llvm.select %1, %arg1, %c-21_i64 : i1, i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.udiv %5, %c0_i64 : i64
    %7 = llvm.icmp "sge" %6, %3 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c-26_i64 = arith.constant -26 : i64
    %false = arith.constant false
    %c-39_i64 = arith.constant -39 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.ashr %arg0, %c-12_i64 : i64
    %1 = llvm.lshr %c-39_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.udiv %3, %c-26_i64 : i64
    %5 = llvm.xor %arg0, %c22_i64 : i64
    %6 = llvm.srem %c-15_i64, %5 : i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c-48_i64 = arith.constant -48 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.urem %c-49_i64, %arg2 : i64
    %2 = llvm.icmp "ugt" %c-44_i64, %c-48_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.sdiv %1, %5 : i64
    %7 = llvm.urem %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.lshr %3, %3 : i64
    %5 = llvm.icmp "sle" %4, %1 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c28_i64 = arith.constant 28 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.srem %arg0, %c-10_i64 : i64
    %1 = llvm.srem %c28_i64, %0 : i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.sdiv %c-48_i64, %2 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.lshr %arg1, %c13_i64 : i64
    %4 = llvm.lshr %3, %arg2 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.urem %c47_i64, %1 : i64
    %3 = llvm.sdiv %arg1, %c-5_i64 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c18_i64 = arith.constant 18 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "slt" %c10_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %c18_i64, %3 : i64
    %5 = llvm.lshr %c-17_i64, %c43_i64 : i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.sdiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c19_i64 = arith.constant 19 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.srem %c44_i64, %c-40_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.srem %1, %c-22_i64 : i64
    %3 = llvm.srem %2, %c19_i64 : i64
    %4 = llvm.icmp "sgt" %3, %c-14_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.icmp "uge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "slt" %c-7_i64, %c-44_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.select %0, %arg0, %arg0 : i1, i64
    %4 = llvm.srem %3, %arg0 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c14_i64 = arith.constant 14 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %arg2, %0 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.sdiv %c14_i64, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.sext %true : i1 to i64
    %6 = llvm.and %5, %2 : i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.srem %c36_i64, %c-18_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.select %arg0, %1, %3 : i1, i64
    %5 = llvm.udiv %3, %arg1 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.sdiv %0, %c-40_i64 : i64
    %4 = llvm.lshr %3, %c-33_i64 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "sgt" %c-7_i64, %c12_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "eq" %c19_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %0, %4, %4 : i1, i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ne" %c-40_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %arg0, %c5_i64 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.ashr %c-9_i64, %4 : i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.select %0, %2, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.srem %0, %5 : i64
    %7 = llvm.srem %6, %5 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.lshr %c-12_i64, %arg0 : i64
    %1 = llvm.or %0, %c17_i64 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.srem %3, %arg1 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    %6 = llvm.select %5, %1, %c38_i64 : i1, i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c-33_i64 = arith.constant -33 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %c-33_i64, %c-1_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %arg2, %5 : i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.urem %arg1, %c-24_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.and %arg0, %arg2 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.ashr %c-11_i64, %0 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.and %c-46_i64, %4 : i64
    %7 = llvm.icmp "slt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %c-3_i64, %1 : i64
    %5 = llvm.ashr %4, %3 : i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sdiv %arg0, %c12_i64 : i64
    %1 = llvm.udiv %c-12_i64, %0 : i64
    %2 = llvm.urem %c-46_i64, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.urem %arg0, %arg2 : i64
    %5 = llvm.and %c-18_i64, %c-30_i64 : i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.xor %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %2, %c-40_i64 : i64
    %4 = llvm.and %c-39_i64, %3 : i64
    %5 = llvm.lshr %arg2, %c-39_i64 : i64
    %6 = llvm.and %0, %5 : i64
    %7 = llvm.lshr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c30_i64 = arith.constant 30 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.xor %c-9_i64, %arg0 : i64
    %1 = llvm.and %c-40_i64, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.urem %c30_i64, %c13_i64 : i64
    %4 = llvm.or %3, %3 : i64
    %5 = llvm.sdiv %4, %arg1 : i64
    %6 = llvm.or %c0_i64, %5 : i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "ult" %arg1, %arg2 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.sdiv %c-18_i64, %c15_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.srem %arg1, %4 : i64
    %6 = llvm.icmp "ugt" %arg0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %arg1, %arg2 : i64
    %3 = llvm.lshr %c-22_i64, %2 : i64
    %4 = llvm.icmp "sle" %c-44_i64, %c-5_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.icmp "ugt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %0, %c-8_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %arg0, %arg2 : i64
    %4 = llvm.and %c6_i64, %c33_i64 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ult" %2, %0 : i64
    %4 = llvm.sdiv %c18_i64, %1 : i64
    %5 = llvm.and %4, %arg2 : i64
    %6 = llvm.select %3, %arg2, %5 : i1, i64
    %7 = llvm.icmp "ule" %6, %2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c45_i64 = arith.constant 45 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "ne" %c22_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %c45_i64, %c-23_i64 : i64
    %6 = llvm.xor %5, %arg2 : i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c39_i64 = arith.constant 39 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "ne" %c16_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.sdiv %1, %c39_i64 : i64
    %4 = llvm.icmp "sge" %3, %arg2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %5, %c5_i64 : i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "ult" %c49_i64, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %c-24_i64, %4 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.urem %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "ugt" %c-28_i64, %c-50_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %c-47_i64, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %2, %c-39_i64 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.srem %arg0, %c33_i64 : i64
    %1 = llvm.lshr %c-40_i64, %0 : i64
    %2 = llvm.icmp "sge" %arg1, %c21_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "ult" %arg1, %arg1 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sle" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c34_i64 = arith.constant 34 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %c46_i64, %c34_i64 : i64
    %2 = llvm.select %false, %c-6_i64, %1 : i1, i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.or %arg1, %c-28_i64 : i64
    %5 = llvm.icmp "slt" %4, %2 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.lshr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.xor %c-44_i64, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.icmp "ult" %4, %1 : i64
    %6 = llvm.select %5, %1, %arg2 : i1, i64
    %7 = llvm.icmp "ult" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %c-6_i64 : i64
    %2 = llvm.udiv %c14_i64, %c8_i64 : i64
    %3 = llvm.lshr %arg2, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.urem %2, %2 : i64
    %6 = llvm.zext %4 : i1 to i64
    %7 = llvm.select %4, %5, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "slt" %3, %c-33_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %5, %3 : i64
    %7 = llvm.icmp "sge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.ashr %c30_i64, %2 : i64
    %5 = llvm.select %3, %4, %1 : i1, i64
    %6 = llvm.xor %5, %arg2 : i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c-16_i64 = arith.constant -16 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c43_i64 = arith.constant 43 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "sge" %c5_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %c43_i64 : i64
    %3 = llvm.select %2, %c-28_i64, %arg1 : i1, i64
    %4 = llvm.sdiv %arg2, %c-16_i64 : i64
    %5 = llvm.trunc %false : i1 to i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.ashr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %true = arith.constant true
    %c43_i64 = arith.constant 43 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.or %arg2, %c1_i64 : i64
    %1 = llvm.xor %c43_i64, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.udiv %arg1, %4 : i64
    %6 = llvm.urem %arg0, %5 : i64
    %7 = llvm.icmp "sle" %6, %c-29_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %c-5_i64, %1 : i64
    %3 = llvm.xor %2, %c-46_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "sge" %arg0, %arg2 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.and %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.and %c-26_i64, %c-36_i64 : i64
    %1 = llvm.icmp "ult" %0, %c42_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %arg1 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.xor %0, %5 : i64
    %7 = llvm.icmp "uge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c19_i64 = arith.constant 19 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.udiv %1, %c19_i64 : i64
    %3 = llvm.xor %2, %0 : i64
    %4 = llvm.srem %c48_i64, %0 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.or %5, %2 : i64
    %7 = llvm.ashr %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.urem %c-5_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %c-35_i64, %0 : i64
    %2 = llvm.select %1, %arg0, %c47_i64 : i1, i64
    %3 = llvm.icmp "sge" %2, %c43_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %0, %arg0 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c50_i64 = arith.constant 50 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.urem %arg0, %c26_i64 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "ule" %arg0, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.lshr %c50_i64, %c35_i64 : i64
    %6 = llvm.or %arg2, %5 : i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c19_i64 = arith.constant 19 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ugt" %c19_i64, %c43_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "eq" %c-50_i64, %c49_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.ashr %c-9_i64, %4 : i64
    %6 = llvm.udiv %c-14_i64, %c10_i64 : i64
    %7 = llvm.urem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.srem %arg2, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "uge" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.select %false, %c40_i64, %arg2 : i1, i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "sgt" %0, %2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %arg0, %5 : i64
    %7 = llvm.or %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %c-22_i64, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.select %arg0, %1, %3 : i1, i64
    %5 = llvm.sdiv %c-20_i64, %c24_i64 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "sge" %c49_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "ne" %c-35_i64, %c36_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.icmp "slt" %c10_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.or %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.and %c-20_i64, %c4_i64 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.lshr %c35_i64, %arg2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "eq" %3, %c21_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %2, %arg0, %1 : i1, i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    %6 = llvm.select %5, %arg2, %c47_i64 : i1, i64
    %7 = llvm.lshr %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c28_i64 = arith.constant 28 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.udiv %c28_i64, %c17_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.icmp "slt" %3, %c28_i64 : i64
    %5 = llvm.select %4, %3, %c-41_i64 : i1, i64
    %6 = llvm.xor %0, %5 : i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c38_i64 = arith.constant 38 : i64
    %c-23_i64 = arith.constant -23 : i64
    %false = arith.constant false
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg1, %arg2 : i1, i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.urem %2, %c-23_i64 : i64
    %4 = llvm.icmp "ule" %c38_i64, %c-42_i64 : i64
    %5 = llvm.select %4, %c36_i64, %c-36_i64 : i1, i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %false = arith.constant false
    %c-17_i64 = arith.constant -17 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.urem %c-17_i64, %c-26_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    %5 = llvm.select %4, %c-21_i64, %arg0 : i1, i64
    %6 = llvm.trunc %4 : i1 to i64
    %7 = llvm.icmp "sle" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.urem %c-50_i64, %c-29_i64 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.icmp "slt" %c-13_i64, %c6_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.xor %4, %arg1 : i64
    %6 = llvm.urem %0, %5 : i64
    %7 = llvm.xor %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %arg1, %c6_i64 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "uge" %3, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %5, %c-8_i64 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.and %c-35_i64, %c-41_i64 : i64
    %1 = llvm.and %c43_i64, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.trunc %3 : i1 to i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c33_i64 = arith.constant 33 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "uge" %c-19_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.or %c33_i64, %3 : i64
    %5 = llvm.urem %4, %2 : i64
    %6 = llvm.icmp "ne" %3, %5 : i64
    %7 = llvm.select %6, %c-46_i64, %c-12_i64 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "uge" %arg1, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %4, %c28_i64 : i64
    %6 = llvm.ashr %2, %5 : i64
    %7 = llvm.icmp "sge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %true = arith.constant true
    %c29_i64 = arith.constant 29 : i64
    %c33_i64 = arith.constant 33 : i64
    %c12_i64 = arith.constant 12 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.srem %c12_i64, %c45_i64 : i64
    %1 = llvm.lshr %0, %c29_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ne" %c33_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %true, %4, %2 : i1, i64
    %6 = llvm.sext %false : i1 to i64
    %7 = llvm.select %3, %5, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c41_i64 = arith.constant 41 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %arg1, %c43_i64 : i64
    %2 = llvm.select %1, %0, %arg2 : i1, i64
    %3 = llvm.icmp "eq" %arg2, %c41_i64 : i64
    %4 = llvm.urem %c-5_i64, %arg1 : i64
    %5 = llvm.select %3, %2, %4 : i1, i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.ashr %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg2, %c-6_i64 : i64
    %3 = llvm.urem %c47_i64, %arg1 : i64
    %4 = llvm.icmp "slt" %3, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.select %2, %5, %arg1 : i1, i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %c-10_i64 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.urem %1, %1 : i64
    %4 = llvm.zext %arg0 : i1 to i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c-44_i64, %1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.and %arg1, %arg2 : i64
    %5 = llvm.xor %4, %3 : i64
    %6 = llvm.icmp "ne" %3, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg1, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.and %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.ashr %c34_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %c-8_i64, %1 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.icmp "ne" %c7_i64, %c-8_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.or %6, %5 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.srem %c-46_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.udiv %c45_i64, %1 : i64
    %3 = llvm.urem %c14_i64, %arg2 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c44_i64 = arith.constant 44 : i64
    %c43_i64 = arith.constant 43 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.sdiv %arg0, %c3_i64 : i64
    %1 = llvm.ashr %c43_i64, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %2, %c44_i64 : i64
    %4 = llvm.select %true, %2, %3 : i1, i64
    %5 = llvm.urem %4, %2 : i64
    %6 = llvm.sdiv %3, %5 : i64
    %7 = llvm.ashr %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sdiv %c39_i64, %0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.sdiv %arg2, %arg0 : i64
    %5 = llvm.sdiv %arg1, %4 : i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "ule" %c24_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.zext %arg1 : i1 to i64
    %5 = llvm.or %arg0, %1 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %c22_i64, %0 : i64
    %2 = llvm.urem %arg0, %0 : i64
    %3 = llvm.icmp "ugt" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.sdiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %true = arith.constant true
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.udiv %arg0, %c-6_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.sdiv %2, %c-45_i64 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c50_i64 = arith.constant 50 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.sdiv %c45_i64, %arg1 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "uge" %c50_i64, %3 : i64
    %5 = llvm.trunc %true : i1 to i64
    %6 = llvm.sext %4 : i1 to i64
    %7 = llvm.select %4, %5, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %arg1, %c-19_i64 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.trunc %0 : i1 to i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ugt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.srem %arg0, %c-1_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %arg1, %arg0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.icmp "sge" %6, %5 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %c-12_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.icmp "ne" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %4, %1 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.icmp "uge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.sdiv %c-29_i64, %c-11_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.select %arg0, %arg1, %2 : i1, i64
    %4 = llvm.urem %3, %1 : i64
    %5 = llvm.sdiv %c14_i64, %4 : i64
    %6 = llvm.or %3, %5 : i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ugt" %c21_i64, %c-12_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.udiv %c-37_i64, %3 : i64
    %5 = llvm.or %4, %3 : i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.icmp "ult" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c35_i64 = arith.constant 35 : i64
    %c-45_i64 = arith.constant -45 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "eq" %c-45_i64, %0 : i64
    %3 = llvm.select %true, %arg0, %arg1 : i1, i64
    %4 = llvm.select %2, %c35_i64, %3 : i1, i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.srem %6, %arg2 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "eq" %c-40_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c-22_i64, %1 : i64
    %3 = llvm.ashr %c-28_i64, %arg1 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.sext %0 : i1 to i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %c-35_i64, %c48_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.sdiv %2, %c30_i64 : i64
    %4 = llvm.and %c-8_i64, %3 : i64
    %5 = llvm.lshr %arg1, %4 : i64
    %6 = llvm.or %0, %5 : i64
    %7 = llvm.sdiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %true = arith.constant true
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.icmp "sle" %0, %c-13_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.select %1, %3, %4 : i1, i64
    %6 = llvm.xor %4, %0 : i64
    %7 = llvm.xor %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c1_i64 = arith.constant 1 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.lshr %c1_i64, %c-36_i64 : i64
    %1 = llvm.lshr %c-22_i64, %arg1 : i64
    %2 = llvm.icmp "eq" %arg2, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %3, %c34_i64 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.select %arg0, %arg1, %5 : i1, i64
    %7 = llvm.icmp "uge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-36_i64 = arith.constant -36 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.udiv %arg2, %c-36_i64 : i64
    %4 = llvm.icmp "slt" %c-5_i64, %3 : i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.select %4, %3, %5 : i1, i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %4, %arg1 : i64
    %6 = llvm.urem %0, %5 : i64
    %7 = llvm.srem %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c7_i64 = arith.constant 7 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.lshr %c7_i64, %c3_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    %6 = llvm.lshr %arg1, %c12_i64 : i64
    %7 = llvm.select %5, %arg0, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.xor %arg1, %arg1 : i64
    %3 = llvm.srem %c-17_i64, %2 : i64
    %4 = llvm.icmp "sge" %3, %arg0 : i64
    %5 = llvm.zext %arg2 : i1 to i64
    %6 = llvm.select %4, %3, %5 : i1, i64
    %7 = llvm.icmp "uge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-47_i64 = arith.constant -47 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %c-47_i64, %0 : i64
    %2 = llvm.ashr %c-35_i64, %arg0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.sdiv %arg1, %arg2 : i64
    %5 = llvm.icmp "ugt" %c-16_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.select %3, %6, %arg0 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c3_i64, %0 : i64
    %2 = llvm.lshr %c-41_i64, %1 : i64
    %3 = llvm.or %c16_i64, %1 : i64
    %4 = llvm.lshr %1, %arg1 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.ashr %0, %0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.udiv %arg2, %1 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sgt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.srem %c25_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c10_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.lshr %2, %arg2 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.urem %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.lshr %0, %c4_i64 : i64
    %3 = llvm.srem %c-2_i64, %2 : i64
    %4 = llvm.xor %c38_i64, %0 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c8_i64 = arith.constant 8 : i64
    %false = arith.constant false
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.select %false, %arg2, %c8_i64 : i1, i64
    %2 = llvm.and %arg2, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %c3_i64, %4 : i64
    %6 = llvm.icmp "ugt" %5, %c-20_i64 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "sle" %3, %2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.srem %5, %arg2 : i64
    %7 = llvm.srem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c12_i64 = arith.constant 12 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.and %c-39_i64, %arg0 : i64
    %1 = llvm.select %arg2, %c12_i64, %arg0 : i1, i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.srem %c-5_i64, %c-24_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.or %arg1, %5 : i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %false = arith.constant false
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "sge" %c43_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.lshr %c-47_i64, %3 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.srem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %true = arith.constant true
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.or %c-48_i64, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ult" %3, %c29_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ult" %arg0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.zext %3 : i1 to i64
    %6 = llvm.udiv %5, %c39_i64 : i64
    %7 = llvm.sdiv %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.ashr %0, %arg2 : i64
    %3 = llvm.icmp "eq" %c35_i64, %2 : i64
    %4 = llvm.select %3, %2, %c-30_i64 : i1, i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.ashr %c-4_i64, %5 : i64
    %7 = llvm.or %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.select %arg1, %c49_i64, %arg0 : i1, i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %arg0, %4 : i64
    %6 = llvm.xor %arg2, %2 : i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "sle" %c10_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.select %0, %c14_i64, %3 : i1, i64
    %5 = llvm.icmp "eq" %arg0, %3 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %c24_i64, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.ashr %1, %c30_i64 : i64
    %5 = llvm.or %0, %arg1 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.or %arg0, %c-26_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.icmp "sle" %4, %c-37_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.and %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "ule" %c41_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.select %true, %1, %arg0 : i1, i64
    %4 = llvm.icmp "ne" %1, %c-22_i64 : i64
    %5 = llvm.select %4, %c21_i64, %3 : i1, i64
    %6 = llvm.sdiv %3, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.and %c-19_i64, %arg0 : i64
    %1 = llvm.and %c-29_i64, %0 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.srem %arg2, %c4_i64 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.sdiv %3, %0 : i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %false = arith.constant false
    %c-32_i64 = arith.constant -32 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.lshr %c-32_i64, %c-23_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.xor %c-33_i64, %0 : i64
    %4 = llvm.udiv %arg0, %arg0 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.icmp "sle" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c6_i64, %arg2 : i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.icmp "ne" %6, %c37_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.lshr %c-17_i64, %c-40_i64 : i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %c19_i64, %2 : i64
    %4 = llvm.ashr %0, %arg1 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.select %arg0, %c45_i64, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.lshr %arg0, %c-26_i64 : i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.and %arg1, %0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "ugt" %c30_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.udiv %0, %5 : i64
    %7 = llvm.icmp "eq" %6, %c32_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.xor %c-1_i64, %c-2_i64 : i64
    %3 = llvm.urem %arg2, %2 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.srem %0, %5 : i64
    %7 = llvm.icmp "sle" %6, %c-37_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "eq" %1, %c-14_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %false, %0, %arg0 : i1, i64
    %5 = llvm.select %true, %3, %4 : i1, i64
    %6 = llvm.or %0, %5 : i64
    %7 = llvm.icmp "slt" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c20_i64 = arith.constant 20 : i64
    %true = arith.constant true
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.select %true, %arg0, %c-35_i64 : i1, i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.or %0, %c20_i64 : i64
    %5 = llvm.ashr %4, %c-33_i64 : i64
    %6 = llvm.ashr %arg1, %5 : i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.udiv %c20_i64, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.icmp "slt" %arg2, %arg1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %arg1, %5 : i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %c16_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.xor %3, %c-25_i64 : i64
    %5 = llvm.icmp "sle" %4, %arg0 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.lshr %6, %c-32_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c41_i64 = arith.constant 41 : i64
    %c20_i64 = arith.constant 20 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "sgt" %c-20_i64, %c44_i64 : i64
    %1 = llvm.ashr %c25_i64, %c20_i64 : i64
    %2 = llvm.select %0, %1, %c41_i64 : i1, i64
    %3 = llvm.lshr %1, %c-10_i64 : i64
    %4 = llvm.and %3, %c-35_i64 : i64
    %5 = llvm.srem %arg0, %2 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg0, %arg2 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.ashr %c-21_i64, %c13_i64 : i64
    %5 = llvm.icmp "eq" %4, %c-43_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.urem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.lshr %c39_i64, %c-20_i64 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "slt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.select %arg0, %c-23_i64, %arg1 : i1, i64
    %1 = llvm.icmp "sle" %0, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg2, %c-36_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.ashr %5, %c47_i64 : i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.lshr %c4_i64, %c-31_i64 : i64
    %1 = llvm.ashr %c21_i64, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.select %arg1, %c-18_i64, %arg2 : i1, i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.udiv %4, %0 : i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.icmp "slt" %c-50_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "slt" %c1_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "uge" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %c12_i64, %4 : i64
    %6 = llvm.icmp "sle" %2, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c40_i64 = arith.constant 40 : i64
    %c23_i64 = arith.constant 23 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %c23_i64, %c47_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %4, %c40_i64 : i64
    %6 = llvm.and %c-10_i64, %2 : i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.xor %arg0, %c-7_i64 : i64
    %1 = llvm.xor %arg0, %c6_i64 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    %6 = llvm.sext %arg1 : i1 to i64
    %7 = llvm.select %5, %6, %c-35_i64 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.srem %arg0, %0 : i64
    %3 = llvm.icmp "ne" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %1, %4, %arg2 : i1, i64
    %6 = llvm.trunc %false : i1 to i64
    %7 = llvm.lshr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c26_i64 = arith.constant 26 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "slt" %c38_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "eq" %c-41_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.urem %c26_i64, %4 : i64
    %6 = llvm.ashr %4, %arg1 : i64
    %7 = llvm.icmp "sle" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.and %4, %arg1 : i64
    %6 = llvm.srem %arg2, %5 : i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c23_i64 = arith.constant 23 : i64
    %true = arith.constant true
    %0 = llvm.ashr %arg0, %arg2 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.select %true, %c23_i64, %c-42_i64 : i1, i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "sgt" %4, %1 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.ashr %1, %c-41_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %3, %arg1, %c17_i64 : i1, i64
    %6 = llvm.udiv %5, %arg1 : i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c8_i64 = arith.constant 8 : i64
    %false = arith.constant false
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.select %false, %c49_i64, %arg0 : i1, i64
    %1 = llvm.lshr %c8_i64, %0 : i64
    %2 = llvm.icmp "sgt" %0, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.lshr %5, %arg1 : i64
    %7 = llvm.icmp "ule" %c50_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c14_i64 = arith.constant 14 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "slt" %c14_i64, %0 : i64
    %2 = llvm.ashr %0, %arg0 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.select %1, %c2_i64, %4 : i1, i64
    %6 = llvm.lshr %3, %0 : i64
    %7 = llvm.ashr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-41_i64 = arith.constant -41 : i64
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.select %true, %0, %arg0 : i1, i64
    %2 = llvm.srem %1, %c-41_i64 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.lshr %3, %c13_i64 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "slt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c30_i64 = arith.constant 30 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %arg0, %c20_i64 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.sdiv %c30_i64, %c40_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.urem %arg1, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.srem %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.lshr %c-2_i64, %arg0 : i64
    %1 = llvm.urem %c6_i64, %arg1 : i64
    %2 = llvm.icmp "ult" %1, %c-1_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.srem %0, %5 : i64
    %7 = llvm.lshr %6, %arg1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.lshr %c45_i64, %1 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.srem %5, %arg2 : i64
    %7 = llvm.icmp "uge" %6, %0 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.srem %c-21_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "sge" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %arg2, %c20_i64 : i64
    %5 = llvm.ashr %4, %0 : i64
    %6 = llvm.sdiv %3, %5 : i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.srem %arg0, %c-24_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.udiv %c-8_i64, %arg2 : i64
    %7 = llvm.or %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.xor %c-36_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %arg1 : i64
    %2 = llvm.select %1, %arg0, %c41_i64 : i1, i64
    %3 = llvm.lshr %c-36_i64, %arg0 : i64
    %4 = llvm.icmp "sge" %arg2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.icmp "ult" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c-37_i64 = arith.constant -37 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %c-37_i64, %2 : i64
    %4 = llvm.and %arg0, %c-3_i64 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "uge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.or %c30_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.xor %1, %c-17_i64 : i64
    %4 = llvm.srem %2, %c-14_i64 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ugt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c7_i64 = arith.constant 7 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "eq" %arg1, %c9_i64 : i64
    %2 = llvm.xor %arg1, %c7_i64 : i64
    %3 = llvm.select %1, %2, %arg1 : i1, i64
    %4 = llvm.ashr %c-12_i64, %0 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %c40_i64 = arith.constant 40 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.select %false, %c40_i64, %c37_i64 : i1, i64
    %1 = llvm.icmp "sge" %c-34_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %c19_i64, %arg0 : i64
    %6 = llvm.ashr %arg0, %5 : i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.udiv %arg1, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.or %c-45_i64, %2 : i64
    %5 = llvm.udiv %arg0, %4 : i64
    %6 = llvm.ashr %5, %arg2 : i64
    %7 = llvm.xor %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.xor %arg0, %c21_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.sdiv %3, %c-2_i64 : i64
    %5 = llvm.udiv %arg1, %4 : i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.sdiv %6, %arg1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "uge" %c46_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg1, %c-50_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.srem %arg2, %c-44_i64 : i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.and %c-17_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.or %arg1, %c44_i64 : i64
    %4 = llvm.sdiv %c-1_i64, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.select %0, %1, %c35_i64 : i1, i64
    %4 = llvm.lshr %arg1, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "uge" %6, %c46_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.ashr %arg0, %c-19_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sge" %5, %3 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c16_i64 = arith.constant 16 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.udiv %2, %c-3_i64 : i64
    %4 = llvm.srem %c16_i64, %c-12_i64 : i64
    %5 = llvm.lshr %arg2, %arg0 : i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.urem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c4_i64 = arith.constant 4 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "ugt" %c4_i64, %c11_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.or %c47_i64, %1 : i64
    %4 = llvm.select %2, %c-12_i64, %3 : i1, i64
    %5 = llvm.zext %0 : i1 to i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.icmp "sge" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %false = arith.constant false
    %c-48_i64 = arith.constant -48 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.select %arg0, %c-18_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ule" %0, %c-48_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %arg2, %2 : i64
    %4 = llvm.select %false, %c-33_i64, %0 : i1, i64
    %5 = llvm.ashr %4, %2 : i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.xor %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %c-22_i64, %0 : i64
    %2 = llvm.sdiv %c25_i64, %arg1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.lshr %c-18_i64, %arg1 : i64
    %5 = llvm.trunc %3 : i1 to i64
    %6 = llvm.select %3, %4, %5 : i1, i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.urem %c13_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %1, %0, %c-39_i64 : i1, i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.srem %5, %c39_i64 : i64
    %7 = llvm.icmp "slt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %true = arith.constant true
    %c30_i64 = arith.constant 30 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.select %true, %c30_i64, %c6_i64 : i1, i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.select %true, %0, %1 : i1, i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.select %false, %3, %arg1 : i1, i64
    %5 = llvm.urem %4, %arg2 : i64
    %6 = llvm.select %arg0, %1, %arg2 : i1, i64
    %7 = llvm.icmp "ult" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.ashr %c19_i64, %arg1 : i64
    %1 = llvm.or %0, %c8_i64 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.zext %3 : i1 to i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.select %1, %0, %c-50_i64 : i1, i64
    %3 = llvm.icmp "uge" %arg0, %c-44_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %c-8_i64, %arg1 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.icmp "sge" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %c25_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.udiv %c-16_i64, %c-46_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.srem %1, %0 : i64
    %4 = llvm.udiv %3, %3 : i64
    %5 = llvm.xor %4, %0 : i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.ashr %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.xor %arg0, %4 : i64
    %6 = llvm.or %5, %c-19_i64 : i64
    %7 = llvm.and %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.and %c17_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "ugt" %c-14_i64, %c-11_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.select %4, %arg0, %5 : i1, i64
    %7 = llvm.sdiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c43_i64 = arith.constant 43 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.sdiv %0, %c38_i64 : i64
    %2 = llvm.or %1, %c43_i64 : i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.sdiv %3, %arg2 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.trunc %false : i1 to i64
    %7 = llvm.and %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.udiv %c-12_i64, %arg1 : i64
    %1 = llvm.urem %arg2, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %4, %arg2 : i64
    %6 = llvm.udiv %arg1, %5 : i64
    %7 = llvm.icmp "sle" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "slt" %arg0, %c34_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %c22_i64 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.select %0, %4, %2 : i1, i64
    %6 = llvm.icmp "eq" %arg0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %true = arith.constant true
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.select %true, %0, %c13_i64 : i1, i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %1, %5 : i64
    %7 = llvm.icmp "ult" %6, %5 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.urem %arg0, %c-14_i64 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.urem %arg2, %2 : i64
    %4 = llvm.or %3, %2 : i64
    %5 = llvm.sdiv %c-35_i64, %4 : i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %true = arith.constant true
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.select %arg0, %c35_i64, %arg1 : i1, i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.srem %0, %c43_i64 : i64
    %3 = llvm.icmp "uge" %arg2, %2 : i64
    %4 = llvm.select %3, %0, %2 : i1, i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.ashr %0, %5 : i64
    %7 = llvm.icmp "uge" %6, %4 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.lshr %c-18_i64, %c-31_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.xor %c-36_i64, %1 : i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.or %4, %2 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.icmp "sge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c4_i64 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.ashr %arg1, %arg1 : i64
    %4 = llvm.icmp "sge" %3, %arg1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %0, %5 : i64
    %7 = llvm.and %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %c-37_i64 : i64
    %2 = llvm.select %1, %arg2, %c13_i64 : i1, i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.select %3, %arg1, %c-5_i64 : i1, i64
    %5 = llvm.icmp "ule" %c-43_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.sdiv %6, %c-40_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.and %arg0, %c-40_i64 : i64
    %1 = llvm.icmp "ule" %0, %arg2 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "sle" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %1, %4, %arg2 : i1, i64
    %6 = llvm.urem %arg1, %5 : i64
    %7 = llvm.icmp "uge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.select %arg0, %c13_i64, %c-3_i64 : i1, i64
    %1 = llvm.srem %0, %c-33_i64 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "sgt" %c-37_i64, %arg1 : i64
    %5 = llvm.select %4, %1, %arg2 : i1, i64
    %6 = llvm.udiv %5, %2 : i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "ult" %c-24_i64, %c9_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "ult" %c24_i64, %1 : i64
    %4 = llvm.trunc %0 : i1 to i64
    %5 = llvm.udiv %4, %4 : i64
    %6 = llvm.select %3, %2, %5 : i1, i64
    %7 = llvm.lshr %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.srem %c-19_i64, %c23_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "uge" %arg0, %c-47_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %arg1, %3, %0 : i1, i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.srem %arg2, %1 : i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %c-49_i64, %0 : i64
    %2 = llvm.icmp "sle" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %3, %arg1 : i64
    %5 = llvm.lshr %4, %arg2 : i64
    %6 = llvm.lshr %arg0, %5 : i64
    %7 = llvm.udiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.or %arg0, %c-18_i64 : i64
    %1 = llvm.icmp "uge" %c25_i64, %arg0 : i64
    %2 = llvm.select %1, %arg2, %c14_i64 : i1, i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.and %arg2, %0 : i64
    %5 = llvm.or %4, %arg0 : i64
    %6 = llvm.or %3, %5 : i64
    %7 = llvm.icmp "ult" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sdiv %c27_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg1, %c-26_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.urem %3, %c-41_i64 : i64
    %5 = llvm.select %1, %c32_i64, %c-36_i64 : i1, i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c24_i64 = arith.constant 24 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.ashr %c-49_i64, %c18_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.udiv %c-39_i64, %c33_i64 : i64
    %3 = llvm.sdiv %arg1, %arg1 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.icmp "ule" %c24_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "slt" %arg0, %c-12_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %c-40_i64, %3 : i64
    %5 = llvm.lshr %arg1, %arg1 : i64
    %6 = llvm.ashr %c43_i64, %5 : i64
    %7 = llvm.select %4, %6, %1 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c39_i64 = arith.constant 39 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.xor %c17_i64, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.lshr %c39_i64, %c-18_i64 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.select %2, %arg2, %4 : i1, i64
    %6 = llvm.icmp "ne" %5, %0 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %c21_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %arg2, %c-34_i64 : i64
    %5 = llvm.lshr %4, %c-8_i64 : i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.lshr %c39_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %c-3_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %0, %c44_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.or %2, %2 : i64
    %6 = llvm.lshr %5, %0 : i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.urem %arg0, %c37_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.select %1, %c19_i64, %arg0 : i1, i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.lshr %3, %0 : i64
    %5 = llvm.lshr %4, %arg0 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c13_i64 = arith.constant 13 : i64
    %c19_i64 = arith.constant 19 : i64
    %c39_i64 = arith.constant 39 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ne" %arg0, %c-40_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %c39_i64, %1 : i64
    %3 = llvm.udiv %c13_i64, %c-6_i64 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ult" %c19_i64, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.ashr %0, %c-20_i64 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.ashr %1, %arg2 : i64
    %4 = llvm.select %arg0, %3, %c30_i64 : i1, i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.udiv %arg0, %c13_i64 : i64
    %1 = llvm.sdiv %c-6_i64, %0 : i64
    %2 = llvm.srem %1, %c-42_i64 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.icmp "ugt" %c7_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.or %6, %0 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %c12_i64 = arith.constant 12 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.sdiv %c12_i64, %c-12_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.urem %2, %3 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ult" %0, %c-34_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %c-9_i64, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.lshr %arg1, %0 : i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.and %c50_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %4, %0 : i64
    %6 = llvm.and %2, %5 : i64
    %7 = llvm.icmp "sle" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.icmp "ugt" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %c20_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %c-31_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.icmp "ule" %3, %arg1 : i64
    %5 = llvm.select %4, %c-8_i64, %c-8_i64 : i1, i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c13_i64 = arith.constant 13 : i64
    %true = arith.constant true
    %c-5_i64 = arith.constant -5 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %c46_i64 : i64
    %2 = llvm.udiv %1, %c-5_i64 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.select %true, %c13_i64, %c-28_i64 : i1, i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %c7_i64, %c-11_i64 : i64
    %2 = llvm.icmp "sgt" %c-26_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.srem %1, %1 : i64
    %6 = llvm.sdiv %c-22_i64, %5 : i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %arg0 : i64
    %4 = llvm.select %3, %arg0, %arg2 : i1, i64
    %5 = llvm.icmp "sge" %arg1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "slt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %true, %c-12_i64, %0 : i1, i64
    %6 = llvm.lshr %5, %1 : i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %4, %0 : i64
    %6 = llvm.or %1, %5 : i64
    %7 = llvm.icmp "ugt" %6, %arg0 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %arg2, %c35_i64 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.lshr %c2_i64, %2 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.or %arg1, %4 : i64
    %6 = llvm.xor %c42_i64, %5 : i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "uge" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %true = arith.constant true
    %c40_i64 = arith.constant 40 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.and %c40_i64, %c-39_i64 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.urem %0, %arg1 : i64
    %3 = llvm.select %true, %1, %2 : i1, i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.icmp "ne" %5, %arg2 : i64
    %7 = llvm.select %6, %0, %c-41_i64 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c34_i64 = arith.constant 34 : i64
    %c16_i64 = arith.constant 16 : i64
    %false = arith.constant false
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.select %false, %c-29_i64, %arg0 : i1, i64
    %1 = llvm.select %false, %arg1, %c-5_i64 : i1, i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.urem %c16_i64, %2 : i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.icmp "ugt" %c34_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %6, %3 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.sext %0 : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.or %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %0, %c-21_i64 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.lshr %1, %c13_i64 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.sdiv %arg1, %5 : i64
    %7 = llvm.and %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "eq" %c-27_i64, %c49_i64 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.udiv %arg1, %arg2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.sext %0 : i1 to i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.and %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.srem %2, %c13_i64 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.icmp "eq" %4, %c-36_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.xor %c39_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %arg0, %arg1 : i64
    %4 = llvm.icmp "ule" %c43_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %0, %5 : i64
    %7 = llvm.icmp "ugt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %true = arith.constant true
    %c14_i64 = arith.constant 14 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.select %true, %c14_i64, %c3_i64 : i1, i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %3, %arg1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %arg2, %c33_i64 : i64
    %7 = llvm.lshr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.and %arg1, %c-50_i64 : i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.and %c39_i64, %3 : i64
    %5 = llvm.zext %0 : i1 to i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %false = arith.constant false
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.select %false, %c-30_i64, %arg0 : i1, i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.srem %0, %c-45_i64 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.lshr %6, %arg1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.xor %arg0, %c-40_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.xor %arg1, %0 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.select %5, %arg1, %c42_i64 : i1, i64
    %7 = llvm.icmp "sle" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ne" %c-27_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.sdiv %c-7_i64, %2 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    %6 = llvm.and %arg0, %c23_i64 : i64
    %7 = llvm.select %5, %c-15_i64, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "sle" %arg0, %c-6_i64 : i64
    %1 = llvm.select %0, %arg1, %c-26_i64 : i1, i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %arg2, %1 : i64
    %5 = llvm.srem %c45_i64, %3 : i64
    %6 = llvm.select %2, %4, %5 : i1, i64
    %7 = llvm.or %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c2_i64 = arith.constant 2 : i64
    %c16_i64 = arith.constant 16 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.ashr %c1_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %c2_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %c16_i64, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    %6 = llvm.select %1, %c23_i64, %2 : i1, i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.sdiv %arg2, %c17_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %arg2 : i64
    %4 = llvm.lshr %2, %0 : i64
    %5 = llvm.or %c40_i64, %4 : i64
    %6 = llvm.select %3, %5, %0 : i1, i64
    %7 = llvm.icmp "ult" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %c35_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.srem %arg0, %c-29_i64 : i64
    %3 = llvm.icmp "sge" %arg2, %arg2 : i64
    %4 = llvm.select %3, %c-15_i64, %arg1 : i1, i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.or %arg1, %5 : i64
    %7 = llvm.or %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "ult" %c-25_i64, %c29_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %c-43_i64, %1 : i64
    %3 = llvm.icmp "slt" %2, %c-46_i64 : i64
    %4 = llvm.and %arg0, %c0_i64 : i64
    %5 = llvm.select %3, %2, %4 : i1, i64
    %6 = llvm.srem %5, %5 : i64
    %7 = llvm.sdiv %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.ashr %c-42_i64, %c38_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.xor %c-27_i64, %4 : i64
    %6 = llvm.urem %arg1, %arg2 : i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %c0_i64, %arg2 : i64
    %2 = llvm.or %c47_i64, %1 : i64
    %3 = llvm.icmp "sge" %arg2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %4, %1 : i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "sgt" %c39_i64, %c26_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %4, %arg0 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.srem %c-14_i64, %c49_i64 : i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.ashr %c-39_i64, %5 : i64
    %7 = llvm.lshr %c-29_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.xor %c-36_i64, %arg1 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %c8_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.udiv %6, %arg2 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.xor %c36_i64, %arg0 : i64
    %2 = llvm.and %arg1, %c-23_i64 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    %5 = llvm.sdiv %c-4_i64, %2 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.icmp "ne" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c12_i64 = arith.constant 12 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.ashr %c12_i64, %c-47_i64 : i64
    %1 = llvm.icmp "ult" %c-16_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %c-7_i64, %0 : i64
    %4 = llvm.and %3, %arg0 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.lshr %5, %5 : i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c3_i64 = arith.constant 3 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %2, %c17_i64, %arg0 : i1, i64
    %5 = llvm.icmp "ne" %c3_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.ashr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %false = arith.constant false
    %c19_i64 = arith.constant 19 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg1, %arg2 : i1, i64
    %1 = llvm.select %false, %arg2, %c7_i64 : i1, i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ule" %c19_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %arg0, %arg1, %2 : i1, i64
    %6 = llvm.ashr %5, %arg1 : i64
    %7 = llvm.select %arg0, %4, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.udiv %3, %2 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.sdiv %2, %5 : i64
    %7 = llvm.icmp "ult" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.and %c26_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %0, %arg0 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.lshr %3, %arg1 : i64
    %5 = llvm.sdiv %arg0, %c-8_i64 : i64
    %6 = llvm.select %arg2, %5, %4 : i1, i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %arg1, %c33_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.icmp "sle" %1, %arg0 : i64
    %5 = llvm.select %4, %c1_i64, %1 : i1, i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c36_i64 = arith.constant 36 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %arg0, %c36_i64 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.and %2, %c-21_i64 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.or %4, %c-11_i64 : i64
    %6 = llvm.srem %5, %arg1 : i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "uge" %arg0, %c-22_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c-10_i64, %arg1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.ashr %5, %5 : i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %c3_i64, %0 : i64
    %2 = llvm.sdiv %arg2, %1 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c45_i64 = arith.constant 45 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.xor %c29_i64, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.urem %1, %c45_i64 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.icmp "ugt" %c23_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.udiv %arg0, %arg1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %4, %arg2 : i64
    %6 = llvm.ashr %5, %arg2 : i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.sdiv %c-42_i64, %c21_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    %3 = llvm.icmp "eq" %c-43_i64, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sext %arg0 : i1 to i64
    %6 = llvm.select %2, %4, %5 : i1, i64
    %7 = llvm.or %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "sgt" %arg0, %c-30_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.udiv %arg1, %arg2 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %c31_i64, %0 : i64
    %2 = llvm.or %c-32_i64, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.select %arg0, %c-13_i64, %c35_i64 : i1, i64
    %5 = llvm.or %4, %c37_i64 : i64
    %6 = llvm.xor %arg2, %5 : i64
    %7 = llvm.icmp "sgt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c19_i64 = arith.constant 19 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %arg2, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.urem %c-17_i64, %c-38_i64 : i64
    %5 = llvm.srem %4, %c19_i64 : i64
    %6 = llvm.or %5, %c-21_i64 : i64
    %7 = llvm.urem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.or %c-15_i64, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.udiv %c-15_i64, %c30_i64 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.srem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.urem %c-3_i64, %arg0 : i64
    %1 = llvm.xor %c14_i64, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.ashr %4, %3 : i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    %7 = llvm.select %6, %c-31_i64, %5 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %true = arith.constant true
    %c45_i64 = arith.constant 45 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.urem %c-43_i64, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "sle" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sext %arg2 : i1 to i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.sdiv %0, %5 : i64
    %7 = llvm.lshr %c45_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.srem %c21_i64, %c14_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.urem %arg1, %arg1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "uge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.and %c-7_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.or %arg1, %arg2 : i64
    %3 = llvm.ashr %2, %c6_i64 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "ule" %4, %arg1 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "eq" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "sle" %c-22_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.sdiv %c49_i64, %2 : i64
    %4 = llvm.trunc %0 : i1 to i64
    %5 = llvm.or %2, %arg2 : i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.lshr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.srem %c8_i64, %1 : i64
    %3 = llvm.udiv %arg0, %1 : i64
    %4 = llvm.icmp "eq" %3, %arg1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.ashr %5, %c46_i64 : i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %c-3_i64, %c42_i64 : i64
    %1 = llvm.icmp "ugt" %0, %c-31_i64 : i64
    %2 = llvm.icmp "sge" %0, %c19_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %1, %3, %3 : i1, i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.xor %0, %arg0 : i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.sdiv %c41_i64, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.xor %4, %arg2 : i64
    %6 = llvm.ashr %c15_i64, %5 : i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg1, %1 : i64
    %3 = llvm.sdiv %arg1, %arg0 : i64
    %4 = llvm.xor %arg0, %arg1 : i64
    %5 = llvm.select %2, %3, %4 : i1, i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    %7 = llvm.select %6, %arg0, %arg1 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "ne" %c47_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.trunc %3 : i1 to i64
    %6 = llvm.ashr %5, %c-14_i64 : i64
    %7 = llvm.lshr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-43_i64 = arith.constant -43 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %c-43_i64, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.select %2, %arg0, %4 : i1, i64
    %6 = llvm.icmp "ule" %5, %c-30_i64 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.udiv %arg1, %c-40_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.urem %arg2, %arg1 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.icmp "sle" %c22_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.udiv %c0_i64, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %c-37_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.xor %c-38_i64, %2 : i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c40_i64 = arith.constant 40 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %c30_i64, %c-34_i64 : i64
    %1 = llvm.ashr %0, %c40_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sge" %c-33_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.trunc %3 : i1 to i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    %4 = llvm.srem %2, %arg1 : i64
    %5 = llvm.select %3, %1, %4 : i1, i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.icmp "sge" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %0, %arg0 : i64
    %4 = llvm.lshr %3, %c-38_i64 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ne" %c28_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %c40_i64, %0 : i1, i64
    %2 = llvm.udiv %1, %c19_i64 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.lshr %arg0, %c-50_i64 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.udiv %c0_i64, %1 : i64
    %3 = llvm.srem %arg0, %1 : i64
    %4 = llvm.sdiv %arg2, %3 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.and %0, %5 : i64
    %7 = llvm.icmp "sge" %c-47_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.lshr %c22_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %c30_i64, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c27_i64 = arith.constant 27 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.and %c39_i64, %arg0 : i64
    %1 = llvm.xor %c27_i64, %arg0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.sdiv %arg2, %c41_i64 : i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "ule" %c-30_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg1, %arg0 : i64
    %3 = llvm.udiv %1, %arg0 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.or %arg2, %2 : i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.ashr %arg1, %c-26_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %c-28_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %5, %0 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.select %2, %0, %arg2 : i1, i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %arg2, %c-13_i64 : i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %false = arith.constant false
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %c-28_i64, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %false = arith.constant false
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %arg1, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.sdiv %5, %c-15_i64 : i64
    %7 = llvm.icmp "slt" %c-50_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "ult" %c-2_i64, %c35_i64 : i64
    %1 = llvm.icmp "sgt" %c-5_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.xor %c-7_i64, %3 : i64
    %5 = llvm.and %3, %c25_i64 : i64
    %6 = llvm.udiv %5, %2 : i64
    %7 = llvm.icmp "eq" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "sgt" %c-9_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %c35_i64, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.icmp "sge" %c-41_i64, %c40_i64 : i64
    %5 = llvm.zext %0 : i1 to i64
    %6 = llvm.select %4, %5, %c18_i64 : i1, i64
    %7 = llvm.lshr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg1, %c-35_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.and %c10_i64, %arg2 : i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sext %arg2 : i1 to i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.udiv %0, %c-4_i64 : i64
    %5 = llvm.and %arg2, %4 : i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.or %arg0, %c-48_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %c36_i64, %c-8_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.udiv %arg1, %5 : i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c26_i64 = arith.constant 26 : i64
    %true = arith.constant true
    %c28_i64 = arith.constant 28 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.lshr %c28_i64, %c-14_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.select %true, %arg0, %c26_i64 : i1, i64
    %3 = llvm.udiv %1, %arg1 : i64
    %4 = llvm.urem %c-4_i64, %3 : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.icmp "sgt" %arg1, %c7_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.select %0, %1, %arg2 : i1, i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.udiv %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg1 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "sge" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.ashr %arg2, %2 : i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.icmp "sle" %3, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sext %false : i1 to i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "sgt" %arg2, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.zext %1 : i1 to i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.urem %0, %5 : i64
    %7 = llvm.icmp "sgt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %c18_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "ule" %c-48_i64, %0 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.or %arg0, %0 : i64
    %4 = llvm.select %arg1, %arg2, %0 : i1, i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.srem %5, %arg2 : i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.select %0, %2, %arg1 : i1, i64
    %4 = llvm.or %c25_i64, %3 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.sext %0 : i1 to i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.ashr %c-10_i64, %arg0 : i64
    %1 = llvm.sdiv %c-11_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %arg1, %c21_i64, %0 : i1, i64
    %5 = llvm.and %arg2, %c10_i64 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg1, %c45_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sge" %arg0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "ne" %c36_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %4, %1 : i64
    %6 = llvm.lshr %1, %5 : i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c26_i64 = arith.constant 26 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ule" %c-6_i64, %arg0 : i64
    %1 = llvm.xor %arg1, %arg0 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.select %0, %2, %c26_i64 : i1, i64
    %4 = llvm.lshr %c-15_i64, %c-49_i64 : i64
    %5 = llvm.or %4, %c-29_i64 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.urem %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %arg1, %arg1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %c-50_i64, %arg2 : i64
    %6 = llvm.xor %5, %c29_i64 : i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-49_i64 = arith.constant -49 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.ashr %c-15_i64, %c-49_i64 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.sdiv %4, %arg0 : i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c8_i64 = arith.constant 8 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.ashr %c-30_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.sdiv %c40_i64, %1 : i64
    %3 = llvm.icmp "uge" %c18_i64, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.lshr %c8_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %c-6_i64, %c45_i64 : i64
    %1 = llvm.xor %c-16_i64, %0 : i64
    %2 = llvm.udiv %1, %c-2_i64 : i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.srem %arg0, %arg0 : i64
    %5 = llvm.sdiv %4, %arg1 : i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c31_i64 = arith.constant 31 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.ashr %c-39_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.lshr %c31_i64, %5 : i64
    %7 = llvm.icmp "ult" %6, %c19_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.lshr %c-18_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.sdiv %c-43_i64, %arg0 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.select %1, %3, %arg1 : i1, i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.lshr %arg0, %c-36_i64 : i64
    %1 = llvm.sdiv %arg0, %c-41_i64 : i64
    %2 = llvm.and %1, %c-2_i64 : i64
    %3 = llvm.srem %1, %0 : i64
    %4 = llvm.udiv %3, %arg0 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.lshr %c-12_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %c-24_i64, %1 : i64
    %3 = llvm.udiv %c8_i64, %2 : i64
    %4 = llvm.ashr %c29_i64, %c29_i64 : i64
    %5 = llvm.icmp "sle" %arg1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c-23_i64 = arith.constant -23 : i64
    %false = arith.constant false
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %false, %arg0, %c20_i64 : i1, i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.urem %c-23_i64, %c34_i64 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.ashr %5, %arg2 : i64
    %7 = llvm.icmp "slt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c18_i64 = arith.constant 18 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sdiv %arg0, %c27_i64 : i64
    %1 = llvm.icmp "sle" %arg1, %c18_i64 : i64
    %2 = llvm.sdiv %c-25_i64, %arg2 : i64
    %3 = llvm.sdiv %c49_i64, %arg0 : i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    %5 = llvm.icmp "sle" %4, %3 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.xor %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    %3 = llvm.select %2, %1, %0 : i1, i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.srem %3, %0 : i64
    %5 = llvm.urem %c21_i64, %4 : i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.icmp "ule" %c0_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c-6_i64 = arith.constant -6 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.udiv %c39_i64, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.icmp "sge" %c-6_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c-6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "eq" %c-6_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c-43_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %4, %arg0 : i64
    %6 = llvm.lshr %5, %2 : i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg2 : i64
    %2 = llvm.udiv %1, %c-46_i64 : i64
    %3 = llvm.udiv %arg1, %c-8_i64 : i64
    %4 = llvm.or %0, %0 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.urem %c38_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.lshr %c23_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %c38_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %0, %arg1 : i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.sdiv %c-7_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.icmp "ne" %arg1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "ult" %c10_i64, %c-20_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.srem %arg1, %arg2 : i64
    %3 = llvm.icmp "uge" %2, %c19_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %c-21_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.select %0, %1, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.icmp "slt" %c-38_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sext %0 : i1 to i64
    %6 = llvm.and %arg0, %5 : i64
    %7 = llvm.icmp "eq" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.lshr %arg1, %c-37_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.and %3, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.ashr %5, %c38_i64 : i64
    %7 = llvm.icmp "ne" %c-11_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c25_i64 = arith.constant 25 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.srem %arg0, %c13_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.or %c25_i64, %2 : i64
    %4 = llvm.icmp "ne" %arg1, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.urem %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.ashr %3, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c9_i64 = arith.constant 9 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.urem %c9_i64, %1 : i64
    %3 = llvm.lshr %c49_i64, %arg1 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.srem %0, %5 : i64
    %7 = llvm.icmp "ne" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.ashr %c37_i64, %arg0 : i64
    %1 = llvm.or %0, %c-48_i64 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.urem %c-16_i64, %2 : i64
    %4 = llvm.or %arg2, %c46_i64 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.ashr %c-25_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c-17_i64, %arg1 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.sdiv %c-10_i64, %0 : i64
    %5 = llvm.sext %1 : i1 to i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg2 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %true, %arg0, %3 : i1, i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.sdiv %0, %arg0 : i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "slt" %c23_i64, %c-37_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %c-43_i64 : i64
    %3 = llvm.or %2, %1 : i64
    %4 = llvm.select %0, %c26_i64, %arg0 : i1, i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.and %c21_i64, %c-41_i64 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %2, %c-8_i64 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    %5 = llvm.select %4, %c42_i64, %0 : i1, i64
    %6 = llvm.lshr %0, %5 : i64
    %7 = llvm.srem %6, %c-49_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "eq" %c-32_i64, %arg1 : i64
    %5 = llvm.sdiv %c4_i64, %3 : i64
    %6 = llvm.select %4, %0, %5 : i1, i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %arg1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "uge" %3, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.or %6, %arg2 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %c0_i64, %arg1 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "slt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c40_i64 = arith.constant 40 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %c24_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %arg2, %c40_i64 : i64
    %5 = llvm.ashr %c-1_i64, %c36_i64 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.icmp "uge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c48_i64 = arith.constant 48 : i64
    %c33_i64 = arith.constant 33 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.xor %arg0, %c50_i64 : i64
    %1 = llvm.udiv %c48_i64, %c13_i64 : i64
    %2 = llvm.or %c33_i64, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.udiv %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %true = arith.constant true
    %c-30_i64 = arith.constant -30 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.urem %c-30_i64, %c4_i64 : i64
    %1 = llvm.select %true, %arg0, %c46_i64 : i1, i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "eq" %5, %arg1 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.urem %1, %arg2 : i64
    %4 = llvm.and %c15_i64, %arg0 : i64
    %5 = llvm.lshr %4, %c-30_i64 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.ashr %arg0, %c46_i64 : i64
    %1 = llvm.srem %arg1, %arg1 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.icmp "ne" %0, %arg0 : i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.select %3, %arg0, %5 : i1, i64
    %7 = llvm.select %2, %1, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg0, %c43_i64 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "sge" %4, %c-17_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ult" %6, %c5_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %false = arith.constant false
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.sdiv %4, %c-22_i64 : i64
    %6 = llvm.and %5, %arg0 : i64
    %7 = llvm.urem %c3_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.urem %c-50_i64, %c-15_i64 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.select %1, %0, %arg1 : i1, i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.ashr %4, %arg2 : i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ugt" %1, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ne" %6, %4 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %true = arith.constant true
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.select %arg2, %c-19_i64, %1 : i1, i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "ugt" %arg0, %c-37_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.icmp "sge" %c-12_i64, %c-27_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %arg2, %3 : i64
    %5 = llvm.urem %4, %1 : i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c31_i64 = arith.constant 31 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.and %c31_i64, %c3_i64 : i64
    %1 = llvm.or %0, %c-11_i64 : i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.icmp "ne" %4, %arg0 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ult" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.and %arg0, %c-38_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.xor %c-47_i64, %3 : i64
    %5 = llvm.urem %0, %0 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.udiv %c-6_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.select %arg2, %2, %1 : i1, i64
    %4 = llvm.select %arg2, %2, %3 : i1, i64
    %5 = llvm.or %4, %0 : i64
    %6 = llvm.or %5, %c-41_i64 : i64
    %7 = llvm.srem %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %c-43_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %arg1, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %c-30_i64, %c2_i64 : i64
    %4 = llvm.select %3, %c29_i64, %arg0 : i1, i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.or %arg1, %5 : i64
    %7 = llvm.lshr %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %c20_i64 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.udiv %2, %arg1 : i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c25_i64 = arith.constant 25 : i64
    %c37_i64 = arith.constant 37 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "sge" %arg0, %c-4_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg1, %c37_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.srem %c25_i64, %2 : i64
    %5 = llvm.udiv %c-13_i64, %arg2 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.icmp "ult" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c11_i64 = arith.constant 11 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.lshr %c13_i64, %c-36_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.lshr %arg0, %c46_i64 : i64
    %3 = llvm.udiv %2, %c11_i64 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    %6 = llvm.select %5, %1, %c-15_i64 : i1, i64
    %7 = llvm.icmp "ult" %c-4_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.urem %c-21_i64, %c11_i64 : i64
    %1 = llvm.icmp "slt" %0, %c-31_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %c13_i64, %arg0 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "uge" %c-49_i64, %c-44_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %false = arith.constant false
    %c1_i64 = arith.constant 1 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.srem %arg0, %c-25_i64 : i64
    %1 = llvm.or %c1_i64, %arg1 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.select %false, %arg0, %2 : i1, i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "slt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c16_i64 = arith.constant 16 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %c2_i64, %0 : i64
    %2 = llvm.or %c16_i64, %1 : i64
    %3 = llvm.sdiv %1, %arg1 : i64
    %4 = llvm.and %c11_i64, %arg0 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ult" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c16_i64 = arith.constant 16 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.srem %c-41_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.urem %1, %c16_i64 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.sext %true : i1 to i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c17_i64 = arith.constant 17 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.lshr %c-17_i64, %arg0 : i64
    %2 = llvm.icmp "slt" %c17_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %3, %0 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %false = arith.constant false
    %c-27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.select %false, %c-27_i64, %1 : i1, i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %c7_i64, %4 : i64
    %6 = llvm.udiv %5, %arg0 : i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %true = arith.constant true
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.ashr %arg0, %c-46_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.and %4, %c1_i64 : i64
    %6 = llvm.or %3, %5 : i64
    %7 = llvm.xor %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %arg1, %c-22_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %c-28_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ne" %6, %c-32_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "eq" %c-12_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.trunc %0 : i1 to i64
    %4 = llvm.xor %3, %arg2 : i64
    %5 = llvm.ashr %4, %4 : i64
    %6 = llvm.and %arg1, %5 : i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "slt" %c21_i64, %c10_i64 : i64
    %1 = llvm.select %0, %arg0, %arg2 : i1, i64
    %2 = llvm.icmp "sge" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %arg2, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.icmp "eq" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.and %arg2, %arg0 : i64
    %4 = llvm.sdiv %3, %1 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %6, %c15_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %c-8_i64, %0 : i64
    %2 = llvm.select %1, %c-14_i64, %arg1 : i1, i64
    %3 = llvm.icmp "ule" %arg2, %c-21_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.and %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c12_i64 = arith.constant 12 : i64
    %c26_i64 = arith.constant 26 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %c26_i64, %c12_i64 : i64
    %2 = llvm.sdiv %c46_i64, %1 : i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.or %4, %4 : i64
    %6 = llvm.lshr %3, %c-32_i64 : i64
    %7 = llvm.urem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %false = arith.constant false
    %c21_i64 = arith.constant 21 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.urem %c11_i64, %c-48_i64 : i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.sdiv %c21_i64, %2 : i64
    %4 = llvm.sdiv %3, %arg0 : i64
    %5 = llvm.srem %4, %c-12_i64 : i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.lshr %1, %c-29_i64 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.xor %c-6_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.select %1, %arg2, %0 : i1, i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "slt" %c8_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.icmp "sge" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ne" %4, %c-30_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-7_i64 = arith.constant -7 : i64
    %true = arith.constant true
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.urem %0, %c-2_i64 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.xor %0, %arg2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.select %true, %arg1, %c-7_i64 : i1, i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "ne" %6, %c13_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c31_i64 = arith.constant 31 : i64
    %c33_i64 = arith.constant 33 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.udiv %arg0, %c47_i64 : i64
    %1 = llvm.urem %c33_i64, %c31_i64 : i64
    %2 = llvm.and %c-40_i64, %arg1 : i64
    %3 = llvm.icmp "sgt" %2, %arg2 : i64
    %4 = llvm.select %3, %0, %arg1 : i1, i64
    %5 = llvm.and %c-33_i64, %4 : i64
    %6 = llvm.xor %1, %5 : i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.lshr %c-15_i64, %c34_i64 : i64
    %4 = llvm.ashr %c-48_i64, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.and %c17_i64, %4 : i64
    %7 = llvm.icmp "ult" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.select %arg1, %2, %c8_i64 : i1, i64
    %4 = llvm.srem %3, %c-45_i64 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.urem %4, %c4_i64 : i64
    %7 = llvm.lshr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-45_i64 = arith.constant -45 : i64
    %false = arith.constant false
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.or %arg1, %c-8_i64 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.sdiv %c-45_i64, %c-6_i64 : i64
    %3 = llvm.icmp "sge" %c-2_i64, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "slt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "uge" %c-28_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.xor %c-35_i64, %arg0 : i64
    %7 = llvm.or %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c38_i64 = arith.constant 38 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.udiv %c38_i64, %c-31_i64 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.and %arg1, %c-34_i64 : i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c37_i64 = arith.constant 37 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.sdiv %c37_i64, %c45_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %c-47_i64, %c50_i64 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.udiv %0, %c34_i64 : i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %false = arith.constant false
    %c6_i64 = arith.constant 6 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.and %c-9_i64, %arg1 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.icmp "slt" %0, %arg2 : i64
    %3 = llvm.select %2, %c6_i64, %arg1 : i1, i64
    %4 = llvm.select %false, %0, %c13_i64 : i1, i64
    %5 = llvm.select %1, %3, %4 : i1, i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.and %arg0, %c-8_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %c-47_i64, %3 : i64
    %5 = llvm.icmp "ule" %c42_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "slt" %6, %c-36_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.udiv %arg1, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.trunc %arg0 : i1 to i64
    %4 = llvm.or %c15_i64, %0 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.icmp "slt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.sdiv %c22_i64, %arg1 : i64
    %4 = llvm.srem %arg2, %3 : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.xor %0, %5 : i64
    %7 = llvm.xor %c49_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %false = arith.constant false
    %c-31_i64 = arith.constant -31 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.select %arg2, %c-44_i64, %arg1 : i1, i64
    %3 = llvm.xor %2, %c-31_i64 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "sle" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.srem %arg0, %c27_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.lshr %3, %arg2 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.ashr %c-18_i64, %c39_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "sge" %1, %0 : i64
    %3 = llvm.select %2, %1, %arg1 : i1, i64
    %4 = llvm.and %c41_i64, %arg2 : i64
    %5 = llvm.xor %arg0, %4 : i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.icmp "ult" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c48_i64 = arith.constant 48 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.select %arg0, %arg1, %c-24_i64 : i1, i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.icmp "slt" %c42_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %c48_i64, %c-21_i64 : i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.xor %c-37_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.ashr %0, %arg1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.srem %arg1, %c11_i64 : i64
    %5 = llvm.icmp "sle" %4, %1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c35_i64 = arith.constant 35 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.urem %arg2, %c35_i64 : i64
    %2 = llvm.lshr %1, %c-3_i64 : i64
    %3 = llvm.icmp "sgt" %c36_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %arg2, %c-29_i64 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.select %arg0, %c-33_i64, %c-16_i64 : i1, i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.lshr %3, %1 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.srem %0, %5 : i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c7_i64 = arith.constant 7 : i64
    %c47_i64 = arith.constant 47 : i64
    %c25_i64 = arith.constant 25 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.srem %0, %c41_i64 : i64
    %2 = llvm.urem %arg2, %c25_i64 : i64
    %3 = llvm.and %2, %c47_i64 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.udiv %4, %c7_i64 : i64
    %6 = llvm.or %c-31_i64, %3 : i64
    %7 = llvm.icmp "slt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.zext %arg1 : i1 to i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.and %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "eq" %arg0, %c-17_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c-5_i64, %1 : i64
    %3 = llvm.urem %2, %c17_i64 : i64
    %4 = llvm.and %1, %arg0 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.lshr %1, %5 : i64
    %7 = llvm.srem %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c22_i64 = arith.constant 22 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.udiv %c-44_i64, %arg0 : i64
    %1 = llvm.srem %c22_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %c40_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %3, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.udiv %arg1, %5 : i64
    %7 = llvm.xor %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.sdiv %c-2_i64, %c24_i64 : i64
    %1 = llvm.or %c-31_i64, %0 : i64
    %2 = llvm.select %arg0, %0, %c-35_i64 : i1, i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.srem %5, %0 : i64
    %7 = llvm.icmp "sgt" %6, %c-29_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.and %c9_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.icmp "slt" %c6_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %c23_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ne" %c-24_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c50_i64 = arith.constant 50 : i64
    %c32_i64 = arith.constant 32 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %c21_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.and %3, %c-17_i64 : i64
    %5 = llvm.ashr %c50_i64, %4 : i64
    %6 = llvm.ashr %c32_i64, %5 : i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sdiv %arg0, %c33_i64 : i64
    %1 = llvm.select %true, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.udiv %arg0, %4 : i64
    %6 = llvm.urem %0, %5 : i64
    %7 = llvm.icmp "sge" %6, %4 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %arg1, %0, %0 : i1, i64
    %2 = llvm.srem %c33_i64, %c0_i64 : i64
    %3 = llvm.ashr %arg2, %2 : i64
    %4 = llvm.icmp "slt" %3, %2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.udiv %1, %5 : i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "sle" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %1 : i64
    %6 = llvm.select %5, %c-9_i64, %arg1 : i1, i64
    %7 = llvm.and %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c-2_i64, %0 : i64
    %2 = llvm.urem %arg0, %0 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.select %1, %3, %arg0 : i1, i64
    %5 = llvm.icmp "uge" %c-40_i64, %c-34_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c28_i64 = arith.constant 28 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %c17_i64, %c28_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.or %4, %arg1 : i64
    %6 = llvm.or %3, %5 : i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.sext %2 : i1 to i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "ult" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.select %arg0, %arg1, %c-14_i64 : i1, i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "slt" %c-4_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %c-19_i64, %c4_i64 : i64
    %6 = llvm.select %5, %arg1, %c-22_i64 : i1, i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.srem %c-5_i64, %1 : i64
    %3 = llvm.ashr %c-48_i64, %c48_i64 : i64
    %4 = llvm.urem %arg2, %3 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    %6 = llvm.select %5, %0, %1 : i1, i64
    %7 = llvm.icmp "uge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %0 : i64
    %3 = llvm.icmp "ne" %2, %c-12_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %arg2, %arg0, %4 : i1, i64
    %6 = llvm.xor %5, %arg1 : i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.lshr %c-20_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    %4 = llvm.select %3, %arg2, %c-24_i64 : i1, i64
    %5 = llvm.icmp "ult" %4, %1 : i64
    %6 = llvm.select %5, %c8_i64, %c-24_i64 : i1, i64
    %7 = llvm.and %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c-25_i64 = arith.constant -25 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.sdiv %1, %c-48_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.or %c-25_i64, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.ashr %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c24_i64 = arith.constant 24 : i64
    %false = arith.constant false
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.and %arg1, %c33_i64 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "ule" %c24_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %arg2, %4 : i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.or %c-19_i64, %arg2 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "sle" %4, %c-4_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.xor %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-6_i64 = arith.constant -6 : i64
    %c41_i64 = arith.constant 41 : i64
    %false = arith.constant false
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %false, %c20_i64, %arg0 : i1, i64
    %1 = llvm.xor %c41_i64, %c-6_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.udiv %arg1, %1 : i64
    %5 = llvm.ashr %4, %2 : i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %0, %1 : i64
    %4 = llvm.udiv %3, %c12_i64 : i64
    %5 = llvm.or %c1_i64, %4 : i64
    %6 = llvm.udiv %2, %5 : i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c46_i64 = arith.constant 46 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "sge" %arg0, %c14_i64 : i64
    %1 = llvm.udiv %arg0, %c46_i64 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "sle" %c6_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %0, %2, %4 : i1, i64
    %6 = llvm.sdiv %2, %arg1 : i64
    %7 = llvm.srem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c43_i64 = arith.constant 43 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.sdiv %c-32_i64, %c1_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.icmp "sgt" %2, %c-3_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %c43_i64, %4 : i64
    %6 = llvm.udiv %0, %5 : i64
    %7 = llvm.xor %6, %4 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "sgt" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %arg0, %1, %1 : i1, i64
    %3 = llvm.select %arg2, %arg1, %1 : i1, i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.icmp "eq" %4, %c-43_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %false = arith.constant false
    %c15_i64 = arith.constant 15 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "sge" %arg0, %c18_i64 : i64
    %1 = llvm.select %arg1, %arg2, %c15_i64 : i1, i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.lshr %4, %c16_i64 : i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.urem %c21_i64, %c-39_i64 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "sge" %c13_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.or %0, %arg1 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.select %2, %0, %1 : i1, i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.urem %0, %4 : i64
    %6 = llvm.lshr %c-11_i64, %c-25_i64 : i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c47_i64 = arith.constant 47 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.udiv %c42_i64, %arg0 : i64
    %1 = llvm.or %0, %c47_i64 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.and %2, %arg1 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.xor %0, %c26_i64 : i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.udiv %c49_i64, %2 : i64
    %4 = llvm.select %arg1, %c-5_i64, %3 : i1, i64
    %5 = llvm.srem %4, %1 : i64
    %6 = llvm.lshr %1, %5 : i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.srem %c-16_i64, %c10_i64 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.sdiv %1, %c-41_i64 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.sdiv %c-41_i64, %c-26_i64 : i64
    %5 = llvm.and %4, %c49_i64 : i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.xor %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %true = arith.constant true
    %false = arith.constant false
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.lshr %c30_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.lshr %1, %1 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.sext %arg1 : i1 to i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.select %false, %1, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.srem %c-42_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.srem %arg1, %0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.urem %4, %arg0 : i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.icmp "ult" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %true = arith.constant true
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %true, %1, %c-42_i64 : i1, i64
    %5 = llvm.and %c30_i64, %4 : i64
    %6 = llvm.sdiv %5, %4 : i64
    %7 = llvm.lshr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %c33_i64 = arith.constant 33 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.select %false, %c33_i64, %c32_i64 : i1, i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.or %1, %0 : i64
    %4 = llvm.icmp "sle" %3, %1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %2, %5 : i64
    %7 = llvm.sdiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c8_i64 = arith.constant 8 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.sdiv %arg0, %c43_i64 : i64
    %1 = llvm.icmp "sle" %0, %c8_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %c-31_i64, %c19_i64 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.or %arg1, %arg2 : i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.sdiv %c40_i64, %c-41_i64 : i64
    %1 = llvm.xor %0, %c-9_i64 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.sdiv %arg0, %arg2 : i64
    %5 = llvm.or %4, %arg0 : i64
    %6 = llvm.sdiv %3, %5 : i64
    %7 = llvm.icmp "ult" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.lshr %c-31_i64, %arg0 : i64
    %1 = llvm.srem %0, %c-46_i64 : i64
    %2 = llvm.urem %1, %c-22_i64 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.or %3, %c-40_i64 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %false = arith.constant false
    %true = arith.constant true
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.select %true, %arg2, %c40_i64 : i1, i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.select %false, %arg1, %c17_i64 : i1, i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "eq" %6, %arg0 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.xor %0, %arg2 : i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "ne" %4, %c50_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "eq" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.xor %1, %1 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.select %3, %2, %5 : i1, i64
    %7 = llvm.icmp "ugt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %false = arith.constant false
    %c-24_i64 = arith.constant -24 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.and %c-24_i64, %c-11_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.select %3, %arg0, %1 : i1, i64
    %5 = llvm.xor %4, %c22_i64 : i64
    %6 = llvm.select %3, %5, %4 : i1, i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %c31_i64, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.icmp "ult" %3, %arg2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.xor %5, %c16_i64 : i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "slt" %c-30_i64, %c-28_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %c23_i64 : i64
    %3 = llvm.udiv %2, %1 : i64
    %4 = llvm.icmp "ule" %3, %arg0 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.or %1, %5 : i64
    %7 = llvm.icmp "eq" %6, %c2_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c-17_i64, %c-24_i64 : i1, i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.srem %arg0, %arg1 : i64
    %4 = llvm.select %0, %1, %arg2 : i1, i64
    %5 = llvm.udiv %c-24_i64, %4 : i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.urem %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c22_i64 = arith.constant 22 : i64
    %c44_i64 = arith.constant 44 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %c44_i64, %c22_i64 : i64
    %2 = llvm.icmp "sle" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.udiv %3, %1 : i64
    %6 = llvm.select %4, %5, %c-40_i64 : i1, i64
    %7 = llvm.icmp "ne" %6, %3 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %c-21_i64, %c-32_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.select %1, %arg1, %c-41_i64 : i1, i64
    %3 = llvm.sdiv %c-12_i64, %arg1 : i64
    %4 = llvm.icmp "ule" %2, %arg0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.select %arg2, %3, %5 : i1, i64
    %7 = llvm.xor %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "ugt" %c50_i64, %c-19_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "ugt" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %4, %2 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c48_i64 = arith.constant 48 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.urem %c31_i64, %c-29_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    %6 = llvm.trunc %true : i1 to i64
    %7 = llvm.select %5, %c48_i64, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.xor %c-34_i64, %c-41_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.xor %0, %0 : i64
    %3 = llvm.select %arg1, %arg0, %1 : i1, i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "ugt" %4, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "slt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %c27_i64, %0 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.xor %3, %0 : i64
    %5 = llvm.udiv %c-24_i64, %3 : i64
    %6 = llvm.urem %arg1, %5 : i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %arg2, %c-1_i64, %2 : i1, i64
    %4 = llvm.srem %arg0, %arg1 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.lshr %c-2_i64, %0 : i64
    %4 = llvm.and %3, %c27_i64 : i64
    %5 = llvm.icmp "ugt" %4, %arg2 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.select %2, %6, %arg0 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c26_i64 = arith.constant 26 : i64
    %c32_i64 = arith.constant 32 : i64
    %true = arith.constant true
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.lshr %c11_i64, %arg0 : i64
    %1 = llvm.lshr %c32_i64, %c26_i64 : i64
    %2 = llvm.icmp "eq" %arg1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %arg2, %arg1 : i64
    %5 = llvm.sdiv %4, %c-22_i64 : i64
    %6 = llvm.select %true, %3, %5 : i1, i64
    %7 = llvm.icmp "sge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %0, %arg0 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sext %arg2 : i1 to i64
    %7 = llvm.xor %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %c-49_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %false, %0, %2 : i1, i64
    %4 = llvm.select %1, %arg0, %0 : i1, i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.srem %arg0, %c36_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.srem %0, %5 : i64
    %7 = llvm.icmp "eq" %c50_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.or %1, %c-5_i64 : i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.lshr %arg1, %arg2 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.ashr %c-9_i64, %c-29_i64 : i64
    %1 = llvm.udiv %c-19_i64, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.xor %1, %0 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.select %2, %3, %5 : i1, i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.zext %3 : i1 to i64
    %6 = llvm.urem %arg0, %5 : i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c23_i64 = arith.constant 23 : i64
    %true = arith.constant true
    %c-35_i64 = arith.constant -35 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.lshr %c-35_i64, %c-19_i64 : i64
    %1 = llvm.select %true, %0, %arg0 : i1, i64
    %2 = llvm.udiv %arg1, %arg1 : i64
    %3 = llvm.urem %0, %c37_i64 : i64
    %4 = llvm.and %c23_i64, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.ashr %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %false = arith.constant false
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.urem %c49_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.srem %4, %c6_i64 : i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.udiv %6, %0 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c46_i64 = arith.constant 46 : i64
    %c42_i64 = arith.constant 42 : i64
    %c28_i64 = arith.constant 28 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg2, %arg0 : i1, i64
    %2 = llvm.xor %c16_i64, %c28_i64 : i64
    %3 = llvm.ashr %2, %c42_i64 : i64
    %4 = llvm.icmp "uge" %c46_i64, %c10_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.ashr %3, %5 : i64
    %7 = llvm.icmp "sge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.select %false, %c36_i64, %arg1 : i1, i64
    %2 = llvm.udiv %arg2, %1 : i64
    %3 = llvm.and %arg2, %1 : i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.sdiv %4, %c-15_i64 : i64
    %6 = llvm.or %2, %5 : i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %c42_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c-49_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg0, %arg1 : i64
    %4 = llvm.select %1, %3, %c8_i64 : i1, i64
    %5 = llvm.icmp "ne" %4, %c-32_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.or %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %arg2, %arg0 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.ashr %0, %c-1_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.trunc %false : i1 to i64
    %7 = llvm.icmp "slt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.icmp "ult" %5, %4 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c22_i64 = arith.constant 22 : i64
    %c6_i64 = arith.constant 6 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.and %c6_i64, %c20_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.select %2, %1, %arg1 : i1, i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ne" %c22_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "uge" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %4, %c44_i64 : i64
    %6 = llvm.udiv %0, %5 : i64
    %7 = llvm.icmp "sge" %6, %1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.select %arg0, %1, %arg2 : i1, i64
    %3 = llvm.srem %c-47_i64, %c-43_i64 : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.xor %5, %0 : i64
    %7 = llvm.or %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "ugt" %c47_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.and %2, %c-48_i64 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.srem %arg0, %c-47_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.and %1, %arg2 : i64
    %5 = llvm.icmp "ugt" %4, %c-7_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-38_i64 = arith.constant -38 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.select %2, %arg2, %c-38_i64 : i1, i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.and %c16_i64, %arg2 : i64
    %7 = llvm.icmp "sle" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %c-7_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c39_i64 = arith.constant 39 : i64
    %c26_i64 = arith.constant 26 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.lshr %0, %c41_i64 : i64
    %3 = llvm.udiv %c26_i64, %c39_i64 : i64
    %4 = llvm.sdiv %2, %c-3_i64 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.udiv %2, %5 : i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.lshr %c38_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sdiv %arg0, %c49_i64 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    %5 = llvm.select %4, %arg0, %2 : i1, i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.urem %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c0_i64 = arith.constant 0 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.and %c27_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.lshr %arg2, %c0_i64 : i64
    %3 = llvm.icmp "sge" %2, %c0_i64 : i64
    %4 = llvm.or %0, %c-12_i64 : i64
    %5 = llvm.select %3, %4, %arg0 : i1, i64
    %6 = llvm.urem %0, %5 : i64
    %7 = llvm.or %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.urem %arg0, %0 : i64
    %3 = llvm.udiv %arg0, %1 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.lshr %c26_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.select %1, %arg0, %arg2 : i1, i64
    %3 = llvm.xor %c36_i64, %2 : i64
    %4 = llvm.icmp "ule" %arg1, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.ashr %3, %5 : i64
    %7 = llvm.icmp "uge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.or %arg0, %4 : i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.sdiv %arg0, %c25_i64 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.icmp "sgt" %0, %arg0 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.lshr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.udiv %3, %c22_i64 : i64
    %5 = llvm.lshr %2, %0 : i64
    %6 = llvm.udiv %arg0, %5 : i64
    %7 = llvm.udiv %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %c-38_i64, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %0, %arg1 : i64
    %5 = llvm.udiv %4, %arg2 : i64
    %6 = llvm.or %c26_i64, %5 : i64
    %7 = llvm.and %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.icmp "ugt" %arg1, %c-49_i64 : i64
    %4 = llvm.select %3, %arg0, %c-5_i64 : i1, i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.and %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %true = arith.constant true
    %c50_i64 = arith.constant 50 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.lshr %c50_i64, %c-11_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %2, %c-30_i64 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.ashr %arg1, %5 : i64
    %7 = llvm.icmp "sle" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %arg0, %c-27_i64 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "eq" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %arg0, %4 : i64
    %6 = llvm.lshr %arg0, %5 : i64
    %7 = llvm.icmp "uge" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "ugt" %c6_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %c-12_i64 : i1, i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.select %0, %2, %1 : i1, i64
    %4 = llvm.or %c-2_i64, %3 : i64
    %5 = llvm.icmp "uge" %c-27_i64, %2 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sle" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %c-28_i64, %arg1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.sdiv %3, %c2_i64 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.ashr %5, %1 : i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-10_i64 = arith.constant -10 : i64
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %true, %c-10_i64, %c40_i64 : i1, i64
    %2 = llvm.or %arg2, %c-48_i64 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.lshr %arg1, %arg2 : i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.sdiv %c-33_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %c44_i64, %3 : i64
    %5 = llvm.icmp "sgt" %3, %1 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c5_i64 = arith.constant 5 : i64
    %false = arith.constant false
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.select %false, %c48_i64, %arg0 : i1, i64
    %1 = llvm.and %0, %c5_i64 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.icmp "eq" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %2, %c28_i64 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "eq" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "ugt" %c-50_i64, %c11_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %arg0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sge" %arg1, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %5, %c-35_i64 : i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %c-6_i64, %c-15_i64 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.trunc %2 : i1 to i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.udiv %0, %arg1 : i64
    %3 = llvm.icmp "sle" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %arg2, %4 : i64
    %6 = llvm.lshr %0, %5 : i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.srem %c-22_i64, %c37_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %arg1 : i64
    %4 = llvm.icmp "eq" %c-3_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.ashr %2, %5 : i64
    %7 = llvm.icmp "uge" %c-32_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c49_i64 = arith.constant 49 : i64
    %false = arith.constant false
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.select %false, %c23_i64, %arg0 : i1, i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.xor %arg2, %2 : i64
    %4 = llvm.xor %c49_i64, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.or %1, %5 : i64
    %7 = llvm.or %6, %c-18_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "eq" %c-5_i64, %c9_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %c-32_i64 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.srem %c-48_i64, %3 : i64
    %5 = llvm.icmp "slt" %4, %arg0 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.and %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.sdiv %c-22_i64, %c-24_i64 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.or %c2_i64, %arg2 : i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.ashr %c-27_i64, %0 : i64
    %7 = llvm.icmp "slt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %false = arith.constant false
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.sdiv %arg0, %c40_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.select %false, %c45_i64, %arg0 : i1, i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.urem %0, %2 : i64
    %5 = llvm.icmp "sge" %4, %3 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    %2 = llvm.and %c47_i64, %1 : i64
    %3 = llvm.srem %c-27_i64, %c-13_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.zext %arg0 : i1 to i64
    %6 = llvm.or %5, %arg2 : i64
    %7 = llvm.icmp "uge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "eq" %c-45_i64, %c-17_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %1, %arg0 : i64
    %5 = llvm.and %4, %1 : i64
    %6 = llvm.icmp "ule" %3, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c-22_i64 : i64
    %2 = llvm.xor %arg1, %0 : i64
    %3 = llvm.icmp "sle" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %4, %2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "slt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "sge" %arg1, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %3, %c-26_i64 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.udiv %arg0, %5 : i64
    %7 = llvm.icmp "sgt" %c-41_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %arg2 : i64
    %2 = llvm.icmp "sle" %c31_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.srem %1, %arg0 : i64
    %6 = llvm.select %4, %1, %5 : i1, i64
    %7 = llvm.udiv %c30_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %c3_i64, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %arg1, %1 : i64
    %5 = llvm.xor %arg1, %4 : i64
    %6 = llvm.and %c-23_i64, %5 : i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c32_i64 = arith.constant 32 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.ashr %arg0, %c48_i64 : i64
    %1 = llvm.udiv %c32_i64, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sge" %arg1, %c-44_i64 : i64
    %4 = llvm.select %3, %c21_i64, %0 : i1, i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.urem %5, %0 : i64
    %7 = llvm.icmp "uge" %6, %c-21_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.lshr %arg1, %c-39_i64 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.sdiv %4, %arg2 : i64
    %6 = llvm.lshr %c32_i64, %c-24_i64 : i64
    %7 = llvm.lshr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c-46_i64 = arith.constant -46 : i64
    %true = arith.constant true
    %c-26_i64 = arith.constant -26 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %c-26_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.select %true, %c-46_i64, %c9_i64 : i1, i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.srem %arg0, %4 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c24_i64 = arith.constant 24 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.urem %c-26_i64, %arg0 : i64
    %1 = llvm.lshr %c-13_i64, %c37_i64 : i64
    %2 = llvm.or %c24_i64, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.urem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.icmp "ule" %arg1, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.zext %1 : i1 to i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.ashr %c-13_i64, %arg0 : i64
    %1 = llvm.select %arg2, %c-11_i64, %c-46_i64 : i1, i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.sdiv %c-11_i64, %2 : i64
    %4 = llvm.icmp "ule" %3, %c17_i64 : i64
    %5 = llvm.ashr %0, %c42_i64 : i64
    %6 = llvm.select %4, %arg0, %5 : i1, i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %0, %c35_i64 : i64
    %2 = llvm.icmp "uge" %c-8_i64, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.urem %5, %c-43_i64 : i64
    %7 = llvm.urem %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.or %c0_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sdiv %0, %arg2 : i64
    %4 = llvm.and %3, %0 : i64
    %5 = llvm.sdiv %1, %c42_i64 : i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "sge" %c-30_i64, %c40_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.urem %arg0, %2 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.or %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.and %c21_i64, %arg0 : i64
    %1 = llvm.xor %c43_i64, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %arg1, %3, %arg2 : i1, i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.ashr %5, %0 : i64
    %7 = llvm.icmp "sle" %c-1_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "eq" %1, %arg1 : i64
    %4 = llvm.select %3, %c42_i64, %arg2 : i1, i64
    %5 = llvm.or %arg0, %4 : i64
    %6 = llvm.sdiv %2, %5 : i64
    %7 = llvm.icmp "eq" %6, %c-32_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "slt" %c-43_i64, %c-11_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.trunc %arg0 : i1 to i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    %5 = llvm.sdiv %c32_i64, %arg2 : i64
    %6 = llvm.ashr %5, %5 : i64
    %7 = llvm.or %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "ult" %arg1, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c33_i64 : i1, i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.select %arg2, %1, %c19_i64 : i1, i64
    %4 = llvm.xor %c-48_i64, %3 : i64
    %5 = llvm.icmp "eq" %4, %arg1 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.select %0, %c24_i64, %arg2 : i1, i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.ashr %arg1, %c5_i64 : i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.icmp "ugt" %3, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %arg1, %arg1 : i64
    %7 = llvm.icmp "slt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %c-4_i64, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "sge" %2, %c-30_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %1, %4 : i64
    %6 = llvm.or %c7_i64, %1 : i64
    %7 = llvm.icmp "sle" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.srem %c-19_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.urem %c-11_i64, %1 : i64
    %3 = llvm.urem %1, %1 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.icmp "ult" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.urem %c-22_i64, %c45_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.udiv %4, %c9_i64 : i64
    %6 = llvm.select %3, %2, %5 : i1, i64
    %7 = llvm.icmp "slt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c43_i64 = arith.constant 43 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "ult" %c49_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %c2_i64, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.select %4, %arg1, %arg2 : i1, i64
    %6 = llvm.and %c43_i64, %5 : i64
    %7 = llvm.icmp "uge" %6, %5 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c22_i64 = arith.constant 22 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "sge" %c8_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %c-25_i64, %c13_i64 : i64
    %3 = llvm.xor %2, %c22_i64 : i64
    %4 = llvm.icmp "ne" %3, %c44_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.icmp "slt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c-19_i64 = arith.constant -19 : i64
    %true = arith.constant true
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.select %true, %c35_i64, %arg0 : i1, i64
    %1 = llvm.icmp "ne" %c-19_i64, %0 : i64
    %2 = llvm.ashr %0, %arg0 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.icmp "uge" %c-28_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.select %1, %2, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "ult" %c23_i64, %c-23_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.udiv %c15_i64, %1 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    %5 = llvm.xor %c-36_i64, %4 : i64
    %6 = llvm.udiv %3, %c0_i64 : i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %true = arith.constant true
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.select %true, %arg0, %c-6_i64 : i1, i64
    %1 = llvm.lshr %c24_i64, %0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.icmp "ugt" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "slt" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %c12_i64, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.select %true, %2, %arg1 : i1, i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c3_i64 = arith.constant 3 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.ashr %c-9_i64, %c21_i64 : i64
    %1 = llvm.sdiv %0, %c3_i64 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.icmp "ule" %c13_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.urem %c11_i64, %arg0 : i64
    %1 = llvm.or %0, %c-1_i64 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.or %c21_i64, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.udiv %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.lshr %c30_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %arg1, %0 : i64
    %4 = llvm.xor %c16_i64, %3 : i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "slt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "eq" %c0_i64, %c43_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.and %c-19_i64, %arg0 : i64
    %1 = llvm.lshr %c47_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %3, %arg1 : i64
    %5 = llvm.and %c38_i64, %4 : i64
    %6 = llvm.icmp "ugt" %5, %arg1 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %c-42_i64, %arg1 : i64
    %2 = llvm.udiv %1, %c-30_i64 : i64
    %3 = llvm.urem %arg1, %1 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c25_i64 = arith.constant 25 : i64
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %false, %c25_i64, %c9_i64 : i1, i64
    %4 = llvm.ashr %3, %arg2 : i64
    %5 = llvm.trunc %false : i1 to i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "sgt" %c-46_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %4, %arg1 : i64
    %6 = llvm.xor %arg0, %5 : i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.urem %1, %arg2 : i64
    %4 = llvm.srem %3, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.or %5, %c34_i64 : i64
    %7 = llvm.or %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg1, %c-32_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %arg2, %c-47_i64 : i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "sge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.or %arg2, %0 : i64
    %5 = llvm.srem %4, %c26_i64 : i64
    %6 = llvm.udiv %2, %5 : i64
    %7 = llvm.urem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.urem %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %c13_i64, %c32_i64 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %4, %arg0 : i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "eq" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %4, %arg0 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.udiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "ule" %c-50_i64, %c21_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %c30_i64, %c41_i64 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.select %0, %4, %1 : i1, i64
    %6 = llvm.lshr %5, %1 : i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %c-38_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %4, %2 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.icmp "eq" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.ashr %c30_i64, %arg0 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %arg2, %2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %c-21_i64, %c29_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sext %2 : i1 to i64
    %5 = llvm.or %4, %arg1 : i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.xor %c-38_i64, %c11_i64 : i64
    %1 = llvm.icmp "ult" %c-11_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.xor %0, %5 : i64
    %7 = llvm.icmp "eq" %c-3_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c41_i64 = arith.constant 41 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.or %c1_i64, %1 : i64
    %3 = llvm.select %arg1, %1, %c41_i64 : i1, i64
    %4 = llvm.srem %3, %c-39_i64 : i64
    %5 = llvm.udiv %4, %c-35_i64 : i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.urem %0, %0 : i64
    %3 = llvm.srem %2, %c45_i64 : i64
    %4 = llvm.sext %1 : i1 to i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.select %1, %0, %5 : i1, i64
    %7 = llvm.srem %6, %0 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.udiv %arg1, %arg1 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %arg0, %arg0 : i64
    %7 = llvm.icmp "sge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %false = arith.constant false
    %true = arith.constant true
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.ashr %arg0, %c-24_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.select %false, %c-31_i64, %2 : i1, i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.trunc %false : i1 to i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.sdiv %3, %1 : i64
    %5 = llvm.trunc %arg2 : i1 to i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.sdiv %6, %arg1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %c17_i64 : i64
    %2 = llvm.srem %c7_i64, %1 : i64
    %3 = llvm.udiv %arg2, %arg0 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.or %c-7_i64, %5 : i64
    %7 = llvm.icmp "ne" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sext %4 : i1 to i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.sdiv %c-4_i64, %c35_i64 : i64
    %1 = llvm.ashr %c-37_i64, %0 : i64
    %2 = llvm.srem %0, %arg0 : i64
    %3 = llvm.srem %c-29_i64, %arg0 : i64
    %4 = llvm.icmp "ule" %3, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.and %c-25_i64, %c15_i64 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.udiv %1, %arg2 : i64
    %4 = llvm.ashr %3, %arg0 : i64
    %5 = llvm.icmp "ult" %4, %c48_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c-4_i64 = arith.constant -4 : i64
    %false = arith.constant false
    %c41_i64 = arith.constant 41 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %false, %0, %c-4_i64 : i1, i64
    %2 = llvm.icmp "ugt" %c41_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %c5_i64, %3 : i64
    %5 = llvm.select %2, %arg0, %c-7_i64 : i1, i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.ashr %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c34_i64 = arith.constant 34 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.sdiv %c34_i64, %c45_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.ashr %c27_i64, %0 : i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.lshr %0, %c41_i64 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.urem %c-43_i64, %2 : i64
    %4 = llvm.lshr %arg1, %1 : i64
    %5 = llvm.udiv %4, %3 : i64
    %6 = llvm.srem %5, %c14_i64 : i64
    %7 = llvm.ashr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %c-32_i64 = arith.constant -32 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "ne" %c-32_i64, %c2_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.zext %0 : i1 to i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c-24_i64 = arith.constant -24 : i64
    %true = arith.constant true
    %false = arith.constant false
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %arg0, %c-47_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %true, %c-24_i64, %arg1 : i1, i64
    %6 = llvm.xor %5, %c38_i64 : i64
    %7 = llvm.or %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %false = arith.constant false
    %c7_i64 = arith.constant 7 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.srem %c7_i64, %c-44_i64 : i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.select %arg1, %arg2, %2 : i1, i64
    %5 = llvm.and %4, %c-47_i64 : i64
    %6 = llvm.and %5, %arg2 : i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.ashr %c-46_i64, %c7_i64 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.icmp "slt" %1, %c-32_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %c39_i64, %3 : i64
    %5 = llvm.srem %4, %0 : i64
    %6 = llvm.ashr %3, %5 : i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c45_i64 = arith.constant 45 : i64
    %c8_i64 = arith.constant 8 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.srem %c24_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.and %2, %c8_i64 : i64
    %4 = llvm.and %3, %c45_i64 : i64
    %5 = llvm.sdiv %0, %4 : i64
    %6 = llvm.and %arg1, %c12_i64 : i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %arg2, %arg2 : i64
    %4 = llvm.ashr %3, %c40_i64 : i64
    %5 = llvm.and %4, %arg2 : i64
    %6 = llvm.srem %arg0, %5 : i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    %3 = llvm.srem %arg0, %arg2 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.xor %1, %arg2 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.and %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c5_i64 = arith.constant 5 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.xor %c24_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.icmp "ule" %c5_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %3, %1, %c-15_i64 : i1, i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "slt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %c-33_i64, %0 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.and %c50_i64, %c37_i64 : i64
    %4 = llvm.sdiv %c-1_i64, %3 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.lshr %c-6_i64, %c30_i64 : i64
    %4 = llvm.sext %arg2 : i1 to i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.icmp "sgt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.lshr %c19_i64, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.select %arg1, %arg0, %2 : i1, i64
    %5 = llvm.srem %4, %0 : i64
    %6 = llvm.or %3, %5 : i64
    %7 = llvm.icmp "ugt" %c26_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.xor %c15_i64, %c-29_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %arg0, %arg0 : i64
    %5 = llvm.select %4, %0, %arg1 : i1, i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.ashr %arg1, %arg1 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %false, %arg0, %3 : i1, i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.urem %c3_i64, %arg2 : i64
    %7 = llvm.urem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %false = arith.constant false
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.select %false, %arg0, %c-11_i64 : i1, i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.icmp "eq" %c-10_i64, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.xor %1, %5 : i64
    %7 = llvm.icmp "uge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c31_i64 = arith.constant 31 : i64
    %c26_i64 = arith.constant 26 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %arg0, %c26_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.udiv %c31_i64, %c18_i64 : i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "uge" %arg0, %c17_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %c-8_i64 : i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.icmp "ult" %5, %arg1 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %c42_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.srem %c-23_i64, %3 : i64
    %5 = llvm.sext %1 : i1 to i64
    %6 = llvm.and %5, %c43_i64 : i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.urem %arg1, %c-28_i64 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %arg1, %arg1 : i64
    %2 = llvm.icmp "ult" %arg2, %c29_i64 : i64
    %3 = llvm.srem %1, %c-43_i64 : i64
    %4 = llvm.udiv %3, %1 : i64
    %5 = llvm.select %2, %arg1, %4 : i1, i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.srem %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c42_i64 = arith.constant 42 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ne" %c42_i64, %3 : i64
    %5 = llvm.select %4, %c-16_i64, %2 : i1, i64
    %6 = llvm.sdiv %c9_i64, %3 : i64
    %7 = llvm.and %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.lshr %c-31_i64, %arg0 : i64
    %3 = llvm.icmp "sgt" %c-3_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %c45_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.udiv %c-37_i64, %1 : i64
    %3 = llvm.urem %2, %c48_i64 : i64
    %4 = llvm.srem %2, %c26_i64 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "slt" %arg1, %c50_i64 : i64
    %1 = llvm.select %0, %arg2, %c-26_i64 : i1, i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "eq" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %c-3_i64, %c13_i64 : i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "ule" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "ult" %0, %c-15_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %1, %c-1_i64, %0 : i1, i64
    %4 = llvm.icmp "ult" %arg1, %c42_i64 : i64
    %5 = llvm.select %4, %arg2, %arg1 : i1, i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-24_i64 = arith.constant -24 : i64
    %true = arith.constant true
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.select %true, %arg0, %c-14_i64 : i1, i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "sge" %arg0, %c-24_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.select %arg2, %arg0, %c-19_i64 : i1, i64
    %7 = llvm.udiv %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.select %arg0, %c-8_i64, %c47_i64 : i1, i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %arg1, %1 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.srem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %c36_i64, %arg1 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.or %3, %1 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.sdiv %2, %c5_i64 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ugt" %6, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.select %1, %c-13_i64, %arg1 : i1, i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.urem %arg2, %c13_i64 : i64
    %5 = llvm.or %4, %c50_i64 : i64
    %6 = llvm.or %arg0, %5 : i64
    %7 = llvm.icmp "slt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "sle" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.or %c-8_i64, %5 : i64
    %7 = llvm.xor %6, %arg2 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %0, %c26_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %0, %arg2 : i64
    %4 = llvm.icmp "ult" %arg1, %c-28_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.xor %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.ashr %c28_i64, %arg0 : i64
    %1 = llvm.xor %c22_i64, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.xor %1, %arg0 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.icmp "eq" %1, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %true = arith.constant true
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.sdiv %c-47_i64, %4 : i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.icmp "ule" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.srem %arg1, %c-45_i64 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %2, %5 : i64
    %7 = llvm.icmp "slt" %c22_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %c6_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.select %0, %4, %c-39_i64 : i1, i64
    %6 = llvm.udiv %4, %arg0 : i64
    %7 = llvm.srem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %c-2_i64, %0 : i64
    %2 = llvm.icmp "ult" %c-20_i64, %1 : i64
    %3 = llvm.select %2, %arg1, %arg1 : i1, i64
    %4 = llvm.sdiv %3, %0 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.xor %5, %arg2 : i64
    %7 = llvm.udiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c49_i64 = arith.constant 49 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.xor %0, %c-45_i64 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.xor %c36_i64, %c49_i64 : i64
    %4 = llvm.icmp "uge" %3, %c-35_i64 : i64
    %5 = llvm.select %4, %3, %c6_i64 : i1, i64
    %6 = llvm.sdiv %5, %c-16_i64 : i64
    %7 = llvm.udiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.ashr %c-11_i64, %1 : i64
    %3 = llvm.sdiv %c20_i64, %2 : i64
    %4 = llvm.lshr %arg1, %0 : i64
    %5 = llvm.and %c33_i64, %4 : i64
    %6 = llvm.sdiv %3, %5 : i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ult" %c18_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %3, %arg0 : i64
    %5 = llvm.trunc %2 : i1 to i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %4, %arg0 : i64
    %6 = llvm.and %5, %2 : i64
    %7 = llvm.or %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-48_i64 = arith.constant -48 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.and %arg0, %c8_i64 : i64
    %1 = llvm.ashr %0, %c-48_i64 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.xor %5, %arg0 : i64
    %7 = llvm.or %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c43_i64 = arith.constant 43 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %c43_i64, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.urem %arg0, %arg2 : i64
    %4 = llvm.srem %arg0, %c39_i64 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.and %2, %5 : i64
    %7 = llvm.sdiv %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.or %c30_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %c-40_i64, %c-28_i64 : i64
    %2 = llvm.icmp "ugt" %0, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.select %1, %arg0, %5 : i1, i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.select %arg0, %arg1, %c36_i64 : i1, i64
    %1 = llvm.icmp "sge" %0, %c-41_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %2, %c-40_i64 : i64
    %4 = llvm.icmp "sle" %c-10_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.xor %5, %arg2 : i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.and %arg1, %c5_i64 : i64
    %1 = llvm.icmp "uge" %c-11_i64, %arg0 : i64
    %2 = llvm.select %1, %c-23_i64, %0 : i1, i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.srem %4, %c24_i64 : i64
    %6 = llvm.ashr %0, %5 : i64
    %7 = llvm.icmp "sgt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %c37_i64, %arg0 : i64
    %1 = llvm.urem %c-46_i64, %0 : i64
    %2 = llvm.icmp "ule" %c-14_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.ashr %4, %4 : i64
    %6 = llvm.and %4, %4 : i64
    %7 = llvm.and %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.and %c-10_i64, %arg0 : i64
    %1 = llvm.sdiv %c-30_i64, %0 : i64
    %2 = llvm.urem %c6_i64, %c13_i64 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.udiv %3, %3 : i64
    %5 = llvm.sdiv %4, %0 : i64
    %6 = llvm.select %arg1, %4, %5 : i1, i64
    %7 = llvm.or %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c42_i64 = arith.constant 42 : i64
    %c20_i64 = arith.constant 20 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.select %arg0, %c20_i64, %c-15_i64 : i1, i64
    %1 = llvm.icmp "sgt" %c42_i64, %0 : i64
    %2 = llvm.sdiv %c-12_i64, %0 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.udiv %3, %3 : i64
    %5 = llvm.ashr %4, %2 : i64
    %6 = llvm.udiv %arg1, %3 : i64
    %7 = llvm.srem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c35_i64 = arith.constant 35 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.and %c-39_i64, %c-31_i64 : i64
    %1 = llvm.icmp "uge" %c-31_i64, %c-28_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %c35_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.icmp "sgt" %c15_i64, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "sle" %c-33_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.srem %1, %1 : i64
    %4 = llvm.icmp "sle" %3, %arg0 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c29_i64 = arith.constant 29 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %c-8_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.udiv %2, %c44_i64 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ule" %c29_i64, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %false = arith.constant false
    %c32_i64 = arith.constant 32 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.lshr %c32_i64, %c6_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.ashr %arg0, %arg1 : i64
    %4 = llvm.lshr %3, %3 : i64
    %5 = llvm.icmp "ugt" %c30_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %c-16_i64 = arith.constant -16 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.udiv %c20_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg1, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %false, %2, %0 : i1, i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.urem %0, %4 : i64
    %6 = llvm.ashr %c-16_i64, %5 : i64
    %7 = llvm.and %6, %c-6_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sdiv %c16_i64, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %c-15_i64, %2 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "uge" %6, %c-33_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c44_i64 = arith.constant 44 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.sdiv %c8_i64, %c-46_i64 : i64
    %1 = llvm.ashr %c44_i64, %0 : i64
    %2 = llvm.icmp "ne" %c-1_i64, %1 : i64
    %3 = llvm.icmp "ugt" %1, %c3_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.select %2, %1, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.select %arg0, %c-37_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ugt" %arg2, %c11_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "ne" %4, %c-21_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %6, %c-43_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.udiv %1, %c-11_i64 : i64
    %4 = llvm.or %c-9_i64, %3 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    %6 = llvm.select %5, %0, %c-17_i64 : i1, i64
    %7 = llvm.lshr %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c14_i64 = arith.constant 14 : i64
    %true = arith.constant true
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %c23_i64 : i64
    %2 = llvm.sdiv %arg1, %arg2 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.select %true, %c14_i64, %3 : i1, i64
    %5 = llvm.or %4, %c-20_i64 : i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %arg0 : i64
    %3 = llvm.and %1, %arg0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.ashr %4, %c-30_i64 : i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.icmp "ule" %6, %c24_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c49_i64 = arith.constant 49 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.xor %c5_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %c49_i64, %2 : i64
    %4 = llvm.or %3, %arg0 : i64
    %5 = llvm.xor %4, %2 : i64
    %6 = llvm.select %1, %c19_i64, %arg0 : i1, i64
    %7 = llvm.or %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.lshr %1, %arg0 : i64
    %4 = llvm.or %2, %c-36_i64 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.or %arg0, %c-29_i64 : i64
    %1 = llvm.icmp "ne" %c-38_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %0, %5 : i64
    %7 = llvm.and %c45_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.or %2, %2 : i64
    %5 = llvm.lshr %0, %2 : i64
    %6 = llvm.select %3, %4, %5 : i1, i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c42_i64 = arith.constant 42 : i64
    %c17_i64 = arith.constant 17 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %c17_i64, %c14_i64 : i64
    %1 = llvm.and %0, %c34_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %c42_i64, %5 : i64
    %7 = llvm.icmp "uge" %6, %5 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.trunc %arg2 : i1 to i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.icmp "slt" %c-16_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %arg0, %arg0 : i64
    %5 = llvm.urem %1, %4 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.icmp "slt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.lshr %arg0, %c34_i64 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
