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
    %c-1_i64 = arith.constant -1 : i64
    %false = arith.constant false
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.ashr %c18_i64, %0 : i64
    %2 = llvm.urem %c-1_i64, %arg2 : i64
    %3 = llvm.select %false, %2, %c28_i64 : i1, i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.srem %c-45_i64, %c-22_i64 : i64
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
    %c-34_i64 = arith.constant -34 : i64
    %c10_i64 = arith.constant 10 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.lshr %c10_i64, %c5_i64 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %c-34_i64 : i64
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
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %c-9_i64, %0 : i64
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
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.ashr %c-37_i64, %arg0 : i64
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
    %c-31_i64 = arith.constant -31 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.and %c-32_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.lshr %c-31_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %c-40_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg1, %arg2, %c-1_i64 : i1, i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ult" %arg0, %c-12_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c-1_i64, %1 : i64
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
    %c-31_i64 = arith.constant -31 : i64
    %c20_i64 = arith.constant 20 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.select %arg0, %c20_i64, %c35_i64 : i1, i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.or %1, %c-31_i64 : i64
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
    %c-43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %0, %c-43_i64 : i64
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
    %c-44_i64 = arith.constant -44 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.and %arg0, %c8_i64 : i64
    %1 = llvm.srem %c-44_i64, %arg2 : i64
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
    %c-2_i64 = arith.constant -2 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.srem %c-48_i64, %arg0 : i64
    %1 = llvm.or %c-2_i64, %arg1 : i64
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
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.and %c-13_i64, %arg0 : i64
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
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.sdiv %arg0, %c-11_i64 : i64
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
    %c-15_i64 = arith.constant -15 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %arg1, %c-15_i64, %c20_i64 : i1, i64
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
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.udiv %c-33_i64, %arg0 : i64
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
    %c-10_i64 = arith.constant -10 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.and %arg2, %c11_i64 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %c-10_i64 : i64
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
    %c-28_i64 = arith.constant -28 : i64
    %c20_i64 = arith.constant 20 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.lshr %c-36_i64, %c-40_i64 : i64
    %1 = llvm.xor %c20_i64, %0 : i64
    %2 = llvm.or %arg1, %c-28_i64 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.udiv %c-24_i64, %arg0 : i64
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
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.srem %c-44_i64, %1 : i64
    %3 = llvm.xor %c48_i64, %c34_i64 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "sle" %c-19_i64, %c-29_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %c-48_i64, %1 : i64
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
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.srem %c32_i64, %1 : i64
    %3 = llvm.select %arg2, %c-25_i64, %2 : i1, i64
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
    %c-24_i64 = arith.constant -24 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "slt" %c-24_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.select %3, %c42_i64, %c-34_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.and %c-36_i64, %arg0 : i64
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
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.lshr %arg0, %c-22_i64 : i64
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
    %c-48_i64 = arith.constant -48 : i64
    %c46_i64 = arith.constant 46 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.select %arg0, %c32_i64, %arg1 : i1, i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    %2 = llvm.icmp "eq" %c46_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ne" %3, %c-48_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.urem %c25_i64, %c-14_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.srem %3, %c-28_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.udiv %c-3_i64, %arg0 : i64
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
    %c-11_i64 = arith.constant -11 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.and %c-11_i64, %c26_i64 : i64
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
    %c-8_i64 = arith.constant -8 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ugt" %c-8_i64, %c43_i64 : i64
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
    %c-14_i64 = arith.constant -14 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.xor %c-34_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %c-14_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.urem %c-22_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %c-13_i64, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c31_i64 = arith.constant 31 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.urem %arg0, %c-46_i64 : i64
    %1 = llvm.urem %c34_i64, %0 : i64
    %2 = llvm.udiv %c31_i64, %1 : i64
    %3 = llvm.lshr %1, %c-8_i64 : i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.or %arg0, %c-17_i64 : i64
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
    %c-46_i64 = arith.constant -46 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.and %c-30_i64, %2 : i64
    %4 = llvm.sdiv %c-46_i64, %3 : i64
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
    %c-1_i64 = arith.constant -1 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ugt" %c-1_i64, %c-40_i64 : i64
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
    %c-29_i64 = arith.constant -29 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.xor %c-16_i64, %c-25_i64 : i64
    %1 = llvm.icmp "ne" %0, %c-29_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %c21_i64, %arg0 : i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "sgt" %c-32_i64, %c25_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %c13_i64 : i64
    %3 = llvm.udiv %2, %c-36_i64 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %c-14_i64 = arith.constant -14 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.select %false, %c-14_i64, %c7_i64 : i1, i64
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
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.sdiv %2, %c-2_i64 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "slt" %3, %c-11_i64 : i64
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
    %c-15_i64 = arith.constant -15 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.and %arg0, %c24_i64 : i64
    %1 = llvm.icmp "eq" %0, %arg1 : i64
    %2 = llvm.select %1, %c-15_i64, %0 : i1, i64
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
    %c-18_i64 = arith.constant -18 : i64
    %c17_i64 = arith.constant 17 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.udiv %c17_i64, %c27_i64 : i64
    %1 = llvm.or %c-18_i64, %0 : i64
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
    %c-47_i64 = arith.constant -47 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.urem %c-42_i64, %c-9_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.ashr %c-33_i64, %2 : i64
    %4 = llvm.icmp "sle" %c-47_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.urem %c32_i64, %c-21_i64 : i64
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
    %c-19_i64 = arith.constant -19 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ugt" %c-19_i64, %c-49_i64 : i64
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
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.xor %c11_i64, %c-7_i64 : i64
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
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.lshr %arg0, %c-12_i64 : i64
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
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.xor %c-6_i64, %arg0 : i64
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
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.or %arg0, %c-21_i64 : i64
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
    %c-33_i64 = arith.constant -33 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "slt" %c18_i64, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "ne" %c-33_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-48_i64 = arith.constant -48 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %0, %c-48_i64 : i64
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
    %c-22_i64 = arith.constant -22 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "sle" %c-37_i64, %c-43_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "eq" %2, %c-22_i64 : i64
    %4 = llvm.select %3, %arg0, %arg0 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "sge" %arg1, %c-14_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %3, %c-48_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %c-49_i64, %0 : i64
    %2 = llvm.and %c-50_i64, %0 : i64
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
    %c-28_i64 = arith.constant -28 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %c-19_i64, %0 : i64
    %2 = llvm.icmp "ugt" %arg1, %c-28_i64 : i64
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
    %c-21_i64 = arith.constant -21 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.sdiv %arg0, %c-26_i64 : i64
    %1 = llvm.lshr %c7_i64, %arg0 : i64
    %2 = llvm.sdiv %1, %c-21_i64 : i64
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
    %c-17_i64 = arith.constant -17 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.xor %c7_i64, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.udiv %arg1, %c-17_i64 : i64
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
    %c-15_i64 = arith.constant -15 : i64
    %c17_i64 = arith.constant 17 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %c20_i64, %0 : i64
    %2 = llvm.sdiv %c17_i64, %1 : i64
    %3 = llvm.xor %arg0, %c-15_i64 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c0_i64 = arith.constant 0 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %c0_i64, %0 : i64
    %2 = llvm.or %c-14_i64, %1 : i64
    %3 = llvm.ashr %c-41_i64, %2 : i64
    %4 = llvm.icmp "sle" %c-48_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %c-27_i64, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.srem %c9_i64, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg1, %c-47_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.srem %c-4_i64, %c7_i64 : i64
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
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %c-30_i64, %0 : i64
    %2 = llvm.sdiv %1, %c42_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c21_i64 = arith.constant 21 : i64
    %false = arith.constant false
    %c39_i64 = arith.constant 39 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.urem %c17_i64, %arg0 : i64
    %1 = llvm.select %false, %c21_i64, %c-1_i64 : i1, i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sle" %c39_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %1, %c29_i64 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.icmp "sle" %3, %c-21_i64 : i64
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
    %c-34_i64 = arith.constant -34 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.udiv %c-3_i64, %c-41_i64 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %1, %c-34_i64, %2 : i1, i64
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
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "uge" %arg0, %c-45_i64 : i64
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
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "uge" %arg0, %c-12_i64 : i64
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
    %c-44_i64 = arith.constant -44 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.icmp "sgt" %c44_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %c-44_i64 : i64
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
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.udiv %c-32_i64, %1 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %c-43_i64, %arg0 : i64
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
    %c-41_i64 = arith.constant -41 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.and %arg2, %c35_i64 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.select %2, %c-41_i64, %arg1 : i1, i64
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
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "ugt" %arg0, %c-47_i64 : i64
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
    %c-47_i64 = arith.constant -47 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.lshr %c-47_i64, %c-45_i64 : i64
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
    %c-24_i64 = arith.constant -24 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %c-24_i64, %c-47_i64 : i64
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
    %c-27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %c-27_i64 : i64
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
    %c-46_i64 = arith.constant -46 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %c46_i64, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "ne" %c-46_i64, %3 : i64
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
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c-17_i64, %1 : i64
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
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.udiv %c-7_i64, %arg0 : i64
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
    %c-21_i64 = arith.constant -21 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ult" %c-44_i64, %c-40_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %c-21_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %3, %1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.srem %c-22_i64, %arg0 : i64
    %1 = llvm.ashr %c-17_i64, %0 : i64
    %2 = llvm.or %c-33_i64, %0 : i64
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
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.icmp "sgt" %1, %c-15_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.udiv %c-44_i64, %c-38_i64 : i64
    %1 = llvm.or %c23_i64, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.or %2, %c-46_i64 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "sge" %c-34_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "ne" %arg0, %c-25_i64 : i64
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
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.srem %c-20_i64, %0 : i64
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
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.select %arg0, %arg1, %c-23_i64 : i1, i64
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
    %c-19_i64 = arith.constant -19 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.sdiv %c-6_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.select %2, %arg2, %c-19_i64 : i1, i64
    %4 = llvm.icmp "sgt" %c-33_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "ult" %c22_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.urem %2, %c-14_i64 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.select %arg0, %arg1, %c-41_i64 : i1, i64
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
    %c-18_i64 = arith.constant -18 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.select %arg0, %c-20_i64, %arg1 : i1, i64
    %1 = llvm.icmp "sle" %c-49_i64, %0 : i64
    %2 = llvm.ashr %arg2, %arg2 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.icmp "sgt" %3, %c-18_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.udiv %c-39_i64, %arg0 : i64
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
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "ult" %c-48_i64, %arg0 : i64
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
    %c-38_i64 = arith.constant -38 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.ashr %c-38_i64, %c-34_i64 : i64
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
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.icmp "sle" %c-43_i64, %1 : i64
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
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "ugt" %c-47_i64, %arg0 : i64
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
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.ashr %arg0, %c-17_i64 : i64
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
    %c-23_i64 = arith.constant -23 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %c-23_i64, %0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c16_i64 = arith.constant 16 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.urem %c-35_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %c-1_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "ult" %c16_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c9_i64 = arith.constant 9 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "sge" %c5_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c9_i64, %1 : i64
    %3 = llvm.urem %c-7_i64, %arg1 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "ule" %arg0, %c-39_i64 : i64
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
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.or %c-42_i64, %arg0 : i64
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
    %c-16_i64 = arith.constant -16 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.select %arg1, %1, %c2_i64 : i1, i64
    %3 = llvm.udiv %c-16_i64, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.sdiv %arg0, %c-20_i64 : i64
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
    %c-35_i64 = arith.constant -35 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %0, %c-35_i64 : i64
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
    %c-2_i64 = arith.constant -2 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.or %2, %c4_i64 : i64
    %4 = llvm.sdiv %3, %c-2_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.select %arg1, %arg2, %c-32_i64 : i1, i64
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
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "uge" %c-28_i64, %arg0 : i64
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
    %c-43_i64 = arith.constant -43 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.or %c34_i64, %arg0 : i64
    %1 = llvm.or %c-31_i64, %0 : i64
    %2 = llvm.lshr %c-43_i64, %1 : i64
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
    %c-50_i64 = arith.constant -50 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c16_i64 = arith.constant 16 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %c-20_i64, %0 : i64
    %2 = llvm.and %c16_i64, %1 : i64
    %3 = llvm.xor %c-16_i64, %2 : i64
    %4 = llvm.urem %c-50_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.and %arg0, %c-9_i64 : i64
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
    %c-11_i64 = arith.constant -11 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.udiv %c0_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg1, %arg2 : i64
    %2 = llvm.and %c-11_i64, %arg0 : i64
    %3 = llvm.select %1, %arg2, %2 : i1, i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %c-35_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c14_i64 = arith.constant 14 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.lshr %arg2, %c14_i64 : i64
    %3 = llvm.and %2, %c-40_i64 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %c-20_i64 : i64
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
    %c-50_i64 = arith.constant -50 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "slt" %c-27_i64, %c49_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c25_i64, %1 : i64
    %3 = llvm.icmp "uge" %c-50_i64, %2 : i64
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
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.or %0, %c-20_i64 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.xor %c-8_i64, %c42_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.or %2, %c-32_i64 : i64
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
    %c-24_i64 = arith.constant -24 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.and %arg0, %c1_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "sgt" %c-24_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %c50_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.and %c-43_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.srem %c-10_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %c-42_i64, %0 : i64
    %2 = llvm.select %1, %c-43_i64, %arg0 : i1, i64
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
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.udiv %c46_i64, %c-15_i64 : i64
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
    %c-48_i64 = arith.constant -48 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.udiv %1, %c43_i64 : i64
    %3 = llvm.or %c-48_i64, %1 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "ugt" %c-7_i64, %c-20_i64 : i64
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
    %c-10_i64 = arith.constant -10 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.srem %c-27_i64, %1 : i64
    %3 = llvm.icmp "ugt" %c-10_i64, %2 : i64
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
    %c-49_i64 = arith.constant -49 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "ule" %c-32_i64, %c30_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c-5_i64, %c-49_i64 : i64
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
    %c-40_i64 = arith.constant -40 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.sdiv %c7_i64, %arg0 : i64
    %1 = llvm.ashr %c-40_i64, %0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "slt" %c-20_i64, %3 : i64
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
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "uge" %c-12_i64, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.urem %c-25_i64, %c-27_i64 : i64
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
    %c-44_i64 = arith.constant -44 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.udiv %c-44_i64, %0 : i64
    %3 = llvm.ashr %c34_i64, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "ugt" %c-28_i64, %c-9_i64 : i64
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
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.lshr %c-30_i64, %arg0 : i64
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
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ne" %c9_i64, %c-11_i64 : i64
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
    %c-34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ult" %c-34_i64, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.select %arg0, %c-2_i64, %c42_i64 : i1, i64
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
    %c-17_i64 = arith.constant -17 : i64
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "uge" %1, %c-17_i64 : i64
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
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.lshr %arg2, %c-36_i64 : i64
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
    %c-13_i64 = arith.constant -13 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %c-12_i64, %c-8_i64 : i64
    %1 = llvm.icmp "ult" %c40_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %2, %c-13_i64 : i64
    %4 = llvm.udiv %3, %0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-31_i64 = arith.constant -31 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.urem %c-10_i64, %arg0 : i64
    %1 = llvm.lshr %c-31_i64, %0 : i64
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
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "slt" %0, %c-30_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %c-8_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %true = arith.constant true
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %c-29_i64, %1 : i64
    %3 = llvm.select %true, %c-24_i64, %arg2 : i1, i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.ashr %arg0, %c-20_i64 : i64
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
    %c-41_i64 = arith.constant -41 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %c4_i64, %c-41_i64 : i64
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
    %c-3_i64 = arith.constant -3 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ult" %c-11_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %c-3_i64, %1 : i64
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
    %c-38_i64 = arith.constant -38 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.or %c3_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c-38_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ule" %c-37_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.ashr %c41_i64, %c-3_i64 : i64
    %1 = llvm.lshr %0, %c-45_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.and %1, %0 : i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.icmp "eq" %arg1, %c-13_i64 : i64
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
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.sdiv %c-32_i64, %arg0 : i64
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
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.xor %c-10_i64, %arg0 : i64
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
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.ashr %arg1, %c-39_i64 : i64
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
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "eq" %1, %c-33_i64 : i64
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
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.select %0, %c-1_i64, %arg0 : i1, i64
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
    %c-38_i64 = arith.constant -38 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ne" %c-20_i64, %c-12_i64 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %c-38_i64 : i1, i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %c-43_i64 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c29_i64 = arith.constant 29 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sdiv %c29_i64, %0 : i64
    %2 = llvm.or %c-13_i64, %1 : i64
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
    %c-16_i64 = arith.constant -16 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.ashr %arg0, %c45_i64 : i64
    %1 = llvm.select %true, %c-16_i64, %0 : i1, i64
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
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %c24_i64 : i64
    %2 = llvm.icmp "ult" %c-32_i64, %1 : i64
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
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %0, %c-3_i64 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.ashr %c19_i64, %0 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c1_i64 = arith.constant 1 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %0, %c26_i64 : i64
    %2 = llvm.or %c1_i64, %arg2 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.urem %3, %c-15_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.and %c-50_i64, %c11_i64 : i64
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
    %c-15_i64 = arith.constant -15 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-29_i64 = arith.constant -29 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %0, %c-29_i64 : i64
    %2 = llvm.icmp "sge" %c-36_i64, %1 : i64
    %3 = llvm.select %2, %1, %c-15_i64 : i1, i64
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
    %c-21_i64 = arith.constant -21 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %arg2, %arg0 : i64
    %2 = llvm.and %c-21_i64, %c25_i64 : i64
    %3 = llvm.select %1, %c-3_i64, %2 : i1, i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %c34_i64, %c-32_i64 : i64
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
    %c-49_i64 = arith.constant -49 : i64
    %c2_i64 = arith.constant 2 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.udiv %c2_i64, %arg2 : i64
    %2 = llvm.and %c39_i64, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.udiv %3, %c-49_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c-1_i64 = arith.constant -1 : i64
    %false = arith.constant false
    %c-41_i64 = arith.constant -41 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %arg1, %c45_i64 : i64
    %1 = llvm.select %arg0, %c-41_i64, %0 : i1, i64
    %2 = llvm.icmp "sle" %1, %arg2 : i64
    %3 = llvm.select %false, %c-1_i64, %c31_i64 : i1, i64
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
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.srem %c-47_i64, %arg0 : i64
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
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %c-42_i64 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "uge" %3, %c-42_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %c-25_i64 = arith.constant -25 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.select %false, %c-25_i64, %c34_i64 : i1, i64
    %1 = llvm.icmp "ule" %c32_i64, %0 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.icmp "slt" %c-45_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.udiv %c45_i64, %c-13_i64 : i64
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
    %c-39_i64 = arith.constant -39 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.select %arg0, %arg1, %c40_i64 : i1, i64
    %1 = llvm.and %c-23_i64, %0 : i64
    %2 = llvm.icmp "sgt" %c-39_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.udiv %c19_i64, %c-26_i64 : i64
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
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.udiv %1, %c-13_i64 : i64
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
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.or %0, %c-4_i64 : i64
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
    %c-49_i64 = arith.constant -49 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %c-2_i64 : i64
    %3 = llvm.xor %2, %c-49_i64 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "sge" %arg0, %c-40_i64 : i64
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
    %c-45_i64 = arith.constant -45 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.select %true, %c-45_i64, %c-6_i64 : i1, i64
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
    %c-5_i64 = arith.constant -5 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sdiv %arg2, %c1_i64 : i64
    %3 = llvm.or %2, %c-5_i64 : i64
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
    %c-33_i64 = arith.constant -33 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "uge" %c-3_i64, %c-27_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %c-33_i64 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.srem %c-1_i64, %3 : i64
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
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.select %1, %c-44_i64, %0 : i1, i64
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
    %c-34_i64 = arith.constant -34 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "sgt" %c-15_i64, %c-16_i64 : i64
    %1 = llvm.icmp "slt" %arg0, %arg0 : i64
    %2 = llvm.select %1, %c-34_i64, %arg1 : i1, i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.sdiv %c7_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "sgt" %c-50_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.xor %c-35_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "eq" %c-19_i64, %arg0 : i64
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
    %c-6_i64 = arith.constant -6 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.urem %c35_i64, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.xor %2, %c-6_i64 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.or %c-40_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.udiv %c-46_i64, %2 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.xor %c17_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %c-24_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c-50_i64, %2 : i64
    %4 = llvm.icmp "ule" %3, %c-19_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c34_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ult" %c-13_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %c-9_i64 : i64
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
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "slt" %arg0, %c-12_i64 : i64
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
    %c-2_i64 = arith.constant -2 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.xor %c-2_i64, %c-33_i64 : i64
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
    %c-48_i64 = arith.constant -48 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.and %2, %c-48_i64 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %c26_i64 = arith.constant 26 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.select %false, %c26_i64, %c-48_i64 : i1, i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.sdiv %1, %c-34_i64 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c-5_i64 = arith.constant -5 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %c-5_i64, %0 : i64
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
    %c-9_i64 = arith.constant -9 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.ashr %c50_i64, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.srem %c-9_i64, %0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.ashr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.xor %c14_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %c-21_i64, %0 : i64
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
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.lshr %c-33_i64, %arg1 : i64
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
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %false, %c-30_i64, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.or %c-29_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c-15_i64, %0 : i64
    %2 = llvm.or %arg1, %arg2 : i64
    %3 = llvm.select %1, %c-47_i64, %2 : i1, i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "sgt" %c-50_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "uge" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.lshr %c-38_i64, %arg0 : i64
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
    %c-12_i64 = arith.constant -12 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.xor %arg0, %c13_i64 : i64
    %1 = llvm.sdiv %arg0, %c-12_i64 : i64
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
    %c-25_i64 = arith.constant -25 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "sge" %c-25_i64, %c-22_i64 : i64
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
    %c-15_i64 = arith.constant -15 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %c-15_i64, %0 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg1, %arg1 : i1, i64
    %2 = llvm.ashr %c-23_i64, %1 : i64
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
    %c-6_i64 = arith.constant -6 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "ne" %c-22_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "ugt" %c32_i64, %2 : i64
    %4 = llvm.select %3, %c-6_i64, %1 : i1, i64
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
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.udiv %c-16_i64, %0 : i64
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
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.xor %2, %c-33_i64 : i64
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
    %c-40_i64 = arith.constant -40 : i64
    %c-36_i64 = arith.constant -36 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %c-36_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %c-40_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %arg2, %c-31_i64 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "sgt" %c-8_i64, %3 : i64
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
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.ashr %1, %c-40_i64 : i64
    %3 = llvm.or %arg0, %1 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.srem %arg0, %c-42_i64 : i64
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
    %c-32_i64 = arith.constant -32 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.and %c-21_i64, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.select %false, %c24_i64, %arg0 : i1, i64
    %3 = llvm.xor %c-32_i64, %2 : i64
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
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %c-11_i64, %0 : i64
    %2 = llvm.srem %0, %0 : i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c24_i64 = arith.constant 24 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "ule" %c24_i64, %c-37_i64 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.ashr %c-38_i64, %2 : i64
    %4 = llvm.icmp "ugt" %c-45_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.select %arg0, %c-14_i64, %arg1 : i1, i64
    %1 = llvm.sdiv %arg2, %c-40_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.or %c-25_i64, %arg0 : i64
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
    %c-18_i64 = arith.constant -18 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "sgt" %arg0, %c-6_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "sge" %1, %c31_i64 : i64
    %3 = llvm.select %2, %1, %arg1 : i1, i64
    %4 = llvm.icmp "ule" %c-18_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.srem %c11_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.xor %arg2, %arg0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.xor %c-33_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %false, %c-9_i64, %0 : i1, i64
    %2 = llvm.or %arg1, %arg2 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c45_i64 = arith.constant 45 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "eq" %c21_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    %3 = llvm.and %c45_i64, %c-49_i64 : i64
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
    %c-16_i64 = arith.constant -16 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "slt" %c-16_i64, %c-39_i64 : i64
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
    %c-27_i64 = arith.constant -27 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.udiv %2, %c-27_i64 : i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.udiv %c-37_i64, %c16_i64 : i64
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
    %c-50_i64 = arith.constant -50 : i64
    %true = arith.constant true
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.select %true, %c-48_i64, %arg0 : i1, i64
    %1 = llvm.and %0, %c27_i64 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %c-50_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.and %c50_i64, %c-3_i64 : i64
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
    %c-12_i64 = arith.constant -12 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.ashr %c-17_i64, %c-38_i64 : i64
    %1 = llvm.udiv %0, %c9_i64 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.srem %c-12_i64, %2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c26_i64 = arith.constant 26 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.urem %c26_i64, %c19_i64 : i64
    %1 = llvm.srem %c-34_i64, %c44_i64 : i64
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
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.srem %c4_i64, %c-10_i64 : i64
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
    %c-31_i64 = arith.constant -31 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.lshr %c-31_i64, %c-35_i64 : i64
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
    %c-24_i64 = arith.constant -24 : i64
    %false = arith.constant false
    %c1_i64 = arith.constant 1 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.select %false, %c1_i64, %c19_i64 : i1, i64
    %1 = llvm.or %0, %c-24_i64 : i64
    %2 = llvm.xor %1, %c42_i64 : i64
    %3 = llvm.icmp "sle" %2, %c7_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "ne" %c-6_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c7_i64 = arith.constant 7 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.select %arg0, %c14_i64, %arg1 : i1, i64
    %1 = llvm.xor %0, %c7_i64 : i64
    %2 = llvm.and %arg2, %arg2 : i64
    %3 = llvm.xor %c-24_i64, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.or %c42_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %c-43_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.select %1, %2, %c-44_i64 : i1, i64
    %4 = llvm.icmp "uge" %c-43_i64, %3 : i64
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
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %c-25_i64, %arg0 : i64
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
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %c-21_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.sdiv %c-34_i64, %arg0 : i64
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
    %c-16_i64 = arith.constant -16 : i64
    %c34_i64 = arith.constant 34 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.xor %c27_i64, %arg1 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.and %c34_i64, %1 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.icmp "sle" %3, %c-16_i64 : i64
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
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.srem %c-6_i64, %0 : i64
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
    %c-35_i64 = arith.constant -35 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.udiv %c-38_i64, %arg0 : i64
    %1 = llvm.urem %c-35_i64, %0 : i64
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
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.and %c-7_i64, %1 : i64
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
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.urem %c-30_i64, %arg0 : i64
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
    %c-13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.xor %c-13_i64, %0 : i64
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
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.srem %c-10_i64, %arg1 : i64
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
    %c-7_i64 = arith.constant -7 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.urem %c-7_i64, %c-31_i64 : i64
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
    %c-40_i64 = arith.constant -40 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "slt" %c-40_i64, %0 : i64
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
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.ashr %c46_i64, %c-17_i64 : i64
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
    %c-27_i64 = arith.constant -27 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "ule" %arg0, %c-28_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %c-27_i64 : i64
    %3 = llvm.lshr %c-5_i64, %2 : i64
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
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %c-27_i64, %arg0 : i64
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
    %c-2_i64 = arith.constant -2 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ule" %0, %c-2_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %c-6_i64, %2 : i64
    %4 = llvm.or %c-16_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.or %c14_i64, %arg0 : i64
    %1 = llvm.srem %0, %c40_i64 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %c-30_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "sgt" %c-29_i64, %arg0 : i64
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
    %c-46_i64 = arith.constant -46 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %c-31_i64, %c32_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c-46_i64, %arg0 : i64
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
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.sdiv %1, %c-42_i64 : i64
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
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.sdiv %c-7_i64, %c47_i64 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "slt" %c-15_i64, %3 : i64
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
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "eq" %c-26_i64, %0 : i64
    %2 = llvm.icmp "uge" %arg1, %c14_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %1, %3, %arg2 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.xor %c-30_i64, %arg0 : i64
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
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "sge" %arg2, %c-42_i64 : i64
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
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.ashr %c13_i64, %c-50_i64 : i64
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
    %c-33_i64 = arith.constant -33 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.srem %c6_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.udiv %arg0, %c-33_i64 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.urem %c5_i64, %c-9_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %c-16_i64 : i64
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
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %c-35_i64, %0 : i64
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
    %c-28_i64 = arith.constant -28 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.udiv %c-28_i64, %c6_i64 : i64
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
    %c-23_i64 = arith.constant -23 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "ugt" %c24_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c-23_i64, %c21_i64 : i64
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
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %c-49_i64, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.and %c33_i64, %2 : i64
    %4 = llvm.icmp "ult" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.lshr %c-46_i64, %c24_i64 : i64
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
    %c-23_i64 = arith.constant -23 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.ashr %c-23_i64, %0 : i64
    %2 = llvm.urem %arg2, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.sdiv %c-25_i64, %3 : i64
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
    %c-26_i64 = arith.constant -26 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.urem %c-15_i64, %c22_i64 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.select %1, %c-26_i64, %0 : i1, i64
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
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %c-28_i64 : i64
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
    %c-16_i64 = arith.constant -16 : i64
    %c43_i64 = arith.constant 43 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %c-11_i64, %c32_i64 : i64
    %1 = llvm.lshr %c43_i64, %c-16_i64 : i64
    %2 = llvm.ashr %arg0, %arg0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.or %c-5_i64, %arg0 : i64
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
    %c-22_i64 = arith.constant -22 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "slt" %c-12_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.ashr %2, %c-22_i64 : i64
    %4 = llvm.icmp "ne" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %c-28_i64, %arg0 : i64
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
    %c-6_i64 = arith.constant -6 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "ne" %c-7_i64, %c-23_i64 : i64
    %1 = llvm.select %0, %c36_i64, %arg0 : i1, i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.select %0, %arg2, %c-6_i64 : i1, i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.srem %c-30_i64, %arg1 : i64
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
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "ult" %arg0, %c-24_i64 : i64
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
    %c-5_i64 = arith.constant -5 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c19_i64 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.xor %c-5_i64, %0 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "sge" %c-41_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c-42_i64, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.select %0, %3, %c-21_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.srem %c26_i64, %c-18_i64 : i64
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
    %c-24_i64 = arith.constant -24 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.or %c31_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c-27_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %1, %c-24_i64, %arg1 : i1, i64
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
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "ult" %c-22_i64, %arg0 : i64
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
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.and %arg1, %c-26_i64 : i64
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
    %c-12_i64 = arith.constant -12 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "sge" %3, %c-12_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.udiv %c-21_i64, %c-19_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %c-39_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.udiv %c-2_i64, %arg0 : i64
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
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "sle" %c-27_i64, %arg0 : i64
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
    %c-41_i64 = arith.constant -41 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.select %arg0, %c-41_i64, %c-31_i64 : i1, i64
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
    %c-22_i64 = arith.constant -22 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %c-22_i64, %c40_i64 : i64
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
    %c-10_i64 = arith.constant -10 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.srem %c-10_i64, %c-38_i64 : i64
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
    %c-12_i64 = arith.constant -12 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.srem %c-33_i64, %arg0 : i64
    %1 = llvm.sdiv %c-12_i64, %0 : i64
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
    %c-40_i64 = arith.constant -40 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.xor %arg0, %c-33_i64 : i64
    %1 = llvm.udiv %c-24_i64, %c-40_i64 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.srem %c-46_i64, %3 : i64
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
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.udiv %c-46_i64, %arg0 : i64
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
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.xor %c-28_i64, %arg0 : i64
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
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.select %arg1, %arg0, %c-38_i64 : i1, i64
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
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %c-7_i64 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.sdiv %2, %c-12_i64 : i64
    %4 = llvm.sdiv %3, %0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %0, %c-2_i64 : i64
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
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.or %arg2, %c-18_i64 : i64
    %2 = llvm.lshr %c12_i64, %c8_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %arg2, %c-42_i64 : i64
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
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.ashr %arg2, %c11_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "uge" %c-33_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c-37_i64, %c2_i64 : i64
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
    %c-8_i64 = arith.constant -8 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "uge" %c-45_i64, %c-19_i64 : i64
    %1 = llvm.icmp "eq" %c-24_i64, %c-8_i64 : i64
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
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %arg2 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.udiv %c-21_i64, %2 : i64
    %4 = llvm.srem %c7_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.lshr %c-27_i64, %arg0 : i64
    %2 = llvm.select %0, %1, %arg2 : i1, i64
    %3 = llvm.srem %1, %c-41_i64 : i64
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
    %c-6_i64 = arith.constant -6 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.udiv %arg0, %c-19_i64 : i64
    %1 = llvm.icmp "sge" %0, %c-6_i64 : i64
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
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "eq" %c-13_i64, %arg0 : i64
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
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %c-10_i64 : i64
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
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.and %arg0, %c-2_i64 : i64
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
    %c-46_i64 = arith.constant -46 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "slt" %arg0, %c41_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.udiv %3, %c-46_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "sge" %arg0, %c-38_i64 : i64
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
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "ule" %c46_i64, %c-21_i64 : i64
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
    %c-18_i64 = arith.constant -18 : i64
    %true = arith.constant true
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.udiv %c-46_i64, %arg0 : i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.srem %2, %c14_i64 : i64
    %4 = llvm.or %c-18_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %c-29_i64, %c32_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %3, %c-26_i64 : i64
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
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %c-41_i64, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.xor %arg0, %c-3_i64 : i64
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
    %c-5_i64 = arith.constant -5 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.xor %arg0, %c48_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %c-5_i64, %0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "slt" %c29_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg1, %c-38_i64 : i64
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
    %c-25_i64 = arith.constant -25 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.sdiv %c-25_i64, %c-34_i64 : i64
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
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.udiv %c17_i64, %c-40_i64 : i64
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
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.udiv %c-12_i64, %c-12_i64 : i64
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
    %c-3_i64 = arith.constant -3 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.sdiv %c-2_i64, %c-36_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "ugt" %c-3_i64, %3 : i64
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
    %c-5_i64 = arith.constant -5 : i64
    %c33_i64 = arith.constant 33 : i64
    %false = arith.constant false
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.select %arg0, %c22_i64, %arg1 : i1, i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.sdiv %c33_i64, %c-5_i64 : i64
    %3 = llvm.select %false, %2, %arg1 : i1, i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.ashr %arg0, %c-3_i64 : i64
    %1 = llvm.icmp "ugt" %arg1, %c20_i64 : i64
    %2 = llvm.select %1, %arg1, %arg1 : i1, i64
    %3 = llvm.or %c-3_i64, %2 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "eq" %arg0, %c-22_i64 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.select %0, %c-44_i64, %1 : i1, i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c5_i64 = arith.constant 5 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.srem %c30_i64, %arg0 : i64
    %1 = llvm.srem %c5_i64, %0 : i64
    %2 = llvm.xor %arg0, %0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ugt" %c-19_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-3_i64 = arith.constant -3 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.ashr %arg2, %c-3_i64 : i64
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
    %c-15_i64 = arith.constant -15 : i64
    %false = arith.constant false
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.xor %2, %c-15_i64 : i64
    %4 = llvm.sdiv %3, %0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ult" %arg0, %c-49_i64 : i64
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
    %c-7_i64 = arith.constant -7 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %c-7_i64, %arg1 : i64
    %3 = llvm.or %c-31_i64, %2 : i64
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
    %c-3_i64 = arith.constant -3 : i64
    %c33_i64 = arith.constant 33 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %c-45_i64, %1 : i64
    %3 = llvm.lshr %c33_i64, %c-3_i64 : i64
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
    %c-43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %c-43_i64, %2 : i64
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
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.ashr %c-35_i64, %arg1 : i64
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
    %c-34_i64 = arith.constant -34 : i64
    %c50_i64 = arith.constant 50 : i64
    %true = arith.constant true
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.ashr %arg0, %c-23_i64 : i64
    %1 = llvm.select %true, %c50_i64, %0 : i1, i64
    %2 = llvm.icmp "ult" %1, %c-34_i64 : i64
    %3 = llvm.select %2, %arg1, %arg2 : i1, i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "uge" %arg0, %c-12_i64 : i64
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
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.and %1, %c-47_i64 : i64
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
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.select %arg0, %1, %arg2 : i1, i64
    %3 = llvm.ashr %c-14_i64, %2 : i64
    %4 = llvm.srem %3, %c9_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c29_i64 = arith.constant 29 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.sdiv %c-6_i64, %arg0 : i64
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
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.sdiv %c18_i64, %c-19_i64 : i64
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
    %c-10_i64 = arith.constant -10 : i64
    %c49_i64 = arith.constant 49 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.or %arg0, %c-23_i64 : i64
    %1 = llvm.srem %c36_i64, %0 : i64
    %2 = llvm.srem %arg0, %c49_i64 : i64
    %3 = llvm.lshr %2, %c-10_i64 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %c-35_i64, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.urem %2, %c-7_i64 : i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-23_i64 = arith.constant -23 : i64
    %true = arith.constant true
    %c1_i64 = arith.constant 1 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.select %true, %c1_i64, %c-4_i64 : i1, i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.xor %1, %c-23_i64 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "sle" %3, %c-27_i64 : i64
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
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.urem %c-42_i64, %arg0 : i64
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
    %c-13_i64 = arith.constant -13 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "uge" %c39_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %c39_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %c-13_i64, %arg1 : i64
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
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.urem %c41_i64, %c-11_i64 : i64
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
    %c-47_i64 = arith.constant -47 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.or %arg0, %c16_i64 : i64
    %1 = llvm.xor %c-47_i64, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "ugt" %c-1_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg1, %arg0 : i64
    %3 = llvm.ashr %2, %c-36_i64 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.lshr %arg0, %c-46_i64 : i64
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
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "ne" %c-31_i64, %arg0 : i64
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
    %c-23_i64 = arith.constant -23 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.lshr %c38_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %c-23_i64, %c31_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c5_i64, %0 : i64
    %2 = llvm.and %c47_i64, %c-22_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ne" %c-32_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "ult" %c-34_i64, %arg0 : i64
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
    %c-20_i64 = arith.constant -20 : i64
    %c-5_i64 = arith.constant -5 : i64
    %true = arith.constant true
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %c48_i64 : i64
    %2 = llvm.select %true, %c-5_i64, %c-20_i64 : i1, i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "uge" %c-21_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c-10_i64 : i1, i64
    %2 = llvm.icmp "slt" %c-46_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c29_i64 = arith.constant 29 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.udiv %c-32_i64, %c-25_i64 : i64
    %1 = llvm.or %0, %c29_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.srem %2, %c-20_i64 : i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c14_i64 = arith.constant 14 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg2, %c14_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %0, %c50_i64, %2 : i1, i64
    %4 = llvm.icmp "sle" %3, %c-27_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.urem %c-13_i64, %c-31_i64 : i64
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
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.lshr %c-48_i64, %c9_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.xor %c-39_i64, %arg0 : i64
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
    %c-34_i64 = arith.constant -34 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "ult" %c-31_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.or %2, %c-34_i64 : i64
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
    %c-35_i64 = arith.constant -35 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.lshr %c-16_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.select %1, %c-4_i64, %c-35_i64 : i1, i64
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
    %c-1_i64 = arith.constant -1 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.urem %c50_i64, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.udiv %arg2, %c-1_i64 : i64
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
    %c-15_i64 = arith.constant -15 : i64
    %c46_i64 = arith.constant 46 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "uge" %c46_i64, %c9_i64 : i64
    %1 = llvm.select %0, %c-15_i64, %arg0 : i1, i64
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
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.or %c-12_i64, %1 : i64
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
    %c-10_i64 = arith.constant -10 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.srem %arg0, %c-14_i64 : i64
    %1 = llvm.ashr %c-42_i64, %c-10_i64 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.sdiv %c42_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.and %0, %c26_i64 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.sdiv %2, %c-22_i64 : i64
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
    %c-11_i64 = arith.constant -11 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "ult" %c-12_i64, %c-8_i64 : i64
    %1 = llvm.and %arg0, %c18_i64 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.select %0, %c-11_i64, %2 : i1, i64
    %4 = llvm.icmp "ule" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c-43_i64 = arith.constant -43 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %0, %c-43_i64 : i64
    %2 = llvm.udiv %1, %c-36_i64 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.xor %c40_i64, %c-43_i64 : i64
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
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %c-25_i64, %arg1 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.select %1, %2, %c-37_i64 : i1, i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.icmp "sge" %3, %c-42_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %c-17_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.urem %arg2, %c-20_i64 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c26_i64 = arith.constant 26 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.lshr %c-43_i64, %1 : i64
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
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.and %arg0, %c-30_i64 : i64
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
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "eq" %c24_i64, %c-4_i64 : i64
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
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %0, %c-14_i64, %2 : i1, i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.ashr %arg0, %c42_i64 : i64
    %1 = llvm.icmp "ule" %c-36_i64, %arg0 : i64
    %2 = llvm.select %1, %arg1, %arg1 : i1, i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "slt" %c-32_i64, %c-21_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c18_i64 = arith.constant 18 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.sdiv %c17_i64, %c-25_i64 : i64
    %1 = llvm.xor %c18_i64, %arg0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "eq" %3, %c-47_i64 : i64
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
    %c-8_i64 = arith.constant -8 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "ule" %c-39_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c-8_i64, %c23_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.or %c-1_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.lshr %c-17_i64, %arg1 : i64
    %3 = llvm.select %1, %2, %c21_i64 : i1, i64
    %4 = llvm.icmp "slt" %c-33_i64, %3 : i64
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
    %c-4_i64 = arith.constant -4 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sdiv %c-4_i64, %c28_i64 : i64
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
    %c-43_i64 = arith.constant -43 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %c-43_i64, %c-32_i64 : i64
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
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.lshr %c-50_i64, %arg0 : i64
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
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %arg1, %0, %0 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %arg2, %c-17_i64 : i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.udiv %1, %c-27_i64 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.xor %2, %c-31_i64 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.lshr %c-43_i64, %arg0 : i64
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
    %c-23_i64 = arith.constant -23 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.udiv %arg0, %c-16_i64 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.srem %c-23_i64, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "ne" %arg0, %c-32_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.xor %c-1_i64, %1 : i64
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
    %c-2_i64 = arith.constant -2 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %arg0, %c20_i64 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.xor %c-2_i64, %2 : i64
    %4 = llvm.icmp "sle" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.urem %c-29_i64, %1 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %c-19_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %c-13_i64 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.ashr %arg0, %c-9_i64 : i64
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
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.urem %c-35_i64, %arg0 : i64
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
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.udiv %arg0, %c-7_i64 : i64
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
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %3, %c-50_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c18_i64 = arith.constant 18 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.select %arg0, %c33_i64, %arg1 : i1, i64
    %1 = llvm.or %c18_i64, %0 : i64
    %2 = llvm.lshr %1, %c-48_i64 : i64
    %3 = llvm.srem %c-30_i64, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.srem %c-19_i64, %arg1 : i64
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
    %c-23_i64 = arith.constant -23 : i64
    %c45_i64 = arith.constant 45 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %arg2 : i64
    %3 = llvm.select %2, %c45_i64, %c-23_i64 : i1, i64
    %4 = llvm.icmp "ugt" %c46_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sgt" %c-39_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %c-49_i64, %0 : i64
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
    %c-15_i64 = arith.constant -15 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.or %c-29_i64, %arg1 : i64
    %1 = llvm.select %arg0, %0, %c-15_i64 : i1, i64
    %2 = llvm.sdiv %c-39_i64, %1 : i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.or %3, %c-22_i64 : i64
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
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c-37_i64 : i64
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
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.lshr %arg0, %c-4_i64 : i64
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
    %c-28_i64 = arith.constant -28 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.sdiv %c-28_i64, %c-36_i64 : i64
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
    %c-38_i64 = arith.constant -38 : i64
    %c50_i64 = arith.constant 50 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.sdiv %c50_i64, %c49_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.icmp "slt" %c-38_i64, %3 : i64
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
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.xor %c-49_i64, %3 : i64
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
    %c-44_i64 = arith.constant -44 : i64
    %c49_i64 = arith.constant 49 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.ashr %c49_i64, %c15_i64 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.udiv %c-44_i64, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %c24_i64, %0 : i64
    %2 = llvm.sdiv %1, %c-49_i64 : i64
    %3 = llvm.ashr %2, %c-1_i64 : i64
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
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %c-34_i64, %arg0 : i64
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
    %c-2_i64 = arith.constant -2 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %c-42_i64, %c-11_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %c-2_i64 : i64
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
    %c-5_i64 = arith.constant -5 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.select %false, %0, %c-5_i64 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.urem %c7_i64, %c-37_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.lshr %c-33_i64, %3 : i64
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
    %c-35_i64 = arith.constant -35 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.and %c-35_i64, %c39_i64 : i64
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
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "sle" %c-42_i64, %arg1 : i64
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
    %c-9_i64 = arith.constant -9 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.ashr %c-9_i64, %c13_i64 : i64
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
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c-32_i64, %c23_i64 : i64
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
    %c-14_i64 = arith.constant -14 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.srem %arg0, %c40_i64 : i64
    %1 = llvm.lshr %c-14_i64, %c8_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %c44_i64, %c-32_i64 : i64
    %1 = llvm.sdiv %c-15_i64, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.lshr %2, %c-1_i64 : i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %c-2_i64, %1 : i64
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
    %c-42_i64 = arith.constant -42 : i64
    %c46_i64 = arith.constant 46 : i64
    %c29_i64 = arith.constant 29 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.xor %c29_i64, %c28_i64 : i64
    %1 = llvm.ashr %0, %c-42_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "slt" %c46_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %true = arith.constant true
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.select %true, %c39_i64, %2 : i1, i64
    %4 = llvm.icmp "eq" %c-29_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "ugt" %c-16_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %c-22_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %c49_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %c-23_i64, %3 : i64
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
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %0 : i64
    %3 = llvm.select %2, %c30_i64, %1 : i1, i64
    %4 = llvm.udiv %c-27_i64, %3 : i64
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
    %c-29_i64 = arith.constant -29 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "sge" %c42_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.ashr %1, %c-29_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.xor %0, %c-18_i64 : i64
    %2 = llvm.lshr %arg2, %arg2 : i64
    %3 = llvm.xor %2, %c49_i64 : i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %true = arith.constant true
    %c-33_i64 = arith.constant -33 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.udiv %c-33_i64, %c14_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.or %arg0, %c-39_i64 : i64
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
    %c-22_i64 = arith.constant -22 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %c-22_i64, %c40_i64 : i64
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
    %c-30_i64 = arith.constant -30 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.sdiv %arg0, %c-25_i64 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.udiv %c-30_i64, %2 : i64
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
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.and %c-27_i64, %arg0 : i64
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
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.and %c22_i64, %c-31_i64 : i64
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
    %c-19_i64 = arith.constant -19 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.srem %1, %c-19_i64 : i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.xor %c14_i64, %c-40_i64 : i64
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
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.or %arg0, %c-34_i64 : i64
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
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c-6_i64 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c50_i64 = arith.constant 50 : i64
    %c17_i64 = arith.constant 17 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "sge" %c17_i64, %c50_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %c-41_i64 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.sdiv %c-15_i64, %2 : i64
    %4 = llvm.icmp "sgt" %c-48_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c-31_i64 : i64
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
    %c-46_i64 = arith.constant -46 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.sdiv %c-13_i64, %c23_i64 : i64
    %1 = llvm.or %0, %c47_i64 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %c-46_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.lshr %c44_i64, %c-19_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.udiv %1, %c-3_i64 : i64
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
    %c-12_i64 = arith.constant -12 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "ne" %c-12_i64, %1 : i64
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
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.select %arg2, %0, %c-34_i64 : i1, i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.lshr %c-25_i64, %c-13_i64 : i64
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
    %c-14_i64 = arith.constant -14 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.udiv %arg0, %c29_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.or %1, %c-14_i64 : i64
    %3 = llvm.and %arg1, %arg1 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg2, %c-27_i64 : i64
    %3 = llvm.sdiv %2, %c32_i64 : i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %true = arith.constant true
    %c-13_i64 = arith.constant -13 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.lshr %c-42_i64, %arg0 : i64
    %1 = llvm.select %true, %c-13_i64, %0 : i1, i64
    %2 = llvm.lshr %0, %c-1_i64 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.sdiv %c-47_i64, %c-28_i64 : i64
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
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c-22_i64 : i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %2, %c-13_i64 : i64
    %4 = llvm.lshr %3, %arg0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "uge" %c-10_i64, %c-36_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %c-39_i64, %0 : i64
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
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.lshr %c-3_i64, %arg0 : i64
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
    %c-29_i64 = arith.constant -29 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.srem %arg2, %arg1 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.and %c-33_i64, %c-29_i64 : i64
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
    %c-31_i64 = arith.constant -31 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %0, %c-31_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "slt" %arg0, %c-19_i64 : i64
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
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "sgt" %c-50_i64, %2 : i64
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
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %c-26_i64 : i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.urem %arg0, %c25_i64 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.or %0, %c-42_i64 : i64
    %3 = llvm.srem %arg2, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.and %arg2, %c-5_i64 : i64
    %2 = llvm.ashr %1, %c-1_i64 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %c-5_i64, %0 : i64
    %2 = llvm.icmp "slt" %0, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.urem %c-26_i64, %c-24_i64 : i64
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
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.ashr %c-30_i64, %arg2 : i64
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
    %c-4_i64 = arith.constant -4 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %c-8_i64, %0 : i64
    %2 = llvm.xor %c-4_i64, %1 : i64
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
    %c-18_i64 = arith.constant -18 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.lshr %arg0, %c47_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.ashr %c-18_i64, %1 : i64
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
    %c-8_i64 = arith.constant -8 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.xor %c-8_i64, %c-23_i64 : i64
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
    %c-18_i64 = arith.constant -18 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.and %c-18_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.ashr %arg2, %c-44_i64 : i64
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
    %c-15_i64 = arith.constant -15 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sdiv %arg0, %c33_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %c-48_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %c-15_i64 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c28_i64 = arith.constant 28 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.and %c2_i64, %c-47_i64 : i64
    %1 = llvm.icmp "ule" %c28_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c-43_i64, %2 : i64
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
    %c-45_i64 = arith.constant -45 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "ugt" %c27_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %c-45_i64, %arg0 : i64
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
    %c-2_i64 = arith.constant -2 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.srem %c-13_i64, %2 : i64
    %4 = llvm.urem %c-2_i64, %3 : i64
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
    %c-7_i64 = arith.constant -7 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %c-7_i64, %c48_i64 : i64
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
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %c-36_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %c15_i64 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.select %0, %2, %c-22_i64 : i1, i64
    %4 = llvm.icmp "ugt" %3, %c-37_i64 : i64
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
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %c-12_i64, %arg0 : i64
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
    %c-10_i64 = arith.constant -10 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.lshr %c-2_i64, %arg0 : i64
    %1 = llvm.and %0, %c33_i64 : i64
    %2 = llvm.icmp "slt" %c-10_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %c7_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.srem %c-49_i64, %c-3_i64 : i64
    %1 = llvm.select %arg0, %arg1, %c-23_i64 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    %4 = llvm.select %3, %1, %arg1 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.or %c-43_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.and %c-27_i64, %1 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.and %c-7_i64, %c28_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.srem %c-29_i64, %1 : i64
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
    %c-21_i64 = arith.constant -21 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %c41_i64 : i1, i64
    %2 = llvm.urem %c-21_i64, %arg1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c43_i64 = arith.constant 43 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.and %c43_i64, %c39_i64 : i64
    %1 = llvm.or %c-10_i64, %0 : i64
    %2 = llvm.udiv %1, %c-49_i64 : i64
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
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.and %c-8_i64, %arg0 : i64
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
    %c-2_i64 = arith.constant -2 : i64
    %c21_i64 = arith.constant 21 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %c21_i64 : i1, i64
    %3 = llvm.lshr %c-2_i64, %2 : i64
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
    %c-31_i64 = arith.constant -31 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %c4_i64, %c49_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ugt" %c-31_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.ashr %c35_i64, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.or %c-27_i64, %3 : i64
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
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %c-39_i64 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.select %3, %arg0, %c10_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %c26_i64, %c-14_i64 : i64
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
    %c-46_i64 = arith.constant -46 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.xor %c19_i64, %c-46_i64 : i64
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
    %c-18_i64 = arith.constant -18 : i64
    %c50_i64 = arith.constant 50 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.lshr %c50_i64, %c29_i64 : i64
    %1 = llvm.udiv %c-18_i64, %0 : i64
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
    %c-14_i64 = arith.constant -14 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "ult" %c42_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.urem %2, %c-14_i64 : i64
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
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.xor %c-6_i64, %arg0 : i64
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
    %c-13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.udiv %c-13_i64, %2 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.udiv %c42_i64, %c-10_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.xor %c-5_i64, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %c-11_i64, %0 : i64
    %2 = llvm.or %c-45_i64, %1 : i64
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
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %c-2_i64, %0 : i64
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
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %c-41_i64, %c1_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %c-35_i64, %arg0 : i64
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
    %c-7_i64 = arith.constant -7 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.xor %c-36_i64, %c-41_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "eq" %arg1, %c-7_i64 : i64
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
    %c-3_i64 = arith.constant -3 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %c-3_i64, %2 : i64
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
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %2 = llvm.xor %arg2, %arg2 : i64
    %3 = llvm.select %1, %c-5_i64, %2 : i1, i64
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
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.lshr %0, %c-23_i64 : i64
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
    %c-1_i64 = arith.constant -1 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.and %c23_i64, %c-19_i64 : i64
    %1 = llvm.icmp "ugt" %c-1_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "ult" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %c3_i64, %c-20_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.sdiv %c25_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %c-18_i64, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.ashr %c-50_i64, %arg0 : i64
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
    %c-13_i64 = arith.constant -13 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.and %c-13_i64, %c-39_i64 : i64
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
    %c-2_i64 = arith.constant -2 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.xor %c18_i64, %c-30_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %c-2_i64, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.xor %c49_i64, %2 : i64
    %4 = llvm.select %arg0, %c-41_i64, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %true = arith.constant true
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "eq" %c24_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %arg2, %arg0 : i64
    %3 = llvm.select %arg1, %2, %c-34_i64 : i1, i64
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
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.sdiv %c-41_i64, %arg0 : i64
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
    %c-33_i64 = arith.constant -33 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "ne" %c-33_i64, %c-30_i64 : i64
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
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %arg1, %c-27_i64 : i64
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
    %c-38_i64 = arith.constant -38 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.udiv %c-50_i64, %c20_i64 : i64
    %1 = llvm.udiv %0, %c-38_i64 : i64
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
    %c-20_i64 = arith.constant -20 : i64
    %true = arith.constant true
    %c-1_i64 = arith.constant -1 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.ashr %c-1_i64, %c25_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.xor %2, %c-20_i64 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %c-5_i64 = arith.constant -5 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.select %false, %c-5_i64, %c-39_i64 : i1, i64
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
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %c-14_i64, %0 : i64
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
    %c-26_i64 = arith.constant -26 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.select %arg1, %c-20_i64, %arg2 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.select %arg1, %c-26_i64, %arg2 : i1, i64
    %3 = llvm.xor %2, %c13_i64 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.xor %c-21_i64, %2 : i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.or %arg1, %c-44_i64 : i64
    %1 = llvm.select %arg0, %0, %c-3_i64 : i1, i64
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
    %c-5_i64 = arith.constant -5 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "ugt" %c-5_i64, %c-20_i64 : i64
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
    %c-45_i64 = arith.constant -45 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "ugt" %c-29_i64, %arg0 : i64
    %1 = llvm.srem %c-45_i64, %arg0 : i64
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
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %c-11_i64, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.xor %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c46_i64 : i64
    %2 = llvm.srem %1, %c-42_i64 : i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "sgt" %c-11_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %c-2_i64, %arg1 : i64
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
    %c-1_i64 = arith.constant -1 : i64
    %c-11_i64 = arith.constant -11 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "ult" %c-11_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %c-1_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-15_i64 = arith.constant -15 : i64
    %true = arith.constant true
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.select %true, %arg0, %c33_i64 : i1, i64
    %1 = llvm.urem %arg0, %c-15_i64 : i64
    %2 = llvm.xor %arg1, %c16_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.srem %c-23_i64, %c-27_i64 : i64
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
    %c-47_i64 = arith.constant -47 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.and %arg0, %c36_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sle" %c-47_i64, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %c9_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c-22_i64, %2 : i64
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
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.xor %arg0, %c-43_i64 : i64
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
    %c-38_i64 = arith.constant -38 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %c-4_i64 : i64
    %2 = llvm.srem %c29_i64, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "ule" %3, %c-38_i64 : i64
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
    %c-48_i64 = arith.constant -48 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "sgt" %c-8_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.xor %1, %c-48_i64 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.and %c11_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-30_i64 = arith.constant -30 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.or %0, %c-30_i64 : i64
    %2 = llvm.srem %0, %c-34_i64 : i64
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
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.udiv %arg0, %c-26_i64 : i64
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
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.ashr %c-44_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.udiv %c-44_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %c-20_i64 : i64
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
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %c-14_i64, %0 : i64
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
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.lshr %arg1, %c-1_i64 : i64
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
    %c-29_i64 = arith.constant -29 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "eq" %c-22_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.sdiv %1, %c-5_i64 : i64
    %3 = llvm.srem %c-29_i64, %arg0 : i64
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
    %c-13_i64 = arith.constant -13 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "ugt" %c21_i64, %arg0 : i64
    %1 = llvm.select %0, %c-13_i64, %arg0 : i1, i64
    %2 = llvm.icmp "ule" %arg0, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.or %arg0, %c-36_i64 : i64
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
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %c-33_i64, %0 : i64
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
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "ult" %c-48_i64, %arg0 : i64
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
    %c-10_i64 = arith.constant -10 : i64
    %c22_i64 = arith.constant 22 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "slt" %c38_i64, %c38_i64 : i64
    %1 = llvm.ashr %c22_i64, %arg0 : i64
    %2 = llvm.srem %c-10_i64, %arg1 : i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %0, %c31_i64 : i64
    %2 = llvm.icmp "uge" %1, %c-5_i64 : i64
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
    %c-41_i64 = arith.constant -41 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.udiv %c-48_i64, %c15_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "ugt" %c-41_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %c-11_i64, %arg2 : i64
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
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "sge" %c30_i64, %c-45_i64 : i64
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
    %c-47_i64 = arith.constant -47 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.urem %c-46_i64, %c35_i64 : i64
    %1 = llvm.ashr %arg0, %c25_i64 : i64
    %2 = llvm.sdiv %c-47_i64, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.lshr %c-19_i64, %c30_i64 : i64
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
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c-18_i64, %0 : i64
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
    %c-44_i64 = arith.constant -44 : i64
    %c26_i64 = arith.constant 26 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.or %arg0, %c-36_i64 : i64
    %1 = llvm.or %c26_i64, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %c-44_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.sdiv %c-39_i64, %arg1 : i64
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
    %c-48_i64 = arith.constant -48 : i64
    %true = arith.constant true
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %c43_i64 : i64
    %2 = llvm.srem %c46_i64, %1 : i64
    %3 = llvm.select %true, %2, %c21_i64 : i1, i64
    %4 = llvm.icmp "ne" %c-48_i64, %3 : i64
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
    %c-6_i64 = arith.constant -6 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "uge" %c-43_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %c-40_i64, %1 : i64
    %3 = llvm.select %2, %1, %arg1 : i1, i64
    %4 = llvm.icmp "ult" %c-6_i64, %3 : i64
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
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %c-13_i64, %0 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.srem %c-7_i64, %c13_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "sle" %c-43_i64, %0 : i64
    %3 = llvm.select %2, %1, %0 : i1, i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.sdiv %3, %c-48_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.srem %c23_i64, %c-43_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.urem %1, %c-13_i64 : i64
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
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "sge" %arg0, %c-8_i64 : i64
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
    %c-38_i64 = arith.constant -38 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.and %arg0, %c33_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.or %1, %c-38_i64 : i64
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
    %c-33_i64 = arith.constant -33 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.and %c-39_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.xor %c-42_i64, %1 : i64
    %3 = llvm.icmp "slt" %2, %c-33_i64 : i64
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
    %c-2_i64 = arith.constant -2 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %c6_i64 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.select %2, %c-2_i64, %0 : i1, i64
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
