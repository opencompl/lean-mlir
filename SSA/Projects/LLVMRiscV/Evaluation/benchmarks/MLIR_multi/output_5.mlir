module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.or %c18_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c_1_i64 = arith.constant -1 : i64
    %false = arith.constant false
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.ashr %c18_i64, %0 : i64
    %2 = llvm.urem %c_1_i64, %arg2 : i64
    %3 = llvm.select %false, %2, %c28_i64 : i1, i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.srem %c_45_i64, %c_22_i64 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "sge" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c10_i64 = arith.constant 10 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.lshr %c10_i64, %c5_i64 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %c_34_i64 : i64
    %4 = llvm.icmp "sle" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.and %0, %0 : i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %c_9_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %arg2, %c13_i64 : i64
    %2 = llvm.icmp "sle" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.ashr %c_37_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.sdiv %arg0, %c16_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.srem %2, %c25_i64 : i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.xor %c6_i64, %0 : i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.and %c_32_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.lshr %c_31_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %c_40_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg1, %arg2, %c_1_i64 : i1, i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ult" %arg0, %c_12_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c_1_i64, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c20_i64 = arith.constant 20 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.select %arg0, %c20_i64, %c35_i64 : i1, i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.or %1, %c_31_i64 : i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.srem %c47_i64, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.icmp "ult" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c_43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %0, %c_43_i64 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.and %arg0, %c8_i64 : i64
    %1 = llvm.srem %c_44_i64, %arg2 : i64
    %2 = llvm.sdiv %1, %c37_i64 : i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.srem %c_48_i64, %arg0 : i64
    %1 = llvm.or %c_2_i64, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.urem %2, %c44_i64 : i64
    %4 = llvm.icmp "sle" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.and %c_13_i64, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    %3 = llvm.udiv %arg0, %c5_i64 : i64
    %4 = llvm.select %2, %3, %0 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.sdiv %arg0, %c_11_i64 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c48_i64 = arith.constant 48 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %c48_i64, %0 : i64
    %2 = llvm.xor %1, %c29_i64 : i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.select %false, %1, %arg0 : i1, i64
    %3 = llvm.urem %2, %c38_i64 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %false, %arg0, %c20_i64 : i1, i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.select %1, %arg1, %arg1 : i1, i64
    %3 = llvm.icmp "uge" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %arg1, %c_15_i64, %c20_i64 : i1, i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %c5_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %c14_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.udiv %c_33_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.and %arg2, %c11_i64 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %c_10_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.urem %arg0, %0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c20_i64 = arith.constant 20 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.lshr %c_36_i64, %c_40_i64 : i64
    %1 = llvm.xor %c20_i64, %0 : i64
    %2 = llvm.or %arg1, %c_28_i64 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.udiv %c_24_i64, %arg0 : i64
    %1 = llvm.or %c15_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "slt" %arg1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.sdiv %arg2, %0 : i64
    %3 = llvm.srem %c30_i64, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %false = arith.constant false
    %c37_i64 = arith.constant 37 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.select %false, %c37_i64, %c6_i64 : i1, i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %c14_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c10_i64 = arith.constant 10 : i64
    %c19_i64 = arith.constant 19 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "slt" %c19_i64, %c44_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %c6_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %c10_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c48_i64 = arith.constant 48 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.srem %c_44_i64, %1 : i64
    %3 = llvm.xor %c48_i64, %c34_i64 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "sle" %c_19_i64, %c_29_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %c_48_i64, %1 : i64
    %3 = llvm.ashr %arg0, %1 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.srem %c32_i64, %1 : i64
    %3 = llvm.select %arg2, %c_25_i64, %2 : i1, i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.or %c10_i64, %arg1 : i64
    %2 = llvm.srem %arg2, %1 : i64
    %3 = llvm.lshr %c0_i64, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "slt" %c22_i64, %c48_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "eq" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.lshr %1, %c43_i64 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.xor %c2_i64, %arg0 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.icmp "sle" %1, %c22_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "slt" %c_24_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.select %3, %c42_i64, %c_34_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.and %c_36_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.lshr %arg0, %c_22_i64 : i64
    %1 = llvm.select %true, %arg1, %0 : i1, i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c46_i64 = arith.constant 46 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.select %arg0, %c32_i64, %arg1 : i1, i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    %2 = llvm.icmp "eq" %c46_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ne" %3, %c_48_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %c25_i64 = arith.constant 25 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.urem %c25_i64, %c_14_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.srem %3, %c_28_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.udiv %c_3_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %arg1, %0 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.and %c38_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.xor %arg2, %2 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.and %c_11_i64, %c26_i64 : i64
    %1 = llvm.icmp "sle" %arg0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "eq" %3, %c24_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.sdiv %c34_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.and %arg1, %c1_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %0, %c28_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %arg0, %arg2 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ugt" %c_8_i64, %c43_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %c45_i64, %1 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c1_i64 = arith.constant 1 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.ashr %c1_i64, %c42_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.xor %arg2, %c2_i64 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.xor %c_34_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %c_14_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.urem %c_22_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %c_13_i64, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c31_i64 = arith.constant 31 : i64
    %c34_i64 = arith.constant 34 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.urem %arg0, %c_46_i64 : i64
    %1 = llvm.urem %c34_i64, %0 : i64
    %2 = llvm.udiv %c31_i64, %1 : i64
    %3 = llvm.lshr %1, %c_8_i64 : i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.or %arg0, %c_17_i64 : i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "slt" %arg1, %arg1 : i64
    %1 = llvm.select %0, %arg2, %arg0 : i1, i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "sle" %3, %c20_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.and %c_30_i64, %2 : i64
    %4 = llvm.sdiv %c_46_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %arg2, %0 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.lshr %3, %0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ugt" %c_1_i64, %c_40_i64 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.srem %2, %c23_i64 : i64
    %4 = llvm.icmp "ne" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.sdiv %c5_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %c17_i64 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.xor %c_16_i64, %c_25_i64 : i64
    %1 = llvm.icmp "ne" %0, %c_29_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %c21_i64, %arg0 : i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %c13_i64 = arith.constant 13 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "sgt" %c_32_i64, %c25_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %c13_i64 : i64
    %3 = llvm.udiv %2, %c_36_i64 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %c_14_i64 = arith.constant -14 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.select %false, %c_14_i64, %c7_i64 : i1, i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.sdiv %2, %c_2_i64 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "slt" %3, %c_11_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %true = arith.constant true
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.select %true, %c0_i64, %0 : i1, i64
    %2 = llvm.xor %c34_i64, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "uge" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg1, %c42_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "sle" %c4_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.select %true, %1, %c17_i64 : i1, i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.and %3, %arg2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.and %arg0, %c24_i64 : i64
    %1 = llvm.icmp "eq" %0, %arg1 : i64
    %2 = llvm.select %1, %c_15_i64, %0 : i1, i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.ashr %arg0, %c12_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "slt" %arg0, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c40_i64 = arith.constant 40 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c17_i64 = arith.constant 17 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.udiv %c17_i64, %c27_i64 : i64
    %1 = llvm.or %c_18_i64, %0 : i64
    %2 = llvm.urem %1, %c40_i64 : i64
    %3 = llvm.urem %c31_i64, %0 : i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.select %true, %c13_i64, %0 : i1, i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.select %false, %c27_i64, %0 : i1, i64
    %2 = llvm.udiv %arg1, %0 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.urem %c_42_i64, %c_9_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.ashr %c_33_i64, %2 : i64
    %4 = llvm.icmp "sle" %c_47_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c32_i64 = arith.constant 32 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.urem %c32_i64, %c_21_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    %4 = llvm.icmp "ne" %c0_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c31_i64 = arith.constant 31 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ugt" %c_19_i64, %c_49_i64 : i64
    %1 = llvm.select %0, %c33_i64, %arg0 : i1, i64
    %2 = llvm.sdiv %c31_i64, %1 : i64
    %3 = llvm.select %0, %arg1, %2 : i1, i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.and %arg0, %c38_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.sdiv %arg1, %0 : i64
    %3 = llvm.ashr %c47_i64, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.xor %c11_i64, %c_7_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.lshr %arg0, %c_12_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.and %arg2, %arg2 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.xor %c_6_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c14_i64 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c17_i64 = arith.constant 17 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.or %arg0, %c_21_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "ugt" %c17_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %arg0, %c48_i64 : i64
    %1 = llvm.ashr %arg0, %c34_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c_33_i64 = arith.constant -33 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "slt" %c18_i64, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "ne" %c_33_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c_48_i64 = arith.constant -48 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %0, %c_48_i64 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.select %false, %c21_i64, %arg0 : i1, i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.icmp "ule" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "sge" %c15_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "sle" %c_37_i64, %c_43_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "eq" %2, %c_22_i64 : i64
    %4 = llvm.select %3, %arg0, %arg0 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "sge" %arg1, %c_14_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %3, %c_48_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %c_49_i64, %0 : i64
    %2 = llvm.and %c_50_i64, %0 : i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %c_19_i64, %0 : i64
    %2 = llvm.icmp "ugt" %arg1, %c_28_i64 : i64
    %3 = llvm.select %2, %0, %0 : i1, i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.sdiv %arg0, %c_26_i64 : i64
    %1 = llvm.lshr %c7_i64, %arg0 : i64
    %2 = llvm.sdiv %1, %c_21_i64 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %false = arith.constant false
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.and %c34_i64, %arg0 : i64
    %1 = llvm.select %false, %arg1, %arg1 : i1, i64
    %2 = llvm.sdiv %c44_i64, %arg2 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.xor %c7_i64, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.udiv %arg1, %c_17_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.lshr %c28_i64, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %c17_i64 = arith.constant 17 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %c20_i64, %0 : i64
    %2 = llvm.sdiv %c17_i64, %1 : i64
    %3 = llvm.xor %arg0, %c_15_i64 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c0_i64 = arith.constant 0 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %c0_i64, %0 : i64
    %2 = llvm.or %c_14_i64, %1 : i64
    %3 = llvm.ashr %c_41_i64, %2 : i64
    %4 = llvm.icmp "sle" %c_48_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %c_27_i64, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.srem %c9_i64, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg1, %c_47_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_4_i64 = arith.constant -4 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.srem %c_4_i64, %c7_i64 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c36_i64 = arith.constant 36 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.or %arg1, %c29_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.xor %c36_i64, %1 : i64
    %3 = llvm.icmp "uge" %c31_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %c_30_i64, %0 : i64
    %2 = llvm.sdiv %1, %c42_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c21_i64 = arith.constant 21 : i64
    %false = arith.constant false
    %c39_i64 = arith.constant 39 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.urem %c17_i64, %arg0 : i64
    %1 = llvm.select %false, %c21_i64, %c_1_i64 : i1, i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sle" %c39_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %1, %c29_i64 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.icmp "sle" %3, %c_21_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.udiv %3, %arg2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %c_3_i64 = arith.constant -3 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.udiv %c_3_i64, %c_41_i64 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %1, %c_34_i64, %2 : i1, i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "eq" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "uge" %arg0, %c_45_i64 : i64
    %1 = llvm.select %0, %arg1, %c33_i64 : i1, i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "uge" %arg0, %c_12_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "sge" %c31_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "ugt" %c8_i64, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg2 : i1, i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "ne" %2, %c20_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %true, %0, %2 : i1, i64
    %4 = llvm.udiv %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.icmp "sgt" %c44_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %c_44_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.select %arg0, %arg1, %c1_i64 : i1, i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "slt" %c31_i64, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.udiv %c_32_i64, %1 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %c_43_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.and %c30_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "ne" %c42_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.urem %c48_i64, %2 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %c46_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.sdiv %arg1, %arg1 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.and %arg2, %c35_i64 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.select %2, %c_41_i64, %arg1 : i1, i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %c36_i64, %0 : i64
    %2 = llvm.xor %1, %c14_i64 : i64
    %3 = llvm.or %1, %0 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.xor %0, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "ugt" %arg0, %c_47_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %3, %arg2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.and %c2_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.lshr %c_47_i64, %c_45_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.sdiv %0, %arg1 : i64
    %3 = llvm.sdiv %c29_i64, %2 : i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c48_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %arg2, %arg2 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.select %arg1, %0, %2 : i1, i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %c_24_i64, %c_47_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.or %arg1, %arg2 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "uge" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %c18_i64, %arg0 : i64
    %3 = llvm.select %2, %arg1, %arg0 : i1, i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %c_27_i64 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %c6_i64, %arg0 : i1, i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %c46_i64, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "ne" %c_46_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c_17_i64, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c25_i64 = arith.constant 25 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.lshr %c25_i64, %c23_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.and %1, %c18_i64 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.and %0, %arg2 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.udiv %c_7_i64, %arg0 : i64
    %1 = llvm.and %0, %c37_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.urem %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.select %1, %arg1, %2 : i1, i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ult" %c_44_i64, %c_40_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %c_21_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %3, %1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.srem %c_22_i64, %arg0 : i64
    %1 = llvm.ashr %c_17_i64, %0 : i64
    %2 = llvm.or %c_33_i64, %0 : i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c45_i64 = arith.constant 45 : i64
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %c45_i64, %c49_i64 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.icmp "sgt" %1, %c_15_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c23_i64 = arith.constant 23 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.udiv %c_44_i64, %c_38_i64 : i64
    %1 = llvm.or %c23_i64, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.or %2, %c_46_i64 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "sge" %c_34_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "ne" %arg0, %c_25_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.select %0, %2, %2 : i1, i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.select %2, %1, %arg0 : i1, i64
    %4 = llvm.icmp "ult" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.srem %c_20_i64, %0 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.select %arg0, %arg1, %c_23_i64 : i1, i64
    %1 = llvm.icmp "ule" %arg1, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.udiv %c40_i64, %1 : i64
    %3 = llvm.icmp "ult" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.lshr %c6_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.icmp "ne" %1, %c20_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.sdiv %c_6_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.select %2, %arg2, %c_19_i64 : i1, i64
    %4 = llvm.icmp "sgt" %c_33_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "ult" %c22_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.urem %2, %c_14_i64 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.select %arg0, %arg1, %c_41_i64 : i1, i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.urem %arg2, %c22_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.select %arg0, %c_20_i64, %arg1 : i1, i64
    %1 = llvm.icmp "sle" %c_49_i64, %0 : i64
    %2 = llvm.ashr %arg2, %arg2 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.icmp "sgt" %3, %c_18_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.udiv %c_39_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "ult" %c_48_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %3, %c0_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.srem %c1_i64, %c29_i64 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c42_i64 = arith.constant 42 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.ashr %c_38_i64, %c_34_i64 : i64
    %1 = llvm.and %c42_i64, %c17_i64 : i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "ne" %2, %c19_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.icmp "sle" %c_43_i64, %1 : i64
    %3 = llvm.select %2, %1, %c3_i64 : i1, i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.sdiv %c1_i64, %c49_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.lshr %c0_i64, %arg0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "ugt" %c_47_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.ashr %arg0, %c_17_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %c_23_i64, %0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c16_i64 = arith.constant 16 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.urem %c_35_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %c_1_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "ult" %c16_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c9_i64 = arith.constant 9 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "sge" %c5_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c9_i64, %1 : i64
    %3 = llvm.urem %c_7_i64, %arg1 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "ule" %arg0, %c_39_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %c42_i64 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c3_i64 = arith.constant 3 : i64
    %c36_i64 = arith.constant 36 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %c36_i64, %c14_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.select %arg0, %arg1, %c3_i64 : i1, i64
    %3 = llvm.sdiv %2, %c19_i64 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.or %arg0, %c50_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.or %c_42_i64, %arg0 : i64
    %1 = llvm.or %c41_i64, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.urem %c46_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c_16_i64 = arith.constant -16 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.select %arg1, %1, %c2_i64 : i1, i64
    %3 = llvm.udiv %c_16_i64, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.sdiv %arg0, %c_20_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %0, %c_35_i64 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "ult" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "sle" %c5_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.ashr %c46_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.lshr %arg0, %arg0 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "ult" %arg0, %c0_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %c45_i64 : i64
    %3 = llvm.select %2, %arg1, %arg2 : i1, i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.lshr %1, %c30_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.or %2, %c4_i64 : i64
    %4 = llvm.sdiv %3, %c_2_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.select %arg1, %arg2, %c_32_i64 : i1, i64
    %1 = llvm.select %arg1, %arg0, %c12_i64 : i1, i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "uge" %c_28_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.lshr %arg1, %arg1 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c_43_i64 = arith.constant -43 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.or %c34_i64, %arg0 : i64
    %1 = llvm.or %c_31_i64, %0 : i64
    %2 = llvm.lshr %c_43_i64, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %0, %0 : i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c16_i64 = arith.constant 16 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %c_20_i64, %0 : i64
    %2 = llvm.and %c16_i64, %1 : i64
    %3 = llvm.xor %c_16_i64, %2 : i64
    %4 = llvm.urem %c_50_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.and %arg0, %c_9_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.or %0, %0 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.udiv %c0_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg1, %arg2 : i64
    %2 = llvm.and %c_11_i64, %arg0 : i64
    %3 = llvm.select %1, %arg2, %2 : i1, i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %c_35_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c14_i64 = arith.constant 14 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.lshr %arg2, %c14_i64 : i64
    %3 = llvm.and %2, %c_40_i64 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %c_20_i64 : i64
    %2 = llvm.icmp "ule" %arg2, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.select %true, %0, %arg0 : i1, i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %c39_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %c11_i64, %1 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %c25_i64 = arith.constant 25 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "slt" %c_27_i64, %c49_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c25_i64, %1 : i64
    %3 = llvm.icmp "uge" %c_50_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.and %arg2, %arg0 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.or %0, %c_20_i64 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.xor %c_8_i64, %c42_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.or %2, %c_32_i64 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.and %arg0, %c1_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "sgt" %c_24_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %c50_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.and %c_43_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.srem %c_10_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %c_42_i64, %0 : i64
    %2 = llvm.select %1, %c_43_i64, %arg0 : i1, i64
    %3 = llvm.and %2, %c44_i64 : i64
    %4 = llvm.icmp "sge" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c46_i64 = arith.constant 46 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.udiv %c46_i64, %c_15_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.select %false, %1, %arg0 : i1, i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.srem %c4_i64, %1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.udiv %1, %c43_i64 : i64
    %3 = llvm.or %c_48_i64, %1 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "ugt" %c_7_i64, %c_20_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ult" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.sdiv %3, %arg2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.srem %c_27_i64, %1 : i64
    %3 = llvm.icmp "ugt" %c_10_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.and %arg0, %c31_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "eq" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "ule" %c_32_i64, %c30_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c_5_i64, %c_49_i64 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "sge" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c_20_i64 = arith.constant -20 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.sdiv %c7_i64, %arg0 : i64
    %1 = llvm.ashr %c_40_i64, %0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "slt" %c_20_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "uge" %c_12_i64, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.urem %c_25_i64, %c_27_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %3, %arg0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.udiv %c_44_i64, %0 : i64
    %3 = llvm.ashr %c34_i64, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "ugt" %c_28_i64, %c_9_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.and %arg0, %arg0 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.sdiv %arg2, %c42_i64 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.udiv %c40_i64, %0 : i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "ule" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "sgt" %c39_i64, %c19_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.select %false, %c46_i64, %arg2 : i1, i64
    %3 = llvm.select %true, %arg2, %2 : i1, i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "ne" %1, %c4_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.lshr %c_30_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.or %c2_i64, %arg2 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.select %arg0, %0, %2 : i1, i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ne" %c9_i64, %c_11_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ult" %c_34_i64, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.select %arg0, %c_2_i64, %c42_i64 : i1, i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "uge" %1, %c_17_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.ashr %c12_i64, %arg1 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %0, %c14_i64 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.lshr %arg2, %c_36_i64 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %c40_i64 = arith.constant 40 : i64
    %c_12_i64 = arith.constant -12 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %c_12_i64, %c_8_i64 : i64
    %1 = llvm.icmp "ult" %c40_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %2, %c_13_i64 : i64
    %4 = llvm.udiv %3, %0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c_31_i64 = arith.constant -31 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.urem %c_10_i64, %arg0 : i64
    %1 = llvm.lshr %c_31_i64, %0 : i64
    %2 = llvm.lshr %arg1, %arg1 : i64
    %3 = llvm.select %true, %2, %arg1 : i1, i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.srem %c18_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.ashr %arg1, %c19_i64 : i64
    %1 = llvm.xor %c41_i64, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "slt" %1, %arg2 : i64
    %3 = llvm.select %2, %1, %arg0 : i1, i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "slt" %0, %c_30_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %c_8_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %true = arith.constant true
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %c_29_i64, %1 : i64
    %3 = llvm.select %true, %c_24_i64, %arg2 : i1, i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.ashr %arg0, %c_20_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sdiv %arg0, %c12_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %1, %c10_i64 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %c4_i64, %c_41_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.or %1, %arg1 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %false, %0, %arg0 : i1, i64
    %2 = llvm.ashr %arg1, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %3, %c27_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ult" %c_11_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %c_3_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.ashr %c7_i64, %arg0 : i64
    %1 = llvm.sdiv %c4_i64, %arg1 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c_38_i64 = arith.constant -38 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.or %c3_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c_38_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ule" %c_37_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %c41_i64 = arith.constant 41 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.ashr %c41_i64, %c_3_i64 : i64
    %1 = llvm.lshr %0, %c_45_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.and %1, %0 : i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.icmp "eq" %arg1, %c_13_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %1, %0, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %true = arith.constant true
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.sdiv %c_32_i64, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.ashr %2, %c46_i64 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.urem %1, %c43_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.xor %c_10_i64, %arg0 : i64
    %1 = llvm.ashr %0, %c42_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.xor %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.sdiv %arg0, %c46_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.udiv %arg0, %c3_i64 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %arg0, %c35_i64 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.srem %0, %arg2 : i64
    %4 = llvm.select %2, %3, %c11_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.ashr %arg1, %c_39_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.lshr %arg1, %c0_i64 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "ugt" %c28_i64, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg1, %arg1 : i64
    %3 = llvm.select %arg0, %1, %2 : i1, i64
    %4 = llvm.icmp "uge" %c25_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "eq" %1, %c_33_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.select %0, %c_1_i64, %arg0 : i1, i64
    %2 = llvm.srem %arg1, %arg0 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %c_20_i64 = arith.constant -20 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ne" %c_20_i64, %c_12_i64 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %c_38_i64 : i1, i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %c_43_i64 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %c29_i64 = arith.constant 29 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sdiv %c29_i64, %0 : i64
    %2 = llvm.or %c_13_i64, %1 : i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %true = arith.constant true
    %c_16_i64 = arith.constant -16 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.ashr %arg0, %c45_i64 : i64
    %1 = llvm.select %true, %c_16_i64, %0 : i1, i64
    %2 = llvm.udiv %1, %c1_i64 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %c24_i64 : i64
    %2 = llvm.icmp "ult" %c_32_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg1, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %0, %c_3_i64 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.ashr %c19_i64, %0 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %c1_i64 = arith.constant 1 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %0, %c26_i64 : i64
    %2 = llvm.or %c1_i64, %arg2 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.urem %3, %c_15_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.and %c_50_i64, %c11_i64 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c_29_i64 = arith.constant -29 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %0, %c_29_i64 : i64
    %2 = llvm.icmp "sge" %c_36_i64, %1 : i64
    %3 = llvm.select %2, %1, %c_15_i64 : i1, i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "slt" %c40_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %c32_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c40_i64 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.udiv %c43_i64, %arg0 : i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %arg2, %arg0 : i64
    %2 = llvm.and %c_21_i64, %c25_i64 : i64
    %3 = llvm.select %1, %c_3_i64, %2 : i1, i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c34_i64 = arith.constant 34 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %c34_i64, %c_32_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %c12_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %c2_i64 = arith.constant 2 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.udiv %c2_i64, %arg2 : i64
    %2 = llvm.and %c39_i64, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.udiv %3, %c_49_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c_1_i64 = arith.constant -1 : i64
    %false = arith.constant false
    %c_41_i64 = arith.constant -41 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %arg1, %c45_i64 : i64
    %1 = llvm.select %arg0, %c_41_i64, %0 : i1, i64
    %2 = llvm.icmp "sle" %1, %arg2 : i64
    %3 = llvm.select %false, %c_1_i64, %c31_i64 : i1, i64
    %4 = llvm.select %2, %3, %arg1 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c33_i64 = arith.constant 33 : i64
    %true = arith.constant true
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.select %true, %c46_i64, %arg0 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.lshr %c33_i64, %c32_i64 : i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c45_i64 = arith.constant 45 : i64
    %c36_i64 = arith.constant 36 : i64
    %c26_i64 = arith.constant 26 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.and %c26_i64, %c39_i64 : i64
    %1 = llvm.xor %c45_i64, %c2_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.or %c36_i64, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.udiv %arg2, %c25_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.srem %c_47_i64, %arg0 : i64
    %1 = llvm.srem %c6_i64, %arg0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %1, %arg0 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c7_i64 = arith.constant 7 : i64
    %c14_i64 = arith.constant 14 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c22_i64, %0 : i64
    %2 = llvm.sdiv %1, %c16_i64 : i64
    %3 = llvm.urem %c14_i64, %2 : i64
    %4 = llvm.icmp "ne" %c7_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %c_42_i64 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "uge" %3, %c_42_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %c_25_i64 = arith.constant -25 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.select %false, %c_25_i64, %c34_i64 : i1, i64
    %1 = llvm.icmp "ule" %c32_i64, %0 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.icmp "slt" %c_45_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c45_i64 = arith.constant 45 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.udiv %c45_i64, %c_13_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.udiv %1, %c15_i64 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.select %arg0, %arg1, %c40_i64 : i1, i64
    %1 = llvm.and %c_23_i64, %0 : i64
    %2 = llvm.icmp "sgt" %c_39_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.udiv %c19_i64, %c_26_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.udiv %1, %c_13_i64 : i64
    %3 = llvm.lshr %2, %arg2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.ashr %c39_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %c13_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %arg1, %arg2 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.or %0, %c_4_i64 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.or %1, %0 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.sdiv %arg1, %arg2 : i64
    %3 = llvm.xor %2, %c7_i64 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %c_2_i64 : i64
    %3 = llvm.xor %2, %c_49_i64 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "sge" %arg0, %c_40_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %c33_i64 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.udiv %2, %c21_i64 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c5_i64 = arith.constant 5 : i64
    %true = arith.constant true
    %c_45_i64 = arith.constant -45 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.select %true, %c_45_i64, %c_6_i64 : i1, i64
    %1 = llvm.ashr %c5_i64, %0 : i64
    %2 = llvm.udiv %c20_i64, %arg0 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.xor %3, %2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sdiv %arg2, %c1_i64 : i64
    %3 = llvm.or %2, %c_5_i64 : i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "sge" %1, %c37_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "uge" %c_3_i64, %c_27_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %c_33_i64 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.srem %c_1_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.lshr %arg2, %arg2 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.select %1, %c_44_i64, %0 : i1, i64
    %3 = llvm.icmp "slt" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "eq" %arg0, %c42_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.udiv %c2_i64, %2 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.or %0, %c42_i64 : i64
    %2 = llvm.srem %arg1, %arg2 : i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "sgt" %c_15_i64, %c_16_i64 : i64
    %1 = llvm.icmp "slt" %arg0, %arg0 : i64
    %2 = llvm.select %1, %c_34_i64, %arg1 : i1, i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.sdiv %c7_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "sgt" %c_50_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.xor %c_35_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "eq" %c_19_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %c11_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.urem %c35_i64, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.xor %2, %c_6_i64 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.or %c_40_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.udiv %c_46_i64, %2 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.xor %c17_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %c_24_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c_50_i64, %2 : i64
    %4 = llvm.icmp "ule" %3, %c_19_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c34_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ult" %c_13_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %c_9_i64 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.icmp "uge" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.ashr %c6_i64, %c12_i64 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "slt" %arg0, %c_12_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.or %arg1, %arg1 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c32_i64 = arith.constant 32 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.xor %c_2_i64, %c_33_i64 : i64
    %1 = llvm.and %c32_i64, %0 : i64
    %2 = llvm.udiv %c33_i64, %1 : i64
    %3 = llvm.urem %c33_i64, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.and %2, %c_48_i64 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %c26_i64 = arith.constant 26 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.select %false, %c26_i64, %c_48_i64 : i1, i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.sdiv %1, %c_34_i64 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c_5_i64 = arith.constant -5 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %c_5_i64, %0 : i64
    %2 = llvm.icmp "ne" %1, %c38_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "ule" %arg0, %c6_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg0, %arg0 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %true, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.and %arg1, %c30_i64 : i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg2, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %c44_i64, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.ashr %c50_i64, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.srem %c_9_i64, %0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.ashr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.xor %c14_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %c_21_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.lshr %c_33_i64, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ne" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %c9_i64, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %true = arith.constant true
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.select %true, %c14_i64, %arg2 : i1, i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %false, %c_30_i64, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.or %c_29_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c_15_i64, %0 : i64
    %2 = llvm.or %arg1, %arg2 : i64
    %3 = llvm.select %1, %c_47_i64, %2 : i1, i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "sgt" %c_50_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "uge" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.lshr %c_38_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.xor %arg0, %c13_i64 : i64
    %1 = llvm.sdiv %arg0, %c_12_i64 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "sle" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.or %c47_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "sge" %c_25_i64, %c_22_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %c_15_i64, %0 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg1, %arg1 : i1, i64
    %2 = llvm.ashr %c_23_i64, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.srem %c41_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %c32_i64 = arith.constant 32 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "ne" %c_22_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "ugt" %c32_i64, %2 : i64
    %4 = llvm.select %3, %c_6_i64, %1 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.udiv %c_16_i64, %0 : i64
    %2 = llvm.udiv %1, %c21_i64 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.select %false, %2, %2 : i1, i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.xor %2, %c_33_i64 : i64
    %4 = llvm.icmp "ule" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %0 : i64
    %3 = llvm.select %2, %arg1, %arg1 : i1, i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.select %true, %1, %2 : i1, i64
    %4 = llvm.icmp "ule" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "ult" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c_36_i64 = arith.constant -36 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %c_36_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %c_40_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %arg2, %c_31_i64 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "sgt" %c_8_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ne" %c50_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %c13_i64 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.select %0, %2, %2 : i1, i64
    %4 = llvm.icmp "ult" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.srem %arg1, %c4_i64 : i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.ashr %1, %c_40_i64 : i64
    %3 = llvm.or %arg0, %1 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.srem %arg0, %c_42_i64 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "ult" %1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %false = arith.constant false
    %c_32_i64 = arith.constant -32 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.and %c_21_i64, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.select %false, %c24_i64, %arg0 : i1, i64
    %3 = llvm.xor %c_32_i64, %2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.lshr %c15_i64, %arg2 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %0, %arg2 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %c_11_i64, %0 : i64
    %2 = llvm.srem %0, %0 : i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c24_i64 = arith.constant 24 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "ule" %c24_i64, %c_37_i64 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.ashr %c_38_i64, %2 : i64
    %4 = llvm.icmp "ugt" %c_45_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.select %arg0, %c_14_i64, %arg1 : i1, i64
    %1 = llvm.sdiv %arg2, %c_40_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.or %c_25_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %arg1, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %c50_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "sgt" %arg0, %c_6_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "sge" %1, %c31_i64 : i64
    %3 = llvm.select %2, %1, %arg1 : i1, i64
    %4 = llvm.icmp "ule" %c_18_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.srem %c11_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.xor %arg2, %arg0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.xor %c_33_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %false, %c_9_i64, %0 : i1, i64
    %2 = llvm.or %arg1, %arg2 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c45_i64 = arith.constant 45 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "eq" %c21_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    %3 = llvm.and %c45_i64, %c_49_i64 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.select %2, %arg1, %0 : i1, i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "slt" %c_16_i64, %c_39_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %c4_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.sdiv %0, %c9_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "sgt" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.udiv %2, %c_27_i64 : i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.udiv %c_37_i64, %c16_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.xor %c26_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %c25_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %arg1, %arg2 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %arg0, %arg1 : i1, i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c_50_i64 = arith.constant -50 : i64
    %true = arith.constant true
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.select %true, %c_48_i64, %arg0 : i1, i64
    %1 = llvm.and %0, %c27_i64 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %c_50_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.and %c50_i64, %c_3_i64 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %arg0, %arg1 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %c19_i64, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ugt" %c19_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %0, %c22_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %arg1, %arg2 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %c9_i64 = arith.constant 9 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.ashr %c_17_i64, %c_38_i64 : i64
    %1 = llvm.udiv %0, %c9_i64 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.srem %c_12_i64, %2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c_34_i64 = arith.constant -34 : i64
    %c26_i64 = arith.constant 26 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.urem %c26_i64, %c19_i64 : i64
    %1 = llvm.srem %c_34_i64, %c44_i64 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c4_i64 = arith.constant 4 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.srem %c4_i64, %c_10_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.urem %1, %c35_i64 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.lshr %c_31_i64, %c_35_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %c37_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c42_i64 = arith.constant 42 : i64
    %c_24_i64 = arith.constant -24 : i64
    %false = arith.constant false
    %c1_i64 = arith.constant 1 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.select %false, %c1_i64, %c19_i64 : i1, i64
    %1 = llvm.or %0, %c_24_i64 : i64
    %2 = llvm.xor %1, %c42_i64 : i64
    %3 = llvm.icmp "sle" %2, %c7_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "ne" %c_6_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %c7_i64 = arith.constant 7 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.select %arg0, %c14_i64, %arg1 : i1, i64
    %1 = llvm.xor %0, %c7_i64 : i64
    %2 = llvm.and %arg2, %arg2 : i64
    %3 = llvm.xor %c_24_i64, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.or %c42_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %c_43_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.select %1, %2, %c_44_i64 : i1, i64
    %4 = llvm.icmp "uge" %c_43_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.select %arg0, %c47_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ule" %0, %c14_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "eq" %arg0, %c26_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %c27_i64, %arg1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ult" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %c_25_i64, %arg0 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.urem %c30_i64, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c39_i64 = arith.constant 39 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "sge" %c29_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %c39_i64, %arg1 : i64
    %3 = llvm.select %2, %arg2, %c26_i64 : i1, i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %c_21_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.sdiv %c_34_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.srem %3, %c25_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c35_i64 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.ashr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %c34_i64 = arith.constant 34 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.xor %c27_i64, %arg1 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.and %c34_i64, %1 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.icmp "sle" %3, %c_16_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.icmp "sgt" %1, %c46_i64 : i64
    %3 = llvm.select %2, %1, %arg2 : i1, i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.srem %c_6_i64, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %arg0, %3, %c6_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.udiv %c_38_i64, %arg0 : i64
    %1 = llvm.urem %c_35_i64, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.select %2, %arg0, %0 : i1, i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.srem %c23_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.select %true, %arg2, %0 : i1, i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.and %c_7_i64, %1 : i64
    %3 = llvm.udiv %2, %c47_i64 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c1_i64 = arith.constant 1 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.urem %c_30_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.and %1, %c1_i64 : i64
    %3 = llvm.select %false, %2, %arg2 : i1, i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.xor %c_13_i64, %0 : i64
    %2 = llvm.ashr %0, %arg2 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c25_i64 = arith.constant 25 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %c23_i64 : i64
    %2 = llvm.or %1, %c25_i64 : i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.udiv %3, %c38_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.srem %c_10_i64, %arg1 : i64
    %1 = llvm.select %arg0, %c12_i64, %0 : i1, i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.urem %c_7_i64, %c_31_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "slt" %c21_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "slt" %c_40_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.ashr %c46_i64, %c_17_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.icmp "eq" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "ule" %arg0, %c_28_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %c_27_i64 : i64
    %3 = llvm.lshr %c_5_i64, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %c_27_i64, %arg0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "ult" %arg0, %c28_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %arg1 : i64
    %3 = llvm.or %c35_i64, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c_6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ule" %0, %c_2_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %c_6_i64, %2 : i64
    %4 = llvm.or %c_16_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.or %c14_i64, %arg0 : i64
    %1 = llvm.srem %0, %c40_i64 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %c_30_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "sgt" %c_29_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg1, %arg0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %c_31_i64, %c32_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c_46_i64, %arg0 : i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "sge" %arg0, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.sdiv %1, %c_42_i64 : i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.lshr %c43_i64, %arg2 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "sge" %2, %c50_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.sdiv %c_7_i64, %c47_i64 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "slt" %c_15_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.srem %arg2, %arg1 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %true = arith.constant true
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.select %true, %c6_i64, %2 : i1, i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "eq" %c_26_i64, %0 : i64
    %2 = llvm.icmp "uge" %arg1, %c14_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %1, %3, %arg2 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.xor %c_30_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.srem %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.sdiv %c34_i64, %arg0 : i64
    %1 = llvm.urem %c31_i64, %0 : i64
    %2 = llvm.icmp "ult" %arg1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "sge" %arg2, %c_42_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    %3 = llvm.lshr %arg1, %arg1 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c13_i64 = arith.constant 13 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.ashr %c13_i64, %c_50_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.srem %c6_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.udiv %arg0, %c_33_i64 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %c5_i64 = arith.constant 5 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.urem %c5_i64, %c_9_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %c_16_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.xor %arg0, %c31_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.lshr %3, %arg2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %c_35_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.srem %c37_i64, %arg1 : i64
    %1 = llvm.icmp "sge" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.xor %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.udiv %c_28_i64, %c6_i64 : i64
    %1 = llvm.or %c49_i64, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "ugt" %c24_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c_23_i64, %c21_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c12_i64 : i64
    %2 = llvm.icmp "sle" %arg1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %c_49_i64, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.and %c33_i64, %2 : i64
    %4 = llvm.icmp "ult" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.lshr %c_46_i64, %c24_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "ugt" %c9_i64, %c8_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.trunc %0 : i1 to i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.and %c4_i64, %c20_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.select %2, %arg0, %arg1 : i1, i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.ashr %c_23_i64, %0 : i64
    %2 = llvm.urem %arg2, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.sdiv %c_25_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.srem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.select %arg0, %c35_i64, %arg1 : i1, i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %arg2, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "sge" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.urem %c_15_i64, %c22_i64 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.select %1, %c_26_i64, %0 : i1, i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "ne" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %c_28_i64 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %c43_i64 = arith.constant 43 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %c_11_i64, %c32_i64 : i64
    %1 = llvm.lshr %c43_i64, %c_16_i64 : i64
    %2 = llvm.ashr %arg0, %arg0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.or %c_5_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "slt" %c_12_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.ashr %2, %c_22_i64 : i64
    %4 = llvm.icmp "ne" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %c_28_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %c36_i64 = arith.constant 36 : i64
    %c_7_i64 = arith.constant -7 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "ne" %c_7_i64, %c_23_i64 : i64
    %1 = llvm.select %0, %c36_i64, %arg0 : i1, i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.select %0, %arg2, %c_6_i64 : i1, i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c27_i64 = arith.constant 27 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.srem %c_30_i64, %arg1 : i64
    %1 = llvm.and %arg2, %c50_i64 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.srem %c27_i64, %2 : i64
    %4 = llvm.xor %3, %2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "ult" %arg0, %c_24_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %3, %arg0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c19_i64 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.xor %c_5_i64, %0 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "sge" %c_41_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c_42_i64, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.select %0, %3, %c_21_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.srem %c26_i64, %c_18_i64 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.or %c31_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c_27_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %1, %c_24_i64, %arg1 : i1, i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "ult" %c_22_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %arg1, %arg2 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.and %arg1, %c_26_i64 : i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.and %c21_i64, %c26_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.urem %arg1, %0 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "sge" %3, %c_12_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.udiv %c_21_i64, %c_19_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %c_39_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c48_i64 = arith.constant 48 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.udiv %c_2_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %c48_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %0, %c42_i64 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "sle" %c_27_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %arg1, %c47_i64, %1 : i1, i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.select %arg0, %c_41_i64, %c_31_i64 : i1, i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ugt" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.or %arg1, %c3_i64 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %c_22_i64, %c40_i64 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %c43_i64 = arith.constant 43 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.srem %c_10_i64, %c_38_i64 : i64
    %1 = llvm.udiv %c43_i64, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.srem %c_33_i64, %arg0 : i64
    %1 = llvm.sdiv %c_12_i64, %0 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "sgt" %c38_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %c9_i64, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.sdiv %2, %c14_i64 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.xor %arg0, %c_33_i64 : i64
    %1 = llvm.udiv %c_24_i64, %c_40_i64 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.srem %c_46_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg1, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %c9_i64, %arg2 : i64
    %3 = llvm.select %2, %arg0, %0 : i1, i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.udiv %c_46_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.xor %c_28_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.select %arg1, %arg0, %c_38_i64 : i1, i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ult" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %c49_i64, %arg2 : i64
    %1 = llvm.and %0, %c40_i64 : i64
    %2 = llvm.icmp "uge" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %c_7_i64 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.sdiv %2, %c_12_i64 : i64
    %4 = llvm.sdiv %3, %0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %0, %c_2_i64 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c12_i64 = arith.constant 12 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.or %arg2, %c_18_i64 : i64
    %2 = llvm.lshr %c12_i64, %c8_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %arg2, %c_42_i64 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.xor %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "ult" %arg0, %c15_i64 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.icmp "eq" %c30_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "ugt" %arg0, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %c28_i64, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %3, %1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.ashr %arg2, %c11_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "uge" %c_33_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c_37_i64, %c2_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "sgt" %c28_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.lshr %c28_i64, %arg0 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "uge" %c_45_i64, %c_19_i64 : i64
    %1 = llvm.icmp "eq" %c_24_i64, %c_8_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "sle" %0, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.and %arg1, %arg2 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "sle" %c10_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.sdiv %arg0, %c13_i64 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %3, %c14_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %arg2 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.udiv %c_21_i64, %2 : i64
    %4 = llvm.srem %c7_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.lshr %c_27_i64, %arg0 : i64
    %2 = llvm.select %0, %1, %arg2 : i1, i64
    %3 = llvm.srem %1, %c_41_i64 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "eq" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.udiv %arg0, %c_19_i64 : i64
    %1 = llvm.icmp "sge" %0, %c_6_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.xor %arg2, %c31_i64 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.srem %arg2, %arg1 : i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c10_i64 = arith.constant 10 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %c49_i64 : i64
    %2 = llvm.udiv %c10_i64, %c29_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.select %3, %2, %0 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "eq" %c_13_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.or %3, %2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.udiv %2, %c46_i64 : i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg2, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %arg0, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sle" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %c_10_i64 : i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.and %arg0, %c_2_i64 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "slt" %arg0, %c41_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.udiv %3, %c_46_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c8_i64 = arith.constant 8 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "sge" %arg0, %c_38_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %arg1, %arg2, %c8_i64 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ule" %3, %c1_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.select %1, %0, %c46_i64 : i1, i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c46_i64 = arith.constant 46 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "ule" %c46_i64, %c_21_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.urem %3, %c14_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c_18_i64 = arith.constant -18 : i64
    %true = arith.constant true
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.udiv %c_46_i64, %arg0 : i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.srem %2, %c14_i64 : i64
    %4 = llvm.or %c_18_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %c_29_i64, %c32_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %3, %c_26_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.or %0, %c39_i64 : i64
    %2 = llvm.lshr %arg0, %arg0 : i64
    %3 = llvm.udiv %2, %c44_i64 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %c_41_i64, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.xor %arg0, %c_3_i64 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.udiv %c28_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %0 : i1, i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    %3 = llvm.select %2, %0, %c27_i64 : i1, i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.xor %arg0, %c48_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %c_5_i64, %0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "slt" %c29_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg1, %c_38_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "ne" %3, %c35_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "ne" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %2, %c24_i64 : i64
    %4 = llvm.icmp "slt" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c40_i64 = arith.constant 40 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.and %c0_i64, %arg0 : i64
    %1 = llvm.xor %c40_i64, %0 : i64
    %2 = llvm.icmp "eq" %arg1, %c23_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.sdiv %c_25_i64, %c_34_i64 : i64
    %1 = llvm.srem %arg0, %c16_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.sdiv %0, %arg0 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c17_i64 = arith.constant 17 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.udiv %c17_i64, %c_40_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.ashr %c30_i64, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.udiv %arg2, %c23_i64 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %arg0, %c37_i64, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c46_i64 = arith.constant 46 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.udiv %c_12_i64, %c_12_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ugt" %c46_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %c3_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.sdiv %c_2_i64, %c_36_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "ugt" %c_3_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.ashr %c41_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "ne" %1, %c29_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %arg2, %0 : i1, i64
    %2 = llvm.and %1, %c25_i64 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg1, %arg2 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.srem %c27_i64, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ule" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %c33_i64 = arith.constant 33 : i64
    %false = arith.constant false
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.select %arg0, %c22_i64, %arg1 : i1, i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.sdiv %c33_i64, %c_5_i64 : i64
    %3 = llvm.select %false, %2, %arg1 : i1, i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.ashr %arg0, %c_3_i64 : i64
    %1 = llvm.icmp "ugt" %arg1, %c20_i64 : i64
    %2 = llvm.select %1, %arg1, %arg1 : i1, i64
    %3 = llvm.or %c_3_i64, %2 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "eq" %arg0, %c_22_i64 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.select %0, %c_44_i64, %1 : i1, i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c5_i64 = arith.constant 5 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.srem %c30_i64, %arg0 : i64
    %1 = llvm.srem %c5_i64, %0 : i64
    %2 = llvm.xor %arg0, %0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ugt" %c_19_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c_3_i64 = arith.constant -3 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.ashr %arg2, %c_3_i64 : i64
    %3 = llvm.and %2, %c29_i64 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "sle" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %0, %0 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %false = arith.constant false
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.xor %2, %c_15_i64 : i64
    %4 = llvm.sdiv %3, %0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ult" %arg0, %c_49_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.or %2, %1 : i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %c_7_i64, %arg1 : i64
    %3 = llvm.or %c_31_i64, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.udiv %c16_i64, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c31_i64 = arith.constant 31 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %c31_i64, %c34_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %c47_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %c33_i64 = arith.constant 33 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %c_45_i64, %1 : i64
    %3 = llvm.lshr %c33_i64, %c_3_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c6_i64 = arith.constant 6 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %c21_i64, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sgt" %c6_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %c_43_i64, %2 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %c0_i64, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.ashr %c_35_i64, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.select %false, %arg1, %arg0 : i1, i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.udiv %3, %0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c50_i64 = arith.constant 50 : i64
    %true = arith.constant true
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.ashr %arg0, %c_23_i64 : i64
    %1 = llvm.select %true, %c50_i64, %0 : i1, i64
    %2 = llvm.icmp "ult" %1, %c_34_i64 : i64
    %3 = llvm.select %2, %arg1, %arg2 : i1, i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "uge" %arg0, %c_12_i64 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.icmp "uge" %c4_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.and %1, %c_47_i64 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.xor %arg0, %c34_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.select %arg0, %1, %arg2 : i1, i64
    %3 = llvm.ashr %c_14_i64, %2 : i64
    %4 = llvm.srem %3, %c9_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c29_i64 = arith.constant 29 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.sdiv %c_6_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.xor %c29_i64, %2 : i64
    %4 = llvm.icmp "sle" %3, %c30_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.sdiv %c18_i64, %c_19_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c49_i64 = arith.constant 49 : i64
    %c36_i64 = arith.constant 36 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.or %arg0, %c_23_i64 : i64
    %1 = llvm.srem %c36_i64, %0 : i64
    %2 = llvm.srem %arg0, %c49_i64 : i64
    %3 = llvm.lshr %2, %c_10_i64 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %c_35_i64, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.urem %2, %c_7_i64 : i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c_23_i64 = arith.constant -23 : i64
    %true = arith.constant true
    %c1_i64 = arith.constant 1 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.select %true, %c1_i64, %c_4_i64 : i1, i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.xor %1, %c_23_i64 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "sle" %3, %c_27_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %0, %3, %arg0 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %arg0, %0 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.urem %c_42_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.select %false, %arg1, %arg2 : i1, i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %c0_i64, %arg0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.ashr %0, %0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "uge" %c39_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %c39_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %c_13_i64, %arg1 : i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.udiv %arg0, %c16_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.srem %arg1, %0 : i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c41_i64 = arith.constant 41 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.urem %c41_i64, %c_11_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.or %arg0, %c16_i64 : i64
    %1 = llvm.xor %c_47_i64, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "ugt" %c_1_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg1, %arg0 : i64
    %3 = llvm.ashr %2, %c_36_i64 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.lshr %arg0, %c_46_i64 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.and %arg1, %c46_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.select %false, %1, %1 : i1, i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %arg2, %arg1 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "ne" %c_31_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c16_i64 = arith.constant 16 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.and %c16_i64, %c35_i64 : i64
    %1 = llvm.lshr %0, %c25_i64 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "sgt" %c17_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.lshr %c38_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %c_23_i64, %c31_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %c47_i64 = arith.constant 47 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c5_i64, %0 : i64
    %2 = llvm.and %c47_i64, %c_22_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ne" %c_32_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "ult" %c_34_i64, %arg0 : i64
    %1 = llvm.select %0, %c20_i64, %arg0 : i1, i64
    %2 = llvm.icmp "ule" %arg0, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c_5_i64 = arith.constant -5 : i64
    %true = arith.constant true
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %c48_i64 : i64
    %2 = llvm.select %true, %c_5_i64, %c_20_i64 : i1, i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "uge" %c_21_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c_10_i64 : i1, i64
    %2 = llvm.icmp "slt" %c_46_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_20_i64 = arith.constant -20 : i64
    %c29_i64 = arith.constant 29 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.udiv %c_32_i64, %c_25_i64 : i64
    %1 = llvm.or %0, %c29_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.srem %2, %c_20_i64 : i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c14_i64 = arith.constant 14 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg2, %c14_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %0, %c50_i64, %2 : i1, i64
    %4 = llvm.icmp "sle" %3, %c_27_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.urem %c_13_i64, %c_31_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.lshr %c_48_i64, %c9_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.xor %c_39_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.srem %2, %c36_i64 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %c29_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "ult" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "slt" %c34_i64, %c13_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "eq" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "ult" %c_31_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.or %2, %c_34_i64 : i64
    %4 = llvm.icmp "uge" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.xor %arg0, %c33_i64 : i64
    %1 = llvm.or %arg1, %c37_i64 : i64
    %2 = llvm.and %arg2, %0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.lshr %c_16_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.select %1, %c_4_i64, %c_35_i64 : i1, i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.lshr %c45_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.or %arg0, %arg2 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.urem %c50_i64, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.udiv %arg2, %c_1_i64 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %true, %arg1, %c21_i64 : i1, i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c46_i64 = arith.constant 46 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "uge" %c46_i64, %c9_i64 : i64
    %1 = llvm.select %0, %c_15_i64, %arg0 : i1, i64
    %2 = llvm.sdiv %1, %c22_i64 : i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %c19_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.or %c_12_i64, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.sdiv %c5_i64, %arg0 : i64
    %1 = llvm.select %arg1, %c44_i64, %arg0 : i1, i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c42_i64 = arith.constant 42 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.srem %arg0, %c_14_i64 : i64
    %1 = llvm.ashr %c_42_i64, %c_10_i64 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.sdiv %c42_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.and %0, %c26_i64 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.sdiv %2, %c_22_i64 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %arg0, %c48_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.sdiv %0, %arg1 : i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %c6_i64, %0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.or %c3_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c_12_i64 = arith.constant -12 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "ult" %c_12_i64, %c_8_i64 : i64
    %1 = llvm.and %arg0, %c18_i64 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.select %0, %c_11_i64, %2 : i1, i64
    %4 = llvm.icmp "ule" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %c_43_i64 = arith.constant -43 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %0, %c_43_i64 : i64
    %2 = llvm.udiv %1, %c_36_i64 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.xor %c40_i64, %c_43_i64 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "ugt" %arg0, %c22_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %c24_i64, %1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "eq" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %c_25_i64, %arg1 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.select %1, %2, %c_37_i64 : i1, i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.icmp "sge" %3, %c_42_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %c_17_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.urem %arg2, %c_20_i64 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c26_i64 = arith.constant 26 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.lshr %c_43_i64, %1 : i64
    %3 = llvm.or %c26_i64, %2 : i64
    %4 = llvm.and %c34_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %true = arith.constant true
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.and %arg0, %c_30_i64 : i64
    %1 = llvm.select %true, %c9_i64, %arg0 : i1, i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %3, %0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "eq" %c24_i64, %c_4_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %arg0, %arg1 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.select %false, %arg2, %c8_i64 : i1, i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %0, %c_14_i64, %2 : i1, i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.ashr %arg0, %c42_i64 : i64
    %1 = llvm.icmp "ule" %c_36_i64, %arg0 : i64
    %2 = llvm.select %1, %arg1, %arg1 : i1, i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "slt" %c_32_i64, %c_21_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c18_i64 = arith.constant 18 : i64
    %c17_i64 = arith.constant 17 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.sdiv %c17_i64, %c_25_i64 : i64
    %1 = llvm.xor %c18_i64, %arg0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "eq" %3, %c_47_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %true = arith.constant true
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %true, %0, %c4_i64 : i1, i64
    %2 = llvm.icmp "sge" %c23_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.select %true, %c42_i64, %arg0 : i1, i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.sdiv %arg1, %arg2 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "ule" %c_39_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c_8_i64, %c23_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.or %c_1_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.lshr %c_17_i64, %arg1 : i64
    %3 = llvm.select %1, %2, %c21_i64 : i1, i64
    %4 = llvm.icmp "slt" %c_33_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg0, %arg1 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sdiv %c_4_i64, %c28_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %c_43_i64, %c_32_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.lshr %c_50_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %c19_i64, %2 : i64
    %4 = llvm.icmp "slt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.lshr %c36_i64, %1 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.srem %arg1, %c39_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.urem %arg2, %c37_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %arg1, %0, %0 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %arg2, %c_17_i64 : i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.udiv %1, %c_27_i64 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.xor %2, %c_31_i64 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.lshr %c_43_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "ule" %arg1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.udiv %arg0, %c_16_i64 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.srem %c_23_i64, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c18_i64 = arith.constant 18 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "ne" %arg0, %c_32_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.xor %c_1_i64, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "sge" %c18_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c14_i64, %1 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %arg0, %c20_i64 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.xor %c_2_i64, %2 : i64
    %4 = llvm.icmp "sle" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.urem %c_29_i64, %1 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %c_19_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %c_13_i64 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.ashr %arg0, %c_9_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "uge" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %c19_i64, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.trunc %arg0 : i1 to i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.urem %c_35_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.sdiv %arg1, %arg1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.udiv %arg0, %c_7_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %3, %c_50_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c18_i64 = arith.constant 18 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.select %arg0, %c33_i64, %arg1 : i1, i64
    %1 = llvm.or %c18_i64, %0 : i64
    %2 = llvm.lshr %1, %c_48_i64 : i64
    %3 = llvm.srem %c_30_i64, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.srem %c_19_i64, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c45_i64 = arith.constant 45 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %arg2 : i64
    %3 = llvm.select %2, %c45_i64, %c_23_i64 : i1, i64
    %4 = llvm.icmp "ugt" %c46_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sgt" %c_39_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %c_49_i64, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %c15_i64 : i64
    %2 = llvm.icmp "ult" %0, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %c_39_i64 = arith.constant -39 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.or %c_29_i64, %arg1 : i64
    %1 = llvm.select %arg0, %0, %c_15_i64 : i1, i64
    %2 = llvm.sdiv %c_39_i64, %1 : i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.or %3, %c_22_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.udiv %c29_i64, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.and %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c17_i64 = arith.constant 17 : i64
    %true = arith.constant true
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.ashr %arg0, %c33_i64 : i64
    %1 = llvm.select %true, %0, %c30_i64 : i1, i64
    %2 = llvm.icmp "ule" %c17_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c_37_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "sle" %c31_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.lshr %arg0, %c_4_i64 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.sdiv %c_28_i64, %c_36_i64 : i64
    %1 = llvm.or %c28_i64, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %c50_i64 = arith.constant 50 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.sdiv %c50_i64, %c49_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.icmp "slt" %c_38_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.xor %c_49_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c33_i64 = arith.constant 33 : i64
    %c8_i64 = arith.constant 8 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.lshr %c8_i64, %c46_i64 : i64
    %1 = llvm.lshr %0, %c33_i64 : i64
    %2 = llvm.or %1, %c26_i64 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "uge" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %c49_i64 = arith.constant 49 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.ashr %c49_i64, %c15_i64 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.udiv %c_44_i64, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %c24_i64, %0 : i64
    %2 = llvm.sdiv %1, %c_49_i64 : i64
    %3 = llvm.ashr %2, %c_1_i64 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %c50_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.sdiv %arg1, %0 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %c_34_i64, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %c_42_i64, %c_11_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %c_2_i64 : i64
    %4 = llvm.icmp "ule" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c5_i64 = arith.constant 5 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %c5_i64, %1 : i64
    %3 = llvm.icmp "uge" %2, %c42_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.select %false, %0, %c_5_i64 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.urem %c7_i64, %c_37_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.lshr %c_33_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.and %c_35_i64, %c39_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c33_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.urem %c38_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg1 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "sle" %c_42_i64, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.and %3, %arg2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %true = arith.constant true
    %c12_i64 = arith.constant 12 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.select %true, %c12_i64, %c2_i64 : i1, i64
    %1 = llvm.xor %0, %c37_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.ashr %c_9_i64, %c13_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.xor %2, %0 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c_32_i64, %c23_i64 : i64
    %2 = llvm.select %1, %0, %arg1 : i1, i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.srem %arg0, %c40_i64 : i64
    %1 = llvm.lshr %c_14_i64, %c8_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c44_i64 = arith.constant 44 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %c44_i64, %c_32_i64 : i64
    %1 = llvm.sdiv %c_15_i64, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.lshr %2, %c_1_i64 : i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %c_2_i64, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.select %arg2, %c0_i64, %2 : i1, i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c46_i64 = arith.constant 46 : i64
    %c29_i64 = arith.constant 29 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.xor %c29_i64, %c28_i64 : i64
    %1 = llvm.ashr %0, %c_42_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "slt" %c46_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %true = arith.constant true
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.select %true, %c39_i64, %2 : i1, i64
    %4 = llvm.icmp "eq" %c_29_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "ugt" %c_16_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %c_22_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %c49_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %c_23_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %c26_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %0 : i64
    %3 = llvm.select %2, %c30_i64, %1 : i1, i64
    %4 = llvm.udiv %c_27_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %c14_i64, %0 : i1, i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c12_i64, %1 : i64
    %3 = llvm.sext %0 : i1 to i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.ashr %c15_i64, %c3_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.icmp "ult" %arg1, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.ashr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %c25_i64, %2 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c47_i64 = arith.constant 47 : i64
    %true = arith.constant true
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.or %arg1, %c47_i64 : i64
    %4 = llvm.select %2, %3, %c6_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "sge" %c42_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.ashr %1, %c_29_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.xor %0, %c_18_i64 : i64
    %2 = llvm.lshr %arg2, %arg2 : i64
    %3 = llvm.xor %2, %c49_i64 : i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %true = arith.constant true
    %c_33_i64 = arith.constant -33 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.udiv %c_33_i64, %c14_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.or %arg0, %c_39_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c12_i64 = arith.constant 12 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.xor %c39_i64, %arg0 : i64
    %1 = llvm.and %c12_i64, %0 : i64
    %2 = llvm.urem %c10_i64, %1 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    %4 = llvm.icmp "sgt" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.lshr %arg0, %c22_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c8_i64 = arith.constant 8 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %c_22_i64, %c40_i64 : i64
    %1 = llvm.xor %c8_i64, %0 : i64
    %2 = llvm.icmp "ule" %c20_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.sdiv %arg0, %c_25_i64 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.udiv %c_30_i64, %2 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.ashr %c49_i64, %1 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.and %c_27_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c22_i64 = arith.constant 22 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.and %c22_i64, %c_31_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.urem %c32_i64, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.sdiv %c12_i64, %arg0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.select %false, %0, %2 : i1, i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.srem %1, %c_19_i64 : i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.xor %c14_i64, %c_40_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.and %c7_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.select %true, %2, %arg1 : i1, i64
    %4 = llvm.icmp "uge" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.or %arg0, %c_34_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.urem %arg2, %arg2 : i64
    %3 = llvm.select %arg1, %0, %2 : i1, i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c_6_i64 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c50_i64 = arith.constant 50 : i64
    %c17_i64 = arith.constant 17 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "sge" %c17_i64, %c50_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %c_41_i64 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.sdiv %c_15_i64, %2 : i64
    %4 = llvm.icmp "sgt" %c_48_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c_31_i64 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.select %arg2, %c1_i64, %arg0 : i1, i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.sdiv %c_13_i64, %c23_i64 : i64
    %1 = llvm.or %0, %c47_i64 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %c_46_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c_3_i64 = arith.constant -3 : i64
    %c44_i64 = arith.constant 44 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.lshr %c44_i64, %c_19_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.udiv %1, %c_3_i64 : i64
    %3 = llvm.and %2, %c21_i64 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %true, %2, %2 : i1, i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "ne" %c_12_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.select %arg2, %0, %c_34_i64 : i1, i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.lshr %c_25_i64, %c_13_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.and %arg0, %1 : i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.udiv %arg0, %c29_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.or %1, %c_14_i64 : i64
    %3 = llvm.and %arg1, %arg1 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg2, %c_27_i64 : i64
    %3 = llvm.sdiv %2, %c32_i64 : i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %true = arith.constant true
    %c_13_i64 = arith.constant -13 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.lshr %c_42_i64, %arg0 : i64
    %1 = llvm.select %true, %c_13_i64, %0 : i1, i64
    %2 = llvm.lshr %0, %c_1_i64 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.sdiv %c_47_i64, %c_28_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c_22_i64 : i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %2, %c_13_i64 : i64
    %4 = llvm.lshr %3, %arg0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "uge" %c_10_i64, %c_36_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %c_39_i64, %0 : i64
    %2 = llvm.and %0, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c29_i64 = arith.constant 29 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.lshr %c_3_i64, %arg0 : i64
    %1 = llvm.or %c29_i64, %0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "sge" %2, %c2_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.srem %arg2, %arg1 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.and %c_33_i64, %c_29_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %0, %0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "ule" %3, %c40_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.ashr %c43_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %0, %c_31_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "slt" %arg0, %c_19_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "eq" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "sgt" %c_50_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "slt" %arg0, %c36_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.sdiv %3, %c16_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c23_i64 = arith.constant 23 : i64
    %c37_i64 = arith.constant 37 : i64
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.ashr %c39_i64, %0 : i64
    %2 = llvm.and %1, %c23_i64 : i64
    %3 = llvm.sdiv %c37_i64, %2 : i64
    %4 = llvm.icmp "sge" %3, %c42_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %c_26_i64 : i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.urem %arg0, %c25_i64 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.or %0, %c_42_i64 : i64
    %3 = llvm.srem %arg2, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.and %arg2, %c_5_i64 : i64
    %2 = llvm.ashr %1, %c_1_i64 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %c_5_i64, %0 : i64
    %2 = llvm.icmp "slt" %0, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.urem %c_26_i64, %c_24_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg2, %0 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.ashr %c_30_i64, %arg2 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.sdiv %arg0, %c10_i64 : i64
    %1 = llvm.xor %0, %c1_i64 : i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %3, %c0_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %c_8_i64, %0 : i64
    %2 = llvm.xor %c_4_i64, %1 : i64
    %3 = llvm.urem %0, %1 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %c1_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.urem %3, %2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.lshr %arg0, %c47_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.ashr %c_18_i64, %1 : i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.icmp "ule" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "uge" %c21_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.xor %c_8_i64, %c_23_i64 : i64
    %1 = llvm.icmp "sgt" %c42_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.and %c_18_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.ashr %arg2, %c_44_i64 : i64
    %4 = llvm.select %2, %c41_i64, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.ashr %c0_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.icmp "sgt" %arg1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sdiv %arg0, %c33_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %c_48_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %c_15_i64 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c28_i64 = arith.constant 28 : i64
    %c2_i64 = arith.constant 2 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.and %c2_i64, %c_47_i64 : i64
    %1 = llvm.icmp "ule" %c28_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c_43_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.ashr %c45_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.sdiv %0, %arg1 : i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "ugt" %c27_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %c_45_i64, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.srem %c_13_i64, %2 : i64
    %4 = llvm.urem %c_2_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.select %false, %arg0, %c49_i64 : i1, i64
    %1 = llvm.sdiv %arg0, %arg2 : i64
    %2 = llvm.icmp "eq" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %c_7_i64, %c48_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.udiv %c32_i64, %c1_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.and %c26_i64, %arg2 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %c_36_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %c15_i64 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.select %0, %2, %c_22_i64 : i1, i64
    %4 = llvm.icmp "ugt" %3, %c_37_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %c18_i64 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %c_12_i64, %arg0 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.icmp "ult" %1, %c24_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.lshr %c_2_i64, %arg0 : i64
    %1 = llvm.and %0, %c33_i64 : i64
    %2 = llvm.icmp "slt" %c_10_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %c7_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.srem %c_49_i64, %c_3_i64 : i64
    %1 = llvm.select %arg0, %arg1, %c_23_i64 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    %4 = llvm.select %3, %1, %arg1 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.or %c_43_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.and %c_27_i64, %1 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %c_7_i64 = arith.constant -7 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.and %c_7_i64, %c28_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.srem %c_29_i64, %1 : i64
    %3 = llvm.and %0, %arg0 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %c41_i64 : i1, i64
    %2 = llvm.urem %c_21_i64, %arg1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c43_i64 = arith.constant 43 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.and %c43_i64, %c39_i64 : i64
    %1 = llvm.or %c_10_i64, %0 : i64
    %2 = llvm.udiv %1, %c_49_i64 : i64
    %3 = llvm.udiv %1, %c42_i64 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %arg0 : i1 to i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.urem %c9_i64, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "slt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.and %c_8_i64, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c50_i64 = arith.constant 50 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.ashr %arg2, %c0_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.icmp "sge" %c50_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c21_i64 = arith.constant 21 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %c21_i64 : i1, i64
    %3 = llvm.lshr %c_2_i64, %2 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sgt" %c6_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %c26_i64 : i64
    %2 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %c39_i64, %c48_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c4_i64 = arith.constant 4 : i64
    %c_31_i64 = arith.constant -31 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %c4_i64, %c49_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ugt" %c_31_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.ashr %c35_i64, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.or %c_27_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c44_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %arg1, %arg0 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %c_39_i64 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.select %3, %arg0, %c10_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %c26_i64, %c_14_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %arg2, %arg1 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.sdiv %1, %arg1 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.xor %c19_i64, %c_46_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "eq" %3, %c5_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %c40_i64 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c5_i64 = arith.constant 5 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.select %false, %c5_i64, %c14_i64 : i1, i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_18_i64 = arith.constant -18 : i64
    %c50_i64 = arith.constant 50 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.lshr %c50_i64, %c29_i64 : i64
    %1 = llvm.udiv %c_18_i64, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.xor %arg0, %arg0 : i64
    %3 = llvm.select %1, %2, %arg0 : i1, i64
    %4 = llvm.icmp "ne" %c16_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "ult" %c42_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.urem %2, %c_14_i64 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c12_i64 = arith.constant 12 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.ashr %c12_i64, %c7_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.urem %c41_i64, %1 : i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.xor %c_6_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "sge" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.udiv %c_13_i64, %2 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %c42_i64 = arith.constant 42 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.udiv %c42_i64, %c_10_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.xor %c_5_i64, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %c_11_i64, %0 : i64
    %2 = llvm.or %c_45_i64, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "ugt" %arg0, %c15_i64 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.xor %arg1, %arg1 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.or %arg0, %c16_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.and %c15_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c34_i64 = arith.constant 34 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %c_2_i64, %0 : i64
    %2 = llvm.srem %c11_i64, %arg1 : i64
    %3 = llvm.srem %c34_i64, %2 : i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "uge" %c18_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "uge" %arg0, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.urem %3, %c13_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %c_41_i64, %c1_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %c_35_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "uge" %arg0, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.xor %c_36_i64, %c_41_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "eq" %arg1, %c_7_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.select %false, %c40_i64, %arg0 : i1, i64
    %1 = llvm.icmp "sle" %arg1, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.and %c14_i64, %2 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.and %arg0, %0 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %arg2 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.icmp "ule" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %c_3_i64, %2 : i64
    %4 = llvm.select %3, %arg0, %arg1 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.and %c40_i64, %arg0 : i64
    %1 = llvm.urem %c10_i64, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.udiv %0, %0 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %2 = llvm.xor %arg2, %arg2 : i64
    %3 = llvm.select %1, %c_5_i64, %2 : i1, i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c7_i64 = arith.constant 7 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %c7_i64, %c20_i64 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %c38_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ult" %0, %c16_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.lshr %0, %c_23_i64 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %3, %arg2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.urem %arg0, %c2_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "sle" %c29_i64, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %c23_i64 = arith.constant 23 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.and %c23_i64, %c_19_i64 : i64
    %1 = llvm.icmp "ugt" %c_1_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "ult" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %c3_i64, %c_20_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_18_i64 = arith.constant -18 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.sdiv %c25_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %c_18_i64, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.ashr %c_50_i64, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.and %c_13_i64, %c_39_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.udiv %2, %1 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c18_i64 = arith.constant 18 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.xor %c18_i64, %c_30_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %c_2_i64, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.xor %c49_i64, %2 : i64
    %4 = llvm.select %arg0, %c_41_i64, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %true = arith.constant true
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "eq" %c24_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %arg2, %arg0 : i64
    %3 = llvm.select %arg1, %2, %c_34_i64 : i1, i64
    %4 = llvm.select %true, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.sdiv %c2_i64, %arg2 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %true = arith.constant true
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.sdiv %c_41_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.ashr %arg1, %c9_i64 : i64
    %3 = llvm.select %true, %2, %2 : i1, i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "ne" %c_33_i64, %c_30_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %0, %c29_i64 : i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.sdiv %c35_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "ult" %c0_i64, %c49_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %arg1, %arg2 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %arg1, %c_27_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c12_i64, %2 : i64
    %4 = llvm.xor %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.udiv %c_50_i64, %c20_i64 : i64
    %1 = llvm.udiv %0, %c_38_i64 : i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.srem %c6_i64, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %true = arith.constant true
    %c_1_i64 = arith.constant -1 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.ashr %c_1_i64, %c25_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.xor %2, %c_20_i64 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %c_5_i64 = arith.constant -5 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.select %false, %c_5_i64, %c_39_i64 : i1, i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sgt" %arg2, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %arg1, %2, %arg2 : i1, i64
    %4 = llvm.xor %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %c_14_i64, %0 : i64
    %2 = llvm.and %1, %c50_i64 : i64
    %3 = llvm.and %arg0, %1 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.or %arg2, %arg2 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.select %arg1, %c_20_i64, %arg2 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.select %arg1, %c_26_i64, %arg2 : i1, i64
    %3 = llvm.xor %2, %c13_i64 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.xor %c_21_i64, %2 : i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c_3_i64 = arith.constant -3 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.or %arg1, %c_44_i64 : i64
    %1 = llvm.select %arg0, %0, %c_3_i64 : i1, i64
    %2 = llvm.lshr %1, %c45_i64 : i64
    %3 = llvm.sdiv %arg2, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "eq" %3, %c31_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "ugt" %c_5_i64, %c_20_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.urem %arg1, %arg0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "ugt" %c_29_i64, %arg0 : i64
    %1 = llvm.srem %c_45_i64, %arg0 : i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c26_i64 = arith.constant 26 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.select %arg0, %c23_i64, %arg1 : i1, i64
    %1 = llvm.icmp "sle" %arg1, %arg2 : i64
    %2 = llvm.select %1, %c26_i64, %c0_i64 : i1, i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %c_11_i64, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.xor %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c46_i64 : i64
    %2 = llvm.srem %1, %c_42_i64 : i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "sgt" %c_11_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %c_2_i64, %arg1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.xor %arg0, %0 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c_11_i64 = arith.constant -11 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "ult" %c_11_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %c_1_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c_15_i64 = arith.constant -15 : i64
    %true = arith.constant true
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.select %true, %arg0, %c33_i64 : i1, i64
    %1 = llvm.urem %arg0, %c_15_i64 : i64
    %2 = llvm.xor %arg1, %c16_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.srem %c_23_i64, %c_27_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %0, %arg0 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.and %arg0, %c36_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sle" %c_47_i64, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %c9_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c_22_i64, %2 : i64
    %4 = llvm.ashr %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.or %c2_i64, %2 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.xor %arg0, %c_43_i64 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.sdiv %c41_i64, %0 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %c_4_i64 : i64
    %2 = llvm.srem %c29_i64, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "ule" %3, %c_38_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %c9_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %c11_i64 = arith.constant 11 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "sgt" %c_8_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.xor %1, %c_48_i64 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.and %c11_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c_30_i64 = arith.constant -30 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.or %0, %c_30_i64 : i64
    %2 = llvm.srem %0, %c_34_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c32_i64 = arith.constant 32 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.udiv %arg0, %c_26_i64 : i64
    %1 = llvm.udiv %c32_i64, %c21_i64 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.ashr %c_44_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.udiv %c_44_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %c_20_i64 : i64
    %2 = llvm.icmp "sge" %1, %c46_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %c_14_i64, %0 : i64
    %2 = llvm.icmp "ule" %arg1, %arg0 : i64
    %3 = llvm.select %2, %0, %c6_i64 : i1, i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.select %true, %1, %2 : i1, i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %c35_i64, %arg1 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.select %2, %c46_i64, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "ne" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.lshr %arg1, %c_1_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.srem %c19_i64, %arg2 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "eq" %c_22_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.sdiv %1, %c_5_i64 : i64
    %3 = llvm.srem %c_29_i64, %arg0 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.icmp "ult" %c11_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.select %2, %0, %arg1 : i1, i64
    %4 = llvm.icmp "ult" %c43_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "ugt" %c21_i64, %arg0 : i64
    %1 = llvm.select %0, %c_13_i64, %arg0 : i1, i64
    %2 = llvm.icmp "ule" %arg0, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.or %arg0, %c_36_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %arg1, %arg2 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %c_33_i64, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "ult" %c_48_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c21_i64 : i1, i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %c22_i64 = arith.constant 22 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "slt" %c38_i64, %c38_i64 : i64
    %1 = llvm.ashr %c22_i64, %arg0 : i64
    %2 = llvm.srem %c_10_i64, %arg1 : i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %0, %c31_i64 : i64
    %2 = llvm.icmp "uge" %1, %c_5_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %c17_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %c11_i64, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.udiv %c_48_i64, %c15_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "ugt" %c_41_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %c_11_i64, %arg2 : i64
    %2 = llvm.select %1, %arg2, %c11_i64 : i1, i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "sge" %c30_i64, %c_45_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c25_i64 = arith.constant 25 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.urem %c_46_i64, %c35_i64 : i64
    %1 = llvm.ashr %arg0, %c25_i64 : i64
    %2 = llvm.sdiv %c_47_i64, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.lshr %c_19_i64, %c30_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %2 = llvm.select %1, %arg2, %0 : i1, i64
    %3 = llvm.lshr %c44_i64, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c_18_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.icmp "ult" %3, %c19_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg1, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "sle" %c31_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "ugt" %c24_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c26_i64 = arith.constant 26 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.or %arg0, %c_36_i64 : i64
    %1 = llvm.or %c26_i64, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %c_44_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.sdiv %c_39_i64, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.ashr %c9_i64, %1 : i64
    %3 = llvm.ashr %arg1, %arg1 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.urem %arg1, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c43_i64 = arith.constant 43 : i64
    %c_48_i64 = arith.constant -48 : i64
    %true = arith.constant true
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %c43_i64 : i64
    %2 = llvm.srem %c46_i64, %1 : i64
    %3 = llvm.select %true, %2, %c21_i64 : i1, i64
    %4 = llvm.icmp "ne" %c_48_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %1, %c18_i64 : i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.ashr %c14_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %c_40_i64 = arith.constant -40 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "uge" %c_43_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %c_40_i64, %1 : i64
    %3 = llvm.select %2, %1, %arg1 : i1, i64
    %4 = llvm.icmp "ult" %c_6_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %c_13_i64, %0 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c_7_i64 = arith.constant -7 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.srem %c_7_i64, %c13_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "sle" %c_43_i64, %0 : i64
    %3 = llvm.select %2, %1, %0 : i1, i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.sdiv %3, %c_48_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c23_i64 = arith.constant 23 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.srem %c23_i64, %c_43_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.urem %1, %c_13_i64 : i64
    %3 = llvm.xor %2, %c2_i64 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %arg1, %c38_i64 : i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg1, %arg2 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "sge" %arg0, %c_8_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.and %arg0, %c33_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.or %1, %c_38_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %c22_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.and %c_39_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.xor %c_42_i64, %1 : i64
    %3 = llvm.icmp "slt" %2, %c_33_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c1_i64 = arith.constant 1 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "eq" %c1_i64, %c16_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %arg0 : i64
    %2 = llvm.select %1, %c21_i64, %arg0 : i1, i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %c6_i64 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.select %2, %c_2_i64, %0 : i1, i64
    %4 = llvm.icmp "ugt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %arg1, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.trunc %arg0 : i1 to i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
