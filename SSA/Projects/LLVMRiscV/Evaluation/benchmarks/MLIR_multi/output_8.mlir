module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %c10_i64 = arith.constant 10 : i64
    %c21_i64 = arith.constant 21 : i64
    %c26_i64 = arith.constant 26 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %c_35_i64 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.sdiv %c21_i64, %c10_i64 : i64
    %4 = llvm.ashr %3, %c_39_i64 : i64
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
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.and %arg2, %c_50_i64 : i64
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
    %c_47_i64 = arith.constant -47 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c22_i64 = arith.constant 22 : i64
    %c_37_i64 = arith.constant -37 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.srem %c_37_i64, %c22_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %c_26_i64, %c_47_i64 : i64
    %5 = llvm.urem %4, %1 : i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.ashr %c23_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.srem %c_29_i64, %1 : i64
    %3 = llvm.icmp "slt" %2, %c_12_i64 : i64
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
    %c_17_i64 = arith.constant -17 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.xor %arg2, %c_17_i64 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    %5 = llvm.select %4, %2, %c30_i64 : i1, i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.and %c_22_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.urem %2, %c_39_i64 : i64
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
    %c_13_i64 = arith.constant -13 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %c_13_i64, %c20_i64 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.icmp "ugt" %c_4_i64, %6 : i64
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
    %c_37_i64 = arith.constant -37 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.icmp "sgt" %arg2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %c_43_i64, %c_37_i64 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.select %2, %4, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c_2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.udiv %c_2_i64, %c_47_i64 : i64
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
    %c_9_i64 = arith.constant -9 : i64
    %c28_i64 = arith.constant 28 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "slt" %c28_i64, %c_42_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.udiv %2, %c_9_i64 : i64
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
    %c_42_i64 = arith.constant -42 : i64
    %c_39_i64 = arith.constant -39 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.srem %c_35_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg1, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %c_42_i64, %arg1 : i64
    %4 = llvm.udiv %c_39_i64, %3 : i64
    %5 = llvm.urem %4, %c2_i64 : i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.icmp "sle" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "sgt" %c_8_i64, %c50_i64 : i64
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
    %c_47_i64 = arith.constant -47 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.urem %arg1, %c_6_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %arg2, %c_47_i64, %arg0 : i1, i64
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
    %c_45_i64 = arith.constant -45 : i64
    %c9_i64 = arith.constant 9 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "slt" %c9_i64, %c_18_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    %4 = llvm.urem %c_45_i64, %c10_i64 : i64
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
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %arg0, %c_36_i64 : i64
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
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.udiv %arg2, %arg1 : i64
    %1 = llvm.icmp "ule" %arg2, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.xor %3, %c_42_i64 : i64
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
    %c_4_i64 = arith.constant -4 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.sdiv %c31_i64, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.udiv %3, %0 : i64
    %5 = llvm.icmp "slt" %4, %c_4_i64 : i64
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
    %c_37_i64 = arith.constant -37 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.udiv %1, %c44_i64 : i64
    %3 = llvm.or %2, %c_32_i64 : i64
    %4 = llvm.icmp "ne" %3, %c_37_i64 : i64
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
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.xor %arg0, %c_16_i64 : i64
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
    %c_44_i64 = arith.constant -44 : i64
    %c33_i64 = arith.constant 33 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "sle" %c7_i64, %c_30_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %c_44_i64 : i64
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
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.urem %arg0, %c_42_i64 : i64
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
    %c_45_i64 = arith.constant -45 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %c7_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c_45_i64, %arg2 : i64
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
    %c_34_i64 = arith.constant -34 : i64
    %c26_i64 = arith.constant 26 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "ugt" %c_17_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.udiv %c26_i64, %3 : i64
    %5 = llvm.select %arg2, %1, %c_34_i64 : i1, i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.udiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c23_i64 = arith.constant 23 : i64
    %true = arith.constant true
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.urem %c_2_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.select %true, %arg2, %c23_i64 : i1, i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "ule" %c_8_i64, %c43_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %c_36_i64, %arg1 : i64
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
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "ule" %arg1, %c_14_i64 : i64
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
    %c_34_i64 = arith.constant -34 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "sle" %c_34_i64, %c_49_i64 : i64
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
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.srem %c_45_i64, %arg0 : i64
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
    %c_19_i64 = arith.constant -19 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sdiv %c12_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %c_19_i64, %arg1 : i64
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
    %c_15_i64 = arith.constant -15 : i64
    %c10_i64 = arith.constant 10 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "slt" %c42_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %c10_i64, %1 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.or %3, %c_15_i64 : i64
    %5 = llvm.and %4, %2 : i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %c31_i64 = arith.constant 31 : i64
    %c18_i64 = arith.constant 18 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "sgt" %c18_i64, %c8_i64 : i64
    %1 = llvm.select %0, %arg0, %c31_i64 : i1, i64
    %2 = llvm.icmp "eq" %arg1, %1 : i64
    %3 = llvm.select %2, %arg2, %c_36_i64 : i1, i64
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
    %c_50_i64 = arith.constant -50 : i64
    %c12_i64 = arith.constant 12 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "sgt" %c12_i64, %c_23_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.srem %1, %arg0 : i64
    %4 = llvm.or %c0_i64, %arg0 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.select %2, %c_50_i64, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %true = arith.constant true
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.select %true, %3, %c_25_i64 : i1, i64
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
    %c_41_i64 = arith.constant -41 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.select %arg0, %c_41_i64, %c15_i64 : i1, i64
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
    %c_40_i64 = arith.constant -40 : i64
    %c_39_i64 = arith.constant -39 : i64
    %false = arith.constant false
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.urem %arg0, %c38_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.and %arg1, %arg2 : i64
    %4 = llvm.select %false, %c_39_i64, %c_40_i64 : i1, i64
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
    %c_41_i64 = arith.constant -41 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.or %c34_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.sdiv %arg0, %arg1 : i64
    %4 = llvm.sdiv %3, %c_41_i64 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.srem %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c_42_i64 = arith.constant -42 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.urem %arg1, %c_10_i64 : i64
    %2 = llvm.icmp "eq" %arg2, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %c_42_i64, %3 : i64
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
    %c_50_i64 = arith.constant -50 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %c_21_i64 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.sdiv %c_50_i64, %c26_i64 : i64
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
    %c_2_i64 = arith.constant -2 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.srem %c_2_i64, %c_18_i64 : i64
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
    %c_1_i64 = arith.constant -1 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %c_29_i64, %0 : i64
    %2 = llvm.icmp "sgt" %c_1_i64, %c0_i64 : i64
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
    %c_44_i64 = arith.constant -44 : i64
    %c40_i64 = arith.constant 40 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.lshr %arg1, %c29_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.sdiv %c40_i64, %3 : i64
    %5 = llvm.icmp "ugt" %4, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.xor %c_44_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.srem %c_29_i64, %arg0 : i64
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
    %c_37_i64 = arith.constant -37 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.and %c_37_i64, %c49_i64 : i64
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
    %c_11_i64 = arith.constant -11 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %c_5_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %0, %c_11_i64 : i64
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
    %c_33_i64 = arith.constant -33 : i64
    %c9_i64 = arith.constant 9 : i64
    %true = arith.constant true
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.select %arg0, %arg1, %c_10_i64 : i1, i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg2 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.select %2, %3, %1 : i1, i64
    %5 = llvm.sdiv %c_33_i64, %3 : i64
    %6 = llvm.or %c9_i64, %5 : i64
    %7 = llvm.srem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.srem %c_49_i64, %c_6_i64 : i64
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
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg0, %arg1 : i64
    %3 = llvm.urem %2, %c_35_i64 : i64
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
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %c_32_i64, %0 : i64
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
    %c_36_i64 = arith.constant -36 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.and %c_36_i64, %c_5_i64 : i64
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
    %c_46_i64 = arith.constant -46 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "ugt" %c_43_i64, %c_14_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c_46_i64, %1 : i64
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
    %c_30_i64 = arith.constant -30 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.ashr %c17_i64, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %c_30_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c0_i64 = arith.constant 0 : i64
    %c_35_i64 = arith.constant -35 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %c_35_i64, %0 : i64
    %2 = llvm.sdiv %1, %c0_i64 : i64
    %3 = llvm.udiv %arg0, %0 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.or %c_30_i64, %2 : i64
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
    %c_12_i64 = arith.constant -12 : i64
    %c43_i64 = arith.constant 43 : i64
    %c25_i64 = arith.constant 25 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.and %c25_i64, %c14_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.srem %arg0, %arg1 : i64
    %4 = llvm.and %3, %c_12_i64 : i64
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
    %c_47_i64 = arith.constant -47 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.icmp "sge" %c_47_i64, %c0_i64 : i64
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
    %c_36_i64 = arith.constant -36 : i64
    %c_33_i64 = arith.constant -33 : i64
    %true = arith.constant true
    %c_26_i64 = arith.constant -26 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.select %true, %c_26_i64, %c_49_i64 : i1, i64
    %1 = llvm.icmp "slt" %arg0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.udiv %c_33_i64, %c_26_i64 : i64
    %6 = llvm.select %4, %5, %c_36_i64 : i1, i64
    %7 = llvm.icmp "sle" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.udiv %0, %arg0 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.and %arg0, %1 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.select %5, %c_8_i64, %arg2 : i1, i64
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
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.icmp "uge" %c_49_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %c_17_i64 : i64
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
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.lshr %c_28_i64, %arg1 : i64
    %5 = llvm.ashr %c30_i64, %4 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %c_23_i64, %0 : i64
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
    %c_17_i64 = arith.constant -17 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c11_i64 = arith.constant 11 : i64
    %c49_i64 = arith.constant 49 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sdiv %arg0, %c20_i64 : i64
    %1 = llvm.udiv %c49_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %c11_i64 : i64
    %3 = llvm.ashr %c_14_i64, %c_19_i64 : i64
    %4 = llvm.select %2, %arg1, %3 : i1, i64
    %5 = llvm.urem %arg1, %4 : i64
    %6 = llvm.ashr %0, %5 : i64
    %7 = llvm.icmp "slt" %6, %c_17_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c_38_i64 = arith.constant -38 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.urem %1, %c_38_i64 : i64
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
    %c_29_i64 = arith.constant -29 : i64
    %c25_i64 = arith.constant 25 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "slt" %c25_i64, %c49_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %c_29_i64, %arg0 : i64
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
    %c_17_i64 = arith.constant -17 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c_5_i64 = arith.constant -5 : i64
    %true = arith.constant true
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.and %c_22_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c_5_i64 : i64
    %2 = llvm.srem %c_43_i64, %c_17_i64 : i64
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
    %c_3_i64 = arith.constant -3 : i64
    %c_34_i64 = arith.constant -34 : i64
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.select %true, %arg2, %arg1 : i1, i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.ashr %2, %c_3_i64 : i64
    %4 = llvm.udiv %c_34_i64, %3 : i64
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
    %c_25_i64 = arith.constant -25 : i64
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
    %7 = llvm.icmp "sle" %6, %c_25_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c_38_i64 = arith.constant -38 : i64
    %true = arith.constant true
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.and %c42_i64, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.sdiv %arg1, %arg0 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.udiv %c_38_i64, %c16_i64 : i64
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
    %c_43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.urem %0, %c6_i64 : i64
    %3 = llvm.ashr %c_43_i64, %2 : i64
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
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg0, %arg0 : i64
    %3 = llvm.ashr %arg1, %arg0 : i64
    %4 = llvm.icmp "ule" %c_21_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %2, %5 : i64
    %7 = llvm.icmp "slt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %c_23_i64, %c14_i64 : i64
    %1 = llvm.or %arg0, %c_17_i64 : i64
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
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sdiv %c_49_i64, %0 : i64
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
    %c_26_i64 = arith.constant -26 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.xor %c_2_i64, %c_47_i64 : i64
    %1 = llvm.icmp "sgt" %c_26_i64, %0 : i64
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
    %c_11_i64 = arith.constant -11 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c42_i64 = arith.constant 42 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %c_4_i64, %c_11_i64 : i64
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
    %c_47_i64 = arith.constant -47 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.udiv %c10_i64, %arg1 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %c_36_i64, %arg2 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %arg0, %5 : i64
    %7 = llvm.icmp "eq" %6, %c_47_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.and %c_1_i64, %arg2 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "sge" %6, %c_34_i64 : i64
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
    %c_42_i64 = arith.constant -42 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.select %arg0, %arg1, %c_5_i64 : i1, i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sdiv %1, %c_42_i64 : i64
    %3 = llvm.icmp "sle" %c_37_i64, %2 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.srem %c16_i64, %4 : i64
    %6 = llvm.select %3, %2, %5 : i1, i64
    %7 = llvm.srem %c_29_i64, %6 : i64
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
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %c_45_i64, %3 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.sdiv %arg1, %3 : i64
    %7 = llvm.select %5, %6, %4 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %c_13_i64, %arg0 : i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.srem %c37_i64, %0 : i64
    %2 = llvm.xor %arg2, %c_30_i64 : i64
    %3 = llvm.icmp "ne" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %4, %c_35_i64 : i64
    %6 = llvm.or %5, %arg2 : i64
    %7 = llvm.icmp "uge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.udiv %arg0, %c_20_i64 : i64
    %1 = llvm.or %0, %c_28_i64 : i64
    %2 = llvm.ashr %c_41_i64, %0 : i64
    %3 = llvm.icmp "slt" %2, %c_37_i64 : i64
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
    %c_9_i64 = arith.constant -9 : i64
    %c46_i64 = arith.constant 46 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c32_i64 = arith.constant 32 : i64
    %c23_i64 = arith.constant 23 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.udiv %c_22_i64, %arg0 : i64
    %1 = llvm.srem %c23_i64, %0 : i64
    %2 = llvm.ashr %c32_i64, %arg1 : i64
    %3 = llvm.ashr %c_27_i64, %c46_i64 : i64
    %4 = llvm.xor %arg2, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.srem %5, %c_9_i64 : i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %c30_i64, %c_26_i64 : i64
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
    %c_22_i64 = arith.constant -22 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.sdiv %arg2, %c23_i64 : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    %2 = llvm.ashr %c_22_i64, %c30_i64 : i64
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
    %c_6_i64 = arith.constant -6 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %c_37_i64 : i64
    %2 = llvm.sdiv %c_16_i64, %1 : i64
    %3 = llvm.icmp "eq" %c_6_i64, %2 : i64
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
    %c_18_i64 = arith.constant -18 : i64
    %c18_i64 = arith.constant 18 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "sge" %c18_i64, %c13_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "eq" %2, %c27_i64 : i64
    %4 = llvm.select %3, %c2_i64, %arg1 : i1, i64
    %5 = llvm.srem %4, %1 : i64
    %6 = llvm.or %2, %5 : i64
    %7 = llvm.icmp "slt" %c_18_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %true = arith.constant true
    %c_13_i64 = arith.constant -13 : i64
    %c41_i64 = arith.constant 41 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.xor %c41_i64, %c7_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.or %2, %c_5_i64 : i64
    %4 = llvm.select %true, %3, %arg0 : i1, i64
    %5 = llvm.icmp "ne" %c_13_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.xor %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.xor %c_30_i64, %c_29_i64 : i64
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
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.and %c0_i64, %c_14_i64 : i64
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
    %c_29_i64 = arith.constant -29 : i64
    %c34_i64 = arith.constant 34 : i64
    %false = arith.constant false
    %c_17_i64 = arith.constant -17 : i64
    %c27_i64 = arith.constant 27 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "ugt" %c27_i64, %c_34_i64 : i64
    %1 = llvm.select %false, %c34_i64, %arg0 : i1, i64
    %2 = llvm.select %0, %c_17_i64, %1 : i1, i64
    %3 = llvm.icmp "sle" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %arg1, %c_29_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %c8_i64 = arith.constant 8 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "sgt" %c_23_i64, %c31_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg0, %c_27_i64 : i64
    %3 = llvm.select %2, %c8_i64, %arg0 : i1, i64
    %4 = llvm.sdiv %c_39_i64, %1 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c_34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "eq" %c_34_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %c_14_i64, %0 : i64
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
    %c_23_i64 = arith.constant -23 : i64
    %c_20_i64 = arith.constant -20 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c38_i64 = arith.constant 38 : i64
    %true = arith.constant true
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.select %true, %0, %arg2 : i1, i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.xor %3, %c38_i64 : i64
    %5 = llvm.udiv %c_44_i64, %c_20_i64 : i64
    %6 = llvm.select %true, %5, %c_23_i64 : i1, i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "uge" %c_26_i64, %arg0 : i64
    %1 = llvm.urem %c_2_i64, %arg0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.select %0, %2, %arg1 : i1, i64
    %4 = llvm.select %arg2, %2, %c_9_i64 : i1, i64
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
    %c_14_i64 = arith.constant -14 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c44_i64 = arith.constant 44 : i64
    %c3_i64 = arith.constant 3 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.lshr %c3_i64, %c18_i64 : i64
    %1 = llvm.lshr %0, %c44_i64 : i64
    %2 = llvm.lshr %c_37_i64, %c_28_i64 : i64
    %3 = llvm.ashr %c_14_i64, %2 : i64
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
    %c_11_i64 = arith.constant -11 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "slt" %arg0, %c_20_i64 : i64
    %1 = llvm.lshr %c_22_i64, %c_11_i64 : i64
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
    %c_20_i64 = arith.constant -20 : i64
    %c_44_i64 = arith.constant -44 : i64
    %false = arith.constant false
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.select %false, %arg0, %c_44_i64 : i1, i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.sdiv %arg0, %c_20_i64 : i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %c_40_i64 : i64
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
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.and %c_20_i64, %arg0 : i64
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
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.or %c_24_i64, %0 : i64
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
    %c_2_i64 = arith.constant -2 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %arg1, %0, %c_40_i64 : i1, i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.xor %4, %c_2_i64 : i64
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
    %c_50_i64 = arith.constant -50 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.xor %c_18_i64, %0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %4, %c_44_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.srem %6, %c_50_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %true = arith.constant true
    %c_37_i64 = arith.constant -37 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "ult" %c16_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.lshr %c_37_i64, %arg1 : i64
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
    %c_13_i64 = arith.constant -13 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "sge" %arg0, %c_7_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c_13_i64, %arg1 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.ashr %c_41_i64, %4 : i64
    %6 = llvm.sdiv %5, %c5_i64 : i64
    %7 = llvm.icmp "sle" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c12_i64 = arith.constant 12 : i64
    %true = arith.constant true
    %c_5_i64 = arith.constant -5 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %c_5_i64, %c_12_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.select %true, %1, %1 : i1, i64
    %3 = llvm.udiv %c12_i64, %c_48_i64 : i64
    %4 = llvm.or %c_29_i64, %3 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.select %5, %c_50_i64, %c_21_i64 : i1, i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
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
    %6 = llvm.or %5, %c_16_i64 : i64
    %7 = llvm.and %c33_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c25_i64, %c_37_i64 : i64
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
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.udiv %c34_i64, %c_32_i64 : i64
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
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.or %c_25_i64, %arg0 : i64
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
    %c_20_i64 = arith.constant -20 : i64
    %true = arith.constant true
    %false = arith.constant false
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.select %false, %arg0, %c_5_i64 : i1, i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.select %true, %arg1, %1 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.or %arg2, %c_20_i64 : i64
    %5 = llvm.sdiv %2, %arg2 : i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.srem %arg1, %c_29_i64 : i64
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
    %c_10_i64 = arith.constant -10 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %c_29_i64, %c_10_i64 : i64
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
    %c_24_i64 = arith.constant -24 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.sdiv %c7_i64, %arg0 : i64
    %1 = llvm.urem %0, %c_24_i64 : i64
    %2 = llvm.icmp "sle" %c_6_i64, %1 : i64
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
    %c_16_i64 = arith.constant -16 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c_8_i64 : i64
    %2 = llvm.urem %c_43_i64, %arg1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.sdiv %arg2, %c_16_i64 : i64
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
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %arg2 : i64
    %2 = llvm.icmp "ult" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %3, %1 : i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.select %2, %c_45_i64, %0 : i1, i64
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
    %c_28_i64 = arith.constant -28 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "sgt" %c_48_i64, %c_7_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c_50_i64, %1 : i64
    %3 = llvm.udiv %2, %c_28_i64 : i64
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
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.icmp "sge" %c_47_i64, %2 : i64
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
    %c_49_i64 = arith.constant -49 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.srem %c_29_i64, %0 : i64
    %2 = llvm.xor %c_49_i64, %1 : i64
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
    %c_49_i64 = arith.constant -49 : i64
    %c37_i64 = arith.constant 37 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.lshr %c11_i64, %arg1 : i64
    %1 = llvm.icmp "ult" %c37_i64, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.and %arg2, %c_49_i64 : i64
    %5 = llvm.select %3, %4, %2 : i1, i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %c_40_i64 = arith.constant -40 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %arg2, %c_37_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %2, %4, %1 : i1, i64
    %6 = llvm.ashr %c_40_i64, %c_33_i64 : i64
    %7 = llvm.ashr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.select %1, %2, %c_39_i64 : i1, i64
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
    %c_46_i64 = arith.constant -46 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "sge" %c_41_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c_46_i64, %arg1 : i64
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
    %c_43_i64 = arith.constant -43 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.lshr %arg0, %c17_i64 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %c_43_i64, %0 : i64
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
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.sdiv %arg0, %c_37_i64 : i64
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
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.urem %c_49_i64, %c43_i64 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c13_i64 = arith.constant 13 : i64
    %c24_i64 = arith.constant 24 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.and %c24_i64, %c_41_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.icmp "ule" %c13_i64, %c_14_i64 : i64
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
    %c_14_i64 = arith.constant -14 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.srem %arg0, %c_23_i64 : i64
    %1 = llvm.or %c_14_i64, %arg0 : i64
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
    %c_2_i64 = arith.constant -2 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.select %arg0, %arg1, %c32_i64 : i1, i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.select %arg2, %c_19_i64, %c_2_i64 : i1, i64
    %5 = llvm.and %4, %0 : i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.icmp "sge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c45_i64 = arith.constant 45 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "sge" %c45_i64, %c34_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %c_13_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %c_42_i64, %3 : i64
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
    %c_49_i64 = arith.constant -49 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.udiv %c_38_i64, %c_19_i64 : i64
    %1 = llvm.icmp "eq" %c_36_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.and %arg0, %c_49_i64 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.zext %1 : i1 to i64
    %7 = llvm.lshr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %c24_i64 = arith.constant 24 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.xor %c24_i64, %c_43_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %c_36_i64, %arg0 : i64
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
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.select %false, %c_11_i64, %arg1 : i1, i64
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
    %c_24_i64 = arith.constant -24 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.udiv %arg0, %c0_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.or %c_24_i64, %5 : i64
    %7 = llvm.icmp "sge" %6, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %true = arith.constant true
    %c21_i64 = arith.constant 21 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %c_18_i64, %c21_i64 : i1, i64
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
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.srem %c_39_i64, %arg0 : i64
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
    %c_46_i64 = arith.constant -46 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %c4_i64 : i64
    %3 = llvm.select %2, %c_46_i64, %arg0 : i1, i64
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
    %c_34_i64 = arith.constant -34 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.ashr %2, %c39_i64 : i64
    %4 = llvm.icmp "slt" %3, %c_34_i64 : i64
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
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.lshr %arg0, %c_31_i64 : i64
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
    %c_16_i64 = arith.constant -16 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.lshr %arg0, %c6_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %arg1, %c_16_i64 : i64
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
    %c_38_i64 = arith.constant -38 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %c34_i64, %arg0 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.icmp "eq" %4, %c_38_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.or %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "ule" %c_6_i64, %2 : i64
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
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %c_27_i64, %c_27_i64 : i64
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
    %c_20_i64 = arith.constant -20 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.xor %c_10_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c_20_i64, %0 : i64
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
    %c_22_i64 = arith.constant -22 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.srem %arg0, %c10_i64 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.udiv %1, %c_4_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.or %2, %c_22_i64 : i64
    %7 = llvm.icmp "sge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c26_i64 = arith.constant 26 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.xor %c26_i64, %c_48_i64 : i64
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
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.sdiv %c_47_i64, %arg0 : i64
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
    %c_23_i64 = arith.constant -23 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %arg0, %c_27_i64 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.urem %1, %c_11_i64 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.zext %3 : i1 to i64
    %6 = llvm.lshr %5, %c_23_i64 : i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.srem %c_42_i64, %c_1_i64 : i64
    %1 = llvm.lshr %c_48_i64, %c_33_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %2, %c_40_i64 : i64
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
    %c_28_i64 = arith.constant -28 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %c47_i64 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %arg2, %4 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "eq" %6, %c_28_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c_7_i64 = arith.constant -7 : i64
    %c15_i64 = arith.constant 15 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.xor %arg0, %c_5_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %c15_i64, %1 : i64
    %3 = llvm.srem %c_7_i64, %2 : i64
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
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.icmp "sge" %c_28_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %c_25_i64 = arith.constant -25 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.srem %c_42_i64, %c_30_i64 : i64
    %1 = llvm.lshr %0, %c_25_i64 : i64
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
    %c_43_i64 = arith.constant -43 : i64
    %c8_i64 = arith.constant 8 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.or %0, %c8_i64 : i64
    %2 = llvm.or %c_42_i64, %1 : i64
    %3 = llvm.or %c_43_i64, %arg2 : i64
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
    %c_45_i64 = arith.constant -45 : i64
    %c37_i64 = arith.constant 37 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %arg1, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %c_40_i64 : i64
    %4 = llvm.sdiv %c37_i64, %c_45_i64 : i64
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
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.lshr %arg2, %3 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.urem %5, %c_30_i64 : i64
    %7 = llvm.icmp "ult" %6, %c13_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.or %c1_i64, %1 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "uge" %4, %c_38_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %c24_i64 = arith.constant 24 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.select %false, %c24_i64, %c_22_i64 : i1, i64
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
    %c_41_i64 = arith.constant -41 : i64
    %true = arith.constant true
    %c_43_i64 = arith.constant -43 : i64
    %c34_i64 = arith.constant 34 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.sdiv %c34_i64, %c_24_i64 : i64
    %1 = llvm.select %true, %c_43_i64, %0 : i1, i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    %3 = llvm.srem %0, %arg0 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.lshr %arg1, %arg1 : i64
    %6 = llvm.and %c_41_i64, %5 : i64
    %7 = llvm.select %2, %4, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c4_i64 = arith.constant 4 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.ashr %c4_i64, %c_22_i64 : i64
    %1 = llvm.ashr %0, %c_9_i64 : i64
    %2 = llvm.xor %c_49_i64, %c30_i64 : i64
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
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.ashr %c_6_i64, %2 : i64
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
    %c_6_i64 = arith.constant -6 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.udiv %arg0, %c14_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ult" %c_6_i64, %c4_i64 : i64
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
    %c_22_i64 = arith.constant -22 : i64
    %c30_i64 = arith.constant 30 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.lshr %c16_i64, %arg0 : i64
    %1 = llvm.lshr %c30_i64, %0 : i64
    %2 = llvm.lshr %c_22_i64, %arg0 : i64
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
    %c_7_i64 = arith.constant -7 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c7_i64 = arith.constant 7 : i64
    %c50_i64 = arith.constant 50 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "eq" %c50_i64, %c_2_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %c7_i64, %1 : i64
    %3 = llvm.sdiv %c_7_i64, %1 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.udiv %2, %5 : i64
    %7 = llvm.icmp "eq" %c_9_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.udiv %arg0, %c_28_i64 : i64
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
    %c_16_i64 = arith.constant -16 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.and %c_15_i64, %c37_i64 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.urem %0, %c_16_i64 : i64
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
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.urem %c32_i64, %c_50_i64 : i64
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
    %c_27_i64 = arith.constant -27 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "sle" %arg0, %c_9_i64 : i64
    %1 = llvm.icmp "slt" %arg1, %arg1 : i64
    %2 = llvm.sdiv %arg2, %arg0 : i64
    %3 = llvm.select %1, %c_27_i64, %2 : i1, i64
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
    %c_21_i64 = arith.constant -21 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.urem %c_15_i64, %c28_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.lshr %arg0, %c_21_i64 : i64
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
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %arg0, %c_47_i64 : i64
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
    %c_5_i64 = arith.constant -5 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ule" %arg0, %c_13_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.xor %c_1_i64, %2 : i64
    %4 = llvm.ashr %arg1, %2 : i64
    %5 = llvm.sdiv %c22_i64, %4 : i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.icmp "sle" %c_5_i64, %6 : i64
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
    %c_22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %c_22_i64, %arg1 : i64
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
    %c_38_i64 = arith.constant -38 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.urem %c_4_i64, %c34_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.lshr %0, %arg1 : i64
    %5 = llvm.select %3, %4, %arg2 : i1, i64
    %6 = llvm.udiv %arg1, %5 : i64
    %7 = llvm.select %3, %c_38_i64, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c50_i64 = arith.constant 50 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %c50_i64 : i64
    %3 = llvm.select %2, %c_10_i64, %arg0 : i1, i64
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
    %c_36_i64 = arith.constant -36 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.and %c_36_i64, %0 : i64
    %3 = llvm.udiv %c_5_i64, %2 : i64
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
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.or %3, %c_13_i64 : i64
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
    %c_31_i64 = arith.constant -31 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.ashr %arg0, %c1_i64 : i64
    %1 = llvm.sdiv %0, %c36_i64 : i64
    %2 = llvm.udiv %c_31_i64, %1 : i64
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
    %c_30_i64 = arith.constant -30 : i64
    %c46_i64 = arith.constant 46 : i64
    %c0_i64 = arith.constant 0 : i64
    %c2_i64 = arith.constant 2 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.xor %arg0, %c40_i64 : i64
    %1 = llvm.ashr %arg1, %c2_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %c0_i64 : i64
    %4 = llvm.select %3, %c46_i64, %0 : i1, i64
    %5 = llvm.select %2, %4, %c_30_i64 : i1, i64
    %6 = llvm.select %3, %5, %arg0 : i1, i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c_38_i64 = arith.constant -38 : i64
    %true = arith.constant true
    %c_34_i64 = arith.constant -34 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.select %true, %c_34_i64, %c29_i64 : i1, i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %1, %c_38_i64 : i64
    %3 = llvm.icmp "sgt" %c_8_i64, %2 : i64
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
    %c_32_i64 = arith.constant -32 : i64
    %c45_i64 = arith.constant 45 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.lshr %c_44_i64, %c_11_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %c45_i64, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.udiv %3, %c_32_i64 : i64
    %5 = llvm.ashr %arg1, %4 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.icmp "slt" %6, %3 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %c_19_i64, %c20_i64 : i64
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
    %c_33_i64 = arith.constant -33 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %arg1, %c37_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.ashr %arg0, %c_33_i64 : i64
    %6 = llvm.and %0, %5 : i64
    %7 = llvm.and %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "ugt" %4, %c_15_i64 : i64
    %6 = llvm.xor %3, %3 : i64
    %7 = llvm.select %5, %6, %arg2 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %c30_i64 = arith.constant 30 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c28_i64 = arith.constant 28 : i64
    %false = arith.constant false
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.or %arg0, %c39_i64 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.select %false, %c28_i64, %c_45_i64 : i1, i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.xor %c30_i64, %1 : i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    %7 = llvm.select %6, %c_3_i64, %0 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %c_6_i64, %0 : i64
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
    %c_8_i64 = arith.constant -8 : i64
    %c_20_i64 = arith.constant -20 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "ult" %c_20_i64, %c_8_i64 : i64
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
    %c_12_i64 = arith.constant -12 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.udiv %c_44_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c_12_i64 : i64
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
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.select %true, %c24_i64, %c_14_i64 : i1, i64
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
    %c_16_i64 = arith.constant -16 : i64
    %c8_i64 = arith.constant 8 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.urem %2, %c8_i64 : i64
    %6 = llvm.select %4, %5, %c_16_i64 : i1, i64
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
    %c_45_i64 = arith.constant -45 : i64
    %c44_i64 = arith.constant 44 : i64
    %c17_i64 = arith.constant 17 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.srem %c17_i64, %c_15_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.select %2, %c44_i64, %arg1 : i1, i64
    %4 = llvm.sdiv %3, %arg2 : i64
    %5 = llvm.sext %2 : i1 to i64
    %6 = llvm.sdiv %5, %c_45_i64 : i64
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
    %c_11_i64 = arith.constant -11 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.xor %arg0, %c_16_i64 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.xor %arg1, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.ashr %c_22_i64, %4 : i64
    %6 = llvm.select %arg2, %c_11_i64, %c12_i64 : i1, i64
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
    %c_46_i64 = arith.constant -46 : i64
    %c20_i64 = arith.constant 20 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.sdiv %c20_i64, %c37_i64 : i64
    %1 = llvm.select %arg0, %c47_i64, %0 : i1, i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sdiv %0, %5 : i64
    %7 = llvm.icmp "sle" %c_46_i64, %6 : i64
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
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "sle" %c31_i64, %c_15_i64 : i64
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
    %c_12_i64 = arith.constant -12 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ugt" %c_10_i64, %c_27_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %c_12_i64 : i64
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
    %c_37_i64 = arith.constant -37 : i64
    %c9_i64 = arith.constant 9 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "ugt" %arg0, %c_26_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg1, %arg2 : i64
    %3 = llvm.select %2, %c_18_i64, %arg1 : i1, i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.ashr %c9_i64, %c_37_i64 : i64
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
    %c_20_i64 = arith.constant -20 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c4_i64 = arith.constant 4 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "uge" %arg0, %c42_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %c4_i64, %1 : i64
    %3 = llvm.ashr %arg1, %arg0 : i64
    %4 = llvm.srem %c_20_i64, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ne" %c_10_i64, %6 : i64
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
    %c_19_i64 = arith.constant -19 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.urem %c30_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %c_19_i64 : i64
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
    %c_10_i64 = arith.constant -10 : i64
    %c2_i64 = arith.constant 2 : i64
    %false = arith.constant false
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.lshr %arg1, %c47_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %false, %3, %c_10_i64 : i1, i64
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
    %c_49_i64 = arith.constant -49 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.select %arg0, %c_23_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ne" %0, %c_49_i64 : i64
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
    %c_16_i64 = arith.constant -16 : i64
    %c11_i64 = arith.constant 11 : i64
    %c4_i64 = arith.constant 4 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "ule" %c_25_i64, %c41_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c4_i64, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %c11_i64 : i64
    %4 = llvm.select %3, %c_16_i64, %2 : i1, i64
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
    %c_13_i64 = arith.constant -13 : i64
    %c22_i64 = arith.constant 22 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.sdiv %c22_i64, %c_3_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.sdiv %c_13_i64, %2 : i64
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
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.and %c_17_i64, %arg1 : i64
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
    %c_21_i64 = arith.constant -21 : i64
    %c17_i64 = arith.constant 17 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "uge" %c_46_i64, %arg0 : i64
    %1 = llvm.select %0, %c_45_i64, %arg0 : i1, i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.lshr %c17_i64, %c_21_i64 : i64
    %7 = llvm.lshr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.xor %c_33_i64, %0 : i64
    %3 = llvm.udiv %c_50_i64, %2 : i64
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
    %c_9_i64 = arith.constant -9 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.lshr %c_36_i64, %c48_i64 : i64
    %1 = llvm.lshr %0, %c_22_i64 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %4, %2 : i64
    %6 = llvm.udiv %1, %c_9_i64 : i64
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
    %c_6_i64 = arith.constant -6 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.or %c_3_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %3, %1 : i64
    %5 = llvm.icmp "ne" %c_6_i64, %arg0 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.select %2, %4, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.select %arg1, %c_8_i64, %1 : i1, i64
    %3 = llvm.and %arg2, %c43_i64 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.icmp "ult" %c_34_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c6_i64 = arith.constant 6 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.urem %c_3_i64, %arg0 : i64
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
    %c_1_i64 = arith.constant -1 : i64
    %c6_i64 = arith.constant 6 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c19_i64 = arith.constant 19 : i64
    %c47_i64 = arith.constant 47 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.lshr %c47_i64, %c_30_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.xor %c_8_i64, %c6_i64 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.xor %c_1_i64, %arg0 : i64
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
    %c_19_i64 = arith.constant -19 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.sdiv %arg0, %c43_i64 : i64
    %1 = llvm.icmp "sle" %c_19_i64, %0 : i64
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
    %c_19_i64 = arith.constant -19 : i64
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
    %6 = llvm.icmp "sgt" %5, %c_19_i64 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %arg0, %c_28_i64 : i64
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
    %c_17_i64 = arith.constant -17 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %c36_i64, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.or %c_17_i64, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %c_8_i64, %1 : i64
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
    %c_34_i64 = arith.constant -34 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "sle" %1, %c43_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.urem %1, %c_34_i64 : i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.ashr %c_29_i64, %0 : i64
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
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "sge" %c_8_i64, %arg0 : i64
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
    %c_47_i64 = arith.constant -47 : i64
    %c44_i64 = arith.constant 44 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.or %c27_i64, %arg0 : i64
    %1 = llvm.urem %0, %c44_i64 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %2, %c_47_i64 : i64
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
    %c_9_i64 = arith.constant -9 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.udiv %c_9_i64, %c32_i64 : i64
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
    %c_36_i64 = arith.constant -36 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %c_29_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.udiv %c33_i64, %3 : i64
    %5 = llvm.urem %c_47_i64, %4 : i64
    %6 = llvm.lshr %c_37_i64, %5 : i64
    %7 = llvm.icmp "uge" %6, %c_36_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c37_i64 = arith.constant 37 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.icmp "eq" %c_38_i64, %c32_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %c37_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %5, %c_35_i64 : i64
    %7 = llvm.lshr %c_29_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c41_i64 = arith.constant 41 : i64
    %false = arith.constant false
    %c_12_i64 = arith.constant -12 : i64
    %c18_i64 = arith.constant 18 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.srem %c18_i64, %c_44_i64 : i64
    %1 = llvm.ashr %c_12_i64, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.select %false, %c41_i64, %0 : i1, i64
    %5 = llvm.srem %4, %c_27_i64 : i64
    %6 = llvm.ashr %3, %5 : i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.xor %c_32_i64, %arg0 : i64
    %1 = llvm.urem %0, %c_21_i64 : i64
    %2 = llvm.and %c_8_i64, %arg0 : i64
    %3 = llvm.icmp "eq" %c_39_i64, %arg2 : i64
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
    %c_44_i64 = arith.constant -44 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.icmp "ult" %arg1, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %c18_i64, %2 : i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.lshr %c_44_i64, %4 : i64
    %6 = llvm.select %1, %3, %5 : i1, i64
    %7 = llvm.icmp "ult" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.xor %c_47_i64, %0 : i64
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
    %c_45_i64 = arith.constant -45 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %c44_i64, %c_45_i64 : i64
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
    %c_22_i64 = arith.constant -22 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c14_i64 = arith.constant 14 : i64
    %c22_i64 = arith.constant 22 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.sdiv %c38_i64, %arg0 : i64
    %1 = llvm.urem %c22_i64, %0 : i64
    %2 = llvm.srem %c_44_i64, %0 : i64
    %3 = llvm.xor %c14_i64, %2 : i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.icmp "slt" %5, %c_22_i64 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %c_3_i64 = arith.constant -3 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "sge" %arg0, %c_9_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %c_3_i64 : i64
    %3 = llvm.lshr %arg2, %c_45_i64 : i64
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
    %c_32_i64 = arith.constant -32 : i64
    %c12_i64 = arith.constant 12 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c_4_i64 : i64
    %2 = llvm.icmp "ugt" %c12_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.ashr %4, %1 : i64
    %6 = llvm.sdiv %3, %c_32_i64 : i64
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
    %c_45_i64 = arith.constant -45 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.ashr %c_45_i64, %c35_i64 : i64
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
    %c_48_i64 = arith.constant -48 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.udiv %arg1, %c_5_i64 : i64
    %2 = llvm.icmp "slt" %1, %c_49_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %arg1, %0 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.lshr %5, %c_48_i64 : i64
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
    %c_23_i64 = arith.constant -23 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %c_28_i64, %arg0 : i64
    %1 = llvm.udiv %c_23_i64, %arg0 : i64
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
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.udiv %c_32_i64, %arg0 : i64
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
    %c_21_i64 = arith.constant -21 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %0, %c_21_i64 : i64
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
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c_43_i64, %arg1 : i64
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
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %c_1_i64, %2 : i64
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
    %c_24_i64 = arith.constant -24 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "eq" %c_24_i64, %c_28_i64 : i64
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
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.lshr %c_32_i64, %arg0 : i64
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
    %c_45_i64 = arith.constant -45 : i64
    %c46_i64 = arith.constant 46 : i64
    %c_2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "sle" %0, %c46_i64 : i64
    %2 = llvm.xor %0, %0 : i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.select %1, %3, %c_45_i64 : i1, i64
    %5 = llvm.srem %c_2_i64, %4 : i64
    %6 = llvm.or %0, %arg0 : i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.select %2, %c_5_i64, %0 : i1, i64
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
    %c_18_i64 = arith.constant -18 : i64
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.sdiv %arg1, %c_18_i64 : i64
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
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %c_43_i64, %2 : i64
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
    %c_6_i64 = arith.constant -6 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %c_42_i64, %c_25_i64 : i64
    %2 = llvm.lshr %0, %arg2 : i64
    %3 = llvm.ashr %c_49_i64, %c_6_i64 : i64
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
    %c_2_i64 = arith.constant -2 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.ashr %c6_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.lshr %1, %c_2_i64 : i64
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
    %c_1_i64 = arith.constant -1 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %c30_i64, %0 : i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.sdiv %3, %c_1_i64 : i64
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
    %c_28_i64 = arith.constant -28 : i64
    %c37_i64 = arith.constant 37 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.sdiv %arg0, %c_46_i64 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.lshr %arg2, %c37_i64 : i64
    %5 = llvm.select %1, %c_28_i64, %arg0 : i1, i64
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
    %c_32_i64 = arith.constant -32 : i64
    %c6_i64 = arith.constant 6 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %c20_i64 : i64
    %2 = llvm.select %arg0, %1, %0 : i1, i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.sdiv %c6_i64, %c_32_i64 : i64
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
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.sdiv %c_12_i64, %arg0 : i64
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
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.or %0, %c0_i64 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.icmp "ule" %c49_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.icmp "sge" %c_5_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c35_i64 = arith.constant 35 : i64
    %c48_i64 = arith.constant 48 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.srem %c_49_i64, %arg0 : i64
    %1 = llvm.sdiv %c48_i64, %0 : i64
    %2 = llvm.lshr %c35_i64, %c_47_i64 : i64
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
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.lshr %0, %c_46_i64 : i64
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
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %c_46_i64, %0 : i64
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
    %c_26_i64 = arith.constant -26 : i64
    %c7_i64 = arith.constant 7 : i64
    %c43_i64 = arith.constant 43 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "ule" %c43_i64, %c0_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c7_i64, %c_26_i64 : i64
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
    %c_7_i64 = arith.constant -7 : i64
    %c12_i64 = arith.constant 12 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %c0_i64 : i64
    %2 = llvm.urem %c12_i64, %arg0 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %c_7_i64, %2 : i64
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
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.or %3, %2 : i64
    %5 = llvm.ashr %c_29_i64, %0 : i64
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
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.urem %c_30_i64, %arg0 : i64
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
    %c_2_i64 = arith.constant -2 : i64
    %c19_i64 = arith.constant 19 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %c2_i64 : i64
    %2 = llvm.select %arg0, %1, %c19_i64 : i1, i64
    %3 = llvm.icmp "sle" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %0, %4 : i64
    %6 = llvm.ashr %c_2_i64, %arg1 : i64
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
    %c_2_i64 = arith.constant -2 : i64
    %c35_i64 = arith.constant 35 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %c_30_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %c35_i64 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.xor %4, %c_2_i64 : i64
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
    %c_24_i64 = arith.constant -24 : i64
    %c3_i64 = arith.constant 3 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.srem %c3_i64, %c7_i64 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %c_24_i64 : i64
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
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.urem %c13_i64, %c_15_i64 : i64
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
    %c_2_i64 = arith.constant -2 : i64
    %c31_i64 = arith.constant 31 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "uge" %c35_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg0, %arg0 : i64
    %3 = llvm.icmp "ugt" %c31_i64, %c_2_i64 : i64
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
    %c_15_i64 = arith.constant -15 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.xor %c22_i64, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.urem %c_15_i64, %arg2 : i64
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
    %c_41_i64 = arith.constant -41 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.urem %0, %c8_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "ule" %2, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.udiv %5, %c_41_i64 : i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.urem %c_37_i64, %arg0 : i64
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
    %c_43_i64 = arith.constant -43 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.and %c26_i64, %1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.udiv %3, %0 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.urem %c_43_i64, %5 : i64
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
    %c_16_i64 = arith.constant -16 : i64
    %c31_i64 = arith.constant 31 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.and %c31_i64, %c21_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "sge" %c_16_i64, %arg2 : i64
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
    %c_21_i64 = arith.constant -21 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.and %arg0, %c22_i64 : i64
    %1 = llvm.urem %arg0, %c_21_i64 : i64
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
    %c_17_i64 = arith.constant -17 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c24_i64 = arith.constant 24 : i64
    %c15_i64 = arith.constant 15 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.sdiv %c37_i64, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %c15_i64, %3 : i64
    %5 = llvm.icmp "ugt" %c_27_i64, %c_17_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.select %4, %c24_i64, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %3, %c_4_i64 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %arg2 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.lshr %c_43_i64, %4 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.srem %c40_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.icmp "ugt" %c_32_i64, %arg1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    %5 = llvm.select %4, %c_20_i64, %3 : i1, i64
    %6 = llvm.udiv %5, %2 : i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %c_34_i64 : i64
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
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.and %c24_i64, %c_24_i64 : i64
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
    %c_8_i64 = arith.constant -8 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c8_i64 = arith.constant 8 : i64
    %c22_i64 = arith.constant 22 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.xor %arg0, %c_4_i64 : i64
    %1 = llvm.ashr %c_26_i64, %c_8_i64 : i64
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
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.xor %c_46_i64, %arg2 : i64
    %6 = llvm.srem %5, %2 : i64
    %7 = llvm.ashr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c49_i64 = arith.constant 49 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.and %c47_i64, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.and %c49_i64, %4 : i64
    %6 = llvm.icmp "ult" %c_28_i64, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %c33_i64 : i64
    %2 = llvm.or %arg1, %0 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.sdiv %c_33_i64, %3 : i64
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
    %c_18_i64 = arith.constant -18 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.ashr %c5_i64, %c5_i64 : i64
    %1 = llvm.or %c_18_i64, %0 : i64
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
    %c_42_i64 = arith.constant -42 : i64
    %c_3_i64 = arith.constant -3 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.select %arg0, %arg1, %c_12_i64 : i1, i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %c_42_i64, %0 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %c_3_i64, %6 : i64
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
    %c_43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %c_43_i64, %arg0 : i64
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
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.and %c_50_i64, %arg0 : i64
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
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.icmp "slt" %1, %c_17_i64 : i64
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
    %c_6_i64 = arith.constant -6 : i64
    %c_2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.select %false, %c_19_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %2, %c_2_i64 : i64
    %4 = llvm.ashr %3, %c_6_i64 : i64
    %5 = llvm.or %arg1, %arg0 : i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.select %1, %arg2, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %c40_i64 = arith.constant 40 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %c49_i64, %arg0 : i64
    %1 = llvm.and %c40_i64, %0 : i64
    %2 = llvm.urem %c_13_i64, %arg1 : i64
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
    %c_42_i64 = arith.constant -42 : i64
    %c_7_i64 = arith.constant -7 : i64
    %c_35_i64 = arith.constant -35 : i64
    %true = arith.constant true
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %c48_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg1 : i64
    %2 = llvm.select %true, %c_35_i64, %c_7_i64 : i1, i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %arg0, %c_42_i64 : i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c_20_i64 = arith.constant -20 : i64
    %c5_i64 = arith.constant 5 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.and %c5_i64, %c_15_i64 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.srem %c18_i64, %arg0 : i64
    %3 = llvm.xor %c_20_i64, %2 : i64
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
    %c_8_i64 = arith.constant -8 : i64
    %c30_i64 = arith.constant 30 : i64
    %c_50_i64 = arith.constant -50 : i64
    %true = arith.constant true
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %arg0, %c_11_i64 : i64
    %1 = llvm.select %true, %0, %arg1 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "ule" %0, %c_50_i64 : i64
    %5 = llvm.select %4, %c30_i64, %c_8_i64 : i1, i64
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
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.ashr %c2_i64, %c_16_i64 : i64
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
    %c_15_i64 = arith.constant -15 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.udiv %1, %c31_i64 : i64
    %3 = llvm.or %0, %c_15_i64 : i64
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
    %c_42_i64 = arith.constant -42 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.xor %c_29_i64, %c12_i64 : i64
    %1 = llvm.and %c_42_i64, %0 : i64
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
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.udiv %arg0, %c_34_i64 : i64
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
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.srem %c10_i64, %c_34_i64 : i64
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
    %c_14_i64 = arith.constant -14 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c28_i64 = arith.constant 28 : i64
    %true = arith.constant true
    %0 = llvm.icmp "slt" %arg2, %arg2 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.udiv %arg2, %1 : i64
    %3 = llvm.select %0, %arg2, %2 : i1, i64
    %4 = llvm.select %arg0, %arg1, %3 : i1, i64
    %5 = llvm.urem %c28_i64, %c_17_i64 : i64
    %6 = llvm.or %5, %c_14_i64 : i64
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
    %c_28_i64 = arith.constant -28 : i64
    %c_7_i64 = arith.constant -7 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.lshr %c_7_i64, %c4_i64 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.icmp "eq" %arg2, %c21_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %true, %1, %3 : i1, i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "uge" %c_28_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.urem %arg0, %c_6_i64 : i64
    %1 = llvm.icmp "ugt" %c_43_i64, %0 : i64
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
    %c_20_i64 = arith.constant -20 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.and %c_20_i64, %c50_i64 : i64
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
    %c_29_i64 = arith.constant -29 : i64
    %c41_i64 = arith.constant 41 : i64
    %c11_i64 = arith.constant 11 : i64
    %c9_i64 = arith.constant 9 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.or %c50_i64, %arg0 : i64
    %1 = llvm.xor %0, %c9_i64 : i64
    %2 = llvm.xor %c41_i64, %arg1 : i64
    %3 = llvm.lshr %c11_i64, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "sle" %arg0, %c_29_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c25_i64 = arith.constant 25 : i64
    %c9_i64 = arith.constant 9 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "ule" %c9_i64, %c41_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.lshr %c25_i64, %c_10_i64 : i64
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
    %c_28_i64 = arith.constant -28 : i64
    %c18_i64 = arith.constant 18 : i64
    %c13_i64 = arith.constant 13 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "uge" %c13_i64, %c_49_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %c_28_i64, %1 : i64
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
    %c_36_i64 = arith.constant -36 : i64
    %c26_i64 = arith.constant 26 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.srem %arg0, %c_47_i64 : i64
    %1 = llvm.sdiv %c26_i64, %arg2 : i64
    %2 = llvm.and %1, %c_36_i64 : i64
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
    %c_21_i64 = arith.constant -21 : i64
    %c4_i64 = arith.constant 4 : i64
    %c_27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.select %true, %0, %c_27_i64 : i1, i64
    %2 = llvm.xor %1, %c4_i64 : i64
    %3 = llvm.ashr %c_21_i64, %arg2 : i64
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
    %c_21_i64 = arith.constant -21 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "slt" %arg2, %c34_i64 : i64
    %2 = llvm.select %1, %arg1, %c_21_i64 : i1, i64
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
    %c_15_i64 = arith.constant -15 : i64
    %c_26_i64 = arith.constant -26 : i64
    %false = arith.constant false
    %c_39_i64 = arith.constant -39 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.ashr %arg0, %c_12_i64 : i64
    %1 = llvm.lshr %c_39_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.udiv %3, %c_26_i64 : i64
    %5 = llvm.xor %arg0, %c22_i64 : i64
    %6 = llvm.srem %c_15_i64, %5 : i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c_48_i64 = arith.constant -48 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.urem %c_49_i64, %arg2 : i64
    %2 = llvm.icmp "ugt" %c_44_i64, %c_48_i64 : i64
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
    %c_48_i64 = arith.constant -48 : i64
    %c28_i64 = arith.constant 28 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.srem %arg0, %c_10_i64 : i64
    %1 = llvm.srem %c28_i64, %0 : i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.sdiv %c_48_i64, %2 : i64
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
    %c_5_i64 = arith.constant -5 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.urem %c47_i64, %1 : i64
    %3 = llvm.sdiv %arg1, %c_5_i64 : i64
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
    %c_17_i64 = arith.constant -17 : i64
    %c18_i64 = arith.constant 18 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "slt" %c10_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %c18_i64, %3 : i64
    %5 = llvm.lshr %c_17_i64, %c43_i64 : i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.sdiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c19_i64 = arith.constant 19 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c44_i64 = arith.constant 44 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.srem %c44_i64, %c_40_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.srem %1, %c_22_i64 : i64
    %3 = llvm.srem %2, %c19_i64 : i64
    %4 = llvm.icmp "sgt" %3, %c_14_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.icmp "uge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "slt" %c_7_i64, %c_44_i64 : i64
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
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.srem %c36_i64, %c_18_i64 : i64
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
    %c_33_i64 = arith.constant -33 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.sdiv %0, %c_40_i64 : i64
    %4 = llvm.lshr %3, %c_33_i64 : i64
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
    %c_7_i64 = arith.constant -7 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "sgt" %c_7_i64, %c12_i64 : i64
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
    %c_9_i64 = arith.constant -9 : i64
    %c5_i64 = arith.constant 5 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ne" %c_40_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %arg0, %c5_i64 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.ashr %c_9_i64, %4 : i64
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
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.lshr %c_12_i64, %arg0 : i64
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
    %c_1_i64 = arith.constant -1 : i64
    %c_33_i64 = arith.constant -33 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %c_33_i64, %c_1_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %arg2, %5 : i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.urem %arg1, %c_24_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.and %arg0, %arg2 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.ashr %c_11_i64, %0 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.and %c_46_i64, %4 : i64
    %7 = llvm.icmp "slt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %c_3_i64, %1 : i64
    %5 = llvm.ashr %4, %3 : i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c_12_i64 = arith.constant -12 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sdiv %arg0, %c12_i64 : i64
    %1 = llvm.udiv %c_12_i64, %0 : i64
    %2 = llvm.urem %c_46_i64, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.urem %arg0, %arg2 : i64
    %5 = llvm.and %c_18_i64, %c_30_i64 : i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.xor %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %2, %c_40_i64 : i64
    %4 = llvm.and %c_39_i64, %3 : i64
    %5 = llvm.lshr %arg2, %c_39_i64 : i64
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
    %c_40_i64 = arith.constant -40 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.xor %c_9_i64, %arg0 : i64
    %1 = llvm.and %c_40_i64, %0 : i64
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
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "ult" %arg1, %arg2 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.sdiv %c_18_i64, %c15_i64 : i64
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
    %c_5_i64 = arith.constant -5 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %arg1, %arg2 : i64
    %3 = llvm.lshr %c_22_i64, %2 : i64
    %4 = llvm.icmp "sle" %c_44_i64, %c_5_i64 : i64
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
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %0, %c_8_i64 : i64
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
    %c_23_i64 = arith.constant -23 : i64
    %c45_i64 = arith.constant 45 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "ne" %c22_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %c45_i64, %c_23_i64 : i64
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
    %c_24_i64 = arith.constant -24 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "ult" %c49_i64, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %c_24_i64, %4 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.urem %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "ugt" %c_28_i64, %c_50_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %c_47_i64, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %2, %c_39_i64 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c_40_i64 = arith.constant -40 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.srem %arg0, %c33_i64 : i64
    %1 = llvm.lshr %c_40_i64, %0 : i64
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
    %c_28_i64 = arith.constant -28 : i64
    %c34_i64 = arith.constant 34 : i64
    %c46_i64 = arith.constant 46 : i64
    %c_6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %c46_i64, %c34_i64 : i64
    %2 = llvm.select %false, %c_6_i64, %1 : i1, i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.or %arg1, %c_28_i64 : i64
    %5 = llvm.icmp "slt" %4, %2 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.lshr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.xor %c_44_i64, %1 : i64
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
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %c_6_i64 : i64
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
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "slt" %3, %c_33_i64 : i64
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
    %c_16_i64 = arith.constant -16 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c43_i64 = arith.constant 43 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "sge" %c5_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %c43_i64 : i64
    %3 = llvm.select %2, %c_28_i64, %arg1 : i1, i64
    %4 = llvm.sdiv %arg2, %c_16_i64 : i64
    %5 = llvm.trunc %false : i1 to i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.ashr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
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
    %7 = llvm.icmp "sle" %6, %c_29_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %c_5_i64, %1 : i64
    %3 = llvm.xor %2, %c_46_i64 : i64
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
    %c_26_i64 = arith.constant -26 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.and %c_26_i64, %c_36_i64 : i64
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
    %c_35_i64 = arith.constant -35 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.urem %c_5_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %c_35_i64, %0 : i64
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
    %c_14_i64 = arith.constant -14 : i64
    %c49_i64 = arith.constant 49 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c19_i64 = arith.constant 19 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ugt" %c19_i64, %c43_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "eq" %c_50_i64, %c49_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.ashr %c_9_i64, %4 : i64
    %6 = llvm.udiv %c_14_i64, %c10_i64 : i64
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
    %c_20_i64 = arith.constant -20 : i64
    %c49_i64 = arith.constant 49 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %c_22_i64, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.select %arg0, %1, %3 : i1, i64
    %5 = llvm.sdiv %c_20_i64, %c24_i64 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "sge" %c49_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "ne" %c_35_i64, %c36_i64 : i64
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
    %c_20_i64 = arith.constant -20 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.and %c_20_i64, %c4_i64 : i64
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
    %c_41_i64 = arith.constant -41 : i64
    %c28_i64 = arith.constant 28 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.udiv %c28_i64, %c17_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.icmp "slt" %3, %c28_i64 : i64
    %5 = llvm.select %4, %3, %c_41_i64 : i1, i64
    %6 = llvm.xor %0, %5 : i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %c36_i64 = arith.constant 36 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c38_i64 = arith.constant 38 : i64
    %c_23_i64 = arith.constant -23 : i64
    %false = arith.constant false
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg1, %arg2 : i1, i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.urem %2, %c_23_i64 : i64
    %4 = llvm.icmp "ule" %c38_i64, %c_42_i64 : i64
    %5 = llvm.select %4, %c36_i64, %c_36_i64 : i1, i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %false = arith.constant false
    %c_17_i64 = arith.constant -17 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.urem %c_17_i64, %c_26_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    %5 = llvm.select %4, %c_21_i64, %arg0 : i1, i64
    %6 = llvm.trunc %4 : i1 to i64
    %7 = llvm.icmp "sle" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.urem %c_50_i64, %c_29_i64 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.icmp "slt" %c_13_i64, %c6_i64 : i64
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
    %c_8_i64 = arith.constant -8 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %arg1, %c6_i64 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "uge" %3, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %5, %c_8_i64 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.and %c_35_i64, %c_41_i64 : i64
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
    %c_12_i64 = arith.constant -12 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c33_i64 = arith.constant 33 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "uge" %c_19_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.or %c33_i64, %3 : i64
    %5 = llvm.urem %4, %2 : i64
    %6 = llvm.icmp "ne" %3, %5 : i64
    %7 = llvm.select %6, %c_46_i64, %c_12_i64 : i1, i64
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
    %c_5_i64 = arith.constant -5 : i64
    %c41_i64 = arith.constant 41 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %arg1, %c43_i64 : i64
    %2 = llvm.select %1, %0, %arg2 : i1, i64
    %3 = llvm.icmp "eq" %arg2, %c41_i64 : i64
    %4 = llvm.urem %c_5_i64, %arg1 : i64
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
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg2, %c_6_i64 : i64
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
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %c_10_i64 : i64
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
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c_44_i64, %1 : i64
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
    %c_8_i64 = arith.constant -8 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.ashr %c34_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %c_8_i64, %1 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.icmp "ne" %c7_i64, %c_8_i64 : i64
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
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.srem %c_46_i64, %arg0 : i64
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
    %c_45_i64 = arith.constant -45 : i64
    %true = arith.constant true
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.udiv %arg0, %c_6_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.sdiv %2, %c_45_i64 : i64
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
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %arg1, %c_19_i64 : i64
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
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.srem %arg0, %c_1_i64 : i64
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
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %c_12_i64, %arg0 : i64
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
    %c_29_i64 = arith.constant -29 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.sdiv %c_29_i64, %c_11_i64 : i64
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
    %c_37_i64 = arith.constant -37 : i64
    %c21_i64 = arith.constant 21 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ugt" %c21_i64, %c_12_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.udiv %c_37_i64, %3 : i64
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
    %c_45_i64 = arith.constant -45 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "eq" %c_45_i64, %0 : i64
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
    %c_28_i64 = arith.constant -28 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "eq" %c_40_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c_22_i64, %1 : i64
    %3 = llvm.ashr %c_28_i64, %arg1 : i64
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
    %c_8_i64 = arith.constant -8 : i64
    %c30_i64 = arith.constant 30 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %c_35_i64, %c48_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.sdiv %2, %c30_i64 : i64
    %4 = llvm.and %c_8_i64, %3 : i64
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
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.icmp "sle" %0, %c_13_i64 : i64
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
    %c_22_i64 = arith.constant -22 : i64
    %c1_i64 = arith.constant 1 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.lshr %c1_i64, %c_36_i64 : i64
    %1 = llvm.lshr %c_22_i64, %arg1 : i64
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
    %c_36_i64 = arith.constant -36 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.udiv %arg2, %c_36_i64 : i64
    %4 = llvm.icmp "slt" %c_5_i64, %3 : i64
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
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.xor %arg1, %arg1 : i64
    %3 = llvm.srem %c_17_i64, %2 : i64
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
    %c_16_i64 = arith.constant -16 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c_47_i64 = arith.constant -47 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %c_47_i64, %0 : i64
    %2 = llvm.ashr %c_35_i64, %arg0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.sdiv %arg1, %arg2 : i64
    %5 = llvm.icmp "ugt" %c_16_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.select %3, %6, %arg0 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c3_i64, %0 : i64
    %2 = llvm.lshr %c_41_i64, %1 : i64
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
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.lshr %0, %c4_i64 : i64
    %3 = llvm.srem %c_2_i64, %2 : i64
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
    %c_20_i64 = arith.constant -20 : i64
    %c8_i64 = arith.constant 8 : i64
    %false = arith.constant false
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.select %false, %arg2, %c8_i64 : i1, i64
    %2 = llvm.and %arg2, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %c3_i64, %4 : i64
    %6 = llvm.icmp "ugt" %5, %c_20_i64 : i64
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
    %c_24_i64 = arith.constant -24 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c12_i64 = arith.constant 12 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.and %c_39_i64, %arg0 : i64
    %1 = llvm.select %arg2, %c12_i64, %arg0 : i1, i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.srem %c_5_i64, %c_24_i64 : i64
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
    %c_47_i64 = arith.constant -47 : i64
    %false = arith.constant false
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "sge" %c43_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.lshr %c_47_i64, %3 : i64
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
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.or %c_48_i64, %0 : i64
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
    %c_30_i64 = arith.constant -30 : i64
    %c35_i64 = arith.constant 35 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.ashr %0, %arg2 : i64
    %3 = llvm.icmp "eq" %c35_i64, %2 : i64
    %4 = llvm.select %3, %2, %c_30_i64 : i1, i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.ashr %c_4_i64, %5 : i64
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
    %c_37_i64 = arith.constant -37 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.or %arg0, %c_26_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.icmp "sle" %4, %c_37_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.and %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c_22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "ule" %c41_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.select %true, %1, %arg0 : i1, i64
    %4 = llvm.icmp "ne" %1, %c_22_i64 : i64
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
    %c_29_i64 = arith.constant -29 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.and %c_19_i64, %arg0 : i64
    %1 = llvm.and %c_29_i64, %0 : i64
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
    %c_33_i64 = arith.constant -33 : i64
    %false = arith.constant false
    %c_32_i64 = arith.constant -32 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.lshr %c_32_i64, %c_23_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.xor %c_33_i64, %0 : i64
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
    %c_17_i64 = arith.constant -17 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.lshr %c_17_i64, %c_40_i64 : i64
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
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.lshr %arg0, %c_26_i64 : i64
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
    %c_37_i64 = arith.constant -37 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.xor %c_1_i64, %c_2_i64 : i64
    %3 = llvm.urem %arg2, %2 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.srem %0, %5 : i64
    %7 = llvm.icmp "sle" %6, %c_37_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "eq" %1, %c_14_i64 : i64
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
    %c_33_i64 = arith.constant -33 : i64
    %c20_i64 = arith.constant 20 : i64
    %true = arith.constant true
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.select %true, %arg0, %c_35_i64 : i1, i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.or %0, %c20_i64 : i64
    %5 = llvm.ashr %4, %c_33_i64 : i64
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
    %c_32_i64 = arith.constant -32 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %c16_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.xor %3, %c_25_i64 : i64
    %5 = llvm.icmp "sle" %4, %arg0 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.lshr %6, %c_32_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c41_i64 = arith.constant 41 : i64
    %c20_i64 = arith.constant 20 : i64
    %c25_i64 = arith.constant 25 : i64
    %c_20_i64 = arith.constant -20 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "sgt" %c_20_i64, %c44_i64 : i64
    %1 = llvm.ashr %c25_i64, %c20_i64 : i64
    %2 = llvm.select %0, %1, %c41_i64 : i1, i64
    %3 = llvm.lshr %1, %c_10_i64 : i64
    %4 = llvm.and %3, %c_35_i64 : i64
    %5 = llvm.srem %arg0, %2 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c13_i64 = arith.constant 13 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg0, %arg2 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.ashr %c_21_i64, %c13_i64 : i64
    %5 = llvm.icmp "eq" %4, %c_43_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.urem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.lshr %c39_i64, %c_20_i64 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "slt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.select %arg0, %c_23_i64, %arg1 : i1, i64
    %1 = llvm.icmp "sle" %0, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg2, %c_36_i64 : i64
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
    %c_18_i64 = arith.constant -18 : i64
    %c21_i64 = arith.constant 21 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c4_i64 = arith.constant 4 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.lshr %c4_i64, %c_31_i64 : i64
    %1 = llvm.ashr %c21_i64, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.select %arg1, %c_18_i64, %arg2 : i1, i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.udiv %4, %0 : i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.icmp "slt" %c_50_i64, %6 : i64
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
    %c_10_i64 = arith.constant -10 : i64
    %c40_i64 = arith.constant 40 : i64
    %c23_i64 = arith.constant 23 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %c23_i64, %c47_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %4, %c40_i64 : i64
    %6 = llvm.and %c_10_i64, %2 : i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %c6_i64 = arith.constant 6 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.xor %arg0, %c_7_i64 : i64
    %1 = llvm.xor %arg0, %c6_i64 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    %6 = llvm.sext %arg1 : i1 to i64
    %7 = llvm.select %5, %6, %c_35_i64 : i1, i64
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
    %c_41_i64 = arith.constant -41 : i64
    %c26_i64 = arith.constant 26 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "slt" %c38_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "eq" %c_41_i64, %1 : i64
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
    %c_42_i64 = arith.constant -42 : i64
    %c23_i64 = arith.constant 23 : i64
    %true = arith.constant true
    %0 = llvm.ashr %arg0, %arg2 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.select %true, %c23_i64, %c_42_i64 : i1, i64
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
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.ashr %1, %c_41_i64 : i64
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
    %c_41_i64 = arith.constant -41 : i64
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.select %true, %0, %arg0 : i1, i64
    %2 = llvm.srem %1, %c_41_i64 : i64
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
    %c_1_i64 = arith.constant -1 : i64
    %c6_i64 = arith.constant 6 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.lshr %c_2_i64, %arg0 : i64
    %1 = llvm.urem %c6_i64, %arg1 : i64
    %2 = llvm.icmp "ult" %1, %c_1_i64 : i64
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
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.srem %c_21_i64, %arg0 : i64
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
    %c_8_i64 = arith.constant -8 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.srem %arg0, %c_24_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.udiv %c_8_i64, %arg2 : i64
    %7 = llvm.or %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.xor %c_36_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %arg1 : i64
    %2 = llvm.select %1, %arg0, %c41_i64 : i1, i64
    %3 = llvm.lshr %c_36_i64, %arg0 : i64
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
    %c_3_i64 = arith.constant -3 : i64
    %c_37_i64 = arith.constant -37 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %c_37_i64, %2 : i64
    %4 = llvm.and %arg0, %c_3_i64 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "uge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.or %c30_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.xor %1, %c_17_i64 : i64
    %4 = llvm.srem %2, %c_14_i64 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ugt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %c7_i64 = arith.constant 7 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "eq" %arg1, %c9_i64 : i64
    %2 = llvm.xor %arg1, %c7_i64 : i64
    %3 = llvm.select %1, %2, %arg1 : i1, i64
    %4 = llvm.ashr %c_12_i64, %0 : i64
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
    %c_34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %c40_i64 = arith.constant 40 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.select %false, %c40_i64, %c37_i64 : i1, i64
    %1 = llvm.icmp "sge" %c_34_i64, %0 : i64
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
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.udiv %arg1, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.or %c_45_i64, %2 : i64
    %5 = llvm.udiv %arg0, %4 : i64
    %6 = llvm.ashr %5, %arg2 : i64
    %7 = llvm.xor %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.xor %arg0, %c21_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.sdiv %3, %c_2_i64 : i64
    %5 = llvm.udiv %arg1, %4 : i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.sdiv %6, %arg1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "uge" %c46_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg1, %c_50_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.srem %arg2, %c_44_i64 : i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.and %c_17_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.or %arg1, %c44_i64 : i64
    %4 = llvm.sdiv %c_1_i64, %3 : i64
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
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.ashr %arg0, %c_19_i64 : i64
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
    %c_12_i64 = arith.constant -12 : i64
    %c16_i64 = arith.constant 16 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.udiv %2, %c_3_i64 : i64
    %4 = llvm.srem %c16_i64, %c_12_i64 : i64
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
    %c_12_i64 = arith.constant -12 : i64
    %c4_i64 = arith.constant 4 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "ugt" %c4_i64, %c11_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.or %c47_i64, %1 : i64
    %4 = llvm.select %2, %c_12_i64, %3 : i1, i64
    %5 = llvm.zext %0 : i1 to i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.icmp "sge" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %false = arith.constant false
    %c_48_i64 = arith.constant -48 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.select %arg0, %c_18_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ule" %0, %c_48_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %arg2, %2 : i64
    %4 = llvm.select %false, %c_33_i64, %0 : i1, i64
    %5 = llvm.ashr %4, %2 : i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.xor %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %c25_i64 = arith.constant 25 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %c_22_i64, %0 : i64
    %2 = llvm.sdiv %c25_i64, %arg1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.lshr %c_18_i64, %arg1 : i64
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
    %c_39_i64 = arith.constant -39 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.urem %c13_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %1, %0, %c_39_i64 : i1, i64
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
    %c_44_i64 = arith.constant -44 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.select %1, %0, %c_50_i64 : i1, i64
    %3 = llvm.icmp "uge" %arg0, %c_44_i64 : i64
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
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %c_8_i64, %arg1 : i64
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
    %c_16_i64 = arith.constant -16 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.udiv %c_16_i64, %c_46_i64 : i64
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
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.xor %arg0, %4 : i64
    %6 = llvm.or %5, %c_19_i64 : i64
    %7 = llvm.and %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.and %c17_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "ugt" %c_14_i64, %c_11_i64 : i64
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
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.udiv %c_12_i64, %arg1 : i64
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
    %c_35_i64 = arith.constant -35 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.urem %arg0, %c_14_i64 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.urem %arg2, %2 : i64
    %4 = llvm.or %3, %2 : i64
    %5 = llvm.sdiv %c_35_i64, %4 : i64
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
    %c_36_i64 = arith.constant -36 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.lshr %c_18_i64, %c_31_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.xor %c_36_i64, %1 : i64
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
    %c_40_i64 = arith.constant -40 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c13_i64 = arith.constant 13 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %c_37_i64 : i64
    %2 = llvm.select %1, %arg2, %c13_i64 : i1, i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.select %3, %arg1, %c_5_i64 : i1, i64
    %5 = llvm.icmp "ule" %c_43_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.sdiv %6, %c_40_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.and %arg0, %c_40_i64 : i64
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
    %c_37_i64 = arith.constant -37 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c13_i64 = arith.constant 13 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.select %arg0, %c13_i64, %c_3_i64 : i1, i64
    %1 = llvm.srem %0, %c_33_i64 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "sgt" %c_37_i64, %arg1 : i64
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
    %c_24_i64 = arith.constant -24 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "ult" %c_24_i64, %c9_i64 : i64
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
    %c_47_i64 = arith.constant -47 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.srem %c_19_i64, %c23_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "uge" %arg0, %c_47_i64 : i64
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
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %c_49_i64, %0 : i64
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
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.or %arg0, %c_18_i64 : i64
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
    %c_36_i64 = arith.constant -36 : i64
    %c32_i64 = arith.constant 32 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sdiv %c27_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg1, %c_26_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.urem %3, %c_41_i64 : i64
    %5 = llvm.select %1, %c32_i64, %c_36_i64 : i1, i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c_39_i64 = arith.constant -39 : i64
    %c24_i64 = arith.constant 24 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.ashr %c_49_i64, %c18_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.udiv %c_39_i64, %c33_i64 : i64
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
    %c_40_i64 = arith.constant -40 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "slt" %arg0, %c_12_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %c_40_i64, %3 : i64
    %5 = llvm.lshr %arg1, %arg1 : i64
    %6 = llvm.ashr %c43_i64, %5 : i64
    %7 = llvm.select %4, %6, %1 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_18_i64 = arith.constant -18 : i64
    %c39_i64 = arith.constant 39 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.xor %c17_i64, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.lshr %c39_i64, %c_18_i64 : i64
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
    %c_8_i64 = arith.constant -8 : i64
    %c_34_i64 = arith.constant -34 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %c21_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %arg2, %c_34_i64 : i64
    %5 = llvm.lshr %4, %c_8_i64 : i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c_3_i64 = arith.constant -3 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.lshr %c39_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %c_3_i64 : i64
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
    %c_6_i64 = arith.constant -6 : i64
    %c13_i64 = arith.constant 13 : i64
    %c19_i64 = arith.constant 19 : i64
    %c39_i64 = arith.constant 39 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ne" %arg0, %c_40_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %c39_i64, %1 : i64
    %3 = llvm.udiv %c13_i64, %c_6_i64 : i64
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
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.ashr %0, %c_20_i64 : i64
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
    %c_42_i64 = arith.constant -42 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.udiv %arg0, %c13_i64 : i64
    %1 = llvm.sdiv %c_6_i64, %0 : i64
    %2 = llvm.srem %1, %c_42_i64 : i64
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
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.sdiv %c12_i64, %c_12_i64 : i64
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
    %c_9_i64 = arith.constant -9 : i64
    %c_34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ult" %0, %c_34_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %c_9_i64, %arg0 : i64
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
    %c_8_i64 = arith.constant -8 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %c_31_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.icmp "ule" %3, %arg1 : i64
    %5 = llvm.select %4, %c_8_i64, %c_8_i64 : i1, i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c13_i64 = arith.constant 13 : i64
    %true = arith.constant true
    %c_5_i64 = arith.constant -5 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %c46_i64 : i64
    %2 = llvm.udiv %1, %c_5_i64 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.select %true, %c13_i64, %c_28_i64 : i1, i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %c7_i64, %c_11_i64 : i64
    %2 = llvm.icmp "sgt" %c_26_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.srem %1, %1 : i64
    %6 = llvm.sdiv %c_22_i64, %5 : i64
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
    %c_12_i64 = arith.constant -12 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %true, %c_12_i64, %0 : i1, i64
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
    %c_41_i64 = arith.constant -41 : i64
    %true = arith.constant true
    %c40_i64 = arith.constant 40 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.and %c40_i64, %c_39_i64 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.urem %0, %arg1 : i64
    %3 = llvm.select %true, %1, %2 : i1, i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.icmp "ne" %5, %arg2 : i64
    %7 = llvm.select %6, %0, %c_41_i64 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %c34_i64 = arith.constant 34 : i64
    %c16_i64 = arith.constant 16 : i64
    %false = arith.constant false
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.select %false, %c_29_i64, %arg0 : i1, i64
    %1 = llvm.select %false, %arg1, %c_5_i64 : i1, i64
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
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %0, %c_21_i64 : i64
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
    %c_27_i64 = arith.constant -27 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "eq" %c_27_i64, %c49_i64 : i64
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
    %c_36_i64 = arith.constant -36 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.srem %2, %c13_i64 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.icmp "eq" %4, %c_36_i64 : i64
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
    %c_50_i64 = arith.constant -50 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.and %arg1, %c_50_i64 : i64
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
    %c_45_i64 = arith.constant -45 : i64
    %false = arith.constant false
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.select %false, %c_30_i64, %arg0 : i1, i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.srem %0, %c_45_i64 : i64
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
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.xor %arg0, %c_40_i64 : i64
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
    %c_15_i64 = arith.constant -15 : i64
    %c_7_i64 = arith.constant -7 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ne" %c_27_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.sdiv %c_7_i64, %2 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    %6 = llvm.and %arg0, %c23_i64 : i64
    %7 = llvm.select %5, %c_15_i64, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "sle" %arg0, %c_6_i64 : i64
    %1 = llvm.select %0, %arg1, %c_26_i64 : i1, i64
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
    %c_15_i64 = arith.constant -15 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %c35_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.srem %arg0, %c_29_i64 : i64
    %3 = llvm.icmp "sge" %arg2, %arg2 : i64
    %4 = llvm.select %3, %c_15_i64, %arg1 : i1, i64
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
    %c_46_i64 = arith.constant -46 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "ult" %c_25_i64, %c29_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %c_43_i64, %1 : i64
    %3 = llvm.icmp "slt" %2, %c_46_i64 : i64
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
    %c_27_i64 = arith.constant -27 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.ashr %c_42_i64, %c38_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.xor %c_27_i64, %4 : i64
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
    %c_14_i64 = arith.constant -14 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.srem %c_14_i64, %c49_i64 : i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.ashr %c_39_i64, %5 : i64
    %7 = llvm.lshr %c_29_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.xor %c_36_i64, %arg1 : i64
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
    %c_4_i64 = arith.constant -4 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.xor %c36_i64, %arg0 : i64
    %2 = llvm.and %arg1, %c_23_i64 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    %5 = llvm.sdiv %c_4_i64, %2 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.icmp "ne" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c12_i64 = arith.constant 12 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.ashr %c12_i64, %c_47_i64 : i64
    %1 = llvm.icmp "ult" %c_16_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %c_7_i64, %0 : i64
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
    %c_8_i64 = arith.constant -8 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.and %c26_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %0, %arg0 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.lshr %3, %arg1 : i64
    %5 = llvm.sdiv %arg0, %c_8_i64 : i64
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
    %c_11_i64 = arith.constant -11 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c36_i64 = arith.constant 36 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %arg0, %c36_i64 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.and %2, %c_21_i64 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.or %4, %c_11_i64 : i64
    %6 = llvm.srem %5, %arg1 : i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "uge" %arg0, %c_22_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c_10_i64, %arg1 : i64
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
    %c_43_i64 = arith.constant -43 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.sdiv %c_42_i64, %c21_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    %3 = llvm.icmp "eq" %c_43_i64, %0 : i64
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
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "sgt" %arg0, %c_30_i64 : i64
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
    %c_13_i64 = arith.constant -13 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %c31_i64, %0 : i64
    %2 = llvm.or %c_32_i64, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.select %arg0, %c_13_i64, %c35_i64 : i1, i64
    %5 = llvm.or %4, %c37_i64 : i64
    %6 = llvm.xor %arg2, %5 : i64
    %7 = llvm.icmp "sgt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c19_i64 = arith.constant 19 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %arg2, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.urem %c_17_i64, %c_38_i64 : i64
    %5 = llvm.srem %4, %c19_i64 : i64
    %6 = llvm.or %5, %c_21_i64 : i64
    %7 = llvm.urem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.or %c_15_i64, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.udiv %c_15_i64, %c30_i64 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.srem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %c14_i64 = arith.constant 14 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.urem %c_3_i64, %arg0 : i64
    %1 = llvm.xor %c14_i64, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.ashr %4, %3 : i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    %7 = llvm.select %6, %c_31_i64, %5 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %true = arith.constant true
    %c45_i64 = arith.constant 45 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.urem %c_43_i64, %arg0 : i64
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
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.and %c_7_i64, %arg0 : i64
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
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "sle" %c_22_i64, %arg0 : i64
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
    %c_31_i64 = arith.constant -31 : i64
    %c_3_i64 = arith.constant -3 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %c_3_i64, %c42_i64 : i64
    %1 = llvm.icmp "ugt" %0, %c_31_i64 : i64
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
    %c_14_i64 = arith.constant -14 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "ne" %c47_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.trunc %3 : i1 to i64
    %6 = llvm.ashr %5, %c_14_i64 : i64
    %7 = llvm.lshr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %c_43_i64 = arith.constant -43 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %c_43_i64, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.select %2, %arg0, %4 : i1, i64
    %6 = llvm.icmp "ule" %5, %c_30_i64 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.udiv %arg1, %c_40_i64 : i64
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
    %c_38_i64 = arith.constant -38 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.udiv %c0_i64, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %c_37_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.xor %c_38_i64, %2 : i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c40_i64 = arith.constant 40 : i64
    %c30_i64 = arith.constant 30 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %c30_i64, %c_34_i64 : i64
    %1 = llvm.ashr %0, %c40_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sge" %c_33_i64, %2 : i64
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
    %c_38_i64 = arith.constant -38 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %0, %arg0 : i64
    %4 = llvm.lshr %3, %c_38_i64 : i64
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
    %c_47_i64 = arith.constant -47 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.lshr %arg0, %c_50_i64 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.udiv %c0_i64, %1 : i64
    %3 = llvm.srem %arg0, %1 : i64
    %4 = llvm.sdiv %arg2, %3 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.and %0, %5 : i64
    %7 = llvm.icmp "sge" %c_47_i64, %6 : i64
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
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "ule" %c_30_i64, %arg0 : i64
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
    %c_28_i64 = arith.constant -28 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.ashr %arg1, %c_26_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %c_28_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %5, %0 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.select %2, %0, %arg2 : i1, i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %arg2, %c_13_i64 : i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %false = arith.constant false
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %c_28_i64, %0 : i64
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
    %c_15_i64 = arith.constant -15 : i64
    %false = arith.constant false
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %arg1, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.sdiv %5, %c_15_i64 : i64
    %7 = llvm.icmp "slt" %c_50_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c_7_i64 = arith.constant -7 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "ult" %c_2_i64, %c35_i64 : i64
    %1 = llvm.icmp "sgt" %c_5_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.xor %c_7_i64, %3 : i64
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
    %c_41_i64 = arith.constant -41 : i64
    %c35_i64 = arith.constant 35 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "sgt" %c_9_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %c35_i64, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.icmp "sge" %c_41_i64, %c40_i64 : i64
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
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg1, %c_35_i64 : i64
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
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.udiv %0, %c_4_i64 : i64
    %5 = llvm.and %arg2, %4 : i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.or %arg0, %c_48_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %c36_i64, %c_8_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.udiv %arg1, %5 : i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_4_i64 = arith.constant -4 : i64
    %c26_i64 = arith.constant 26 : i64
    %true = arith.constant true
    %c28_i64 = arith.constant 28 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.lshr %c28_i64, %c_14_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.select %true, %arg0, %c26_i64 : i1, i64
    %3 = llvm.udiv %1, %arg1 : i64
    %4 = llvm.urem %c_4_i64, %3 : i64
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
    %c_48_i64 = arith.constant -48 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %c18_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "ule" %c_48_i64, %0 : i64
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
    %c_11_i64 = arith.constant -11 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.ashr %c_10_i64, %arg0 : i64
    %1 = llvm.sdiv %c_11_i64, %0 : i64
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
    %c_29_i64 = arith.constant -29 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c26_i64 = arith.constant 26 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ule" %c_6_i64, %arg0 : i64
    %1 = llvm.xor %arg1, %arg0 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.select %0, %2, %c26_i64 : i1, i64
    %4 = llvm.lshr %c_15_i64, %c_49_i64 : i64
    %5 = llvm.or %4, %c_29_i64 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.urem %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %arg1, %arg1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %c_50_i64, %arg2 : i64
    %6 = llvm.xor %5, %c29_i64 : i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c_49_i64 = arith.constant -49 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.ashr %c_15_i64, %c_49_i64 : i64
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
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.ashr %c_30_i64, %arg0 : i64
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
    %c_2_i64 = arith.constant -2 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %c_6_i64, %c45_i64 : i64
    %1 = llvm.xor %c_16_i64, %0 : i64
    %2 = llvm.udiv %1, %c_2_i64 : i64
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
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.ashr %c_39_i64, %arg0 : i64
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
    %c_43_i64 = arith.constant -43 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.lshr %c_18_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.sdiv %c_43_i64, %arg0 : i64
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
    %c_2_i64 = arith.constant -2 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.lshr %arg0, %c_36_i64 : i64
    %1 = llvm.sdiv %arg0, %c_41_i64 : i64
    %2 = llvm.and %1, %c_2_i64 : i64
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
    %c_24_i64 = arith.constant -24 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.lshr %c_12_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %c_24_i64, %1 : i64
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
    %c_23_i64 = arith.constant -23 : i64
    %false = arith.constant false
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %false, %arg0, %c20_i64 : i1, i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.urem %c_23_i64, %c34_i64 : i64
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
    %c_25_i64 = arith.constant -25 : i64
    %c18_i64 = arith.constant 18 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sdiv %arg0, %c27_i64 : i64
    %1 = llvm.icmp "sle" %arg1, %c18_i64 : i64
    %2 = llvm.sdiv %c_25_i64, %arg2 : i64
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
    %c_6_i64 = arith.constant -6 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.udiv %c39_i64, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.icmp "sge" %c_6_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c_6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "eq" %c_6_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c_43_i64, %2 : i64
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
    %c_8_i64 = arith.constant -8 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg2 : i64
    %2 = llvm.udiv %1, %c_46_i64 : i64
    %3 = llvm.udiv %arg1, %c_8_i64 : i64
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
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.sdiv %c_7_i64, %arg0 : i64
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
    %c_21_i64 = arith.constant -21 : i64
    %c10_i64 = arith.constant 10 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "ult" %c10_i64, %c_20_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.srem %arg1, %arg2 : i64
    %3 = llvm.icmp "uge" %2, %c19_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %c_21_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.select %0, %1, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.icmp "slt" %c_38_i64, %2 : i64
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
    %c_37_i64 = arith.constant -37 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.lshr %arg1, %c_37_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.and %3, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.ashr %5, %c38_i64 : i64
    %7 = llvm.icmp "ne" %c_11_i64, %6 : i64
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
    %c_48_i64 = arith.constant -48 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.ashr %c37_i64, %arg0 : i64
    %1 = llvm.or %0, %c_48_i64 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.urem %c_16_i64, %2 : i64
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
    %c_10_i64 = arith.constant -10 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.ashr %c_25_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c_17_i64, %arg1 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.sdiv %c_10_i64, %0 : i64
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
    %c_43_i64 = arith.constant -43 : i64
    %c23_i64 = arith.constant 23 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "slt" %c23_i64, %c_37_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %c_43_i64 : i64
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
    %c_49_i64 = arith.constant -49 : i64
    %c42_i64 = arith.constant 42 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c21_i64 = arith.constant 21 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.and %c21_i64, %c_41_i64 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %2, %c_8_i64 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    %5 = llvm.select %4, %c42_i64, %0 : i1, i64
    %6 = llvm.lshr %0, %5 : i64
    %7 = llvm.srem %6, %c_49_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "eq" %c_32_i64, %arg1 : i64
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
    %c_1_i64 = arith.constant -1 : i64
    %c40_i64 = arith.constant 40 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %c24_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %arg2, %c40_i64 : i64
    %5 = llvm.ashr %c_1_i64, %c36_i64 : i64
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
    %c_30_i64 = arith.constant -30 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.urem %c_30_i64, %c4_i64 : i64
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
    %c_30_i64 = arith.constant -30 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.urem %1, %arg2 : i64
    %4 = llvm.and %c15_i64, %arg0 : i64
    %5 = llvm.lshr %4, %c_30_i64 : i64
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
    %c_17_i64 = arith.constant -17 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg0, %c43_i64 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "sge" %4, %c_17_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ult" %6, %c5_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %false = arith.constant false
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.sdiv %4, %c_22_i64 : i64
    %6 = llvm.and %5, %arg0 : i64
    %7 = llvm.urem %c3_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.urem %c_50_i64, %c_15_i64 : i64
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
    %c_19_i64 = arith.constant -19 : i64
    %true = arith.constant true
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.select %arg2, %c_19_i64, %1 : i1, i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c_12_i64 = arith.constant -12 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "ugt" %arg0, %c_37_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.icmp "sge" %c_12_i64, %c_27_i64 : i64
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
    %c_11_i64 = arith.constant -11 : i64
    %c31_i64 = arith.constant 31 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.and %c31_i64, %c3_i64 : i64
    %1 = llvm.or %0, %c_11_i64 : i64
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
    %c_38_i64 = arith.constant -38 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.and %arg0, %c_38_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.xor %c_47_i64, %3 : i64
    %5 = llvm.urem %0, %0 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.udiv %c_6_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.select %arg2, %2, %1 : i1, i64
    %4 = llvm.select %arg2, %2, %3 : i1, i64
    %5 = llvm.or %4, %0 : i64
    %6 = llvm.or %5, %c_41_i64 : i64
    %7 = llvm.srem %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c2_i64 = arith.constant 2 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %c_43_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %arg1, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %c_30_i64, %c2_i64 : i64
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
    %c_13_i64 = arith.constant -13 : i64
    %c25_i64 = arith.constant 25 : i64
    %c37_i64 = arith.constant 37 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "sge" %arg0, %c_4_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg1, %c37_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.srem %c25_i64, %2 : i64
    %5 = llvm.udiv %c_13_i64, %arg2 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.icmp "ult" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %c11_i64 = arith.constant 11 : i64
    %c46_i64 = arith.constant 46 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c13_i64 = arith.constant 13 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.lshr %c13_i64, %c_36_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.lshr %arg0, %c46_i64 : i64
    %3 = llvm.udiv %2, %c11_i64 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    %6 = llvm.select %5, %1, %c_15_i64 : i1, i64
    %7 = llvm.icmp "ult" %c_4_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c13_i64 = arith.constant 13 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.urem %c_21_i64, %c11_i64 : i64
    %1 = llvm.icmp "slt" %0, %c_31_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %c13_i64, %arg0 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "uge" %c_49_i64, %c_44_i64 : i64
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
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.srem %arg0, %c_25_i64 : i64
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
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.srem %c_41_i64, %arg0 : i64
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
    %c_17_i64 = arith.constant -17 : i64
    %c17_i64 = arith.constant 17 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.lshr %c_17_i64, %arg0 : i64
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
    %c_27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.select %false, %c_27_i64, %1 : i1, i64
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
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.ashr %arg0, %c_46_i64 : i64
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
    %c_32_i64 = arith.constant -32 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %arg1, %c_22_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %c_28_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ne" %6, %c_32_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "eq" %c_12_i64, %arg0 : i64
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
    %c_21_i64 = arith.constant -21 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %c_8_i64, %0 : i64
    %2 = llvm.select %1, %c_14_i64, %arg1 : i1, i64
    %3 = llvm.icmp "ule" %arg2, %c_21_i64 : i64
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
    %c_32_i64 = arith.constant -32 : i64
    %c12_i64 = arith.constant 12 : i64
    %c26_i64 = arith.constant 26 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %c26_i64, %c12_i64 : i64
    %2 = llvm.sdiv %c46_i64, %1 : i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.or %4, %4 : i64
    %6 = llvm.lshr %3, %c_32_i64 : i64
    %7 = llvm.urem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %false = arith.constant false
    %c21_i64 = arith.constant 21 : i64
    %c11_i64 = arith.constant 11 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.urem %c11_i64, %c_48_i64 : i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.sdiv %c21_i64, %2 : i64
    %4 = llvm.sdiv %3, %arg0 : i64
    %5 = llvm.srem %4, %c_12_i64 : i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.lshr %1, %c_29_i64 : i64
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
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.xor %c_6_i64, %arg0 : i64
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
    %c_30_i64 = arith.constant -30 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "slt" %c8_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.icmp "sge" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ne" %4, %c_30_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c_7_i64 = arith.constant -7 : i64
    %true = arith.constant true
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.urem %0, %c_2_i64 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.xor %0, %arg2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.select %true, %arg1, %c_7_i64 : i1, i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "ne" %6, %c13_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c31_i64 = arith.constant 31 : i64
    %c33_i64 = arith.constant 33 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.udiv %arg0, %c47_i64 : i64
    %1 = llvm.urem %c33_i64, %c31_i64 : i64
    %2 = llvm.and %c_40_i64, %arg1 : i64
    %3 = llvm.icmp "sgt" %2, %arg2 : i64
    %4 = llvm.select %3, %0, %arg1 : i1, i64
    %5 = llvm.and %c_33_i64, %4 : i64
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
    %c_15_i64 = arith.constant -15 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.lshr %c_15_i64, %c34_i64 : i64
    %4 = llvm.ashr %c_48_i64, %3 : i64
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
    %c_45_i64 = arith.constant -45 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.select %arg1, %2, %c8_i64 : i1, i64
    %4 = llvm.srem %3, %c_45_i64 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.urem %4, %c4_i64 : i64
    %7 = llvm.lshr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c_45_i64 = arith.constant -45 : i64
    %false = arith.constant false
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.or %arg1, %c_8_i64 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.sdiv %c_45_i64, %c_6_i64 : i64
    %3 = llvm.icmp "sge" %c_2_i64, %0 : i64
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
    %c_35_i64 = arith.constant -35 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "uge" %c_28_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.xor %c_35_i64, %arg0 : i64
    %7 = llvm.or %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %c38_i64 = arith.constant 38 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.udiv %c38_i64, %c_31_i64 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.and %arg1, %c_34_i64 : i64
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
    %c_47_i64 = arith.constant -47 : i64
    %c37_i64 = arith.constant 37 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.sdiv %c37_i64, %c45_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %c_47_i64, %c50_i64 : i64
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
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.and %c_9_i64, %arg1 : i64
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
    %c_36_i64 = arith.constant -36 : i64
    %c42_i64 = arith.constant 42 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.and %arg0, %c_8_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %c_47_i64, %3 : i64
    %5 = llvm.icmp "ule" %c42_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "slt" %6, %c_36_i64 : i64
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
    %c_31_i64 = arith.constant -31 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.select %arg2, %c_44_i64, %arg1 : i1, i64
    %3 = llvm.xor %2, %c_31_i64 : i64
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
    %c_18_i64 = arith.constant -18 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.ashr %c_18_i64, %c39_i64 : i64
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
    %c_21_i64 = arith.constant -21 : i64
    %c48_i64 = arith.constant 48 : i64
    %c42_i64 = arith.constant 42 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.select %arg0, %arg1, %c_24_i64 : i1, i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.icmp "slt" %c42_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %c48_i64, %c_21_i64 : i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.xor %c_37_i64, %arg0 : i64
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
    %c_29_i64 = arith.constant -29 : i64
    %c_3_i64 = arith.constant -3 : i64
    %c35_i64 = arith.constant 35 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.urem %arg2, %c35_i64 : i64
    %2 = llvm.lshr %1, %c_3_i64 : i64
    %3 = llvm.icmp "sgt" %c36_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %arg2, %c_29_i64 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.select %arg0, %c_33_i64, %c_16_i64 : i1, i64
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
    %c_31_i64 = arith.constant -31 : i64
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
    %6 = llvm.or %c_31_i64, %3 : i64
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
    %c_5_i64 = arith.constant -5 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "eq" %arg0, %c_17_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c_5_i64, %1 : i64
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
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.udiv %c_44_i64, %arg0 : i64
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
    %c_29_i64 = arith.constant -29 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.sdiv %c_2_i64, %c24_i64 : i64
    %1 = llvm.or %c_31_i64, %0 : i64
    %2 = llvm.select %arg0, %0, %c_35_i64 : i1, i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.srem %5, %0 : i64
    %7 = llvm.icmp "sgt" %6, %c_29_i64 : i64
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
    %c_24_i64 = arith.constant -24 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %c23_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ne" %c_24_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %c50_i64 = arith.constant 50 : i64
    %c32_i64 = arith.constant 32 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %c21_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.and %3, %c_17_i64 : i64
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
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "sle" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %1 : i64
    %6 = llvm.select %5, %c_9_i64, %arg1 : i1, i64
    %7 = llvm.and %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c_40_i64 = arith.constant -40 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c_2_i64, %0 : i64
    %2 = llvm.urem %arg0, %0 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.select %1, %3, %arg0 : i1, i64
    %5 = llvm.icmp "uge" %c_40_i64, %c_34_i64 : i64
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
    %c_22_i64 = arith.constant -22 : i64
    %c4_i64 = arith.constant 4 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.select %arg0, %arg1, %c_14_i64 : i1, i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "slt" %c_4_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %c_19_i64, %c4_i64 : i64
    %6 = llvm.select %5, %arg1, %c_22_i64 : i1, i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.srem %c_5_i64, %1 : i64
    %3 = llvm.ashr %c_48_i64, %c48_i64 : i64
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
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %0 : i64
    %3 = llvm.icmp "ne" %2, %c_12_i64 : i64
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
    %c_24_i64 = arith.constant -24 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.lshr %c_20_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    %4 = llvm.select %3, %arg2, %c_24_i64 : i1, i64
    %5 = llvm.icmp "ult" %4, %1 : i64
    %6 = llvm.select %5, %c8_i64, %c_24_i64 : i1, i64
    %7 = llvm.and %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %c_25_i64 = arith.constant -25 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.sdiv %1, %c_48_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.or %c_25_i64, %3 : i64
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
    %c_4_i64 = arith.constant -4 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.or %c_19_i64, %arg2 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "sle" %4, %c_4_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.xor %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c_6_i64 = arith.constant -6 : i64
    %c41_i64 = arith.constant 41 : i64
    %false = arith.constant false
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %false, %c20_i64, %arg0 : i1, i64
    %1 = llvm.xor %c41_i64, %c_6_i64 : i64
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
    %c_3_i64 = arith.constant -3 : i64
    %c43_i64 = arith.constant 43 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.sdiv %c_32_i64, %c1_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.icmp "sgt" %2, %c_3_i64 : i64
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
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "sgt" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %arg0, %1, %1 : i1, i64
    %3 = llvm.select %arg2, %arg1, %1 : i1, i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.icmp "eq" %4, %c_43_i64 : i64
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
    %c_39_i64 = arith.constant -39 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.urem %c21_i64, %c_39_i64 : i64
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
    %c_25_i64 = arith.constant -25 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.select %2, %0, %1 : i1, i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.urem %0, %4 : i64
    %6 = llvm.lshr %c_11_i64, %c_25_i64 : i64
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
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.udiv %c49_i64, %2 : i64
    %4 = llvm.select %arg1, %c_5_i64, %3 : i1, i64
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
    %c_26_i64 = arith.constant -26 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.srem %c_16_i64, %c10_i64 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.sdiv %1, %c_41_i64 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.sdiv %c_41_i64, %c_26_i64 : i64
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
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.srem %c_42_i64, %arg0 : i64
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
    %c_42_i64 = arith.constant -42 : i64
    %true = arith.constant true
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %true, %1, %c_42_i64 : i1, i64
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
    %c_31_i64 = arith.constant -31 : i64
    %c8_i64 = arith.constant 8 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.sdiv %arg0, %c43_i64 : i64
    %1 = llvm.icmp "sle" %0, %c8_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %c_31_i64, %c19_i64 : i64
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
    %c_9_i64 = arith.constant -9 : i64
    %c40_i64 = arith.constant 40 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.sdiv %c40_i64, %c_41_i64 : i64
    %1 = llvm.xor %0, %c_9_i64 : i64
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
    %c_40_i64 = arith.constant -40 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.lshr %c_31_i64, %arg0 : i64
    %1 = llvm.srem %0, %c_46_i64 : i64
    %2 = llvm.urem %1, %c_22_i64 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.or %3, %c_40_i64 : i64
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
    %c_24_i64 = arith.constant -24 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.and %c_24_i64, %c_11_i64 : i64
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
    %c_30_i64 = arith.constant -30 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "slt" %c_30_i64, %c_28_i64 : i64
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
    %c_24_i64 = arith.constant -24 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c_17_i64, %c_24_i64 : i1, i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.srem %arg0, %arg1 : i64
    %4 = llvm.select %0, %1, %arg2 : i1, i64
    %5 = llvm.udiv %c_24_i64, %4 : i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.urem %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c22_i64 = arith.constant 22 : i64
    %c44_i64 = arith.constant 44 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %c44_i64, %c22_i64 : i64
    %2 = llvm.icmp "sle" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.udiv %3, %1 : i64
    %6 = llvm.select %4, %5, %c_40_i64 : i1, i64
    %7 = llvm.icmp "ne" %6, %3 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %c_21_i64, %c_32_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.select %1, %arg1, %c_41_i64 : i1, i64
    %3 = llvm.sdiv %c_12_i64, %arg1 : i64
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
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "ugt" %c50_i64, %c_19_i64 : i64
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
    %c_29_i64 = arith.constant -29 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.urem %c31_i64, %c_29_i64 : i64
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
    %c_34_i64 = arith.constant -34 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.xor %c_34_i64, %c_41_i64 : i64
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
    %c_24_i64 = arith.constant -24 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %c27_i64, %0 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.xor %3, %0 : i64
    %5 = llvm.udiv %c_24_i64, %3 : i64
    %6 = llvm.urem %arg1, %5 : i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %arg2, %c_1_i64, %2 : i1, i64
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
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.lshr %c_2_i64, %0 : i64
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
    %c_22_i64 = arith.constant -22 : i64
    %c26_i64 = arith.constant 26 : i64
    %c32_i64 = arith.constant 32 : i64
    %true = arith.constant true
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.lshr %c11_i64, %arg0 : i64
    %1 = llvm.lshr %c32_i64, %c26_i64 : i64
    %2 = llvm.icmp "eq" %arg1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %arg2, %arg1 : i64
    %5 = llvm.sdiv %4, %c_22_i64 : i64
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
    %c_49_i64 = arith.constant -49 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %c_49_i64 : i64
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
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.or %1, %c_5_i64 : i64
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
    %c_19_i64 = arith.constant -19 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.ashr %c_9_i64, %c_29_i64 : i64
    %1 = llvm.udiv %c_19_i64, %0 : i64
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
    %c_35_i64 = arith.constant -35 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.lshr %c_35_i64, %c_19_i64 : i64
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
    %c_15_i64 = arith.constant -15 : i64
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.select %false, %c36_i64, %arg1 : i1, i64
    %2 = llvm.udiv %arg2, %1 : i64
    %3 = llvm.and %arg2, %1 : i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.sdiv %4, %c_15_i64 : i64
    %6 = llvm.or %2, %5 : i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %c8_i64 = arith.constant 8 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %c42_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c_49_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg0, %arg1 : i64
    %4 = llvm.select %1, %3, %c8_i64 : i1, i64
    %5 = llvm.icmp "ne" %4, %c_32_i64 : i64
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
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.ashr %0, %c_1_i64 : i64
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
    %c_43_i64 = arith.constant -43 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.select %arg0, %1, %arg2 : i1, i64
    %3 = llvm.srem %c_47_i64, %c_43_i64 : i64
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
    %c_48_i64 = arith.constant -48 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "ugt" %c47_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.and %2, %c_48_i64 : i64
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
    %c_7_i64 = arith.constant -7 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.srem %arg0, %c_47_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.and %1, %arg2 : i64
    %5 = llvm.icmp "ugt" %4, %c_7_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c_38_i64 = arith.constant -38 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.select %2, %arg2, %c_38_i64 : i1, i64
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
    %c_7_i64 = arith.constant -7 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %c_7_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c39_i64 = arith.constant 39 : i64
    %c26_i64 = arith.constant 26 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.lshr %0, %c41_i64 : i64
    %3 = llvm.udiv %c26_i64, %c39_i64 : i64
    %4 = llvm.sdiv %2, %c_3_i64 : i64
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
    %c_12_i64 = arith.constant -12 : i64
    %c0_i64 = arith.constant 0 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.and %c27_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.lshr %arg2, %c0_i64 : i64
    %3 = llvm.icmp "sge" %2, %c0_i64 : i64
    %4 = llvm.or %0, %c_12_i64 : i64
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
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %c_38_i64, %0 : i64
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
    %c_5_i64 = arith.constant -5 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.icmp "ugt" %arg1, %c_49_i64 : i64
    %4 = llvm.select %3, %arg0, %c_5_i64 : i1, i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.and %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %true = arith.constant true
    %c50_i64 = arith.constant 50 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.lshr %c50_i64, %c_11_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %2, %c_30_i64 : i64
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
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %arg0, %c_27_i64 : i64
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
    %c_27_i64 = arith.constant -27 : i64
    %c_12_i64 = arith.constant -12 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "ugt" %c6_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %c_12_i64 : i1, i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.select %0, %2, %1 : i1, i64
    %4 = llvm.or %c_2_i64, %3 : i64
    %5 = llvm.icmp "uge" %c_27_i64, %2 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sle" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %c_28_i64, %arg1 : i64
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
    %c_48_i64 = arith.constant -48 : i64
    %c40_i64 = arith.constant 40 : i64
    %c_10_i64 = arith.constant -10 : i64
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %true, %c_10_i64, %c40_i64 : i1, i64
    %2 = llvm.or %arg2, %c_48_i64 : i64
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
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.sdiv %c_33_i64, %arg0 : i64
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
    %c_35_i64 = arith.constant -35 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "ugt" %c_50_i64, %c11_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %arg0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sge" %arg1, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %5, %c_35_i64 : i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %c_6_i64, %c_15_i64 : i64
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
    %c_3_i64 = arith.constant -3 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.srem %c_22_i64, %c37_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %arg1 : i64
    %4 = llvm.icmp "eq" %c_3_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.ashr %2, %5 : i64
    %7 = llvm.icmp "uge" %c_32_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_18_i64 = arith.constant -18 : i64
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
    %7 = llvm.or %6, %c_18_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "eq" %c_5_i64, %c9_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %c_32_i64 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.srem %c_48_i64, %3 : i64
    %5 = llvm.icmp "slt" %4, %arg0 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.and %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c2_i64 = arith.constant 2 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.sdiv %c_22_i64, %c_24_i64 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.or %c2_i64, %arg2 : i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.ashr %c_27_i64, %0 : i64
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
    %c_13_i64 = arith.constant -13 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    %2 = llvm.and %c47_i64, %1 : i64
    %3 = llvm.srem %c_27_i64, %c_13_i64 : i64
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
    %c_45_i64 = arith.constant -45 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "eq" %c_45_i64, %c_17_i64 : i64
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
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c_22_i64 : i64
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
    %c_26_i64 = arith.constant -26 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "sge" %arg1, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %3, %c_26_i64 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.udiv %arg0, %5 : i64
    %7 = llvm.icmp "sgt" %c_41_i64, %6 : i64
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
    %c_23_i64 = arith.constant -23 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %c3_i64, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %arg1, %1 : i64
    %5 = llvm.xor %arg1, %4 : i64
    %6 = llvm.and %c_23_i64, %5 : i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c21_i64 = arith.constant 21 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c32_i64 = arith.constant 32 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.ashr %arg0, %c48_i64 : i64
    %1 = llvm.udiv %c32_i64, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sge" %arg1, %c_44_i64 : i64
    %4 = llvm.select %3, %c21_i64, %0 : i1, i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.urem %5, %0 : i64
    %7 = llvm.icmp "uge" %6, %c_21_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %c32_i64 = arith.constant 32 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.lshr %arg1, %c_39_i64 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.sdiv %4, %arg2 : i64
    %6 = llvm.lshr %c32_i64, %c_24_i64 : i64
    %7 = llvm.lshr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c_46_i64 = arith.constant -46 : i64
    %true = arith.constant true
    %c_26_i64 = arith.constant -26 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %c_26_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.select %true, %c_46_i64, %c9_i64 : i1, i64
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
    %c_13_i64 = arith.constant -13 : i64
    %c24_i64 = arith.constant 24 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.urem %c_26_i64, %arg0 : i64
    %1 = llvm.lshr %c_13_i64, %c37_i64 : i64
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
    %c_46_i64 = arith.constant -46 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.ashr %c_13_i64, %arg0 : i64
    %1 = llvm.select %arg2, %c_11_i64, %c_46_i64 : i1, i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.sdiv %c_11_i64, %2 : i64
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
    %c_43_i64 = arith.constant -43 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %0, %c35_i64 : i64
    %2 = llvm.icmp "uge" %c_8_i64, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.urem %5, %c_43_i64 : i64
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
    %c_30_i64 = arith.constant -30 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "sge" %c_30_i64, %c40_i64 : i64
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
    %c_1_i64 = arith.constant -1 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.and %c21_i64, %arg0 : i64
    %1 = llvm.xor %c43_i64, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %arg1, %3, %arg2 : i1, i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.ashr %5, %0 : i64
    %7 = llvm.icmp "sle" %c_1_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "eq" %1, %arg1 : i64
    %4 = llvm.select %3, %c42_i64, %arg2 : i1, i64
    %5 = llvm.or %arg0, %4 : i64
    %6 = llvm.sdiv %2, %5 : i64
    %7 = llvm.icmp "eq" %6, %c_32_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "slt" %c_43_i64, %c_11_i64 : i64
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
    %c_48_i64 = arith.constant -48 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "ult" %arg1, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c33_i64 : i1, i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.select %arg2, %1, %c19_i64 : i1, i64
    %4 = llvm.xor %c_48_i64, %3 : i64
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
    %c_30_i64 = arith.constant -30 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %c_4_i64, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "sge" %2, %c_30_i64 : i64
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
    %c_11_i64 = arith.constant -11 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.srem %c_19_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.urem %c_11_i64, %1 : i64
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
    %c_22_i64 = arith.constant -22 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.urem %c_22_i64, %c45_i64 : i64
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
    %c_25_i64 = arith.constant -25 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "sge" %c8_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %c_25_i64, %c13_i64 : i64
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
    %c_28_i64 = arith.constant -28 : i64
    %c_19_i64 = arith.constant -19 : i64
    %true = arith.constant true
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.select %true, %c35_i64, %arg0 : i1, i64
    %1 = llvm.icmp "ne" %c_19_i64, %0 : i64
    %2 = llvm.ashr %0, %arg0 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.icmp "uge" %c_28_i64, %3 : i64
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
    %c_36_i64 = arith.constant -36 : i64
    %c23_i64 = arith.constant 23 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "ult" %c23_i64, %c_23_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.udiv %c15_i64, %1 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    %5 = llvm.xor %c_36_i64, %4 : i64
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
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.select %true, %arg0, %c_6_i64 : i1, i64
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
    %c_9_i64 = arith.constant -9 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.ashr %c_9_i64, %c21_i64 : i64
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
    %c_1_i64 = arith.constant -1 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.urem %c11_i64, %arg0 : i64
    %1 = llvm.or %0, %c_1_i64 : i64
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
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.and %c_19_i64, %arg0 : i64
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
    %c_30_i64 = arith.constant -30 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %c_42_i64, %arg1 : i64
    %2 = llvm.udiv %1, %c_30_i64 : i64
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
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "sgt" %c_46_i64, %arg0 : i64
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
    %c_47_i64 = arith.constant -47 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg1, %c_32_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %arg2, %c_47_i64 : i64
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
    %c_50_i64 = arith.constant -50 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "ule" %c_50_i64, %c21_i64 : i64
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
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %c_38_i64 : i64
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
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %c_21_i64, %c29_i64 : i64
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
    %c_11_i64 = arith.constant -11 : i64
    %c_3_i64 = arith.constant -3 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.xor %c_38_i64, %c11_i64 : i64
    %1 = llvm.icmp "ult" %c_11_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.xor %0, %5 : i64
    %7 = llvm.icmp "eq" %c_3_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %c_39_i64 = arith.constant -39 : i64
    %c41_i64 = arith.constant 41 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.or %c1_i64, %1 : i64
    %3 = llvm.select %arg1, %1, %c41_i64 : i1, i64
    %4 = llvm.srem %3, %c_39_i64 : i64
    %5 = llvm.udiv %4, %c_35_i64 : i64
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
    %c_31_i64 = arith.constant -31 : i64
    %false = arith.constant false
    %true = arith.constant true
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.ashr %arg0, %c_24_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.select %false, %c_31_i64, %2 : i1, i64
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
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %c17_i64 : i64
    %2 = llvm.srem %c7_i64, %1 : i64
    %3 = llvm.udiv %arg2, %arg0 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.or %c_7_i64, %5 : i64
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
    %c_29_i64 = arith.constant -29 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.sdiv %c_4_i64, %c35_i64 : i64
    %1 = llvm.ashr %c_37_i64, %0 : i64
    %2 = llvm.srem %0, %arg0 : i64
    %3 = llvm.srem %c_29_i64, %arg0 : i64
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
    %c_25_i64 = arith.constant -25 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.and %c_25_i64, %c15_i64 : i64
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
    %c_7_i64 = arith.constant -7 : i64
    %c_4_i64 = arith.constant -4 : i64
    %false = arith.constant false
    %c41_i64 = arith.constant 41 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %false, %0, %c_4_i64 : i1, i64
    %2 = llvm.icmp "ugt" %c41_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %c5_i64, %3 : i64
    %5 = llvm.select %2, %arg0, %c_7_i64 : i1, i64
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
    %c_43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.lshr %0, %c41_i64 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.urem %c_43_i64, %2 : i64
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
    %c_32_i64 = arith.constant -32 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "ne" %c_32_i64, %c2_i64 : i64
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
    %c_24_i64 = arith.constant -24 : i64
    %true = arith.constant true
    %false = arith.constant false
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %arg0, %c_47_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %true, %c_24_i64, %arg1 : i1, i64
    %6 = llvm.xor %5, %c38_i64 : i64
    %7 = llvm.or %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %false = arith.constant false
    %c7_i64 = arith.constant 7 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.srem %c7_i64, %c_44_i64 : i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.select %arg1, %arg2, %2 : i1, i64
    %5 = llvm.and %4, %c_47_i64 : i64
    %6 = llvm.and %5, %arg2 : i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.ashr %c_46_i64, %c7_i64 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.icmp "slt" %1, %c_32_i64 : i64
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
    %c_15_i64 = arith.constant -15 : i64
    %c5_i64 = arith.constant 5 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.xor %c24_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.icmp "ule" %c5_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %3, %1, %c_15_i64 : i1, i64
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
    %c_1_i64 = arith.constant -1 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %c_33_i64, %0 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.and %c50_i64, %c37_i64 : i64
    %4 = llvm.sdiv %c_1_i64, %3 : i64
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
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.lshr %c_6_i64, %c30_i64 : i64
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
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.xor %c15_i64, %c_29_i64 : i64
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
    %c_10_i64 = arith.constant -10 : i64
    %false = arith.constant false
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.select %false, %arg0, %c_11_i64 : i1, i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.icmp "eq" %c_10_i64, %0 : i64
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
    %c_8_i64 = arith.constant -8 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "uge" %arg0, %c17_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %c_8_i64 : i64
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
    %c_23_i64 = arith.constant -23 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %c42_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.srem %c_23_i64, %3 : i64
    %5 = llvm.sext %1 : i1 to i64
    %6 = llvm.and %5, %c43_i64 : i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.urem %arg1, %c_28_i64 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %arg1, %arg1 : i64
    %2 = llvm.icmp "ult" %arg2, %c29_i64 : i64
    %3 = llvm.srem %1, %c_43_i64 : i64
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
    %c_16_i64 = arith.constant -16 : i64
    %c42_i64 = arith.constant 42 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ne" %c42_i64, %3 : i64
    %5 = llvm.select %4, %c_16_i64, %2 : i1, i64
    %6 = llvm.sdiv %c9_i64, %3 : i64
    %7 = llvm.and %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c_3_i64 = arith.constant -3 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.lshr %c_31_i64, %arg0 : i64
    %3 = llvm.icmp "sgt" %c_3_i64, %2 : i64
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
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.udiv %c_37_i64, %1 : i64
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
    %c_3_i64 = arith.constant -3 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "slt" %arg1, %c50_i64 : i64
    %1 = llvm.select %0, %arg2, %c_26_i64 : i1, i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "eq" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %c_3_i64, %c13_i64 : i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "ule" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "ult" %0, %c_15_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %1, %c_1_i64, %0 : i1, i64
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
    %c_19_i64 = arith.constant -19 : i64
    %c_24_i64 = arith.constant -24 : i64
    %true = arith.constant true
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.select %true, %arg0, %c_14_i64 : i1, i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "sge" %arg0, %c_24_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.select %arg2, %arg0, %c_19_i64 : i1, i64
    %7 = llvm.udiv %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.select %arg0, %c_8_i64, %c47_i64 : i1, i64
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
    %c_13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.select %1, %c_13_i64, %arg1 : i1, i64
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
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "sle" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.or %c_8_i64, %5 : i64
    %7 = llvm.xor %6, %arg2 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %0, %c26_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %0, %arg2 : i64
    %4 = llvm.icmp "ult" %arg1, %c_28_i64 : i64
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
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.sdiv %c_47_i64, %4 : i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.icmp "ule" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.srem %arg1, %c_45_i64 : i64
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
    %c_39_i64 = arith.constant -39 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %c6_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.select %0, %4, %c_39_i64 : i1, i64
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
    %c_20_i64 = arith.constant -20 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %c_2_i64, %0 : i64
    %2 = llvm.icmp "ult" %c_20_i64, %1 : i64
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
    %c_16_i64 = arith.constant -16 : i64
    %c6_i64 = arith.constant 6 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c49_i64 = arith.constant 49 : i64
    %c36_i64 = arith.constant 36 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.xor %0, %c_45_i64 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.xor %c36_i64, %c49_i64 : i64
    %4 = llvm.icmp "uge" %3, %c_35_i64 : i64
    %5 = llvm.select %4, %3, %c6_i64 : i1, i64
    %6 = llvm.sdiv %5, %c_16_i64 : i64
    %7 = llvm.udiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.ashr %c_11_i64, %1 : i64
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
    %c_48_i64 = arith.constant -48 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.and %arg0, %c8_i64 : i64
    %1 = llvm.ashr %0, %c_48_i64 : i64
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
    %c_28_i64 = arith.constant -28 : i64
    %c_40_i64 = arith.constant -40 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.or %c30_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %c_40_i64, %c_28_i64 : i64
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
    %c_40_i64 = arith.constant -40 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.select %arg0, %arg1, %c36_i64 : i1, i64
    %1 = llvm.icmp "sge" %0, %c_41_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %2, %c_40_i64 : i64
    %4 = llvm.icmp "sle" %c_10_i64, %3 : i64
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
    %c_23_i64 = arith.constant -23 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.and %arg1, %c5_i64 : i64
    %1 = llvm.icmp "uge" %c_11_i64, %arg0 : i64
    %2 = llvm.select %1, %c_23_i64, %0 : i1, i64
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
    %c_14_i64 = arith.constant -14 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %c37_i64, %arg0 : i64
    %1 = llvm.urem %c_46_i64, %0 : i64
    %2 = llvm.icmp "ule" %c_14_i64, %1 : i64
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
    %c_30_i64 = arith.constant -30 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.and %c_10_i64, %arg0 : i64
    %1 = llvm.sdiv %c_30_i64, %0 : i64
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
    %c_12_i64 = arith.constant -12 : i64
    %c42_i64 = arith.constant 42 : i64
    %c20_i64 = arith.constant 20 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.select %arg0, %c20_i64, %c_15_i64 : i1, i64
    %1 = llvm.icmp "sgt" %c42_i64, %0 : i64
    %2 = llvm.sdiv %c_12_i64, %0 : i64
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
    %c_28_i64 = arith.constant -28 : i64
    %c35_i64 = arith.constant 35 : i64
    %c15_i64 = arith.constant 15 : i64
    %c_39_i64 = arith.constant -39 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.and %c_39_i64, %c_31_i64 : i64
    %1 = llvm.icmp "uge" %c_31_i64, %c_28_i64 : i64
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
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "sle" %c_33_i64, %arg0 : i64
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
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %c_8_i64, %arg0 : i64
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
    %c_6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %c_16_i64 = arith.constant -16 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.udiv %c20_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg1, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %false, %2, %0 : i1, i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.urem %0, %4 : i64
    %6 = llvm.ashr %c_16_i64, %5 : i64
    %7 = llvm.and %6, %c_6_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sdiv %c16_i64, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %c_15_i64, %2 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "uge" %6, %c_33_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c44_i64 = arith.constant 44 : i64
    %c8_i64 = arith.constant 8 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.sdiv %c8_i64, %c_46_i64 : i64
    %1 = llvm.ashr %c44_i64, %0 : i64
    %2 = llvm.icmp "ne" %c_1_i64, %1 : i64
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
    %c_43_i64 = arith.constant -43 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c11_i64 = arith.constant 11 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.select %arg0, %c_37_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ugt" %arg2, %c11_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "ne" %4, %c_21_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %6, %c_43_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.udiv %1, %c_11_i64 : i64
    %4 = llvm.or %c_9_i64, %3 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    %6 = llvm.select %5, %0, %c_17_i64 : i1, i64
    %7 = llvm.lshr %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_20_i64 = arith.constant -20 : i64
    %c14_i64 = arith.constant 14 : i64
    %true = arith.constant true
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %c23_i64 : i64
    %2 = llvm.sdiv %arg1, %arg2 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.select %true, %c14_i64, %3 : i1, i64
    %5 = llvm.or %4, %c_20_i64 : i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %arg0 : i64
    %3 = llvm.and %1, %arg0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.ashr %4, %c_30_i64 : i64
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
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.lshr %1, %arg0 : i64
    %4 = llvm.or %2, %c_36_i64 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %c45_i64 = arith.constant 45 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.or %arg0, %c_29_i64 : i64
    %1 = llvm.icmp "ne" %c_38_i64, %0 : i64
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
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.trunc %arg2 : i1 to i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.icmp "slt" %c_16_i64, %1 : i64
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
