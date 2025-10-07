module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.sdiv %3, %c17_i64 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c11_i64 = arith.constant 11 : i64
    %c37_i64 = arith.constant 37 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %c37_i64, %c40_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.udiv %c11_i64, %1 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %c18_i64 = arith.constant 18 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.srem %c18_i64, %c_5_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.sdiv %c_16_i64, %arg1 : i64
    %5 = llvm.xor %4, %3 : i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %c8_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.sdiv %c33_i64, %arg0 : i64
    %4 = llvm.sdiv %2, %2 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.udiv %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.or %1, %c_37_i64 : i64
    %3 = llvm.icmp "sge" %c_21_i64, %c_45_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %4, %c_13_i64 : i64
    %6 = llvm.lshr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "uge" %c11_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.select %0, %1, %arg2 : i1, i64
    %5 = llvm.sdiv %c25_i64, %4 : i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.lshr %c22_i64, %3 : i64
    %5 = llvm.select %true, %0, %4 : i1, i64
    %6 = llvm.icmp "sge" %5, %c38_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.and %c21_i64, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "ne" %4, %2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.udiv %c30_i64, %c9_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %arg1, %1 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.udiv %c_15_i64, %c44_i64 : i64
    %1 = llvm.icmp "ugt" %c_23_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %0, %0 : i64
    %4 = llvm.icmp "sge" %3, %c_11_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %c_31_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %0, %arg2 : i64
    %4 = llvm.or %c45_i64, %3 : i64
    %5 = llvm.srem %arg1, %4 : i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.ashr %0, %arg1 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.urem %arg2, %c10_i64 : i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c1_i64 = arith.constant 1 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %c_36_i64, %c_8_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.sdiv %c1_i64, %arg0 : i64
    %3 = llvm.icmp "sle" %2, %c22_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c17_i64 = arith.constant 17 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.srem %c29_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.srem %c_32_i64, %1 : i64
    %3 = llvm.urem %c17_i64, %c14_i64 : i64
    %4 = llvm.lshr %arg2, %3 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.or %arg0, %c10_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.urem %0, %arg0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "sgt" %arg1, %2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.srem %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.xor %c_29_i64, %c12_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.and %c_5_i64, %arg1 : i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.or %c_4_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.ashr %c5_i64, %0 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.select %1, %5, %3 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.udiv %arg0, %c_46_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "sge" %arg1, %1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.udiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "sgt" %0, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c30_i64 = arith.constant 30 : i64
    %c46_i64 = arith.constant 46 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %c46_i64 : i64
    %2 = llvm.xor %1, %c30_i64 : i64
    %3 = llvm.udiv %arg1, %c_8_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.lshr %c_3_i64, %4 : i64
    %6 = llvm.srem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.select %arg1, %c3_i64, %arg2 : i1, i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "slt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c5_i64, %arg0 : i64
    %3 = llvm.sdiv %arg2, %2 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c43_i64 = arith.constant 43 : i64
    %c29_i64 = arith.constant 29 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %0, %c29_i64 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    %3 = llvm.sdiv %0, %c_17_i64 : i64
    %4 = llvm.select %2, %c43_i64, %3 : i1, i64
    %5 = llvm.lshr %arg0, %c37_i64 : i64
    %6 = llvm.sdiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c16_i64 = arith.constant 16 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "ne" %c33_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %arg0 : i64
    %3 = llvm.udiv %c16_i64, %2 : i64
    %4 = llvm.or %3, %c9_i64 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %c_40_i64, %0 : i64
    %2 = llvm.icmp "sle" %c48_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sle" %5, %0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c48_i64 = arith.constant 48 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.srem %arg2, %c_15_i64 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %c_31_i64, %3 : i64
    %5 = llvm.srem %c48_i64, %4 : i64
    %6 = llvm.icmp "ule" %c25_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c8_i64 = arith.constant 8 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.xor %c_10_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %arg1, %c8_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg2, %c_41_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.sdiv %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.urem %2, %c_36_i64 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.icmp "slt" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c42_i64 = arith.constant 42 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.or %c_9_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.and %1, %c36_i64 : i64
    %3 = llvm.icmp "ne" %c42_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %4, %2 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %c16_i64, %1 : i64
    %3 = llvm.or %2, %c_37_i64 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.or %4, %4 : i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %c_7_i64, %c_28_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.srem %3, %0 : i64
    %5 = llvm.urem %arg2, %4 : i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %false = arith.constant false
    %c18_i64 = arith.constant 18 : i64
    %c20_i64 = arith.constant 20 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.lshr %c_6_i64, %c24_i64 : i64
    %1 = llvm.and %c20_i64, %c18_i64 : i64
    %2 = llvm.select %false, %1, %1 : i1, i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.sdiv %3, %c15_i64 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c_40_i64 = arith.constant -40 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %c_40_i64, %c_27_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.lshr %arg1, %c_30_i64 : i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c30_i64 = arith.constant 30 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.sdiv %c_25_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c30_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %c14_i64, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.icmp "sgt" %5, %0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %arg0, %arg0 : i64
    %4 = llvm.udiv %arg1, %arg2 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.ashr %c13_i64, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %4, %1 : i64
    %6 = llvm.or %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg2, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.trunc %3 : i1 to i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c_30_i64 : i1, i64
    %2 = llvm.and %c38_i64, %1 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.sdiv %arg2, %4 : i64
    %6 = llvm.xor %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "ne" %arg1, %arg2 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c_41_i64, %1 : i64
    %3 = llvm.ashr %2, %c_42_i64 : i64
    %4 = llvm.urem %c45_i64, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    %6 = llvm.icmp "sgt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.lshr %c29_i64, %4 : i64
    %6 = llvm.ashr %c_40_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.or %0, %c30_i64 : i64
    %4 = llvm.icmp "slt" %c30_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.or %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c8_i64 = arith.constant 8 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %c_1_i64, %c_16_i64 : i1, i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %c_36_i64, %4 : i64
    %6 = llvm.icmp "uge" %c8_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %false = arith.constant false
    %c42_i64 = arith.constant 42 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sdiv %arg0, %c28_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.icmp "uge" %3, %c_32_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %c42_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c0_i64 = arith.constant 0 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "eq" %c0_i64, %c20_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %c_30_i64, %arg0 : i64
    %5 = llvm.xor %c_32_i64, %4 : i64
    %6 = llvm.icmp "eq" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c15_i64 = arith.constant 15 : i64
    %c41_i64 = arith.constant 41 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c13_i64 = arith.constant 13 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.ashr %c13_i64, %c2_i64 : i64
    %1 = llvm.and %0, %c_46_i64 : i64
    %2 = llvm.icmp "sle" %1, %c41_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %c35_i64, %arg0 : i64
    %5 = llvm.urem %c15_i64, %4 : i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %c_9_i64, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.icmp "sgt" %0, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %2, %0, %4 : i1, i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.lshr %c19_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %arg0, %0 : i64
    %5 = llvm.xor %4, %0 : i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c30_i64 = arith.constant 30 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c30_i64, %arg1 : i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.or %3, %c_7_i64 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.icmp "ugt" %c_28_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.urem %c0_i64, %1 : i64
    %3 = llvm.and %c47_i64, %arg2 : i64
    %4 = llvm.lshr %arg2, %2 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.xor %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %true = arith.constant true
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %c_26_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %false = arith.constant false
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.select %false, %c9_i64, %arg0 : i1, i64
    %1 = llvm.srem %c0_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.and %3, %arg2 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.or %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.srem %c_19_i64, %c_7_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.ashr %0, %0 : i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.srem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %3, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.udiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c13_i64 = arith.constant 13 : i64
    %c50_i64 = arith.constant 50 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.udiv %arg0, %c_20_i64 : i64
    %1 = llvm.xor %arg1, %c50_i64 : i64
    %2 = llvm.urem %c13_i64, %0 : i64
    %3 = llvm.select %false, %2, %arg2 : i1, i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %c18_i64, %c_16_i64 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %2, %arg1 : i64
    %6 = llvm.urem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    %2 = llvm.or %c_21_i64, %arg2 : i64
    %3 = llvm.or %2, %c36_i64 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "eq" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.sdiv %arg0, %arg0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.sdiv %c_17_i64, %arg1 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.xor %arg0, %c46_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c18_i64 = arith.constant 18 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %c18_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.select %3, %arg1, %c47_i64 : i1, i64
    %5 = llvm.icmp "ule" %c_16_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.icmp "ugt" %arg1, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.and %2, %c_10_i64 : i64
    %4 = llvm.or %3, %arg2 : i64
    %5 = llvm.lshr %4, %4 : i64
    %6 = llvm.icmp "ule" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_4_i64 = arith.constant -4 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.srem %arg0, %c35_i64 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %c_15_i64, %c_4_i64 : i64
    %6 = llvm.and %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.ashr %0, %c_34_i64 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.and %arg1, %3 : i64
    %5 = llvm.udiv %c40_i64, %4 : i64
    %6 = llvm.icmp "sgt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.udiv %c38_i64, %c_39_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %5, %arg1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.urem %arg1, %c2_i64 : i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "ult" %4, %0 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.lshr %c_32_i64, %c47_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.ashr %4, %1 : i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.or %arg0, %c_9_i64 : i64
    %1 = llvm.select %arg1, %arg2, %c_50_i64 : i1, i64
    %2 = llvm.lshr %0, %c33_i64 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.xor %c19_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg2, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %arg1, %c20_i64, %2 : i1, i64
    %4 = llvm.urem %0, %0 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.lshr %c5_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %c15_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %c48_i64 = arith.constant 48 : i64
    %c24_i64 = arith.constant 24 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.and %c17_i64, %1 : i64
    %3 = llvm.srem %2, %c24_i64 : i64
    %4 = llvm.udiv %3, %c48_i64 : i64
    %5 = llvm.udiv %0, %c_5_i64 : i64
    %6 = llvm.xor %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "ult" %c5_i64, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %arg2 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.xor %arg0, %4 : i64
    %6 = llvm.icmp "ne" %5, %arg0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg1, %arg1 : i64
    %3 = llvm.icmp "slt" %c_16_i64, %c_40_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.udiv %2, %c6_i64 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.xor %c27_i64, %0 : i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.xor %1, %c46_i64 : i64
    %5 = llvm.and %4, %arg2 : i64
    %6 = llvm.icmp "ule" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.and %c_42_i64, %0 : i64
    %2 = llvm.ashr %0, %arg0 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.select %3, %c_31_i64, %arg2 : i1, i64
    %5 = llvm.urem %4, %arg0 : i64
    %6 = llvm.xor %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %c_22_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.select %false, %0, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.lshr %c2_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.xor %3, %1 : i64
    %5 = llvm.urem %arg0, %4 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ule" %arg2, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.lshr %1, %c_40_i64 : i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %c39_i64 = arith.constant 39 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.select %arg0, %c_26_i64, %arg1 : i1, i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %arg2, %c39_i64, %c_24_i64 : i1, i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.urem %c35_i64, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "sge" %arg1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "eq" %c_33_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.urem %c_11_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.lshr %c17_i64, %3 : i64
    %5 = llvm.ashr %4, %4 : i64
    %6 = llvm.icmp "sle" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "uge" %c_21_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.select %0, %c7_i64, %1 : i1, i64
    %3 = llvm.icmp "sge" %c_48_i64, %arg0 : i64
    %4 = llvm.select %3, %c24_i64, %2 : i1, i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.ashr %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.ashr %3, %2 : i64
    %5 = llvm.or %4, %4 : i64
    %6 = llvm.xor %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c_12_i64 = arith.constant -12 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "eq" %arg0, %c_25_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %c1_i64, %arg0 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.icmp "ugt" %c_12_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.udiv %arg0, %c_39_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.udiv %4, %arg0 : i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.select %arg0, %c_40_i64, %arg1 : i1, i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.icmp "uge" %3, %c_35_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.urem %arg0, %c_42_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ule" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c3_i64 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %3, %c_30_i64 : i64
    %5 = llvm.ashr %4, %arg1 : i64
    %6 = llvm.or %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c39_i64 = arith.constant 39 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %c39_i64, %c14_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.lshr %2, %c_30_i64 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.udiv %4, %arg2 : i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.icmp "sge" %arg2, %c_20_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c34_i64 = arith.constant 34 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %c34_i64 : i64
    %2 = llvm.udiv %1, %c26_i64 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.ashr %c25_i64, %3 : i64
    %5 = llvm.or %1, %1 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg2, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %c_22_i64 : i64
    %4 = llvm.urem %arg1, %3 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "ult" %c_32_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %c19_i64 : i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.lshr %5, %1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "slt" %c37_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg1, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %c_43_i64, %2 : i64
    %4 = llvm.select %0, %arg0, %3 : i1, i64
    %5 = llvm.or %c_44_i64, %arg1 : i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c50_i64 = arith.constant 50 : i64
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.select %true, %c50_i64, %c_2_i64 : i1, i64
    %3 = llvm.lshr %arg2, %2 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %c46_i64 = arith.constant 46 : i64
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %c46_i64, %arg0 : i64
    %2 = llvm.and %0, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.ashr %c_12_i64, %3 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.select %true, %0, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %c_24_i64 = arith.constant -24 : i64
    %true = arith.constant true
    %c_47_i64 = arith.constant -47 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.select %true, %c_47_i64, %c34_i64 : i1, i64
    %1 = llvm.icmp "sle" %c_24_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %2, %0 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %5, %c_23_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.or %arg0, %c_33_i64 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %c_40_i64, %arg0 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.icmp "sgt" %c_30_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "ne" %c10_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c33_i64 : i1, i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %5 = llvm.urem %4, %c0_i64 : i64
    %6 = llvm.sdiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.urem %c_2_i64, %arg2 : i64
    %2 = llvm.icmp "uge" %c14_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.xor %4, %0 : i64
    %6 = llvm.lshr %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "sgt" %c_10_i64, %c_46_i64 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.select %0, %c_33_i64, %1 : i1, i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %2, %arg0 : i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.sdiv %arg0, %c_16_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c15_i64 = arith.constant 15 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %c10_i64, %arg0 : i64
    %2 = llvm.select %arg1, %arg2, %1 : i1, i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.urem %c15_i64, %c_2_i64 : i64
    %5 = llvm.and %4, %c40_i64 : i64
    %6 = llvm.urem %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.lshr %2, %arg1 : i64
    %5 = llvm.or %4, %arg2 : i64
    %6 = llvm.udiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "eq" %arg1, %c8_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sext %3 : i1 to i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.udiv %c27_i64, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.lshr %3, %c_42_i64 : i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.and %arg0, %c_5_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.xor %c50_i64, %arg0 : i64
    %1 = llvm.srem %c_18_i64, %0 : i64
    %2 = llvm.and %0, %arg1 : i64
    %3 = llvm.udiv %c38_i64, %2 : i64
    %4 = llvm.icmp "sgt" %3, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sgt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "sge" %c45_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg0, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %0, %2, %4 : i1, i64
    %6 = llvm.or %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c47_i64 = arith.constant 47 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.and %c_18_i64, %c3_i64 : i64
    %1 = llvm.srem %c47_i64, %c14_i64 : i64
    %2 = llvm.urem %arg0, %arg1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c32_i64 = arith.constant 32 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.xor %c44_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.udiv %c32_i64, %c_18_i64 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %4, %c_40_i64 : i64
    %6 = llvm.ashr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %false = arith.constant false
    %true = arith.constant true
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.select %true, %arg0, %c_46_i64 : i1, i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.udiv %3, %2 : i64
    %5 = llvm.sdiv %4, %c_40_i64 : i64
    %6 = llvm.and %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %false = arith.constant false
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %c_49_i64 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.select %false, %arg0, %c16_i64 : i1, i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.sdiv %c_46_i64, %c10_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %1, %0 : i64
    %5 = llvm.or %4, %arg0 : i64
    %6 = llvm.icmp "ne" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "ule" %arg0, %c20_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.icmp "uge" %2, %c27_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c24_i64 = arith.constant 24 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ult" %c_27_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %c24_i64 : i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    %4 = llvm.sdiv %arg0, %c_22_i64 : i64
    %5 = llvm.select %3, %c_35_i64, %4 : i1, i64
    %6 = llvm.select %3, %5, %arg2 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg0, %c_14_i64 : i64
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    %3 = llvm.select %1, %2, %c17_i64 : i1, i64
    %4 = llvm.icmp "sle" %3, %c17_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.udiv %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %c4_i64 = arith.constant 4 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "eq" %arg2, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %2, %c28_i64 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.urem %c4_i64, %c_6_i64 : i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c37_i64 = arith.constant 37 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %c42_i64, %0 : i64
    %2 = llvm.ashr %arg1, %arg2 : i64
    %3 = llvm.and %c37_i64, %c_28_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.icmp "ule" %5, %3 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.lshr %arg1, %c_17_i64 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.select %1, %3, %c15_i64 : i1, i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.srem %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c38_i64 = arith.constant 38 : i64
    %c14_i64 = arith.constant 14 : i64
    %c16_i64 = arith.constant 16 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.sdiv %c16_i64, %0 : i64
    %2 = llvm.icmp "ne" %c14_i64, %c38_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %3, %c17_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sgt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "eq" %c_30_i64, %c5_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.sdiv %arg0, %c26_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.icmp "eq" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c39_i64 = arith.constant 39 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.and %c21_i64, %arg0 : i64
    %1 = llvm.lshr %c_15_i64, %0 : i64
    %2 = llvm.udiv %c39_i64, %arg0 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.ashr %c_4_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %c_16_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.icmp "ult" %3, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c50_i64 = arith.constant 50 : i64
    %false = arith.constant false
    %c_23_i64 = arith.constant -23 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.udiv %c_23_i64, %c_41_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.xor %1, %c50_i64 : i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.xor %c19_i64, %1 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.select %false, %0, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.sdiv %c_20_i64, %arg0 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "slt" %2, %c_17_i64 : i64
    %5 = llvm.select %4, %arg1, %c17_i64 : i1, i64
    %6 = llvm.xor %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.select %3, %1, %0 : i1, i64
    %5 = llvm.sdiv %4, %2 : i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.ashr %arg2, %0 : i64
    %2 = llvm.udiv %c29_i64, %1 : i64
    %3 = llvm.lshr %arg2, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.icmp "ule" %4, %c15_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %c_7_i64, %0 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.select %2, %arg2, %c_6_i64 : i1, i64
    %4 = llvm.and %c11_i64, %3 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "sge" %3, %2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sle" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ne" %c10_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sext %1 : i1 to i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %arg0, %arg1 : i1, i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.or %1, %0 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.icmp "eq" %5, %c_15_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "slt" %arg1, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.sdiv %c_15_i64, %c_26_i64 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.sdiv %c_31_i64, %arg0 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "ne" %arg0, %c39_i64 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.and %arg2, %1 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.xor %c_43_i64, %arg1 : i64
    %1 = llvm.icmp "eq" %c_41_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg0, %2, %2 : i1, i64
    %4 = llvm.icmp "sgt" %3, %arg2 : i64
    %5 = llvm.select %4, %arg1, %c11_i64 : i1, i64
    %6 = llvm.srem %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %arg0, %arg2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.sdiv %arg0, %0 : i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.srem %c_45_i64, %0 : i64
    %2 = llvm.sdiv %arg1, %arg2 : i64
    %3 = llvm.xor %2, %c_24_i64 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "uge" %4, %arg2 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.or %c_29_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %arg2, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %c_35_i64, %2 : i64
    %4 = llvm.icmp "ugt" %arg1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.xor %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.xor %c_16_i64, %c35_i64 : i64
    %1 = llvm.ashr %c_41_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "slt" %1, %arg0 : i64
    %4 = llvm.select %3, %arg1, %arg2 : i1, i64
    %5 = llvm.lshr %4, %1 : i64
    %6 = llvm.icmp "sle" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.and %c46_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.urem %1, %c30_i64 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg0, %c_17_i64 : i1, i64
    %2 = llvm.and %arg1, %c_42_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.xor %c_21_i64, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %true = arith.constant true
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.select %true, %arg0, %c50_i64 : i1, i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.icmp "eq" %1, %c33_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c19_i64 = arith.constant 19 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "sge" %c19_i64, %c_44_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.lshr %2, %1 : i64
    %4 = llvm.select %arg0, %c25_i64, %3 : i1, i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.srem %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %true = arith.constant true
    %c12_i64 = arith.constant 12 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.srem %c_16_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "sgt" %arg2, %c12_i64 : i64
    %3 = llvm.select %true, %0, %c35_i64 : i1, i64
    %4 = llvm.select %2, %3, %arg2 : i1, i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ule" %arg1, %arg2 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %c_40_i64, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.ashr %arg0, %arg1 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.icmp "uge" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.udiv %3, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.urem %5, %c_36_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %false = arith.constant false
    %c10_i64 = arith.constant 10 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.lshr %c10_i64, %arg2 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.and %c_13_i64, %2 : i64
    %4 = llvm.srem %2, %1 : i64
    %5 = llvm.select %false, %4, %c38_i64 : i1, i64
    %6 = llvm.sdiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg1, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.xor %3, %c_14_i64 : i64
    %5 = llvm.or %4, %arg1 : i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.or %arg1, %c_23_i64 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.trunc %arg2 : i1 to i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %false = arith.constant false
    %c_28_i64 = arith.constant -28 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.ashr %arg0, %c_42_i64 : i64
    %1 = llvm.and %0, %c_28_i64 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.xor %c_10_i64, %2 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.sdiv %5, %2 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c38_i64 = arith.constant 38 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.select %arg1, %c_39_i64, %arg0 : i1, i64
    %1 = llvm.udiv %c_38_i64, %0 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.xor %c38_i64, %2 : i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.select %4, %5, %c30_i64 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c32_i64 = arith.constant 32 : i64
    %c30_i64 = arith.constant 30 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "sge" %c_42_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %c30_i64, %2 : i64
    %4 = llvm.srem %c_11_i64, %c9_i64 : i64
    %5 = llvm.xor %c32_i64, %4 : i64
    %6 = llvm.icmp "ule" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %c36_i64 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.select %1, %c_27_i64, %arg2 : i1, i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %arg0, %c41_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.icmp "uge" %c_7_i64, %2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.select %3, %c_37_i64, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %true = arith.constant true
    %c_32_i64 = arith.constant -32 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.srem %arg0, %c2_i64 : i64
    %1 = llvm.srem %c_32_i64, %0 : i64
    %2 = llvm.select %true, %1, %c_11_i64 : i1, i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.and %3, %0 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_20_i64 = arith.constant -20 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.ashr %c_19_i64, %c_2_i64 : i64
    %1 = llvm.icmp "ne" %c_45_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.ashr %3, %c_20_i64 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c38_i64 = arith.constant 38 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.lshr %c_4_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c38_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %c28_i64, %4 : i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c_35_i64 = arith.constant -35 : i64
    %true = arith.constant true
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.or %c_35_i64, %0 : i64
    %5 = llvm.lshr %4, %c50_i64 : i64
    %6 = llvm.icmp "sle" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "ule" %arg2, %c16_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.trunc %1 : i1 to i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c45_i64 = arith.constant 45 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.xor %c42_i64, %arg0 : i64
    %1 = llvm.xor %0, %c45_i64 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sdiv %5, %c41_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c28_i64 = arith.constant 28 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.urem %c28_i64, %c33_i64 : i64
    %1 = llvm.icmp "eq" %0, %c_26_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.icmp "sgt" %3, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.trunc %true : i1 to i64
    %6 = llvm.icmp "ult" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %0, %4 : i64
    %6 = llvm.icmp "ule" %c30_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.urem %arg0, %c_45_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "ule" %c50_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.lshr %2, %arg2 : i64
    %5 = llvm.srem %arg0, %4 : i64
    %6 = llvm.and %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %false = arith.constant false
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.select %false, %arg0, %c31_i64 : i1, i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "ne" %arg1, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %4, %c49_i64 : i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "uge" %arg0, %c8_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %c_14_i64 : i64
    %3 = llvm.xor %c_44_i64, %2 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.zext %arg1 : i1 to i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %c_30_i64 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ule" %3, %arg1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c21_i64 = arith.constant 21 : i64
    %false = arith.constant false
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.select %false, %c36_i64, %arg0 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.xor %1, %c21_i64 : i64
    %3 = llvm.and %c_47_i64, %arg1 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.lshr %4, %c41_i64 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c_32_i64 = arith.constant -32 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.srem %c_32_i64, %c_8_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.xor %c_27_i64, %arg0 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %arg0, %c32_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %3, %arg0 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %5, %1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ne" %c_19_i64, %c24_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %c18_i64, %c34_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.xor %c34_i64, %2 : i64
    %4 = llvm.icmp "ult" %arg1, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c30_i64 = arith.constant 30 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "ule" %c30_i64, %c13_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.select %0, %arg1, %c_43_i64 : i1, i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c_34_i64 = arith.constant -34 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.urem %0, %c_34_i64 : i64
    %2 = llvm.ashr %c26_i64, %1 : i64
    %3 = llvm.udiv %c_38_i64, %c_10_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c24_i64 = arith.constant 24 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.srem %c1_i64, %c24_i64 : i64
    %2 = llvm.select %false, %arg2, %arg0 : i1, i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.or %arg0, %c_35_i64 : i64
    %1 = llvm.icmp "slt" %c_43_i64, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %3, %4, %0 : i1, i64
    %6 = llvm.icmp "sle" %5, %c_42_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.xor %arg2, %c41_i64 : i64
    %3 = llvm.icmp "eq" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.ashr %5, %1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ule" %arg2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.udiv %c37_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c_46_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %arg1, %arg1 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %5, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.lshr %3, %c_2_i64 : i64
    %5 = llvm.srem %4, %arg1 : i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %c39_i64 = arith.constant 39 : i64
    %c_9_i64 = arith.constant -9 : i64
    %false = arith.constant false
    %0 = llvm.zext %arg2 : i1 to i64
    %1 = llvm.select %false, %arg1, %0 : i1, i64
    %2 = llvm.srem %1, %c39_i64 : i64
    %3 = llvm.sdiv %2, %c_47_i64 : i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.icmp "ugt" %c_9_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.sdiv %c8_i64, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %c36_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %4, %4 : i64
    %6 = llvm.icmp "eq" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.urem %c26_i64, %2 : i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "ne" %c_44_i64, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %true, %2, %4 : i1, i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.and %c_24_i64, %c14_i64 : i64
    %1 = llvm.icmp "ult" %c_49_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %arg0, %arg0 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "ule" %c_14_i64, %c_28_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.udiv %c_9_i64, %3 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.select %arg1, %1, %2 : i1, i64
    %4 = llvm.urem %3, %3 : i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.ashr %arg1, %c_22_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.or %4, %c_32_i64 : i64
    %6 = llvm.icmp "sge" %5, %c22_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %c_43_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %c29_i64, %4 : i64
    %6 = llvm.ashr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.icmp "ne" %2, %c_31_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %arg2, %c_25_i64 : i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c25_i64 = arith.constant 25 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %c14_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "eq" %c25_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.xor %c_37_i64, %c17_i64 : i64
    %2 = llvm.lshr %arg2, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "sle" %3, %1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sgt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c31_i64 = arith.constant 31 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.urem %arg0, %c_27_i64 : i64
    %1 = llvm.lshr %c31_i64, %0 : i64
    %2 = llvm.urem %arg1, %arg0 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.and %arg2, %c24_i64 : i64
    %6 = llvm.and %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ult" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %c8_i64, %c_31_i64 : i64
    %6 = llvm.udiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.icmp "sge" %c30_i64, %c38_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %c34_i64, %0 : i64
    %2 = llvm.icmp "eq" %c_49_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.lshr %c_23_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %c27_i64 = arith.constant 27 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "sge" %c27_i64, %c8_i64 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.xor %arg2, %arg0 : i64
    %4 = llvm.udiv %3, %c_17_i64 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.icmp "eq" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.xor %c_41_i64, %c_41_i64 : i64
    %3 = llvm.icmp "ugt" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.icmp "ult" %c_5_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg2, %c39_i64 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %c8_i64 = arith.constant 8 : i64
    %c30_i64 = arith.constant 30 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %c30_i64, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.xor %c_17_i64, %3 : i64
    %5 = llvm.udiv %c8_i64, %4 : i64
    %6 = llvm.and %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %c11_i64, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.udiv %0, %1 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.srem %5, %2 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %c_47_i64, %0 : i64
    %2 = llvm.xor %0, %0 : i64
    %3 = llvm.select %1, %2, %c_29_i64 : i1, i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.urem %4, %arg1 : i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %arg2, %arg0 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.ashr %c_3_i64, %arg2 : i64
    %3 = llvm.lshr %c28_i64, %c28_i64 : i64
    %4 = llvm.srem %arg2, %3 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.ashr %c36_i64, %c0_i64 : i64
    %1 = llvm.and %arg1, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.lshr %arg0, %1 : i64
    %5 = llvm.udiv %4, %3 : i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.sdiv %c_5_i64, %arg0 : i64
    %1 = llvm.sdiv %c_30_i64, %c23_i64 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %c26_i64 = arith.constant 26 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.srem %arg0, %c_33_i64 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.srem %3, %c26_i64 : i64
    %5 = llvm.icmp "uge" %4, %c_6_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.udiv %arg0, %2 : i64
    %5 = llvm.ashr %4, %c_11_i64 : i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.lshr %c41_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sdiv %0, %c_10_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.udiv %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "ugt" %c18_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.xor %arg0, %1 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "sgt" %4, %arg1 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c1_i64 = arith.constant 1 : i64
    %c33_i64 = arith.constant 33 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.lshr %c_32_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c33_i64, %c1_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.select %3, %arg0, %arg1 : i1, i64
    %5 = llvm.udiv %4, %c23_i64 : i64
    %6 = llvm.icmp "sge" %c_8_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.sdiv %arg1, %c_13_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.srem %1, %c_48_i64 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.and %arg1, %4 : i64
    %6 = llvm.ashr %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c13_i64 = arith.constant 13 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.lshr %0, %c_47_i64 : i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.and %4, %c13_i64 : i64
    %6 = llvm.icmp "ult" %5, %c39_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.and %3, %0 : i64
    %5 = llvm.and %4, %3 : i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c41_i64 = arith.constant 41 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.urem %arg0, %c2_i64 : i64
    %1 = llvm.or %0, %c41_i64 : i64
    %2 = llvm.icmp "ne" %0, %c11_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %3, %arg0 : i64
    %5 = llvm.or %4, %0 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %c_2_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %c10_i64, %arg1 : i64
    %4 = llvm.ashr %3, %arg2 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.srem %1, %c_15_i64 : i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.urem %3, %2 : i64
    %5 = llvm.ashr %arg0, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c18_i64 = arith.constant 18 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.ashr %arg0, %c3_i64 : i64
    %1 = llvm.ashr %arg1, %c36_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ule" %c18_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.trunc %arg2 : i1 to i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c0_i64 = arith.constant 0 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.sdiv %c0_i64, %c25_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.srem %arg1, %0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %1, %c2_i64 : i64
    %6 = llvm.icmp "ult" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %arg1, %c_11_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "sle" %arg1, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c21_i64 : i1, i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %arg0, %arg1 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %c44_i64, %c_20_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.xor %c_37_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %c_6_i64 : i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %c_29_i64, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.urem %c_19_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %arg1, %arg0 : i64
    %3 = llvm.sdiv %arg2, %c_1_i64 : i64
    %4 = llvm.and %c_33_i64, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "sgt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c26_i64 = arith.constant 26 : i64
    %c5_i64 = arith.constant 5 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.ashr %c7_i64, %arg0 : i64
    %1 = llvm.urem %0, %c5_i64 : i64
    %2 = llvm.ashr %1, %c26_i64 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.sext %true : i1 to i64
    %6 = llvm.icmp "ult" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c_20_i64 = arith.constant -20 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.xor %c49_i64, %arg0 : i64
    %1 = llvm.urem %0, %c_20_i64 : i64
    %2 = llvm.urem %1, %c_4_i64 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.icmp "uge" %3, %c17_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.ashr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.select %arg1, %1, %arg0 : i1, i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.udiv %1, %c_42_i64 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.or %1, %c15_i64 : i64
    %4 = llvm.urem %3, %2 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c29_i64 = arith.constant 29 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.ashr %c4_i64, %arg0 : i64
    %1 = llvm.ashr %0, %c21_i64 : i64
    %2 = llvm.sdiv %c29_i64, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.trunc %arg2 : i1 to i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    %6 = llvm.select %5, %c6_i64, %4 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %3, %arg1 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.udiv %c_15_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.sdiv %arg0, %arg1 : i64
    %3 = llvm.xor %2, %0 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.srem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.srem %c13_i64, %0 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.icmp "ult" %1, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %4, %c45_i64 : i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "sge" %c_18_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.select %3, %arg1, %arg1 : i1, i64
    %5 = llvm.icmp "sge" %4, %c37_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %false = arith.constant false
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.sdiv %c_42_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.lshr %c15_i64, %arg1 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.xor %c_24_i64, %arg0 : i64
    %5 = llvm.ashr %4, %arg0 : i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.urem %c_45_i64, %arg0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.ashr %c_42_i64, %c_2_i64 : i64
    %5 = llvm.select %3, %arg2, %4 : i1, i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.ashr %arg0, %c49_i64 : i64
    %1 = llvm.urem %arg1, %arg0 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "ult" %arg0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.select %arg0, %c_1_i64, %arg1 : i1, i64
    %1 = llvm.udiv %arg2, %c_44_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.xor %c7_i64, %2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "ult" %4, %c_2_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %c_35_i64, %c_11_i64 : i64
    %3 = llvm.lshr %2, %1 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.xor %4, %c17_i64 : i64
    %6 = llvm.icmp "ne" %5, %4 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %c19_i64 = arith.constant 19 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.and %c0_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %c_25_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.icmp "ne" %c19_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.srem %5, %0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c10_i64 = arith.constant 10 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.sdiv %c_35_i64, %arg0 : i64
    %1 = llvm.ashr %c10_i64, %arg0 : i64
    %2 = llvm.icmp "ne" %c_26_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.zext %arg2 : i1 to i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.sdiv %0, %arg1 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c33_i64 = arith.constant 33 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.ashr %c_4_i64, %arg0 : i64
    %1 = llvm.ashr %c34_i64, %arg0 : i64
    %2 = llvm.icmp "ult" %arg1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.xor %c33_i64, %4 : i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.sdiv %c_43_i64, %arg0 : i64
    %1 = llvm.and %c_49_i64, %0 : i64
    %2 = llvm.icmp "sle" %c_13_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %c_20_i64, %3 : i64
    %5 = llvm.xor %4, %1 : i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %c1_i64, %arg1 : i64
    %2 = llvm.ashr %0, %arg2 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "eq" %c48_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.ashr %c3_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.sdiv %arg2, %c_15_i64 : i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.select %true, %0, %arg1 : i1, i64
    %2 = llvm.icmp "ne" %arg2, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.lshr %c21_i64, %arg0 : i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "sge" %c48_i64, %c17_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.sdiv %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %arg0, %c14_i64 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %3, %1 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.xor %c12_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.select %true, %c_37_i64, %arg0 : i1, i64
    %1 = llvm.srem %arg1, %arg1 : i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    %3 = llvm.lshr %arg0, %arg2 : i64
    %4 = llvm.select %2, %0, %3 : i1, i64
    %5 = llvm.or %4, %arg0 : i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c15_i64 = arith.constant 15 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "uge" %c_25_i64, %c39_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "eq" %c15_i64, %c49_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "uge" %4, %1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c32_i64 = arith.constant 32 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "sle" %c29_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %c32_i64 : i64
    %3 = llvm.icmp "uge" %2, %arg0 : i64
    %4 = llvm.select %3, %c22_i64, %arg0 : i1, i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.or %5, %4 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %c_2_i64, %c_44_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.xor %arg0, %4 : i64
    %6 = llvm.icmp "ult" %5, %arg0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c33_i64 = arith.constant 33 : i64
    %c41_i64 = arith.constant 41 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "sle" %c41_i64, %c_11_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %c33_i64 : i64
    %3 = llvm.or %c44_i64, %arg0 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c37_i64 = arith.constant 37 : i64
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.urem %arg2, %c37_i64 : i64
    %4 = llvm.lshr %3, %c_35_i64 : i64
    %5 = llvm.or %4, %c_31_i64 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %c_27_i64, %arg0 : i64
    %1 = llvm.lshr %c_45_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.select %3, %arg0, %c20_i64 : i1, i64
    %5 = llvm.ashr %4, %4 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c45_i64 = arith.constant 45 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.xor %arg0, %c14_i64 : i64
    %1 = llvm.ashr %0, %c45_i64 : i64
    %2 = llvm.udiv %c_47_i64, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.sdiv %3, %2 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.trunc %arg2 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.srem %c_31_i64, %1 : i64
    %3 = llvm.srem %c_9_i64, %c_44_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.or %c_28_i64, %3 : i64
    %6 = llvm.udiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %false = arith.constant false
    %c_30_i64 = arith.constant -30 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.and %c_37_i64, %c_50_i64 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %false, %3, %c_48_i64 : i1, i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.urem %c_30_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %arg0, %c29_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.sdiv %3, %0 : i64
    %5 = llvm.udiv %4, %c_10_i64 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %c_42_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg1, %arg0 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sdiv %5, %c41_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %0, %c35_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.srem %4, %4 : i64
    %6 = llvm.icmp "sge" %c40_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %3, %2, %arg0 : i1, i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %c28_i64 = arith.constant 28 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.ashr %c_35_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %c28_i64, %c_45_i64 : i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.icmp "ugt" %c_19_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "ult" %arg1, %arg2 : i64
    %3 = llvm.select %2, %arg2, %c_15_i64 : i1, i64
    %4 = llvm.icmp "slt" %arg2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "eq" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.sdiv %c_35_i64, %c_35_i64 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %c_9_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.and %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %c_16_i64, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ne" %3, %2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %false = arith.constant false
    %c_30_i64 = arith.constant -30 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "sgt" %c_1_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %c_30_i64, %arg1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.udiv %3, %c_14_i64 : i64
    %5 = llvm.select %2, %1, %4 : i1, i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg2, %2 : i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.or %4, %arg1 : i64
    %6 = llvm.icmp "sle" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.udiv %arg0, %c_50_i64 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.icmp "ne" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %c18_i64, %3 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.urem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.udiv %arg0, %c_6_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.icmp "sle" %4, %arg1 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.xor %0, %c_14_i64 : i64
    %3 = llvm.icmp "eq" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c6_i64 = arith.constant 6 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.xor %arg0, %c14_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.xor %c6_i64, %c_1_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "sge" %3, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.urem %arg0, %arg2 : i64
    %3 = llvm.or %c_39_i64, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.ashr %arg1, %c_32_i64 : i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %0, %arg2 : i64
    %4 = llvm.udiv %3, %c10_i64 : i64
    %5 = llvm.sdiv %4, %arg0 : i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c26_i64 = arith.constant 26 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.or %arg0, %c_10_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.udiv %c26_i64, %1 : i64
    %3 = llvm.udiv %1, %1 : i64
    %4 = llvm.lshr %c16_i64, %2 : i64
    %5 = llvm.select %arg1, %3, %4 : i1, i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.lshr %arg1, %c12_i64 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.icmp "eq" %3, %c_46_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %c_24_i64, %0 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.and %2, %c_20_i64 : i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.icmp "eq" %c_24_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.urem %c8_i64, %arg1 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.or %1, %0 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "sgt" %c_50_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "ult" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.xor %c_48_i64, %c_16_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.ashr %arg0, %arg1 : i64
    %3 = llvm.xor %2, %c41_i64 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.lshr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.xor %c28_i64, %arg0 : i64
    %1 = llvm.xor %arg1, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.lshr %arg1, %arg2 : i64
    %4 = llvm.srem %3, %c_46_i64 : i64
    %5 = llvm.sdiv %arg0, %4 : i64
    %6 = llvm.srem %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %false = arith.constant false
    %c20_i64 = arith.constant 20 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.srem %arg0, %c_29_i64 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.lshr %arg2, %c20_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "ne" %5, %c37_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.srem %c43_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.ashr %arg1, %arg0 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.icmp "slt" %5, %c43_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c24_i64 = arith.constant 24 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.udiv %arg0, %c_30_i64 : i64
    %1 = llvm.xor %c24_i64, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sext %3 : i1 to i64
    %6 = llvm.sdiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c12_i64 = arith.constant 12 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.and %c_42_i64, %arg0 : i64
    %1 = llvm.sdiv %c12_i64, %0 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.icmp "sgt" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %c_14_i64, %4 : i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.and %c20_i64, %c11_i64 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %arg1, %arg0, %2 : i1, i64
    %4 = llvm.xor %3, %arg0 : i64
    %5 = llvm.sdiv %4, %2 : i64
    %6 = llvm.ashr %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c42_i64 = arith.constant 42 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.and %arg0, %c12_i64 : i64
    %1 = llvm.udiv %0, %c_14_i64 : i64
    %2 = llvm.icmp "ugt" %c42_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %c47_i64, %arg0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.or %0, %c33_i64 : i64
    %2 = llvm.icmp "ne" %c_19_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %c_26_i64, %3 : i64
    %5 = llvm.urem %arg2, %c_26_i64 : i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "slt" %1, %c_21_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %3, %c29_i64 : i64
    %5 = llvm.and %arg1, %1 : i64
    %6 = llvm.ashr %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %c_33_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %c_8_i64, %arg1 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.srem %4, %arg2 : i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %3, %arg1 : i64
    %5 = llvm.zext %arg2 : i1 to i64
    %6 = llvm.urem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "ne" %arg1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %c_12_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.sdiv %arg2, %c_38_i64 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.icmp "slt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.ashr %1, %c26_i64 : i64
    %3 = llvm.lshr %c_12_i64, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ne" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.urem %2, %c_17_i64 : i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.udiv %c_19_i64, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %0, %0 : i64
    %4 = llvm.xor %3, %arg2 : i64
    %5 = llvm.or %arg1, %4 : i64
    %6 = llvm.urem %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c39_i64 = arith.constant 39 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.sdiv %c_22_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %c39_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %2, %c45_i64 : i64
    %4 = llvm.udiv %arg0, %0 : i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.xor %c38_i64, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.ashr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "ult" %arg0, %c34_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.urem %c24_i64, %2 : i64
    %4 = llvm.and %3, %3 : i64
    %5 = llvm.xor %4, %3 : i64
    %6 = llvm.or %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.xor %c_41_i64, %c_46_i64 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.udiv %arg1, %arg2 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.sdiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c3_i64 = arith.constant 3 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.lshr %c_20_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg1, %c3_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg2, %c_3_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c25_i64 = arith.constant 25 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %0, %c25_i64 : i64
    %2 = llvm.or %arg1, %c_31_i64 : i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.udiv %c_38_i64, %c_25_i64 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.lshr %arg0, %arg1 : i64
    %5 = llvm.sdiv %4, %arg2 : i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.srem %arg1, %4 : i64
    %6 = llvm.or %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.or %arg0, %c40_i64 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.sdiv %arg0, %c46_i64 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.icmp "ult" %3, %1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.ashr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "eq" %c_46_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %arg0, %arg0 : i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c_27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.ashr %c16_i64, %1 : i64
    %3 = llvm.select %true, %c_27_i64, %c_28_i64 : i1, i64
    %4 = llvm.icmp "uge" %arg2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %c_48_i64, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.select %true, %1, %3 : i1, i64
    %5 = llvm.ashr %4, %0 : i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.ashr %c43_i64, %1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.sdiv %0, %4 : i64
    %6 = llvm.icmp "uge" %5, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.udiv %c49_i64, %arg0 : i64
    %1 = llvm.xor %0, %c26_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.zext %3 : i1 to i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c18_i64 = arith.constant 18 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.srem %c_24_i64, %arg0 : i64
    %1 = llvm.sdiv %c18_i64, %0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.select %false, %arg2, %0 : i1, i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c9_i64 = arith.constant 9 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %arg2, %c_46_i64, %c5_i64 : i1, i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.udiv %c_26_i64, %4 : i64
    %6 = llvm.icmp "sgt" %c9_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c28_i64 = arith.constant 28 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.and %c_7_i64, %1 : i64
    %3 = llvm.and %c28_i64, %arg2 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %arg0, %c_34_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %arg1 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.or %3, %c_30_i64 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.lshr %arg0, %c12_i64 : i64
    %1 = llvm.and %arg0, %c_5_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.ashr %arg1, %arg2 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.udiv %5, %c20_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %c_44_i64 : i1, i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.select %arg1, %c_8_i64, %c15_i64 : i1, i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.urem %0, %4 : i64
    %6 = llvm.icmp "ugt" %c33_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.icmp "ugt" %3, %c_11_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %c_47_i64, %c_14_i64 : i64
    %2 = llvm.and %arg2, %1 : i64
    %3 = llvm.lshr %c_2_i64, %c14_i64 : i64
    %4 = llvm.urem %3, %1 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.urem %c_26_i64, %c_42_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.zext %arg1 : i1 to i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.urem %c_3_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %c_8_i64, %arg1 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.udiv %arg2, %c_42_i64 : i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c21_i64 = arith.constant 21 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.lshr %c_33_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %c21_i64, %2 : i64
    %4 = llvm.ashr %c25_i64, %3 : i64
    %5 = llvm.lshr %4, %2 : i64
    %6 = llvm.xor %5, %arg1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c1_i64 = arith.constant 1 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.urem %arg0, %c_27_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.select %arg1, %arg2, %c1_i64 : i1, i64
    %3 = llvm.lshr %c35_i64, %1 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %false = arith.constant false
    %c_48_i64 = arith.constant -48 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.udiv %c_39_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.select %false, %0, %c_31_i64 : i1, i64
    %4 = llvm.lshr %c_48_i64, %3 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "ne" %c_50_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.trunc %0 : i1 to i64
    %4 = llvm.urem %c_22_i64, %3 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.sdiv %5, %arg0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "ule" %c_28_i64, %c_25_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %false = arith.constant false
    %c_26_i64 = arith.constant -26 : i64
    %c6_i64 = arith.constant 6 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.ashr %c32_i64, %arg0 : i64
    %1 = llvm.urem %0, %c6_i64 : i64
    %2 = llvm.lshr %c_26_i64, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.select %false, %c_12_i64, %arg1 : i1, i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.sdiv %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c_12_i64 = arith.constant -12 : i64
    %true = arith.constant true
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.urem %c_50_i64, %arg0 : i64
    %1 = llvm.xor %c_12_i64, %c_9_i64 : i64
    %2 = llvm.select %true, %1, %0 : i1, i64
    %3 = llvm.select %true, %1, %2 : i1, i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    %6 = llvm.icmp "sle" %5, %3 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.sdiv %c_27_i64, %arg0 : i64
    %1 = llvm.or %arg0, %c_42_i64 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.icmp "eq" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %c_45_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.icmp "ult" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c_17_i64 = arith.constant -17 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %c_17_i64, %c40_i64 : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    %3 = llvm.select %2, %1, %arg1 : i1, i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %c26_i64 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.icmp "eq" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c23_i64 = arith.constant 23 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "eq" %c23_i64, %c9_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "sge" %c38_i64, %1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sdiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.urem %c21_i64, %3 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c6_i64 = arith.constant 6 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.udiv %c47_i64, %arg0 : i64
    %1 = llvm.and %c6_i64, %0 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %3, %arg2 : i64
    %5 = llvm.or %c_41_i64, %arg0 : i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c11_i64 = arith.constant 11 : i64
    %c34_i64 = arith.constant 34 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.lshr %c_18_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %c34_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ugt" %c11_i64, %c_47_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %arg2, %4 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %true = arith.constant true
    %c_8_i64 = arith.constant -8 : i64
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.select %false, %0, %arg2 : i1, i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.udiv %2, %c23_i64 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "sgt" %c_8_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.xor %arg1, %c34_i64 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg0, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %4, %c12_i64 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c18_i64 = arith.constant 18 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.srem %arg0, %c_6_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %c43_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %4, %4 : i64
    %6 = llvm.icmp "eq" %c18_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.or %c_49_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.icmp "sle" %5, %2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c_19_i64 = arith.constant -19 : i64
    %true = arith.constant true
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.select %true, %arg0, %c_47_i64 : i1, i64
    %1 = llvm.udiv %c_19_i64, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %arg1, %2, %c17_i64 : i1, i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %c26_i64, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ult" %c_41_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.lshr %c2_i64, %1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %5, %arg0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c_12_i64 = arith.constant -12 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.or %c5_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %c_12_i64, %0 : i64
    %2 = llvm.select %1, %arg1, %c_47_i64 : i1, i64
    %3 = llvm.ashr %0, %arg0 : i64
    %4 = llvm.icmp "ule" %arg1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg2, %arg2 : i64
    %3 = llvm.lshr %arg2, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.xor %5, %3 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %arg1, %1 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %c6_i64 = arith.constant 6 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ugt" %c_31_i64, %c_13_i64 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %c6_i64 : i1, i64
    %3 = llvm.icmp "uge" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %arg2, %c_39_i64 : i64
    %6 = llvm.sdiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.udiv %c_42_i64, %c_16_i64 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %arg0, %c47_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.urem %arg1, %2 : i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "sgt" %c_1_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.icmp "uge" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %0, %1, %4 : i1, i64
    %6 = llvm.icmp "ugt" %5, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.urem %arg1, %c_28_i64 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg0, %c_26_i64 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.sdiv %arg1, %4 : i64
    %6 = llvm.icmp "sge" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ne" %arg0, %c_11_i64 : i64
    %1 = llvm.udiv %arg1, %arg0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    %4 = llvm.select %3, %arg0, %c19_i64 : i1, i64
    %5 = llvm.select %3, %c_2_i64, %4 : i1, i64
    %6 = llvm.select %0, %5, %arg2 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.urem %0, %0 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %false = arith.constant false
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.sdiv %0, %1 : i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.icmp "ule" %5, %c_28_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "sge" %arg0, %c_14_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg1, %c_41_i64 : i64
    %3 = llvm.urem %c_36_i64, %2 : i64
    %4 = llvm.icmp "slt" %arg1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %c43_i64 = arith.constant 43 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.lshr %c_17_i64, %c18_i64 : i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "ugt" %c43_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.udiv %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ne" %3, %arg1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c26_i64 = arith.constant 26 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c_40_i64, %1 : i64
    %3 = llvm.sdiv %2, %c26_i64 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c43_i64 = arith.constant 43 : i64
    %c_40_i64 = arith.constant -40 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %c_40_i64 : i64
    %2 = llvm.udiv %c_29_i64, %1 : i64
    %3 = llvm.and %arg2, %2 : i64
    %4 = llvm.and %c8_i64, %arg2 : i64
    %5 = llvm.srem %c43_i64, %4 : i64
    %6 = llvm.select %0, %3, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.xor %c7_i64, %arg1 : i64
    %4 = llvm.lshr %arg2, %3 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c19_i64 = arith.constant 19 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.udiv %c_22_i64, %arg0 : i64
    %1 = llvm.udiv %c19_i64, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.select %2, %1, %0 : i1, i64
    %4 = llvm.sdiv %arg0, %c7_i64 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %c14_i64 = arith.constant 14 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %c35_i64, %0 : i64
    %2 = llvm.urem %0, %arg1 : i64
    %3 = llvm.select %1, %arg2, %2 : i1, i64
    %4 = llvm.or %arg1, %c14_i64 : i64
    %5 = llvm.srem %4, %c_24_i64 : i64
    %6 = llvm.srem %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "ne" %2, %c_17_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.xor %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.srem %c14_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %c_50_i64, %c0_i64 : i64
    %3 = llvm.icmp "sgt" %c_27_i64, %2 : i64
    %4 = llvm.select %3, %arg1, %2 : i1, i64
    %5 = llvm.sdiv %4, %2 : i64
    %6 = llvm.xor %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "slt" %c_37_i64, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %arg0, %4 : i64
    %6 = llvm.lshr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c46_i64 = arith.constant 46 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %c46_i64, %c_31_i64 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.zext %3 : i1 to i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "eq" %arg0, %c6_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.xor %2, %c_6_i64 : i64
    %4 = llvm.zext %arg1 : i1 to i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.lshr %arg2, %c_3_i64 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.lshr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.ashr %arg1, %c42_i64 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c26_i64 = arith.constant 26 : i64
    %true = arith.constant true
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.select %true, %arg0, %c_8_i64 : i1, i64
    %1 = llvm.xor %arg1, %arg0 : i64
    %2 = llvm.urem %arg2, %c26_i64 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.or %3, %c38_i64 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.lshr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %c8_i64 = arith.constant 8 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "sge" %c_20_i64, %0 : i64
    %2 = llvm.urem %0, %arg2 : i64
    %3 = llvm.urem %2, %c_49_i64 : i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.select %1, %c8_i64, %4 : i1, i64
    %6 = llvm.udiv %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.srem %arg1, %c_5_i64 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.sdiv %c40_i64, %4 : i64
    %6 = llvm.or %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c28_i64 = arith.constant 28 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.or %arg0, %arg1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.select %4, %c28_i64, %c_39_i64 : i1, i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.ashr %c5_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %c_26_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.select %1, %arg1, %3 : i1, i64
    %5 = llvm.udiv %0, %4 : i64
    %6 = llvm.icmp "eq" %5, %c29_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sdiv %c12_i64, %arg0 : i64
    %1 = llvm.and %arg1, %arg1 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.select %2, %0, %arg0 : i1, i64
    %4 = llvm.icmp "sge" %c48_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "slt" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c21_i64 = arith.constant 21 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "uge" %arg0, %c_4_i64 : i64
    %1 = llvm.select %0, %arg0, %c21_i64 : i1, i64
    %2 = llvm.urem %arg1, %c10_i64 : i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.select %0, %arg1, %arg1 : i1, i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c19_i64 = arith.constant 19 : i64
    %c12_i64 = arith.constant 12 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.xor %c_31_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %c12_i64, %0 : i64
    %2 = llvm.select %1, %arg1, %0 : i1, i64
    %3 = llvm.srem %c4_i64, %2 : i64
    %4 = llvm.lshr %arg2, %3 : i64
    %5 = llvm.select %1, %2, %4 : i1, i64
    %6 = llvm.icmp "ne" %c19_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c_34_i64 = arith.constant -34 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "sge" %c_34_i64, %c16_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.select %arg1, %2, %arg2 : i1, i64
    %5 = llvm.sdiv %4, %c_42_i64 : i64
    %6 = llvm.lshr %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.srem %1, %0 : i64
    %5 = llvm.select %3, %4, %arg0 : i1, i64
    %6 = llvm.sdiv %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c1_i64 = arith.constant 1 : i64
    %c_20_i64 = arith.constant -20 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.xor %arg0, %c21_i64 : i64
    %1 = llvm.sdiv %c_16_i64, %0 : i64
    %2 = llvm.udiv %1, %c_20_i64 : i64
    %3 = llvm.icmp "ult" %c1_i64, %c40_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.sdiv %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "ne" %c_41_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %c_41_i64, %arg1 : i64
    %2 = llvm.select %1, %c_11_i64, %arg2 : i1, i64
    %3 = llvm.select %0, %c_45_i64, %2 : i1, i64
    %4 = llvm.sdiv %c_17_i64, %c_43_i64 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.icmp "eq" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c20_i64 = arith.constant 20 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %c_37_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %arg2, %c20_i64 : i64
    %4 = llvm.udiv %3, %c_21_i64 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.and %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.and %arg0, %c13_i64 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %c_37_i64 : i64
    %4 = llvm.srem %3, %2 : i64
    %5 = llvm.xor %4, %4 : i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.urem %c_22_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sdiv %arg0, %c27_i64 : i64
    %1 = llvm.or %arg2, %c19_i64 : i64
    %2 = llvm.icmp "eq" %arg2, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %arg1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c_21_i64 = arith.constant -21 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.srem %c_21_i64, %c_47_i64 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %c20_i64 = arith.constant 20 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.udiv %c20_i64, %c34_i64 : i64
    %1 = llvm.lshr %c_48_i64, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "ne" %c_4_i64, %c29_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %c_36_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %arg1, %1 : i64
    %5 = llvm.select %4, %3, %c41_i64 : i1, i64
    %6 = llvm.xor %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %c28_i64 = arith.constant 28 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.sdiv %c28_i64, %c_35_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.urem %2, %arg0 : i64
    %5 = llvm.srem %4, %1 : i64
    %6 = llvm.select %3, %c_26_i64, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.icmp "eq" %c50_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c21_i64 = arith.constant 21 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.xor %c_30_i64, %arg0 : i64
    %1 = llvm.ashr %c21_i64, %0 : i64
    %2 = llvm.sdiv %arg1, %arg2 : i64
    %3 = llvm.or %2, %c_26_i64 : i64
    %4 = llvm.urem %c_50_i64, %c_47_i64 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "sge" %0, %c_1_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.trunc %false : i1 to i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.srem %c47_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.udiv %arg0, %0 : i64
    %3 = llvm.or %arg1, %0 : i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %c39_i64, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.select %arg2, %1, %0 : i1, i64
    %4 = llvm.icmp "uge" %arg1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %arg2 : i64
    %2 = llvm.urem %c_32_i64, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.trunc %0 : i1 to i64
    %5 = llvm.select %0, %3, %4 : i1, i64
    %6 = llvm.icmp "sgt" %5, %c_4_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.or %arg1, %c_38_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %arg2, %c_9_i64 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.icmp "uge" %5, %0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.select %arg1, %c32_i64, %arg0 : i1, i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.or %c30_i64, %arg2 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.icmp "sge" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %c_28_i64, %c27_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.xor %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c35_i64 = arith.constant 35 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %c_8_i64, %arg0 : i64
    %1 = llvm.ashr %c_50_i64, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.xor %c35_i64, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.and %c_2_i64, %arg1 : i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %c_24_i64, %0 : i64
    %2 = llvm.srem %1, %c_36_i64 : i64
    %3 = llvm.udiv %c_47_i64, %2 : i64
    %4 = llvm.sdiv %3, %arg1 : i64
    %5 = llvm.select %arg2, %c10_i64, %arg1 : i1, i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.lshr %c_37_i64, %arg2 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.udiv %1, %c32_i64 : i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.icmp "sle" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.and %arg1, %arg1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.lshr %4, %arg0 : i64
    %6 = llvm.lshr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.sdiv %c_18_i64, %arg0 : i64
    %1 = llvm.urem %c40_i64, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %5, %0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %c45_i64 = arith.constant 45 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.sdiv %c30_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %c45_i64, %c_1_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.urem %1, %c24_i64 : i64
    %3 = llvm.and %arg0, %c_2_i64 : i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sgt" %0, %c19_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c40_i64 = arith.constant 40 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.xor %c_4_i64, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %1, %c40_i64 : i64
    %3 = llvm.udiv %arg2, %c29_i64 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %2, %0 : i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c6_i64 = arith.constant 6 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %c6_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    %4 = llvm.select %3, %0, %c_7_i64 : i1, i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.icmp "slt" %c45_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %c33_i64 = arith.constant 33 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c_48_i64 : i64
    %2 = llvm.and %c35_i64, %1 : i64
    %3 = llvm.udiv %arg0, %arg1 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.xor %c33_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c44_i64 = arith.constant 44 : i64
    %c39_i64 = arith.constant 39 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.select %arg0, %c43_i64, %arg1 : i1, i64
    %1 = llvm.srem %0, %c39_i64 : i64
    %2 = llvm.icmp "sge" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %c44_i64 : i64
    %5 = llvm.lshr %arg2, %c_46_i64 : i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.or %c32_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.select %1, %arg0, %c17_i64 : i1, i64
    %3 = llvm.icmp "uge" %arg0, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.or %5, %arg0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %c_42_i64 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.xor %c31_i64, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.or %4, %c33_i64 : i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c25_i64 = arith.constant 25 : i64
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.xor %c25_i64, %arg0 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.select %false, %2, %3 : i1, i64
    %5 = llvm.select %1, %arg2, %4 : i1, i64
    %6 = llvm.icmp "ult" %5, %0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c13_i64 = arith.constant 13 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %c13_i64, %0 : i64
    %2 = llvm.icmp "uge" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %c12_i64, %3 : i64
    %5 = llvm.select %4, %c10_i64, %1 : i1, i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.ashr %c_36_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.and %c3_i64, %arg2 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %c50_i64 = arith.constant 50 : i64
    %c_2_i64 = arith.constant -2 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.lshr %c_2_i64, %arg0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.ashr %c50_i64, %c_17_i64 : i64
    %5 = llvm.srem %4, %arg1 : i64
    %6 = llvm.sdiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.sdiv %c26_i64, %1 : i64
    %3 = llvm.icmp "sge" %c_37_i64, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "ult" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c8_i64 = arith.constant 8 : i64
    %true = arith.constant true
    %c21_i64 = arith.constant 21 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.select %true, %c21_i64, %c13_i64 : i1, i64
    %1 = llvm.select %arg0, %c8_i64, %0 : i1, i64
    %2 = llvm.srem %1, %c46_i64 : i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.icmp "eq" %3, %2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %5, %arg1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c2_i64 = arith.constant 2 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.or %c_20_i64, %arg1 : i64
    %1 = llvm.select %arg0, %c_31_i64, %0 : i1, i64
    %2 = llvm.lshr %arg2, %c2_i64 : i64
    %3 = llvm.icmp "ule" %arg1, %c6_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %c_28_i64 = arith.constant -28 : i64
    %false = arith.constant false
    %c_22_i64 = arith.constant -22 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.select %false, %c_22_i64, %c5_i64 : i1, i64
    %1 = llvm.lshr %c_28_i64, %c_13_i64 : i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.sdiv %arg1, %arg2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.srem %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg1, %c22_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %c_24_i64, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %false = arith.constant false
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.ashr %c_10_i64, %arg0 : i64
    %1 = llvm.select %false, %0, %arg1 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.sdiv %0, %c13_i64 : i64
    %4 = llvm.or %arg1, %arg2 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.and %4, %1 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %c45_i64 = arith.constant 45 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.select %arg1, %arg0, %c_9_i64 : i1, i64
    %1 = llvm.lshr %c45_i64, %c_46_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %3, %arg2 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.sdiv %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.urem %c45_i64, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %c7_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.ashr %1, %c_39_i64 : i64
    %3 = llvm.urem %c_32_i64, %arg1 : i64
    %4 = llvm.ashr %3, %c14_i64 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %3, %c_28_i64, %c4_i64 : i1, i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c_46_i64 = arith.constant -46 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.and %c_46_i64, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.or %arg1, %arg0 : i64
    %4 = llvm.udiv %c_34_i64, %arg2 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.select %2, %1, %arg1 : i1, i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.or %arg0, %4 : i64
    %6 = llvm.icmp "ne" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.urem %c_12_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.and %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c_42_i64 = arith.constant -42 : i64
    %false = arith.constant false
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %c_42_i64, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %false, %0, %2 : i1, i64
    %4 = llvm.ashr %arg2, %c_37_i64 : i64
    %5 = llvm.urem %4, %c_12_i64 : i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %c22_i64, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.udiv %c_21_i64, %3 : i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %c31_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.lshr %arg2, %4 : i64
    %6 = llvm.and %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.or %c_5_i64, %1 : i64
    %5 = llvm.ashr %4, %arg1 : i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %true = arith.constant true
    %c_5_i64 = arith.constant -5 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.srem %arg0, %c_17_i64 : i64
    %1 = llvm.select %arg1, %0, %c_5_i64 : i1, i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.udiv %4, %3 : i64
    %6 = llvm.xor %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.sext %2 : i1 to i64
    %6 = llvm.lshr %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c9_i64 = arith.constant 9 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.select %arg0, %c_20_i64, %arg1 : i1, i64
    %1 = llvm.icmp "sgt" %0, %c9_i64 : i64
    %2 = llvm.sdiv %arg2, %0 : i64
    %3 = llvm.select %1, %2, %arg2 : i1, i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.urem %c30_i64, %4 : i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.xor %c44_i64, %4 : i64
    %6 = llvm.icmp "eq" %c_24_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %false = arith.constant false
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.urem %arg0, %c_18_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %4 = llvm.icmp "eq" %3, %arg2 : i64
    %5 = llvm.select %4, %arg2, %c_25_i64 : i1, i64
    %6 = llvm.or %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.srem %c_34_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.xor %arg0, %c_46_i64 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.xor %5, %c_8_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.sdiv %c_39_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %c40_i64 = arith.constant 40 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.lshr %c_1_i64, %c8_i64 : i64
    %1 = llvm.icmp "ne" %c_50_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %arg0, %arg1 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.and %c40_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %0, %c22_i64 : i64
    %2 = llvm.icmp "slt" %arg0, %c_21_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %2, %1, %3 : i1, i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg2, %c_29_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.lshr %4, %c7_i64 : i64
    %6 = llvm.icmp "ule" %c12_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.sdiv %c39_i64, %arg1 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.srem %arg2, %1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c34_i64 = arith.constant 34 : i64
    %false = arith.constant false
    %c32_i64 = arith.constant 32 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.sdiv %c32_i64, %c10_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.icmp "sgt" %arg1, %c34_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %4, %c_39_i64 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c29_i64 = arith.constant 29 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %c_47_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.lshr %c29_i64, %1 : i64
    %3 = llvm.urem %c30_i64, %2 : i64
    %4 = llvm.xor %arg1, %0 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %c17_i64 = arith.constant 17 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.udiv %c_2_i64, %c2_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.srem %3, %c17_i64 : i64
    %5 = llvm.lshr %arg1, %c_40_i64 : i64
    %6 = llvm.xor %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %c46_i64, %0 : i64
    %2 = llvm.select %1, %arg1, %c47_i64 : i1, i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.icmp "ult" %2, %0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %c_19_i64 : i64
    %2 = llvm.select %1, %arg1, %c_26_i64 : i1, i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.lshr %c11_i64, %3 : i64
    %5 = llvm.icmp "ult" %4, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.or %c_47_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %c4_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %c1_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %c19_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.zext %arg1 : i1 to i64
    %6 = llvm.and %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %c_47_i64 : i64
    %2 = llvm.or %1, %c_25_i64 : i64
    %3 = llvm.udiv %c45_i64, %2 : i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c50_i64 = arith.constant 50 : i64
    %c11_i64 = arith.constant 11 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "ne" %c11_i64, %c_26_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %c50_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %arg0, %arg1 : i64
    %5 = llvm.and %4, %c35_i64 : i64
    %6 = llvm.lshr %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %c_32_i64 = arith.constant -32 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.or %0, %0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.udiv %c_32_i64, %3 : i64
    %5 = llvm.xor %4, %c_17_i64 : i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.udiv %2, %c_21_i64 : i64
    %4 = llvm.sext %0 : i1 to i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c46_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %c_28_i64, %2 : i64
    %4 = llvm.select %3, %arg1, %c1_i64 : i1, i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %c5_i64 = arith.constant 5 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "eq" %c_12_i64, %arg0 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.icmp "ule" %1, %c_5_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.select %0, %arg1, %4 : i1, i64
    %6 = llvm.icmp "sle" %c5_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.xor %arg2, %c_19_i64 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %c_46_i64, %4 : i64
    %6 = llvm.udiv %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %0, %c27_i64 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %3, %c15_i64, %arg2 : i1, i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "eq" %2, %c_38_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %1, %arg1, %4 : i1, i64
    %6 = llvm.and %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.lshr %c24_i64, %c_3_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sext %arg0 : i1 to i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %c5_i64 = arith.constant 5 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %arg0, %c5_i64 : i64
    %2 = llvm.srem %1, %c_32_i64 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.select %arg1, %2, %arg2 : i1, i64
    %5 = llvm.udiv %4, %arg0 : i64
    %6 = llvm.and %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.icmp "ugt" %c_38_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.xor %arg2, %c49_i64 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %c_26_i64 = arith.constant -26 : i64
    %false = arith.constant false
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.select %false, %c10_i64, %arg0 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.lshr %c_26_i64, %1 : i64
    %3 = llvm.select %arg1, %c_3_i64, %0 : i1, i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.sdiv %0, %4 : i64
    %6 = llvm.sdiv %5, %1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %c_14_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %0, %c_42_i64 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %c_44_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c20_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "uge" %arg1, %c26_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.srem %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %c13_i64 = arith.constant 13 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "sgt" %c13_i64, %c_23_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %arg1, %arg0 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.lshr %5, %c_28_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %false = arith.constant false
    %c_27_i64 = arith.constant -27 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.select %false, %c_27_i64, %c_42_i64 : i1, i64
    %1 = llvm.select %false, %0, %c37_i64 : i1, i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.zext %arg0 : i1 to i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.udiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.and %arg2, %c50_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.srem %4, %4 : i64
    %6 = llvm.icmp "ult" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c_8_i64 : i1, i64
    %2 = llvm.select %0, %c_3_i64, %1 : i1, i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.icmp "sge" %5, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.and %0, %c_41_i64 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.udiv %3, %c10_i64 : i64
    %5 = llvm.ashr %c13_i64, %4 : i64
    %6 = llvm.icmp "uge" %5, %c10_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %c_12_i64 = arith.constant -12 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "ugt" %arg1, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg2, %arg1 : i64
    %3 = llvm.icmp "ne" %2, %c40_i64 : i64
    %4 = llvm.srem %c_27_i64, %arg1 : i64
    %5 = llvm.select %3, %c_12_i64, %4 : i1, i64
    %6 = llvm.select %arg0, %1, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c_6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.select %false, %c_6_i64, %0 : i1, i64
    %2 = llvm.icmp "eq" %1, %c22_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %arg0, %1, %3 : i1, i64
    %5 = llvm.udiv %4, %3 : i64
    %6 = llvm.lshr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %false = arith.constant false
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.select %false, %c24_i64, %arg0 : i1, i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "sle" %c_32_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.srem %arg2, %4 : i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %false = arith.constant false
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %c32_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.icmp "eq" %3, %c_24_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c15_i64 = arith.constant 15 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.urem %c15_i64, %c33_i64 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "uge" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.urem %arg0, %c39_i64 : i64
    %1 = llvm.and %c_10_i64, %c6_i64 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.srem %5, %arg1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_20_i64 = arith.constant -20 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.srem %c40_i64, %arg2 : i64
    %3 = llvm.or %arg2, %2 : i64
    %4 = llvm.sdiv %3, %c_20_i64 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %1, %c47_i64 : i64
    %6 = llvm.select %2, %4, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c19_i64 = arith.constant 19 : i64
    %c43_i64 = arith.constant 43 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "eq" %c43_i64, %c_42_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.and %1, %c19_i64 : i64
    %3 = llvm.icmp "sle" %arg2, %c_43_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.icmp "uge" %5, %c16_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "eq" %arg0, %c44_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.icmp "ult" %arg1, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.icmp "uge" %5, %c50_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.or %arg0, %c15_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.and %c47_i64, %1 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "slt" %5, %1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %c_3_i64, %arg0 : i1, i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.or %4, %arg0 : i64
    %6 = llvm.select %0, %3, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.udiv %c_4_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "eq" %c36_i64, %0 : i64
    %3 = llvm.sdiv %0, %0 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.select %2, %3, %4 : i1, i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.urem %c48_i64, %arg1 : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %c_41_i64, %4 : i64
    %6 = llvm.urem %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c37_i64 = arith.constant 37 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.udiv %c_11_i64, %c37_i64 : i64
    %2 = llvm.urem %1, %c50_i64 : i64
    %3 = llvm.udiv %arg2, %2 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %c_23_i64 : i64
    %2 = llvm.sdiv %arg2, %arg2 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.select %0, %3, %c19_i64 : i1, i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.and %c_7_i64, %c15_i64 : i64
    %4 = llvm.lshr %3, %1 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %c18_i64 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.icmp "ugt" %c_36_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c28_i64 = arith.constant 28 : i64
    %c38_i64 = arith.constant 38 : i64
    %c24_i64 = arith.constant 24 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %c38_i64, %c28_i64 : i64
    %2 = llvm.udiv %c24_i64, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "ult" %3, %c_41_i64 : i64
    %5 = llvm.select %4, %3, %2 : i1, i64
    %6 = llvm.xor %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %arg2, %4, %arg1 : i1, i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.lshr %arg0, %c8_i64 : i64
    %1 = llvm.lshr %c_10_i64, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.sdiv %arg1, %0 : i64
    %4 = llvm.xor %3, %0 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %c_2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %c19_i64 = arith.constant 19 : i64
    %c43_i64 = arith.constant 43 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.select %arg0, %c43_i64, %c28_i64 : i1, i64
    %1 = llvm.lshr %c19_i64, %0 : i64
    %2 = llvm.select %false, %1, %1 : i1, i64
    %3 = llvm.udiv %2, %c_2_i64 : i64
    %4 = llvm.or %3, %c_17_i64 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.srem %arg0, %c40_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.lshr %arg0, %0 : i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %arg0, %4 : i64
    %6 = llvm.icmp "sgt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "sle" %c_6_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %c_49_i64, %arg1 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.icmp "slt" %3, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.icmp "sgt" %c2_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %arg2, %c49_i64 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "eq" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c2_i64 = arith.constant 2 : i64
    %false = arith.constant false
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.srem %0, %arg2 : i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.or %c2_i64, %3 : i64
    %5 = llvm.select %1, %4, %c_42_i64 : i1, i64
    %6 = llvm.select %false, %c_38_i64, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %4, %arg2 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %true = arith.constant true
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.ashr %2, %c27_i64 : i64
    %4 = llvm.srem %2, %2 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %c_39_i64, %arg1 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "sge" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.icmp "uge" %c_8_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.ashr %c_15_i64, %arg0 : i64
    %1 = llvm.ashr %c5_i64, %arg0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.srem %arg0, %4 : i64
    %6 = llvm.lshr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c45_i64 : i64
    %2 = llvm.icmp "ult" %0, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.udiv %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "ule" %c_10_i64, %c_15_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c_31_i64, %1 : i64
    %3 = llvm.srem %1, %c37_i64 : i64
    %4 = llvm.sdiv %c_30_i64, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.or %arg0, %c28_i64 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.select %1, %arg1, %arg0 : i1, i64
    %3 = llvm.ashr %2, %arg1 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ule" %5, %2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %false = arith.constant false
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.select %false, %c_47_i64, %0 : i1, i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.icmp "ugt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.or %arg0, %c_47_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.xor %arg2, %2 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.lshr %4, %c_49_i64 : i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %c37_i64, %arg1 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg1, %arg0 : i64
    %4 = llvm.and %c50_i64, %2 : i64
    %5 = llvm.select %3, %2, %4 : i1, i64
    %6 = llvm.or %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.zext %0 : i1 to i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c_17_i64 = arith.constant -17 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.udiv %c_17_i64, %c24_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.xor %arg1, %0 : i64
    %5 = llvm.sdiv %arg0, %4 : i64
    %6 = llvm.ashr %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %c10_i64, %0 : i64
    %2 = llvm.and %arg1, %arg2 : i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.select %1, %arg1, %3 : i1, i64
    %5 = llvm.select %arg0, %arg1, %2 : i1, i64
    %6 = llvm.and %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.xor %c32_i64, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "sle" %c_27_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %2, %3, %arg1 : i1, i64
    %5 = llvm.urem %3, %3 : i64
    %6 = llvm.xor %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "eq" %c25_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.udiv %4, %0 : i64
    %6 = llvm.udiv %c_48_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %0, %c_21_i64 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.ashr %2, %c47_i64 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    %6 = llvm.ashr %5, %arg1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c22_i64 = arith.constant 22 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.select %arg0, %c22_i64, %c10_i64 : i1, i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sdiv %c_38_i64, %c26_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.urem %3, %2 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "ule" %c_13_i64, %c6_i64 : i64
    %1 = llvm.icmp "ugt" %c30_i64, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.ashr %3, %arg2 : i64
    %5 = llvm.icmp "eq" %4, %arg1 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.select %arg1, %arg0, %1 : i1, i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %4, %1 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.icmp "ne" %c_45_i64, %c_10_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c_6_i64, %c_21_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.select %0, %3, %4 : i1, i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.srem %c_32_i64, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.udiv %c_50_i64, %2 : i64
    %4 = llvm.urem %arg0, %2 : i64
    %5 = llvm.urem %4, %4 : i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.ashr %0, %0 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c42_i64 = arith.constant 42 : i64
    %c22_i64 = arith.constant 22 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %c_33_i64, %arg2 : i64
    %2 = llvm.ashr %1, %c22_i64 : i64
    %3 = llvm.icmp "sle" %c42_i64, %c16_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "ne" %c_4_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "ugt" %c_19_i64, %c17_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.select %arg2, %c_33_i64, %c_45_i64 : i1, i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "slt" %3, %c35_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.select %0, %c_47_i64, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.select %true, %arg0, %arg1 : i1, i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.urem %c_11_i64, %arg2 : i64
    %5 = llvm.xor %4, %4 : i64
    %6 = llvm.icmp "sle" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.udiv %0, %c_32_i64 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.sdiv %c3_i64, %arg1 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sle" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c20_i64 = arith.constant 20 : i64
    %c43_i64 = arith.constant 43 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %c_45_i64, %0 : i64
    %2 = llvm.ashr %arg2, %c43_i64 : i64
    %3 = llvm.ashr %arg1, %c20_i64 : i64
    %4 = llvm.and %3, %c3_i64 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %c22_i64 = arith.constant 22 : i64
    %c29_i64 = arith.constant 29 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.udiv %c_1_i64, %arg0 : i64
    %1 = llvm.select %arg1, %c29_i64, %c22_i64 : i1, i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.select %arg1, %arg2, %1 : i1, i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.lshr %4, %c_13_i64 : i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c15_i64 = arith.constant 15 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "uge" %c_42_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %c15_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %3, %3 : i64
    %5 = llvm.urem %4, %c8_i64 : i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.and %0, %c13_i64 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sext %2 : i1 to i64
    %5 = llvm.lshr %c_19_i64, %4 : i64
    %6 = llvm.icmp "sle" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.icmp "ult" %c_2_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.lshr %3, %arg2 : i64
    %5 = llvm.select %1, %3, %c_10_i64 : i1, i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c43_i64 = arith.constant 43 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.xor %c43_i64, %c34_i64 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %c_27_i64, %2 : i64
    %4 = llvm.icmp "sge" %arg1, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %false = arith.constant false
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.select %false, %arg0, %c_29_i64 : i1, i64
    %1 = llvm.icmp "ule" %c_46_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.or %4, %arg1 : i64
    %6 = llvm.sdiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %c19_i64 = arith.constant 19 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "ne" %c19_i64, %c_42_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.sdiv %3, %arg1 : i64
    %5 = llvm.ashr %c_48_i64, %arg2 : i64
    %6 = llvm.and %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.or %c30_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.select %1, %arg1, %c40_i64 : i1, i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "eq" %4, %arg2 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %4, %arg1 : i64
    %6 = llvm.or %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %0, %arg2 : i64
    %5 = llvm.sdiv %c_39_i64, %4 : i64
    %6 = llvm.icmp "ule" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "eq" %c46_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c27_i64 = arith.constant 27 : i64
    %c50_i64 = arith.constant 50 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.srem %arg0, %c_46_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.urem %c27_i64, %c_1_i64 : i64
    %3 = llvm.ashr %c50_i64, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.xor %arg0, %0 : i64
    %6 = llvm.icmp "ult" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c49_i64 = arith.constant 49 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.urem %c49_i64, %c9_i64 : i64
    %1 = llvm.xor %c_30_i64, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.sdiv %arg0, %arg1 : i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.urem %c43_i64, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %2, %c_7_i64 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.trunc %1 : i1 to i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "ult" %arg0, %c37_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.ashr %arg0, %arg1 : i64
    %5 = llvm.or %c27_i64, %4 : i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.lshr %c_32_i64, %c26_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.lshr %1, %2 : i64
    %5 = llvm.select %arg0, %3, %4 : i1, i64
    %6 = llvm.icmp "sge" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.xor %c3_i64, %1 : i64
    %3 = llvm.icmp "uge" %arg2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %4, %2 : i64
    %6 = llvm.xor %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.select %arg0, %0, %2 : i1, i64
    %4 = llvm.udiv %c_15_i64, %2 : i64
    %5 = llvm.and %4, %2 : i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %arg1, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %3, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.select %arg2, %arg0, %c2_i64 : i1, i64
    %3 = llvm.lshr %2, %c_40_i64 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.sdiv %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %2, %c_26_i64 : i64
    %4 = llvm.icmp "ugt" %3, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "uge" %c_20_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %c_1_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.ashr %4, %arg1 : i64
    %6 = llvm.urem %c3_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c_49_i64 = arith.constant -49 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %0, %c_49_i64 : i64
    %2 = llvm.and %arg0, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sgt" %3, %c9_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.srem %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "sge" %arg2, %arg1 : i64
    %3 = llvm.and %1, %c_8_i64 : i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.select %2, %4, %c_14_i64 : i1, i64
    %6 = llvm.icmp "eq" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c35_i64 = arith.constant 35 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %c_8_i64, %arg0 : i64
    %1 = llvm.lshr %c35_i64, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.urem %3, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    %6 = llvm.select %5, %4, %c_41_i64 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %c7_i64 : i64
    %3 = llvm.xor %arg2, %c_38_i64 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.ashr %c_31_i64, %c48_i64 : i64
    %1 = llvm.ashr %c48_i64, %arg0 : i64
    %2 = llvm.xor %c34_i64, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "slt" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %false, %3, %arg0 : i1, i64
    %5 = llvm.and %4, %c_32_i64 : i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c_1_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %4, %2 : i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %c35_i64, %c_11_i64 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.select %5, %3, %0 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c2_i64 = arith.constant 2 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "ule" %c33_i64, %arg0 : i64
    %1 = llvm.select %0, %c_16_i64, %c_37_i64 : i1, i64
    %2 = llvm.xor %arg1, %arg1 : i64
    %3 = llvm.icmp "uge" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.icmp "slt" %c2_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.or %arg0, %c31_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.ashr %c_27_i64, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.udiv %arg0, %c_23_i64 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.select %arg2, %arg1, %2 : i1, i64
    %4 = llvm.ashr %3, %c16_i64 : i64
    %5 = llvm.udiv %4, %c40_i64 : i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %c20_i64 = arith.constant 20 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "ugt" %c20_i64, %c_26_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %c_27_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.lshr %3, %arg1 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.select %0, %arg0, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.srem %c_16_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %arg1, %1 : i64
    %3 = llvm.select %2, %c_5_i64, %arg2 : i1, i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.zext %2 : i1 to i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c44_i64 = arith.constant 44 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.urem %arg0, %c4_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %3, %c44_i64 : i64
    %5 = llvm.srem %4, %c3_i64 : i64
    %6 = llvm.icmp "ult" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c37_i64 = arith.constant 37 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %c_39_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "slt" %c37_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %c_36_i64, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.urem %3, %c_13_i64 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.sdiv %arg1, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.and %3, %c_34_i64 : i64
    %5 = llvm.icmp "ugt" %c_15_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.xor %c_11_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.select %1, %3, %0 : i1, i64
    %5 = llvm.urem %0, %4 : i64
    %6 = llvm.icmp "sgt" %c_12_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %c40_i64 = arith.constant 40 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.urem %c40_i64, %c_16_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.or %0, %c_12_i64 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.sdiv %3, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    %6 = llvm.ashr %5, %0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.urem %1, %c_41_i64 : i64
    %3 = llvm.select %arg1, %c_41_i64, %arg0 : i1, i64
    %4 = llvm.select %arg1, %0, %3 : i1, i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c_31_i64 = arith.constant -31 : i64
    %false = arith.constant false
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.xor %arg0, %c43_i64 : i64
    %1 = llvm.sdiv %c_32_i64, %c_31_i64 : i64
    %2 = llvm.select %false, %c_31_i64, %1 : i1, i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.lshr %c_25_i64, %c22_i64 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %c18_i64 = arith.constant 18 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %c_28_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.and %arg2, %c_15_i64 : i64
    %3 = llvm.ashr %c18_i64, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.udiv %4, %1 : i64
    %6 = llvm.and %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.or %arg1, %c25_i64 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %arg2, %2 : i64
    %4 = llvm.icmp "sge" %c_35_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c43_i64 = arith.constant 43 : i64
    %c_40_i64 = arith.constant -40 : i64
    %false = arith.constant false
    %c_35_i64 = arith.constant -35 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.lshr %c_35_i64, %c_24_i64 : i64
    %1 = llvm.select %false, %c_40_i64, %c43_i64 : i1, i64
    %2 = llvm.udiv %arg0, %c_18_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.xor %c43_i64, %c_25_i64 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %c16_i64 = arith.constant 16 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.srem %0, %c16_i64 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.xor %2, %c_34_i64 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.ashr %c18_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.xor %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.or %c_37_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.select %1, %arg1, %arg1 : i1, i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.trunc %arg2 : i1 to i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.ashr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c12_i64 = arith.constant 12 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.urem %c12_i64, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "eq" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %arg2, %c49_i64 : i64
    %6 = llvm.lshr %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %true = arith.constant true
    %c23_i64 = arith.constant 23 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.select %true, %c23_i64, %c_36_i64 : i1, i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg0, %0, %2 : i1, i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "slt" %c28_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.udiv %arg0, %arg2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.ashr %4, %3 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.srem %c24_i64, %c24_i64 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.icmp "sge" %1, %c32_i64 : i64
    %3 = llvm.select %2, %arg1, %arg2 : i1, i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.or %c25_i64, %4 : i64
    %6 = llvm.sdiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c19_i64 = arith.constant 19 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.xor %c21_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %c19_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.sdiv %3, %c49_i64 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %true = arith.constant true
    %c34_i64 = arith.constant 34 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.ashr %0, %arg0 : i64
    %3 = llvm.and %c17_i64, %c34_i64 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.sext %true : i1 to i64
    %6 = llvm.select %1, %4, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.lshr %c7_i64, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %3 = llvm.select %2, %arg1, %arg0 : i1, i64
    %4 = llvm.or %3, %arg0 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %c28_i64 = arith.constant 28 : i64
    %c18_i64 = arith.constant 18 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %c18_i64, %0 : i64
    %2 = llvm.ashr %c28_i64, %c_23_i64 : i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.ashr %5, %0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c_50_i64 = arith.constant -50 : i64
    %true = arith.constant true
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.select %arg2, %c_27_i64, %c_1_i64 : i1, i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %true, %arg0, %4 : i1, i64
    %6 = llvm.icmp "ule" %c_50_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c17_i64 = arith.constant 17 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.and %c50_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %c17_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.xor %1, %c_24_i64 : i64
    %4 = llvm.srem %c_42_i64, %arg0 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.select %3, %c_7_i64, %2 : i1, i64
    %5 = llvm.icmp "ule" %4, %c_29_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.and %arg0, %c1_i64 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "eq" %c17_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %arg1, %0 : i64
    %6 = llvm.xor %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sdiv %arg1, %c31_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.sdiv %3, %c48_i64 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg2, %arg2 : i1, i64
    %2 = llvm.or %arg0, %arg0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.select %false, %3, %1 : i1, i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.xor %4, %c42_i64 : i64
    %6 = llvm.xor %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.srem %c_39_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.and %3, %arg0 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c41_i64 = arith.constant 41 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.urem %c_26_i64, %c20_i64 : i64
    %1 = llvm.sdiv %c47_i64, %0 : i64
    %2 = llvm.udiv %c41_i64, %1 : i64
    %3 = llvm.icmp "uge" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.icmp "ugt" %c_13_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %c_8_i64, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.or %3, %arg2 : i64
    %5 = llvm.udiv %c_11_i64, %1 : i64
    %6 = llvm.xor %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.xor %2, %c20_i64 : i64
    %4 = llvm.srem %3, %c_42_i64 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %c47_i64 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.lshr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.select %false, %c_47_i64, %0 : i1, i64
    %6 = llvm.xor %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ult" %c22_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %arg0, %arg1 : i64
    %4 = llvm.srem %3, %c_37_i64 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.icmp "ult" %c_47_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c4_i64 = arith.constant 4 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.select %3, %c4_i64, %c18_i64 : i1, i64
    %5 = llvm.ashr %c17_i64, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.xor %c_21_i64, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.or %c_21_i64, %1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %4, %arg0 : i64
    %6 = llvm.icmp "ult" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "sle" %c_45_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %arg1, %c_43_i64 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %arg1, %arg1 : i64
    %3 = llvm.sdiv %c29_i64, %2 : i64
    %4 = llvm.icmp "ult" %3, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.ashr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_18_i64 = arith.constant -18 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.udiv %arg0, %c_50_i64 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %0, %0 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.sext %1 : i1 to i64
    %6 = llvm.select %4, %c_18_i64, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.or %c29_i64, %arg0 : i64
    %1 = llvm.and %0, %c_31_i64 : i64
    %2 = llvm.urem %c_47_i64, %1 : i64
    %3 = llvm.or %c31_i64, %arg0 : i64
    %4 = llvm.icmp "ult" %3, %arg1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c42_i64 = arith.constant 42 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.sdiv %arg0, %c_34_i64 : i64
    %1 = llvm.and %c_15_i64, %c_47_i64 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.urem %c42_i64, %2 : i64
    %4 = llvm.select %arg1, %2, %arg2 : i1, i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.lshr %arg0, %c38_i64 : i64
    %1 = llvm.or %0, %c40_i64 : i64
    %2 = llvm.select %arg1, %1, %arg2 : i1, i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "eq" %5, %1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %3, %3 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_18_i64 = arith.constant -18 : i64
    %c24_i64 = arith.constant 24 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %c_20_i64, %c24_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.udiv %c_18_i64, %arg1 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %c16_i64 = arith.constant 16 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.xor %c_33_i64, %c_23_i64 : i64
    %1 = llvm.udiv %0, %c16_i64 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.urem %c_16_i64, %1 : i64
    %4 = llvm.lshr %arg1, %3 : i64
    %5 = llvm.ashr %c_33_i64, %4 : i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.lshr %c32_i64, %c47_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.icmp "ne" %3, %arg0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.or %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %c_37_i64, %0 : i64
    %2 = llvm.and %c_38_i64, %1 : i64
    %3 = llvm.sdiv %c_6_i64, %0 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %c20_i64 = arith.constant 20 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "sgt" %c17_i64, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.ashr %c20_i64, %c_14_i64 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.select %arg0, %0, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c_49_i64 = arith.constant -49 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.urem %1, %c_29_i64 : i64
    %3 = llvm.or %arg2, %c_49_i64 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg1, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %c_9_i64, %2 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.xor %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.xor %arg1, %c_24_i64 : i64
    %3 = llvm.and %c_6_i64, %c37_i64 : i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c_7_i64 = arith.constant -7 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.lshr %arg0, %c_31_i64 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.sdiv %arg2, %c_7_i64 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.lshr %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "ugt" %c35_i64, %c37_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.urem %arg0, %c_1_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.sdiv %c50_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.xor %c_21_i64, %2 : i64
    %4 = llvm.lshr %0, %arg2 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "eq" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %c9_i64 = arith.constant 9 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.udiv %c_26_i64, %c_15_i64 : i64
    %1 = llvm.ashr %0, %c9_i64 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.select %arg0, %2, %arg1 : i1, i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.srem %c_48_i64, %arg1 : i64
    %6 = llvm.urem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "ne" %5, %c_17_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %true = arith.constant true
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.select %true, %c13_i64, %arg0 : i1, i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.icmp "uge" %3, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg1, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.urem %3, %2 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg1, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %arg0 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %5, %c26_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "sgt" %c_50_i64, %c_50_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.and %2, %c42_i64 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.udiv %arg1, %arg2 : i64
    %6 = llvm.udiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.urem %c41_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %c11_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    %6 = llvm.select %5, %0, %0 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_4_i64 = arith.constant -4 : i64
    %c12_i64 = arith.constant 12 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.xor %c23_i64, %c23_i64 : i64
    %1 = llvm.icmp "sgt" %0, %c_18_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %0, %c12_i64 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.sext %1 : i1 to i64
    %6 = llvm.select %4, %5, %c_4_i64 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c_28_i64 = arith.constant -28 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "eq" %arg0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.or %c_20_i64, %3 : i64
    %5 = llvm.select %false, %c_28_i64, %4 : i1, i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c46_i64 = arith.constant 46 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "uge" %c_33_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.xor %c46_i64, %c22_i64 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.urem %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c2_i64 = arith.constant 2 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.xor %c_45_i64, %c_34_i64 : i64
    %1 = llvm.sdiv %c2_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %c_21_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %2, %arg0, %3 : i1, i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "ult" %c36_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.srem %arg2, %arg2 : i64
    %5 = llvm.udiv %4, %arg0 : i64
    %6 = llvm.lshr %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %true = arith.constant true
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "slt" %c_28_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.select %true, %arg1, %2 : i1, i64
    %4 = llvm.srem %c29_i64, %arg2 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %c_43_i64, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %3, %1 : i64
    %5 = llvm.sdiv %arg0, %4 : i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c_46_i64 = arith.constant -46 : i64
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.or %c_46_i64, %0 : i64
    %3 = llvm.lshr %2, %c_19_i64 : i64
    %4 = llvm.select %arg1, %1, %3 : i1, i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.urem %3, %c25_i64 : i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.sdiv %3, %arg0 : i64
    %5 = llvm.xor %3, %arg1 : i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.udiv %arg0, %c2_i64 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.lshr %3, %c5_i64 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "ne" %c_41_i64, %c_5_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %arg0, %c_14_i64 : i64
    %6 = llvm.sdiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ule" %c_12_i64, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.or %arg2, %arg1 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.icmp "slt" %arg1, %1 : i64
    %3 = llvm.select %2, %arg2, %0 : i1, i64
    %4 = llvm.ashr %c42_i64, %3 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.icmp "uge" %c6_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c_7_i64 = arith.constant -7 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.ashr %c_5_i64, %c_25_i64 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.srem %c_7_i64, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.select %1, %0, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.or %arg0, %4 : i64
    %6 = llvm.sdiv %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.lshr %c_20_i64, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %3, %3 : i64
    %5 = llvm.select %false, %1, %c_43_i64 : i1, i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %c39_i64 = arith.constant 39 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.srem %c_31_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.lshr %c39_i64, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.or %3, %0 : i64
    %5 = llvm.urem %0, %c_50_i64 : i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.select %arg2, %arg0, %arg1 : i1, i64
    %4 = llvm.or %3, %arg0 : i64
    %5 = llvm.srem %4, %1 : i64
    %6 = llvm.or %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.xor %2, %c_15_i64 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c45_i64 = arith.constant 45 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.sdiv %0, %arg2 : i64
    %4 = llvm.srem %c45_i64, %c50_i64 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.ashr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.srem %c_1_i64, %1 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.srem %c5_i64, %3 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.icmp "uge" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %c5_i64 = arith.constant 5 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.udiv %c5_i64, %c_17_i64 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ult" %c_27_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %arg0, %1 : i64
    %6 = llvm.lshr %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.select %arg0, %c_45_i64, %arg1 : i1, i64
    %1 = llvm.icmp "sge" %c11_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.or %arg2, %arg1 : i64
    %6 = llvm.select %4, %5, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c11_i64 = arith.constant 11 : i64
    %c8_i64 = arith.constant 8 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.srem %arg1, %c8_i64 : i64
    %3 = llvm.icmp "ult" %c11_i64, %arg2 : i64
    %4 = llvm.select %3, %arg1, %c20_i64 : i1, i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.urem %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %c_20_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.urem %arg1, %c40_i64 : i64
    %4 = llvm.icmp "sge" %arg2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %c38_i64 = arith.constant 38 : i64
    %c21_i64 = arith.constant 21 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %c21_i64, %0 : i64
    %2 = llvm.lshr %c38_i64, %1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.select %arg0, %c_28_i64, %1 : i1, i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.lshr %5, %arg1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "sgt" %arg0, %c_49_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %c8_i64 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.srem %arg1, %arg2 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.select %arg0, %c_23_i64, %arg1 : i1, i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.sdiv %c0_i64, %0 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c_15_i64 = arith.constant -15 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.and %c_15_i64, %c_3_i64 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.udiv %3, %1 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_20_i64 = arith.constant -20 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.lshr %c_20_i64, %c_15_i64 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.xor %0, %0 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %arg1, %arg2 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %c0_i64, %3 : i64
    %5 = llvm.urem %c_14_i64, %4 : i64
    %6 = llvm.urem %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c39_i64 = arith.constant 39 : i64
    %c50_i64 = arith.constant 50 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %c50_i64, %0 : i64
    %2 = llvm.srem %1, %c39_i64 : i64
    %3 = llvm.or %2, %1 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.lshr %4, %c25_i64 : i64
    %6 = llvm.or %c45_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.srem %arg0, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.ashr %arg2, %2 : i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c_46_i64 = arith.constant -46 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %0, %c_46_i64 : i64
    %2 = llvm.urem %1, %c10_i64 : i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.or %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.select %1, %arg1, %arg1 : i1, i64
    %3 = llvm.icmp "eq" %c20_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %arg0, %0, %4 : i1, i64
    %6 = llvm.icmp "ult" %5, %2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_4_i64 = arith.constant -4 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "sgt" %c_21_i64, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.icmp "slt" %1, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %arg0, %2, %4 : i1, i64
    %6 = llvm.srem %5, %c_4_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c12_i64 = arith.constant 12 : i64
    %c6_i64 = arith.constant 6 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.srem %c6_i64, %c_50_i64 : i64
    %1 = llvm.icmp "uge" %c12_i64, %0 : i64
    %2 = llvm.and %c_33_i64, %0 : i64
    %3 = llvm.and %2, %c_49_i64 : i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    %5 = llvm.xor %0, %2 : i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.urem %c_13_i64, %arg0 : i64
    %1 = llvm.and %c_36_i64, %arg1 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.icmp "sle" %c_30_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.lshr %c_41_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.lshr %5, %arg2 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "sle" %c33_i64, %1 : i64
    %3 = llvm.srem %arg0, %c34_i64 : i64
    %4 = llvm.select %2, %3, %3 : i1, i64
    %5 = llvm.udiv %arg1, %arg2 : i64
    %6 = llvm.or %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.srem %c_28_i64, %c2_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %0 : i64
    %3 = llvm.select %2, %0, %arg0 : i1, i64
    %4 = llvm.select %2, %1, %3 : i1, i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c44_i64 = arith.constant 44 : i64
    %c14_i64 = arith.constant 14 : i64
    %c50_i64 = arith.constant 50 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sdiv %c50_i64, %c20_i64 : i64
    %1 = llvm.ashr %0, %c44_i64 : i64
    %2 = llvm.srem %arg0, %c_26_i64 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.icmp "sle" %c14_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c9_i64 = arith.constant 9 : i64
    %c5_i64 = arith.constant 5 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sdiv %c5_i64, %c31_i64 : i64
    %1 = llvm.sdiv %0, %c_24_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.urem %3, %c_2_i64 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "eq" %c9_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c12_i64 = arith.constant 12 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %0, %c_11_i64 : i64
    %2 = llvm.icmp "ult" %0, %arg1 : i64
    %3 = llvm.select %2, %arg2, %c12_i64 : i1, i64
    %4 = llvm.ashr %3, %c_20_i64 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.icmp "ule" %c41_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "slt" %c_42_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "ult" %4, %arg0 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "ugt" %arg1, %arg2 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %c10_i64 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "slt" %2, %c_28_i64 : i64
    %5 = llvm.select %4, %arg2, %arg1 : i1, i64
    %6 = llvm.icmp "sle" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "ugt" %c44_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.select %3, %c46_i64, %arg1 : i1, i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.lshr %5, %arg2 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %c_26_i64, %0 : i64
    %2 = llvm.sdiv %1, %c_2_i64 : i64
    %3 = llvm.ashr %arg1, %c_43_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.srem %c7_i64, %2 : i64
    %6 = llvm.urem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %c48_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.lshr %arg2, %0 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.icmp "ne" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %c_13_i64, %arg0 : i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %c36_i64, %arg0 : i64
    %5 = llvm.udiv %4, %c49_i64 : i64
    %6 = llvm.icmp "sle" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.or %c7_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.or %arg1, %c13_i64 : i64
    %4 = llvm.ashr %3, %1 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "ult" %c_24_i64, %c_48_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %c_43_i64 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.icmp "sge" %c_1_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %arg2, %2, %2 : i1, i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.srem %arg0, %4 : i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.or %arg0, %c_45_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "ult" %arg2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "uge" %1, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.icmp "sge" %5, %c2_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %c2_i64, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "slt" %c20_i64, %arg1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sdiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "uge" %c_16_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "slt" %2, %c13_i64 : i64
    %4 = llvm.ashr %arg1, %arg0 : i64
    %5 = llvm.select %3, %arg1, %4 : i1, i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %c9_i64, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.lshr %c44_i64, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sge" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.and %0, %arg2 : i64
    %3 = llvm.udiv %c_4_i64, %c_1_i64 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.select %4, %c_41_i64, %3 : i1, i64
    %6 = llvm.xor %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c17_i64 = arith.constant 17 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %arg0, %c14_i64 : i64
    %1 = llvm.sdiv %0, %c17_i64 : i64
    %2 = llvm.ashr %c_10_i64, %0 : i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.xor %arg2, %c26_i64 : i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %c4_i64 = arith.constant 4 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "sge" %c4_i64, %c_34_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %c_11_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c19_i64 = arith.constant 19 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.or %c_29_i64, %arg0 : i64
    %1 = llvm.udiv %c_25_i64, %c19_i64 : i64
    %2 = llvm.sdiv %c42_i64, %arg0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.select %3, %0, %2 : i1, i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.srem %c34_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.srem %0, %c_47_i64 : i64
    %3 = llvm.and %c_49_i64, %2 : i64
    %4 = llvm.select %1, %0, %3 : i1, i64
    %5 = llvm.sdiv %4, %3 : i64
    %6 = llvm.xor %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c12_i64 = arith.constant 12 : i64
    %c_20_i64 = arith.constant -20 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.sdiv %arg0, %c_10_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.select %1, %c_20_i64, %c12_i64 : i1, i64
    %3 = llvm.srem %c_35_i64, %arg2 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.xor %4, %c24_i64 : i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.srem %arg2, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.and %c5_i64, %2 : i64
    %6 = llvm.xor %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c20_i64 = arith.constant 20 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.icmp "eq" %c7_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    %3 = llvm.ashr %c20_i64, %arg1 : i64
    %4 = llvm.select %2, %arg1, %3 : i1, i64
    %5 = llvm.or %3, %c22_i64 : i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c_44_i64 = arith.constant -44 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.urem %arg0, %c_17_i64 : i64
    %1 = llvm.or %c_44_i64, %0 : i64
    %2 = llvm.select %true, %0, %arg1 : i1, i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "uge" %0, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.urem %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.or %c_47_i64, %arg2 : i64
    %3 = llvm.and %arg0, %c_18_i64 : i64
    %4 = llvm.and %3, %c37_i64 : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.select %0, %1, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.icmp "ugt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c_14_i64 = arith.constant -14 : i64
    %true = arith.constant true
    %c_11_i64 = arith.constant -11 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.ashr %arg0, %c23_i64 : i64
    %1 = llvm.srem %c_11_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.select %true, %c_14_i64, %c25_i64 : i1, i64
    %4 = llvm.srem %arg1, %arg2 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.icmp "sgt" %c_11_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %c38_i64, %arg1 : i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "sgt" %c_6_i64, %c30_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.urem %arg0, %arg0 : i64
    %4 = llvm.icmp "sgt" %c46_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.sdiv %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.sdiv %c8_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.icmp "sgt" %c13_i64, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.select %arg0, %c14_i64, %arg1 : i1, i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %c_6_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %arg2, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.icmp "uge" %5, %1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.select %4, %arg2, %c_19_i64 : i1, i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.or %c_23_i64, %0 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.sext %arg2 : i1 to i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "ne" %5, %4 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_7_i64 = arith.constant -7 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "ult" %c_7_i64, %c49_i64 : i64
    %1 = llvm.icmp "eq" %c7_i64, %arg0 : i64
    %2 = llvm.select %1, %c_37_i64, %arg0 : i1, i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %0, %2, %4 : i1, i64
    %6 = llvm.ashr %5, %arg1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "ule" %arg0, %c26_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c_5_i64, %1 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.lshr %c23_i64, %arg0 : i64
    %1 = llvm.udiv %c_33_i64, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.urem %c_32_i64, %3 : i64
    %5 = llvm.udiv %arg2, %4 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.srem %arg1, %0 : i64
    %5 = llvm.or %4, %arg1 : i64
    %6 = llvm.ashr %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %arg2, %c_10_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %arg0, %1 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c42_i64 = arith.constant 42 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %c_31_i64 : i64
    %2 = llvm.lshr %1, %c42_i64 : i64
    %3 = llvm.icmp "ule" %c38_i64, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.udiv %arg2, %3 : i64
    %5 = llvm.xor %c_21_i64, %4 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %c44_i64 = arith.constant 44 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.srem %c13_i64, %arg0 : i64
    %1 = llvm.lshr %c44_i64, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.or %arg2, %c_3_i64 : i64
    %4 = llvm.and %arg1, %3 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "sge" %arg0, %c_40_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg1, %arg2 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %false = arith.constant false
    %c44_i64 = arith.constant 44 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.select %arg1, %c44_i64, %c50_i64 : i1, i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.lshr %arg2, %c45_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.and %5, %arg0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.srem %c_41_i64, %arg1 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.and %c5_i64, %3 : i64
    %5 = llvm.icmp "sge" %4, %arg2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.xor %c1_i64, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.icmp "sle" %3, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %c_24_i64 = arith.constant -24 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "uge" %c_50_i64, %c14_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.srem %c_44_i64, %c_24_i64 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.ashr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %c_48_i64, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.udiv %2, %1 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.urem %arg0, %arg1 : i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %arg1, %c_13_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ule" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.srem %arg2, %c12_i64 : i64
    %4 = llvm.select %2, %arg1, %3 : i1, i64
    %5 = llvm.srem %4, %c_7_i64 : i64
    %6 = llvm.icmp "sgt" %5, %3 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %c_47_i64, %c2_i64 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sle" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c49_i64 = arith.constant 49 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %c49_i64, %c35_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    %6 = llvm.icmp "eq" %5, %c_20_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %false = arith.constant false
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.urem %arg0, %c1_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.or %arg2, %c43_i64 : i64
    %4 = llvm.icmp "ugt" %arg1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.xor %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %c6_i64 = arith.constant 6 : i64
    %c17_i64 = arith.constant 17 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %c20_i64, %c20_i64 : i64
    %1 = llvm.icmp "ult" %c6_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %c_22_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.icmp "ule" %c17_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "slt" %0, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.udiv %c_25_i64, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.icmp "slt" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c11_i64 = arith.constant 11 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "slt" %0, %c11_i64 : i64
    %2 = llvm.and %arg0, %c_2_i64 : i64
    %3 = llvm.select %1, %2, %c_11_i64 : i1, i64
    %4 = llvm.sdiv %c41_i64, %3 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.icmp "slt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "eq" %c45_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %c1_i64, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.urem %arg1, %arg1 : i64
    %5 = llvm.xor %4, %arg2 : i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c40_i64 = arith.constant 40 : i64
    %c37_i64 = arith.constant 37 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.select %arg0, %c37_i64, %c8_i64 : i1, i64
    %1 = llvm.udiv %arg1, %arg1 : i64
    %2 = llvm.icmp "sge" %c40_i64, %arg1 : i64
    %3 = llvm.select %2, %c6_i64, %arg1 : i1, i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.xor %c2_i64, %arg0 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.sdiv %0, %4 : i64
    %6 = llvm.icmp "sgt" %c37_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c18_i64 = arith.constant 18 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.select %arg0, %c_1_i64, %arg1 : i1, i64
    %1 = llvm.and %c_8_i64, %c18_i64 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sle" %3, %c_10_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ule" %c_37_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %c_30_i64 = arith.constant -30 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %0, %c_30_i64 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %arg0, %c_45_i64 : i64
    %5 = llvm.select %4, %arg0, %1 : i1, i64
    %6 = llvm.icmp "ule" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %arg2, %c_4_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %2, %c_44_i64 : i64
    %4 = llvm.lshr %3, %c29_i64 : i64
    %5 = llvm.udiv %arg1, %4 : i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.urem %arg1, %arg1 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.ashr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c23_i64 = arith.constant 23 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.xor %c23_i64, %c_13_i64 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c28_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sext %arg1 : i1 to i64
    %6 = llvm.xor %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.urem %c_31_i64, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.and %c_33_i64, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "sge" %arg2, %c_4_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ne" %arg1, %c_30_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "eq" %c18_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.and %c_9_i64, %c10_i64 : i64
    %1 = llvm.urem %c_37_i64, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %c_11_i64, %1 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.icmp "uge" %5, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.udiv %c_16_i64, %c_34_i64 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %c_25_i64, %4 : i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "ne" %arg0, %c_31_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %arg1, %arg2 : i64
    %5 = llvm.udiv %4, %c_42_i64 : i64
    %6 = llvm.udiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sdiv %arg0, %c20_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c19_i64 = arith.constant 19 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.icmp "ult" %c7_i64, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.and %c19_i64, %c_3_i64 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.icmp "ult" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c49_i64 = arith.constant 49 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.or %arg0, %c22_i64 : i64
    %1 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "slt" %2, %c49_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.icmp "eq" %5, %c31_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %c_34_i64, %arg0 : i64
    %1 = llvm.and %c_44_i64, %0 : i64
    %2 = llvm.and %0, %0 : i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.sdiv %3, %arg1 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.xor %5, %c14_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c17_i64 = arith.constant 17 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "sle" %arg0, %c_42_i64 : i64
    %1 = llvm.select %0, %c17_i64, %arg0 : i1, i64
    %2 = llvm.lshr %1, %c14_i64 : i64
    %3 = llvm.srem %arg1, %arg0 : i64
    %4 = llvm.sdiv %3, %3 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.icmp "sgt" %5, %4 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %c5_i64 = arith.constant 5 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "sge" %c_47_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c_45_i64, %c5_i64 : i64
    %3 = llvm.and %arg0, %arg1 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.xor %4, %c_16_i64 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.xor %arg0, %c_9_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.srem %c18_i64, %0 : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.icmp "sge" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %c46_i64 = arith.constant 46 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "uge" %c46_i64, %c_20_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.urem %1, %c_1_i64 : i64
    %4 = llvm.select %0, %3, %1 : i1, i64
    %5 = llvm.urem %4, %arg0 : i64
    %6 = llvm.srem %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c9_i64 = arith.constant 9 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.and %c_2_i64, %c_34_i64 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.srem %c9_i64, %1 : i64
    %3 = llvm.and %2, %c16_i64 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %c34_i64 : i64
    %2 = llvm.or %arg0, %arg0 : i64
    %3 = llvm.icmp "slt" %c_21_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %1, %4, %0 : i1, i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c15_i64 = arith.constant 15 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c_46_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %c15_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %3, %c36_i64 : i64
    %5 = llvm.or %4, %arg1 : i64
    %6 = llvm.udiv %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.urem %arg2, %c49_i64 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "sge" %c_26_i64, %c_32_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg0, %arg1 : i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "uge" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.and %c_25_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %arg1, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %c4_i64, %arg1 : i64
    %4 = llvm.select %3, %arg1, %arg2 : i1, i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c35_i64 = arith.constant 35 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.urem %c35_i64, %c4_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.urem %0, %arg0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "ult" %3, %c0_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %c_7_i64, %arg0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %arg0, %arg1 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "ult" %c38_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.sdiv %3, %arg0 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.icmp "eq" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %arg0, %c48_i64 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.urem %1, %arg0 : i64
    %4 = llvm.icmp "eq" %3, %arg0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.urem %c_22_i64, %c26_i64 : i64
    %1 = llvm.sdiv %c7_i64, %0 : i64
    %2 = llvm.urem %c_10_i64, %arg0 : i64
    %3 = llvm.lshr %0, %c49_i64 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.xor %arg2, %c21_i64 : i64
    %2 = llvm.or %c9_i64, %1 : i64
    %3 = llvm.srem %arg2, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %c26_i64, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c5_i64 = arith.constant 5 : i64
    %false = arith.constant false
    %c7_i64 = arith.constant 7 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.sdiv %c7_i64, %c_31_i64 : i64
    %1 = llvm.select %false, %c5_i64, %c42_i64 : i1, i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.sdiv %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c18_i64 = arith.constant 18 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %c26_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.xor %c18_i64, %arg1 : i64
    %4 = llvm.sdiv %c_40_i64, %arg2 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "sge" %c_29_i64, %c40_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.icmp "sge" %c28_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %4, %arg0 : i64
    %6 = llvm.urem %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.icmp "sle" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "ugt" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %0, %4 : i64
    %6 = llvm.icmp "slt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.icmp "eq" %3, %arg1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ne" %5, %2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.lshr %c_43_i64, %arg0 : i64
    %1 = llvm.lshr %c_28_i64, %c11_i64 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.ashr %c_14_i64, %4 : i64
    %6 = llvm.icmp "sle" %c_31_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.udiv %arg0, %c_49_i64 : i64
    %1 = llvm.and %c_24_i64, %c7_i64 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.ashr %3, %c3_i64 : i64
    %5 = llvm.and %4, %0 : i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c38_i64 = arith.constant 38 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.select %arg0, %c26_i64, %arg1 : i1, i64
    %1 = llvm.or %c_32_i64, %0 : i64
    %2 = llvm.icmp "slt" %c_22_i64, %1 : i64
    %3 = llvm.lshr %arg2, %c38_i64 : i64
    %4 = llvm.select %2, %3, %c21_i64 : i1, i64
    %5 = llvm.lshr %c_32_i64, %4 : i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.udiv %c13_i64, %arg1 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg2, %arg0 : i64
    %4 = llvm.ashr %c_1_i64, %c_5_i64 : i64
    %5 = llvm.select %3, %arg2, %4 : i1, i64
    %6 = llvm.lshr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.sdiv %0, %c_27_i64 : i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %arg0, %1, %4 : i1, i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.ashr %arg1, %c32_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ule" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.sdiv %c_19_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.select %arg2, %arg0, %arg0 : i1, i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.srem %3, %c_44_i64 : i64
    %6 = llvm.select %4, %5, %arg0 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c43_i64 = arith.constant 43 : i64
    %c8_i64 = arith.constant 8 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.sdiv %c8_i64, %c32_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ugt" %c43_i64, %2 : i64
    %4 = llvm.srem %arg1, %arg2 : i64
    %5 = llvm.and %4, %4 : i64
    %6 = llvm.select %3, %arg0, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c24_i64 = arith.constant 24 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %c24_i64, %c_35_i64 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %arg1, %arg1 : i64
    %5 = llvm.srem %4, %c42_i64 : i64
    %6 = llvm.icmp "sle" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %c_23_i64 = arith.constant -23 : i64
    %false = arith.constant false
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.select %false, %arg1, %c29_i64 : i1, i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %c_23_i64, %arg1 : i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    %6 = llvm.select %5, %c_48_i64, %3 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.trunc %arg2 : i1 to i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.xor %c0_i64, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.sdiv %arg1, %4 : i64
    %6 = llvm.icmp "slt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.sdiv %0, %arg2 : i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.srem %3, %arg2 : i64
    %5 = llvm.ashr %c_10_i64, %4 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %false = arith.constant false
    %c24_i64 = arith.constant 24 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.select %arg0, %c31_i64, %arg1 : i1, i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %c24_i64, %2 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "ne" %5, %c21_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.urem %c_47_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.and %arg1, %c4_i64 : i64
    %3 = llvm.select %arg2, %1, %arg0 : i1, i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "eq" %c21_i64, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %1, %c_27_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %4, %arg2 : i64
    %6 = llvm.or %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c6_i64 = arith.constant 6 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.udiv %c_13_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %c6_i64 : i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %arg2, %c12_i64 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.udiv %5, %0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_20_i64 = arith.constant -20 : i64
    %c50_i64 = arith.constant 50 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %c50_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %4, %c_20_i64 : i64
    %6 = llvm.sdiv %c36_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "eq" %c_16_i64, %c_46_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %arg1 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.ashr %4, %1 : i64
    %6 = llvm.urem %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "uge" %c_6_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.sext %0 : i1 to i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "uge" %3, %c_27_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %5, %0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.urem %c_49_i64, %c39_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.ashr %1, %c_16_i64 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.lshr %arg0, %0 : i64
    %6 = llvm.or %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "sge" %c_41_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c_48_i64, %1 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.and %arg0, %arg2 : i64
    %5 = llvm.udiv %4, %arg1 : i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ne" %c_38_i64, %0 : i64
    %3 = llvm.ashr %0, %arg0 : i64
    %4 = llvm.select %2, %arg0, %3 : i1, i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.icmp "eq" %c_6_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %arg0, %0 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.lshr %c_6_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %c_39_i64 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.lshr %0, %0 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %2, %c39_i64 : i64
    %4 = llvm.icmp "eq" %3, %c_44_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.ashr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %true = arith.constant true
    %c34_i64 = arith.constant 34 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "eq" %arg0, %c_25_i64 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.select %0, %c_50_i64, %1 : i1, i64
    %3 = llvm.and %c34_i64, %arg2 : i64
    %4 = llvm.select %true, %1, %c_11_i64 : i1, i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.xor %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %c7_i64, %c_49_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg1, %0, %0 : i1, i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.select %false, %2, %2 : i1, i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %c45_i64, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.xor %3, %c_34_i64 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c20_i64 = arith.constant 20 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %c27_i64, %0 : i1, i64
    %2 = llvm.sdiv %1, %c20_i64 : i64
    %3 = llvm.and %c50_i64, %0 : i64
    %4 = llvm.or %3, %2 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.xor %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %c36_i64 : i64
    %2 = llvm.srem %arg0, %arg0 : i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.icmp "ult" %5, %c26_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c33_i64 = arith.constant 33 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.sdiv %c33_i64, %c_13_i64 : i64
    %1 = llvm.xor %0, %c27_i64 : i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %arg0, %arg1 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "ugt" %c18_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.select %0, %c_19_i64, %1 : i1, i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.srem %c_1_i64, %c23_i64 : i64
    %5 = llvm.and %c_2_i64, %4 : i64
    %6 = llvm.urem %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c_19_i64 = arith.constant -19 : i64
    %false = arith.constant false
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.srem %c_19_i64, %arg1 : i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    %3 = llvm.select %false, %2, %c13_i64 : i1, i64
    %4 = llvm.lshr %2, %arg2 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.srem %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.srem %1, %c1_i64 : i64
    %3 = llvm.icmp "eq" %c_19_i64, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.or %c_19_i64, %arg0 : i64
    %1 = llvm.sdiv %c25_i64, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.xor %arg0, %arg2 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.urem %c_3_i64, %arg1 : i64
    %4 = llvm.srem %c_34_i64, %3 : i64
    %5 = llvm.ashr %4, %arg0 : i64
    %6 = llvm.srem %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %c_44_i64, %arg2 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.or %arg1, %c15_i64 : i64
    %3 = llvm.icmp "uge" %c42_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %4, %2 : i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %c_2_i64, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.sdiv %arg0, %arg1 : i64
    %5 = llvm.xor %4, %arg1 : i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.select %false, %arg1, %arg2 : i1, i64
    %3 = llvm.icmp "uge" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.or %c_35_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %arg0, %arg0 : i64
    %4 = llvm.lshr %arg0, %0 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.udiv %c_8_i64, %arg0 : i64
    %3 = llvm.udiv %arg2, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.udiv %arg1, %0 : i64
    %3 = llvm.urem %2, %c15_i64 : i64
    %4 = llvm.or %1, %arg1 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c_4_i64 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c12_i64 = arith.constant 12 : i64
    %true = arith.constant true
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %c_50_i64, %0 : i64
    %2 = llvm.and %arg1, %0 : i64
    %3 = llvm.select %true, %0, %2 : i1, i64
    %4 = llvm.icmp "sle" %3, %c12_i64 : i64
    %5 = llvm.select %4, %arg2, %c29_i64 : i1, i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c11_i64 = arith.constant 11 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.urem %c33_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ult" %c11_i64, %c19_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.or %4, %arg1 : i64
    %6 = llvm.ashr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_18_i64 = arith.constant -18 : i64
    %c16_i64 = arith.constant 16 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ne" %c16_i64, %c_18_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.select %1, %arg0, %3 : i1, i64
    %5 = llvm.srem %arg0, %4 : i64
    %6 = llvm.xor %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %arg2, %c_15_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c_39_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.ashr %3, %2 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.or %c_16_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ne" %c_49_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.select %0, %3, %arg0 : i1, i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %c3_i64 = arith.constant 3 : i64
    %c_12_i64 = arith.constant -12 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.srem %c_12_i64, %c_19_i64 : i64
    %1 = llvm.ashr %c3_i64, %c_37_i64 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.or %c41_i64, %arg0 : i64
    %1 = llvm.xor %c14_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.urem %3, %arg0 : i64
    %5 = llvm.sdiv %0, %4 : i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.select %false, %c15_i64, %arg0 : i1, i64
    %1 = llvm.icmp "uge" %arg1, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c24_i64 = arith.constant 24 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.select %arg0, %c24_i64, %c9_i64 : i1, i64
    %3 = llvm.urem %c4_i64, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.sdiv %2, %c_34_i64 : i64
    %4 = llvm.ashr %arg1, %c27_i64 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.select %false, %c27_i64, %arg0 : i1, i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c29_i64 = arith.constant 29 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.or %arg0, %arg2 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.icmp "ult" %c46_i64, %arg0 : i64
    %4 = llvm.select %3, %c29_i64, %c_26_i64 : i1, i64
    %5 = llvm.select %2, %arg1, %4 : i1, i64
    %6 = llvm.urem %5, %c1_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.select %arg1, %4, %4 : i1, i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.sdiv %arg1, %c9_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %c18_i64, %0 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.urem %c27_i64, %2 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c48_i64 = arith.constant 48 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c5_i64 = arith.constant 5 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.lshr %c5_i64, %c44_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.urem %1, %c_27_i64 : i64
    %3 = llvm.icmp "ult" %c48_i64, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %4, %c17_i64 : i64
    %6 = llvm.icmp "sle" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.xor %arg0, %c_30_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.and %4, %c_24_i64 : i64
    %6 = llvm.xor %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %arg0 : i64
    %3 = llvm.srem %c17_i64, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.and %c_46_i64, %4 : i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "sge" %arg0, %c_44_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.or %3, %arg2 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.icmp "ne" %5, %c_40_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %false = arith.constant false
    %c35_i64 = arith.constant 35 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.udiv %c27_i64, %arg0 : i64
    %1 = llvm.urem %c35_i64, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.udiv %5, %c21_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c9_i64 = arith.constant 9 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "sle" %arg0, %c12_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %c9_i64 : i64
    %3 = llvm.udiv %c_14_i64, %arg1 : i64
    %4 = llvm.icmp "ult" %3, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.urem %c40_i64, %c_39_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "sgt" %0, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.select %arg0, %c_50_i64, %c_48_i64 : i1, i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.ashr %3, %3 : i64
    %5 = llvm.sdiv %0, %4 : i64
    %6 = llvm.icmp "ule" %5, %c19_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c_29_i64 = arith.constant -29 : i64
    %c36_i64 = arith.constant 36 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "eq" %c_24_i64, %c38_i64 : i64
    %1 = llvm.select %0, %c36_i64, %c_29_i64 : i1, i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.select %true, %3, %4 : i1, i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c25_i64 = arith.constant 25 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.ashr %c_35_i64, %c_12_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.srem %c25_i64, %1 : i64
    %3 = llvm.urem %c36_i64, %2 : i64
    %4 = llvm.ashr %c_35_i64, %c25_i64 : i64
    %5 = llvm.xor %4, %2 : i64
    %6 = llvm.icmp "ule" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c44_i64 = arith.constant 44 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.urem %c44_i64, %c_25_i64 : i64
    %1 = llvm.ashr %0, %c_41_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %c_17_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %4, %2 : i64
    %6 = llvm.icmp "ugt" %5, %c_9_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.xor %c35_i64, %c_1_i64 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %arg1, %4 : i64
    %6 = llvm.srem %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.and %c15_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.icmp "slt" %0, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %4, %c_21_i64 : i64
    %6 = llvm.select %2, %4, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c8_i64 = arith.constant 8 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.lshr %arg0, %c40_i64 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.or %c8_i64, %3 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.icmp "sge" %5, %c1_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_4_i64 = arith.constant -4 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c39_i64 = arith.constant 39 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.select %arg0, %c2_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ne" %c_43_i64, %0 : i64
    %2 = llvm.sdiv %c39_i64, %c_1_i64 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.select %1, %c_17_i64, %3 : i1, i64
    %5 = llvm.ashr %c_4_i64, %arg2 : i64
    %6 = llvm.srem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c12_i64 = arith.constant 12 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.udiv %c_18_i64, %arg1 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.sdiv %c_44_i64, %1 : i64
    %3 = llvm.icmp "ne" %2, %c12_i64 : i64
    %4 = llvm.select %3, %0, %1 : i1, i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.urem %5, %c7_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %c27_i64, %arg0 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.urem %3, %arg0 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %3, %0 : i64
    %5 = llvm.icmp "eq" %4, %arg0 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.urem %c_33_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg0 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %c_28_i64 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    %5 = llvm.select %4, %2, %c_34_i64 : i1, i64
    %6 = llvm.srem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.srem %c11_i64, %1 : i64
    %5 = llvm.udiv %c26_i64, %4 : i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.srem %arg0, %c3_i64 : i64
    %1 = llvm.ashr %0, %c_14_i64 : i64
    %2 = llvm.icmp "ule" %arg0, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %c39_i64, %arg0 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.ashr %c_37_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "uge" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %3, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c8_i64 = arith.constant 8 : i64
    %true = arith.constant true
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.select %true, %arg1, %c_30_i64 : i1, i64
    %1 = llvm.xor %c8_i64, %c_21_i64 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.lshr %arg2, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.or %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %c33_i64 = arith.constant 33 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %c15_i64 : i64
    %2 = llvm.icmp "uge" %c33_i64, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    %5 = llvm.urem %c_30_i64, %arg0 : i64
    %6 = llvm.sdiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c44_i64 = arith.constant 44 : i64
    %c7_i64 = arith.constant 7 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sdiv %0, %c7_i64 : i64
    %2 = llvm.sdiv %1, %c44_i64 : i64
    %3 = llvm.icmp "sgt" %c38_i64, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.xor %1, %c_48_i64 : i64
    %3 = llvm.urem %c_2_i64, %arg2 : i64
    %4 = llvm.icmp "ult" %3, %c_31_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.lshr %arg0, %c5_i64 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ult" %c6_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %c47_i64 = arith.constant 47 : i64
    %c30_i64 = arith.constant 30 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.urem %c30_i64, %c_18_i64 : i64
    %1 = llvm.and %0, %c47_i64 : i64
    %2 = llvm.urem %arg0, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "sle" %3, %c_49_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.xor %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.xor %arg1, %c38_i64 : i64
    %1 = llvm.icmp "sgt" %0, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %2, %c1_i64 : i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c2_i64 = arith.constant 2 : i64
    %c38_i64 = arith.constant 38 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.xor %c_23_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %c38_i64 : i64
    %2 = llvm.udiv %1, %c2_i64 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.ashr %1, %c_47_i64 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c6_i64 = arith.constant 6 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %c_29_i64, %arg1 : i64
    %2 = llvm.srem %1, %c6_i64 : i64
    %3 = llvm.icmp "sgt" %2, %c28_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.icmp "ne" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %4, %1 : i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.and %arg0, %c4_i64 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.udiv %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c8_i64 = arith.constant 8 : i64
    %c_10_i64 = arith.constant -10 : i64
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.urem %arg2, %arg1 : i64
    %3 = llvm.or %c8_i64, %2 : i64
    %4 = llvm.or %c_10_i64, %3 : i64
    %5 = llvm.xor %4, %c39_i64 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.sdiv %c_4_i64, %arg1 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.srem %arg0, %c36_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    %6 = llvm.icmp "ugt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c44_i64 = arith.constant 44 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.ashr %arg0, %c21_i64 : i64
    %1 = llvm.udiv %c_50_i64, %0 : i64
    %2 = llvm.srem %arg1, %arg2 : i64
    %3 = llvm.and %0, %c_26_i64 : i64
    %4 = llvm.and %c44_i64, %3 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c_22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %true, %0, %arg0 : i1, i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %c_22_i64, %c44_i64 : i64
    %5 = llvm.lshr %4, %arg1 : i64
    %6 = llvm.icmp "eq" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.srem %c17_i64, %3 : i64
    %5 = llvm.ashr %4, %arg0 : i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c_20_i64 = arith.constant -20 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %c38_i64 : i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.xor %2, %c_20_i64 : i64
    %4 = llvm.or %c34_i64, %arg1 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.udiv %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c40_i64 = arith.constant 40 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "sgt" %c40_i64, %c47_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %c2_i64, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.select %3, %arg1, %2 : i1, i64
    %5 = llvm.srem %4, %arg2 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.and %c_27_i64, %c9_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.sdiv %3, %arg1 : i64
    %5 = llvm.or %c_8_i64, %4 : i64
    %6 = llvm.icmp "eq" %c26_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %c40_i64 = arith.constant 40 : i64
    %c35_i64 = arith.constant 35 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %c29_i64, %arg0 : i64
    %1 = llvm.ashr %c35_i64, %0 : i64
    %2 = llvm.sdiv %1, %c40_i64 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %c_11_i64, %4 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ult" %1, %c_13_i64 : i64
    %3 = llvm.urem %0, %0 : i64
    %4 = llvm.select %2, %3, %3 : i1, i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.lshr %arg0, %c29_i64 : i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %1, %c_25_i64 : i64
    %5 = llvm.ashr %arg1, %4 : i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %0, %c_40_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.srem %3, %0 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "uge" %c20_i64, %arg0 : i64
    %1 = llvm.select %0, %c27_i64, %arg0 : i1, i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.or %c20_i64, %3 : i64
    %6 = llvm.select %4, %arg1, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "sle" %c47_i64, %c_35_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.ashr %arg0, %arg0 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.urem %4, %arg2 : i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.or %arg0, %c_40_i64 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.sdiv %c_1_i64, %1 : i64
    %3 = llvm.sdiv %arg2, %c_29_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.or %4, %4 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c34_i64 = arith.constant 34 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.urem %c_9_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %c_44_i64, %2 : i64
    %4 = llvm.icmp "sgt" %c34_i64, %3 : i64
    %5 = llvm.select %4, %c_23_i64, %c19_i64 : i1, i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "ule" %c_38_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %c_31_i64, %1 : i64
    %3 = llvm.lshr %arg2, %c_49_i64 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %c24_i64 = arith.constant 24 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.select %arg0, %c42_i64, %arg1 : i1, i64
    %1 = llvm.urem %0, %c_13_i64 : i64
    %2 = llvm.and %1, %c24_i64 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.ashr %0, %c_25_i64 : i64
    %6 = llvm.udiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c48_i64 = arith.constant 48 : i64
    %c45_i64 = arith.constant 45 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.udiv %c45_i64, %c13_i64 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.xor %c48_i64, %c15_i64 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sge" %arg0, %c6_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg0, %arg0 : i64
    %3 = llvm.icmp "uge" %2, %arg0 : i64
    %4 = llvm.select %3, %arg1, %arg1 : i1, i64
    %5 = llvm.select %0, %4, %c36_i64 : i1, i64
    %6 = llvm.and %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.and %c_44_i64, %c_16_i64 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %c_17_i64, %arg1 : i64
    %4 = llvm.sdiv %3, %c_2_i64 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c_47_i64 = arith.constant -47 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.udiv %0, %c10_i64 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.icmp "sge" %arg2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %0, %4 : i64
    %6 = llvm.icmp "ne" %c_47_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c48_i64 = arith.constant 48 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.xor %c48_i64, %c_20_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %3, %c20_i64 : i64
    %5 = llvm.select %4, %1, %arg1 : i1, i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c30_i64 = arith.constant 30 : i64
    %c15_i64 = arith.constant 15 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "sle" %c15_i64, %c37_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.urem %c_1_i64, %1 : i64
    %4 = llvm.or %c30_i64, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "sgt" %5, %2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c49_i64 = arith.constant 49 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.or %c43_i64, %arg0 : i64
    %1 = llvm.or %0, %c_13_i64 : i64
    %2 = llvm.xor %c49_i64, %0 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sge" %5, %c7_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.and %arg0, %c_4_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.xor %5, %arg0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.xor %c18_i64, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.urem %c_24_i64, %arg1 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.xor %arg0, %4 : i64
    %6 = llvm.icmp "sge" %5, %c19_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.and %c20_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.urem %c32_i64, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.udiv %arg0, %arg1 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.ashr %5, %arg0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c_39_i64 = arith.constant -39 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.or %c_10_i64, %arg0 : i64
    %1 = llvm.select %arg1, %c_11_i64, %arg0 : i1, i64
    %2 = llvm.icmp "ule" %c_39_i64, %0 : i64
    %3 = llvm.select %2, %0, %c27_i64 : i1, i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %c20_i64 = arith.constant 20 : i64
    %c_39_i64 = arith.constant -39 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.icmp "slt" %c_47_i64, %c_39_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.ashr %4, %c20_i64 : i64
    %6 = llvm.icmp "sgt" %5, %c_42_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %c11_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c_34_i64 = arith.constant -34 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %0, %c22_i64, %1 : i1, i64
    %3 = llvm.icmp "ugt" %arg1, %c_34_i64 : i64
    %4 = llvm.select %3, %arg2, %arg0 : i1, i64
    %5 = llvm.srem %4, %c4_i64 : i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "sge" %c19_i64, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.zext %1 : i1 to i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.and %c48_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %c_26_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "sge" %4, %c_12_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c6_i64 = arith.constant 6 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.sdiv %c_12_i64, %0 : i64
    %2 = llvm.srem %c6_i64, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.srem %3, %2 : i64
    %5 = llvm.xor %arg2, %4 : i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %c42_i64, %0 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %c_40_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.lshr %0, %arg1 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.icmp "ugt" %3, %c15_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c17_i64 = arith.constant 17 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "sgt" %c47_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %c_41_i64 : i64
    %3 = llvm.sdiv %c17_i64, %2 : i64
    %4 = llvm.srem %c_10_i64, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.srem %c_33_i64, %c_29_i64 : i64
    %1 = llvm.udiv %0, %c_19_i64 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "slt" %3, %0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "uge" %3, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c3_i64 = arith.constant 3 : i64
    %c_25_i64 = arith.constant -25 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.srem %c_25_i64, %c3_i64 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %2, %c_32_i64 : i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.udiv %arg0, %c9_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %c_24_i64 : i64
    %2 = llvm.select %1, %arg1, %c_37_i64 : i1, i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.sdiv %arg2, %c23_i64 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.icmp "uge" %5, %0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.or %1, %c_32_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ult" %5, %c_44_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.srem %3, %arg0 : i64
    %5 = llvm.urem %arg2, %4 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %arg1, %arg0 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.or %4, %0 : i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "ne" %c_38_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.trunc %0 : i1 to i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %c50_i64 = arith.constant 50 : i64
    %c47_i64 = arith.constant 47 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "uge" %c47_i64, %c_50_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %c_19_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.xor %c50_i64, %4 : i64
    %6 = llvm.and %5, %4 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.select %1, %arg0, %arg1 : i1, i64
    %3 = llvm.or %arg2, %c_29_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "sle" %c_33_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c17_i64 = arith.constant 17 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %arg2, %c6_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.srem %c17_i64, %1 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "eq" %5, %c16_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.sdiv %c_17_i64, %1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.icmp "sge" %arg1, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.lshr %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg1, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.sdiv %c31_i64, %c_31_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.srem %0, %0 : i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %c27_i64, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %0, %0 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.icmp "eq" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "uge" %c_5_i64, %c_48_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %c_11_i64, %1 : i64
    %3 = llvm.srem %1, %arg0 : i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.and %5, %3 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.or %arg0, %arg1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.or %2, %arg2 : i64
    %5 = llvm.or %4, %c12_i64 : i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %true = arith.constant true
    %c23_i64 = arith.constant 23 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.srem %arg0, %c0_i64 : i64
    %1 = llvm.and %c23_i64, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.sdiv %arg2, %2 : i64
    %4 = llvm.icmp "eq" %arg1, %3 : i64
    %5 = llvm.select %4, %c4_i64, %0 : i1, i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.and %arg2, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "sgt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %c39_i64, %1 : i64
    %6 = llvm.icmp "ult" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.urem %2, %arg1 : i64
    %5 = llvm.select %3, %0, %4 : i1, i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.udiv %c27_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.srem %c_41_i64, %2 : i64
    %4 = llvm.trunc %arg2 : i1 to i64
    %5 = llvm.urem %4, %arg1 : i64
    %6 = llvm.and %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.or %0, %c_45_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.srem %3, %c1_i64 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c_39_i64 = arith.constant -39 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.ashr %c_46_i64, %0 : i64
    %2 = llvm.xor %c_23_i64, %c_21_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.select %arg0, %c_39_i64, %3 : i1, i64
    %5 = llvm.sext %arg0 : i1 to i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c0_i64 = arith.constant 0 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.xor %c_9_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.ashr %c_14_i64, %1 : i64
    %3 = llvm.and %2, %c9_i64 : i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.urem %arg0, %4 : i64
    %6 = llvm.lshr %c0_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.xor %2, %c_1_i64 : i64
    %4 = llvm.icmp "ugt" %c_14_i64, %c42_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.udiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.and %c50_i64, %c28_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.sext %arg0 : i1 to i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c5_i64 = arith.constant 5 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %c_30_i64, %c48_i64 : i64
    %1 = llvm.icmp "ult" %c_26_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ult" %c5_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %c_49_i64, %arg0 : i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "ule" %arg0, %c6_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %c_47_i64, %c44_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %0, %0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.xor %arg0, %arg0 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c25_i64 = arith.constant 25 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.udiv %c23_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c25_i64 : i64
    %2 = llvm.select %arg1, %c_16_i64, %c_9_i64 : i1, i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %4, %c_25_i64 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.urem %arg1, %0 : i64
    %3 = llvm.lshr %2, %arg2 : i64
    %4 = llvm.ashr %3, %1 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.icmp "eq" %5, %c_16_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.xor %c_32_i64, %arg0 : i64
    %1 = llvm.sdiv %c_10_i64, %c_28_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.lshr %3, %arg1 : i64
    %5 = llvm.and %arg2, %arg0 : i64
    %6 = llvm.and %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c15_i64 = arith.constant 15 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %c15_i64, %0 : i64
    %2 = llvm.urem %1, %c26_i64 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.sdiv %c43_i64, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "sge" %arg2, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.zext %arg2 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "sle" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.icmp "slt" %4, %c_48_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ult" %arg1, %c_45_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ule" %5, %arg0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c38_i64 = arith.constant 38 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sgt" %arg0, %c6_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.srem %c38_i64, %c13_i64 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.sdiv %arg1, %c47_i64 : i64
    %6 = llvm.urem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %false = arith.constant false
    %c_3_i64 = arith.constant -3 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.select %arg2, %arg1, %c_35_i64 : i1, i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.sdiv %c_3_i64, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %c14_i64 = arith.constant 14 : i64
    %true = arith.constant true
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.select %arg0, %c18_i64, %arg1 : i1, i64
    %1 = llvm.select %true, %0, %arg1 : i1, i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.ashr %c14_i64, %c_18_i64 : i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "slt" %arg0, %c20_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %arg1, %arg0 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "uge" %5, %1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.lshr %c29_i64, %arg2 : i64
    %4 = llvm.lshr %arg1, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %c48_i64 = arith.constant 48 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "ult" %c_16_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c48_i64 : i1, i64
    %2 = llvm.srem %1, %c_46_i64 : i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.urem %arg0, %2 : i64
    %5 = llvm.xor %4, %arg1 : i64
    %6 = llvm.xor %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.lshr %c_19_i64, %c19_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.udiv %c44_i64, %1 : i64
    %3 = llvm.icmp "ne" %c_1_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.ashr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %c43_i64 : i64
    %3 = llvm.urem %0, %c15_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.icmp "ugt" %5, %4 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.srem %c39_i64, %arg0 : i64
    %1 = llvm.lshr %c_5_i64, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.select %arg1, %c_15_i64, %c_28_i64 : i1, i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.icmp "slt" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %c16_i64 = arith.constant 16 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %c16_i64, %c32_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.srem %arg1, %c_46_i64 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.xor %c_4_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %c3_i64 : i64
    %4 = llvm.xor %2, %arg0 : i64
    %5 = llvm.select %3, %4, %arg1 : i1, i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %c_13_i64, %1 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.or %0, %1 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.udiv %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %true = arith.constant true
    %c_50_i64 = arith.constant -50 : i64
    %c49_i64 = arith.constant 49 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.lshr %c_25_i64, %arg1 : i64
    %1 = llvm.urem %c49_i64, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.srem %arg2, %c_50_i64 : i64
    %4 = llvm.select %true, %arg2, %c33_i64 : i1, i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.xor %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "sle" %c10_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %c14_i64, %arg1 : i64
    %5 = llvm.xor %c_27_i64, %4 : i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %c_46_i64, %c_47_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg2, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.icmp "ule" %4, %c11_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.xor %c7_i64, %arg0 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c31_i64 = arith.constant 31 : i64
    %c26_i64 = arith.constant 26 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sdiv %c44_i64, %c39_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.lshr %c26_i64, %1 : i64
    %3 = llvm.xor %c31_i64, %2 : i64
    %4 = llvm.xor %c39_i64, %3 : i64
    %5 = llvm.or %1, %2 : i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.udiv %c_39_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.select %arg1, %c_37_i64, %0 : i1, i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.urem %arg2, %c6_i64 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %c35_i64, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ne" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "slt" %0, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %arg1, %3 : i64
    %5 = llvm.select %4, %3, %arg1 : i1, i64
    %6 = llvm.icmp "eq" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.udiv %c48_i64, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c32_i64 = arith.constant 32 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "slt" %c32_i64, %c_26_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %c31_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %3, %arg0 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "ule" %5, %1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.ashr %c_29_i64, %0 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "ugt" %c8_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %arg1, %c20_i64 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c_19_i64 = arith.constant -19 : i64
    %true = arith.constant true
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.and %c_16_i64, %arg0 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.sdiv %c_19_i64, %c9_i64 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %c36_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.and %4, %c50_i64 : i64
    %6 = llvm.icmp "eq" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %c28_i64 = arith.constant 28 : i64
    %c14_i64 = arith.constant 14 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.xor %arg0, %c15_i64 : i64
    %1 = llvm.urem %0, %c14_i64 : i64
    %2 = llvm.udiv %c_33_i64, %arg1 : i64
    %3 = llvm.or %c28_i64, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.urem %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c_20_i64 = arith.constant -20 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.srem %1, %c6_i64 : i64
    %3 = llvm.or %c_20_i64, %0 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.or %5, %c39_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.icmp "eq" %c_41_i64, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.urem %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.or %arg1, %c_33_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.select %arg0, %arg1, %c26_i64 : i1, i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.udiv %1, %c_22_i64 : i64
    %3 = llvm.srem %arg2, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %5, %arg1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %true = arith.constant true
    %c18_i64 = arith.constant 18 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %true, %0, %2 : i1, i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.lshr %c18_i64, %4 : i64
    %6 = llvm.xor %5, %c21_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.srem %0, %c_9_i64 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.sdiv %c_1_i64, %3 : i64
    %5 = llvm.or %4, %c_15_i64 : i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.select %false, %c4_i64, %arg0 : i1, i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %2, %c36_i64 : i64
    %4 = llvm.icmp "ule" %3, %arg0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.xor %3, %5 : i64
    return %6 : i64
  }
}
// -----
