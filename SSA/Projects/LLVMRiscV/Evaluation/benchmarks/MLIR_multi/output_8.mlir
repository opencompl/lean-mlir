module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c-18_i64 = arith.constant -18 : i64
    %false = arith.constant false
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.xor %c18_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.select %3, %arg1, %c-18_i64 : i1, i64
    %5 = llvm.or %arg2, %c-42_i64 : i64
    %6 = llvm.xor %5, %arg1 : i64
    %7 = llvm.ashr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %false = arith.constant false
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %false, %0, %arg1 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "sge" %c-19_i64, %0 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.xor %c-9_i64, %3 : i64
    %5 = llvm.and %c-29_i64, %c16_i64 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.icmp "ult" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %c-9_i64, %c-44_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %arg2, %c5_i64 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.srem %0, %5 : i64
    %7 = llvm.icmp "ne" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %true = arith.constant true
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.select %true, %1, %arg1 : i1, i64
    %3 = llvm.srem %2, %c9_i64 : i64
    %4 = llvm.ashr %arg0, %arg2 : i64
    %5 = llvm.icmp "ugt" %arg1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.xor %c-31_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.srem %c-25_i64, %4 : i64
    %6 = llvm.udiv %5, %arg2 : i64
    %7 = llvm.and %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.srem %c16_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.or %c34_i64, %arg0 : i64
    %3 = llvm.and %arg0, %1 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.ashr %arg1, %4 : i64
    %6 = llvm.ashr %2, %5 : i64
    %7 = llvm.icmp "slt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.select %false, %c0_i64, %arg0 : i1, i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c36_i64 = arith.constant 36 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %c7_i64, %0 : i64
    %2 = llvm.select %1, %0, %c36_i64 : i1, i64
    %3 = llvm.icmp "sge" %arg1, %c-9_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "uge" %4, %arg1 : i64
    %6 = llvm.select %5, %c19_i64, %arg2 : i1, i64
    %7 = llvm.ashr %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %c33_i64 = arith.constant 33 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.sdiv %c33_i64, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %arg2, %c-10_i64 : i64
    %6 = llvm.srem %5, %arg1 : i64
    %7 = llvm.or %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "ugt" %c-30_i64, %c13_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %arg1, %arg2 : i64
    %6 = llvm.srem %5, %c16_i64 : i64
    %7 = llvm.or %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %c-13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ule" %c-13_i64, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.or %2, %c-27_i64 : i64
    %4 = llvm.ashr %2, %arg0 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.select %1, %3, %5 : i1, i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %c22_i64 : i64
    %5 = llvm.srem %c45_i64, %4 : i64
    %6 = llvm.and %0, %5 : i64
    %7 = llvm.icmp "uge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.and %c-23_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.lshr %arg0, %c-50_i64 : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c-29_i64 = arith.constant -29 : i64
    %true = arith.constant true
    %c1_i64 = arith.constant 1 : i64
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "eq" %c1_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %false, %3, %c-29_i64 : i1, i64
    %5 = llvm.sdiv %4, %c-38_i64 : i64
    %6 = llvm.urem %0, %5 : i64
    %7 = llvm.icmp "sge" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %arg2, %arg0 : i64
    %2 = llvm.lshr %c39_i64, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sext %3 : i1 to i64
    %6 = llvm.select %3, %1, %5 : i1, i64
    %7 = llvm.ashr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c3_i64 = arith.constant 3 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %c-44_i64, %c3_i64 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.icmp "sge" %6, %c-50_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ult" %arg0, %c50_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg0, %arg0 : i64
    %3 = llvm.lshr %c7_i64, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "ne" %4, %arg1 : i64
    %6 = llvm.select %5, %arg2, %arg1 : i1, i64
    %7 = llvm.srem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c-10_i64 = arith.constant -10 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %c-23_i64, %3 : i64
    %5 = llvm.trunc %false : i1 to i64
    %6 = llvm.and %c-10_i64, %5 : i64
    %7 = llvm.or %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c37_i64 = arith.constant 37 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "eq" %arg1, %c41_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.or %2, %c-35_i64 : i64
    %4 = llvm.sdiv %3, %c37_i64 : i64
    %5 = llvm.urem %arg2, %c-37_i64 : i64
    %6 = llvm.xor %5, %c-44_i64 : i64
    %7 = llvm.and %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c33_i64 = arith.constant 33 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.urem %c42_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %1, %c33_i64 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.udiv %2, %arg1 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.udiv %c35_i64, %arg2 : i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.xor %c-39_i64, %c-26_i64 : i64
    %1 = llvm.and %c-20_i64, %0 : i64
    %2 = llvm.or %arg0, %c38_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.sdiv %5, %5 : i64
    %7 = llvm.udiv %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c2_i64 = arith.constant 2 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.or %c45_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.and %0, %c19_i64 : i64
    %4 = llvm.lshr %c-23_i64, %3 : i64
    %5 = llvm.icmp "sle" %c2_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c19_i64 = arith.constant 19 : i64
    %c25_i64 = arith.constant 25 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.lshr %c25_i64, %c39_i64 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.select %1, %c19_i64, %0 : i1, i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.select %false, %2, %3 : i1, i64
    %5 = llvm.icmp "uge" %4, %arg0 : i64
    %6 = llvm.select %5, %arg1, %4 : i1, i64
    %7 = llvm.icmp "ugt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.urem %c3_i64, %c25_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.and %arg1, %1 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.srem %2, %arg2 : i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "ne" %c-26_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %c14_i64 : i64
    %3 = llvm.lshr %arg1, %arg1 : i64
    %4 = llvm.and %c43_i64, %3 : i64
    %5 = llvm.icmp "sle" %c-7_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.xor %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.sdiv %c-1_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.urem %0, %arg1 : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    %4 = llvm.srem %2, %c-31_i64 : i64
    %5 = llvm.select %1, %arg2, %4 : i1, i64
    %6 = llvm.ashr %5, %c-24_i64 : i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "uge" %c-22_i64, %arg0 : i64
    %1 = llvm.ashr %c-11_i64, %arg0 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %0, %arg1, %3 : i1, i64
    %5 = llvm.urem %arg0, %4 : i64
    %6 = llvm.select %0, %5, %arg1 : i1, i64
    %7 = llvm.srem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "eq" %c-6_i64, %arg0 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.sdiv %arg0, %arg1 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %arg1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.icmp "sge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %arg1, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "slt" %c-14_i64, %0 : i64
    %5 = llvm.select %true, %3, %arg0 : i1, i64
    %6 = llvm.select %4, %5, %arg1 : i1, i64
    %7 = llvm.or %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.and %arg2, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %arg0, %5 : i64
    %7 = llvm.icmp "sge" %6, %1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %1, %c16_i64 : i64
    %3 = llvm.icmp "sle" %c-2_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %1, %arg0 : i64
    %6 = llvm.udiv %1, %5 : i64
    %7 = llvm.icmp "uge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %c25_i64, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.urem %0, %c-48_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.srem %arg2, %3 : i64
    %6 = llvm.lshr %arg1, %5 : i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %c-48_i64, %arg1 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.trunc %3 : i1 to i64
    %6 = llvm.icmp "ult" %4, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c36_i64 = arith.constant 36 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.ashr %c-24_i64, %arg0 : i64
    %1 = llvm.and %c14_i64, %0 : i64
    %2 = llvm.lshr %1, %c36_i64 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c43_i64 = arith.constant 43 : i64
    %c30_i64 = arith.constant 30 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.ashr %c30_i64, %c32_i64 : i64
    %1 = llvm.ashr %c-9_i64, %arg1 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "ult" %c43_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "eq" %4, %0 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "ne" %arg2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    %6 = llvm.select %5, %1, %1 : i1, i64
    %7 = llvm.icmp "ule" %c41_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.ashr %c-16_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %arg0, %4 : i64
    %6 = llvm.trunc %true : i1 to i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c26_i64 = arith.constant 26 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.srem %c48_i64, %c-21_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "eq" %c26_i64, %1 : i64
    %3 = llvm.select %2, %1, %c30_i64 : i1, i64
    %4 = llvm.xor %c-7_i64, %3 : i64
    %5 = llvm.sdiv %4, %0 : i64
    %6 = llvm.sdiv %5, %arg0 : i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.ashr %c43_i64, %0 : i64
    %2 = llvm.or %arg0, %arg2 : i64
    %3 = llvm.and %2, %c13_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.xor %c-39_i64, %4 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c20_i64 = arith.constant 20 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %c20_i64, %c-47_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.ashr %1, %c20_i64 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.srem %arg1, %c-23_i64 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c30_i64 = arith.constant 30 : i64
    %c38_i64 = arith.constant 38 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.select %arg0, %c38_i64, %c-29_i64 : i1, i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.xor %c30_i64, %1 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "sgt" %c1_i64, %0 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.urem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-50_i64 = arith.constant -50 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c49_i64 = arith.constant 49 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.udiv %c5_i64, %arg0 : i64
    %1 = llvm.or %0, %c49_i64 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.srem %c-50_i64, %2 : i64
    %4 = llvm.ashr %c-16_i64, %3 : i64
    %5 = llvm.icmp "sle" %c-44_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.udiv %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.ashr %arg2, %c-2_i64 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.ashr %c-29_i64, %3 : i64
    %5 = llvm.udiv %c44_i64, %c-40_i64 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.icmp "sle" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.sdiv %3, %c47_i64 : i64
    %5 = llvm.lshr %arg0, %3 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.or %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c-2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.xor %1, %c14_i64 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.and %c-2_i64, %3 : i64
    %5 = llvm.ashr %arg2, %2 : i64
    %6 = llvm.or %0, %5 : i64
    %7 = llvm.srem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "sle" %c-37_i64, %c29_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.ashr %c25_i64, %arg1 : i64
    %3 = llvm.zext %0 : i1 to i64
    %4 = llvm.sdiv %3, %arg2 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.urem %5, %3 : i64
    %7 = llvm.icmp "uge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.udiv %c-30_i64, %c-17_i64 : i64
    %4 = llvm.udiv %c5_i64, %c0_i64 : i64
    %5 = llvm.srem %arg2, %4 : i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.lshr %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c27_i64 = arith.constant 27 : i64
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %c27_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %false, %arg0, %2 : i1, i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.select %1, %arg1, %arg2 : i1, i64
    %6 = llvm.srem %5, %c25_i64 : i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.xor %c37_i64, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.xor %arg2, %0 : i64
    %4 = llvm.lshr %3, %c18_i64 : i64
    %5 = llvm.xor %4, %3 : i64
    %6 = llvm.select %2, %3, %5 : i1, i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c18_i64 = arith.constant 18 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %c-22_i64, %0 : i64
    %2 = llvm.and %c48_i64, %1 : i64
    %3 = llvm.sdiv %c-47_i64, %c46_i64 : i64
    %4 = llvm.or %3, %0 : i64
    %5 = llvm.icmp "ugt" %c18_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %c-43_i64, %c-9_i64 : i64
    %5 = llvm.srem %4, %c-15_i64 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.xor %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.udiv %c1_i64, %arg1 : i64
    %1 = llvm.or %c14_i64, %arg1 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %arg0, %arg1, %c29_i64 : i1, i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.select %arg0, %3, %5 : i1, i64
    %7 = llvm.icmp "eq" %c-32_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %c33_i64, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.sdiv %c22_i64, %arg2 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.icmp "sle" %3, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c44_i64 = arith.constant 44 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.xor %c44_i64, %c5_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.urem %arg2, %0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %arg1, %4 : i64
    %6 = llvm.or %1, %5 : i64
    %7 = llvm.icmp "uge" %6, %c40_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.lshr %c-40_i64, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.xor %c-7_i64, %arg2 : i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.icmp "ne" %3, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c13_i64 = arith.constant 13 : i64
    %true = arith.constant true
    %c20_i64 = arith.constant 20 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.select %true, %c13_i64, %c6_i64 : i1, i64
    %4 = llvm.lshr %c20_i64, %3 : i64
    %5 = llvm.or %3, %3 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c8_i64 = arith.constant 8 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %c31_i64, %0 : i64
    %2 = llvm.or %arg0, %c8_i64 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %5, %c5_i64 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.lshr %c-28_i64, %c30_i64 : i64
    %1 = llvm.or %0, %c-24_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sge" %5, %arg0 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.select %false, %c-17_i64, %0 : i1, i64
    %2 = llvm.icmp "sle" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %arg2, %arg1 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %true = arith.constant true
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %c37_i64, %arg1 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.or %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %c-11_i64, %arg0 : i64
    %1 = llvm.and %c-38_i64, %0 : i64
    %2 = llvm.lshr %c-28_i64, %1 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    %4 = llvm.icmp "ule" %3, %c44_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.lshr %c-13_i64, %5 : i64
    %7 = llvm.lshr %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.select %arg1, %0, %arg2 : i1, i64
    %3 = llvm.urem %2, %c26_i64 : i64
    %4 = llvm.srem %3, %2 : i64
    %5 = llvm.urem %4, %0 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.sdiv %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.ashr %c40_i64, %c-34_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.ashr %c46_i64, %c50_i64 : i64
    %5 = llvm.icmp "ne" %c-38_i64, %4 : i64
    %6 = llvm.select %5, %3, %0 : i1, i64
    %7 = llvm.urem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.urem %2, %c-21_i64 : i64
    %4 = llvm.sdiv %arg0, %arg1 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "slt" %c-27_i64, %c30_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "ult" %1, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "slt" %6, %1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "sge" %4, %arg2 : i64
    %6 = llvm.lshr %c-30_i64, %arg1 : i64
    %7 = llvm.select %5, %c36_i64, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.and %4, %1 : i64
    %6 = llvm.ashr %0, %5 : i64
    %7 = llvm.urem %c-34_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.srem %arg0, %c-43_i64 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %arg2, %3 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.or %4, %0 : i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.urem %c-31_i64, %1 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.srem %arg0, %4 : i64
    %6 = llvm.icmp "ne" %arg0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %c-47_i64, %arg2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c48_i64 = arith.constant 48 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %c-34_i64, %arg0 : i64
    %2 = llvm.xor %1, %c45_i64 : i64
    %3 = llvm.urem %0, %c48_i64 : i64
    %4 = llvm.urem %3, %c0_i64 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.xor %1, %c-4_i64 : i64
    %3 = llvm.urem %c-36_i64, %c-8_i64 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %5, %c-47_i64 : i64
    %7 = llvm.icmp "eq" %6, %c4_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.sext %0 : i1 to i64
    %4 = llvm.ashr %3, %3 : i64
    %5 = llvm.or %4, %c-13_i64 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.or %arg1, %c-12_i64 : i64
    %1 = llvm.icmp "ne" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.urem %c44_i64, %arg2 : i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.or %2, %5 : i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %arg1, %c-4_i64 : i64
    %2 = llvm.sdiv %0, %0 : i64
    %3 = llvm.select %1, %arg0, %2 : i1, i64
    %4 = llvm.and %3, %c42_i64 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "slt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.srem %c15_i64, %c36_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c34_i64 = arith.constant 34 : i64
    %c22_i64 = arith.constant 22 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.xor %c37_i64, %arg0 : i64
    %1 = llvm.urem %0, %c22_i64 : i64
    %2 = llvm.xor %arg1, %arg2 : i64
    %3 = llvm.lshr %c34_i64, %2 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.lshr %6, %4 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "ult" %c-9_i64, %c8_i64 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "sgt" %arg2, %c43_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.select %0, %arg0, %5 : i1, i64
    %7 = llvm.urem %c-42_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "ult" %arg2, %1 : i64
    %4 = llvm.icmp "eq" %c2_i64, %2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.select %3, %arg0, %5 : i1, i64
    %7 = llvm.xor %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "uge" %c-49_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg0, %arg1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.and %arg2, %2 : i64
    %5 = llvm.select %0, %4, %2 : i1, i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.select %0, %1, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %c11_i64, %arg2 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "sgt" %arg1, %3 : i64
    %5 = llvm.select %4, %arg2, %2 : i1, i64
    %6 = llvm.urem %5, %1 : i64
    %7 = llvm.and %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c-46_i64 = arith.constant -46 : i64
    %true = arith.constant true
    %c-4_i64 = arith.constant -4 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.ashr %c-4_i64, %c36_i64 : i64
    %1 = llvm.select %true, %0, %c-46_i64 : i1, i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.select %2, %arg0, %0 : i1, i64
    %4 = llvm.icmp "eq" %3, %c27_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c-44_i64 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %c2_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %2, %arg1 : i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    %7 = llvm.select %6, %2, %arg0 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %3, %arg2 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.urem %6, %c27_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.or %c-40_i64, %1 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.sdiv %3, %arg0 : i64
    %5 = llvm.icmp "sge" %arg2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c47_i64 = arith.constant 47 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.ashr %arg0, %c12_i64 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.srem %c47_i64, %2 : i64
    %4 = llvm.lshr %3, %arg2 : i64
    %5 = llvm.icmp "uge" %4, %c11_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.or %arg0, %c36_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.and %c-38_i64, %c15_i64 : i64
    %3 = llvm.and %arg1, %arg0 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.lshr %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %true = arith.constant true
    %c8_i64 = arith.constant 8 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "slt" %c8_i64, %c-7_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %true, %1, %1 : i1, i64
    %3 = llvm.icmp "slt" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %c-32_i64, %1 : i64
    %6 = llvm.udiv %1, %5 : i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-48_i64 = arith.constant -48 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.icmp "sgt" %arg1, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %2, %c-33_i64 : i64
    %4 = llvm.udiv %c-48_i64, %3 : i64
    %5 = llvm.icmp "sle" %4, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %arg2, %arg2 : i64
    %5 = llvm.trunc %2 : i1 to i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.lshr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.xor %c-29_i64, %arg2 : i64
    %1 = llvm.xor %arg2, %0 : i64
    %2 = llvm.or %1, %c23_i64 : i64
    %3 = llvm.select %arg0, %arg1, %2 : i1, i64
    %4 = llvm.sdiv %c-32_i64, %c-45_i64 : i64
    %5 = llvm.srem %4, %c-32_i64 : i64
    %6 = llvm.lshr %c-31_i64, %5 : i64
    %7 = llvm.icmp "uge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.xor %c-7_i64, %c-26_i64 : i64
    %1 = llvm.xor %c42_i64, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %4, %1 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %c-33_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %5, %3 : i64
    %7 = llvm.icmp "uge" %c20_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c-7_i64 = arith.constant -7 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.xor %c-7_i64, %c-46_i64 : i64
    %4 = llvm.icmp "slt" %3, %0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.ashr %5, %arg1 : i64
    %7 = llvm.icmp "uge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "ugt" %arg2, %c8_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.or %5, %1 : i64
    %7 = llvm.xor %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-4_i64 = arith.constant -4 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %c-29_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ule" %c-4_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.select %0, %1, %c-6_i64 : i1, i64
    %4 = llvm.and %3, %arg2 : i64
    %5 = llvm.icmp "ugt" %arg1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "ne" %arg0, %c-45_i64 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.ashr %arg1, %arg1 : i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.xor %5, %arg2 : i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c47_i64 = arith.constant 47 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "ne" %c22_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.icmp "eq" %2, %c47_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %0, %1, %4 : i1, i64
    %6 = llvm.and %2, %c-19_i64 : i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c20_i64 = arith.constant 20 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.srem %c12_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.and %0, %c20_i64 : i64
    %3 = llvm.or %c32_i64, %arg1 : i64
    %4 = llvm.icmp "ugt" %3, %arg1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.or %2, %5 : i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %c50_i64, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.select %4, %arg1, %1 : i1, i64
    %7 = llvm.and %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c-21_i64 = arith.constant -21 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.select %false, %c-21_i64, %0 : i1, i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.and %1, %c7_i64 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "ult" %c-36_i64, %c-5_i64 : i64
    %1 = llvm.sdiv %arg1, %c46_i64 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.or %c-9_i64, %arg1 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.xor %c0_i64, %3 : i64
    %7 = llvm.lshr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c1_i64 = arith.constant 1 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "eq" %arg0, %c-15_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.ashr %c1_i64, %c-46_i64 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    %5 = llvm.select %4, %arg1, %arg2 : i1, i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ne" %arg0, %c48_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.lshr %2, %arg2 : i64
    %4 = llvm.icmp "sgt" %c32_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.lshr %arg1, %5 : i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c22_i64 = arith.constant 22 : i64
    %c28_i64 = arith.constant 28 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.ashr %c28_i64, %c-31_i64 : i64
    %1 = llvm.lshr %c22_i64, %0 : i64
    %2 = llvm.select %arg0, %c-41_i64, %0 : i1, i64
    %3 = llvm.or %arg1, %0 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.icmp "sge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c19_i64 = arith.constant 19 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.select %arg0, %arg1, %c0_i64 : i1, i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.icmp "eq" %0, %c19_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.ashr %4, %c29_i64 : i64
    %6 = llvm.udiv %c-45_i64, %5 : i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.and %c47_i64, %arg0 : i64
    %1 = llvm.srem %0, %c-22_i64 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.zext %arg1 : i1 to i64
    %5 = llvm.and %4, %2 : i64
    %6 = llvm.sdiv %3, %5 : i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.icmp "eq" %c-38_i64, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.lshr %c-46_i64, %3 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.select %arg0, %c39_i64, %5 : i1, i64
    %7 = llvm.icmp "uge" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %true = arith.constant true
    %c-5_i64 = arith.constant -5 : i64
    %c24_i64 = arith.constant 24 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %0, %c24_i64 : i64
    %2 = llvm.sdiv %arg0, %c-5_i64 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.srem %3, %c31_i64 : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.ashr %5, %arg1 : i64
    %7 = llvm.icmp "sge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.select %1, %arg2, %c-12_i64 : i1, i64
    %3 = llvm.icmp "sgt" %c45_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %c-2_i64, %4 : i64
    %6 = llvm.sdiv %c21_i64, %arg0 : i64
    %7 = llvm.icmp "slt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %c-28_i64, %arg0 : i64
    %1 = llvm.select %arg1, %c-15_i64, %arg0 : i1, i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.srem %arg2, %0 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "sge" %4, %c8_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c44_i64 = arith.constant 44 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %c1_i64, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %2, %c44_i64 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.sdiv %c26_i64, %arg0 : i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c6_i64 = arith.constant 6 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.sdiv %c23_i64, %arg1 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %c-42_i64, %c-48_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.and %4, %arg2 : i64
    %6 = llvm.xor %c6_i64, %5 : i64
    %7 = llvm.icmp "ult" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %c-38_i64 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.xor %arg1, %0 : i64
    %4 = llvm.sdiv %c34_i64, %3 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.and %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ugt" %c-13_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg1 : i64
    %2 = llvm.select %0, %c50_i64, %arg2 : i1, i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.icmp "sgt" %c-38_i64, %arg0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.urem %arg2, %5 : i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.urem %c-37_i64, %c39_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "sgt" %arg2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %arg1, %4 : i64
    %6 = llvm.and %5, %c28_i64 : i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.xor %c-17_i64, %1 : i64
    %3 = llvm.icmp "ne" %1, %c49_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %c45_i64, %4 : i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c-37_i64 = arith.constant -37 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.or %arg1, %c-37_i64 : i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.srem %4, %c11_i64 : i64
    %6 = llvm.or %2, %5 : i64
    %7 = llvm.srem %6, %arg1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c-42_i64 = arith.constant -42 : i64
    %true = arith.constant true
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.and %c-23_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.sdiv %1, %c-42_i64 : i64
    %4 = llvm.select %true, %2, %3 : i1, i64
    %5 = llvm.icmp "ult" %c35_i64, %0 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.or %c-38_i64, %arg0 : i64
    %1 = llvm.udiv %c0_i64, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %c-6_i64, %c-23_i64 : i64
    %6 = llvm.udiv %5, %0 : i64
    %7 = llvm.urem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c8_i64 = arith.constant 8 : i64
    %false = arith.constant false
    %c17_i64 = arith.constant 17 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.sdiv %c-45_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c17_i64, %0 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.lshr %c8_i64, %arg1 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    %7 = llvm.select %6, %c24_i64, %5 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.select %3, %c41_i64, %arg2 : i1, i64
    %5 = llvm.icmp "sle" %4, %c-3_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c29_i64 = arith.constant 29 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c36_i64 = arith.constant 36 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.select %arg0, %c36_i64, %c27_i64 : i1, i64
    %1 = llvm.xor %c-25_i64, %0 : i64
    %2 = llvm.udiv %c29_i64, %arg1 : i64
    %3 = llvm.srem %arg1, %c2_i64 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.lshr %4, %4 : i64
    %6 = llvm.ashr %2, %5 : i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.udiv %c30_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg2 : i64
    %2 = llvm.icmp "ule" %arg1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ne" %c-3_i64, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c18_i64 = arith.constant 18 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %c13_i64, %arg2 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.or %c18_i64, %arg2 : i64
    %5 = llvm.srem %2, %c-9_i64 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %arg0, %arg0 : i64
    %5 = llvm.ashr %arg1, %1 : i64
    %6 = llvm.select %4, %5, %arg2 : i1, i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.urem %arg1, %arg2 : i64
    %4 = llvm.icmp "ule" %c14_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg1, %c-50_i64 : i64
    %2 = llvm.or %1, %c32_i64 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %c-42_i64, %c29_i64 : i64
    %6 = llvm.urem %5, %0 : i64
    %7 = llvm.and %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c33_i64 = arith.constant 33 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.xor %c33_i64, %c49_i64 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %c-8_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %c5_i64, %2 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.srem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c20_i64 = arith.constant 20 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c-14_i64, %arg0 : i1, i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.sdiv %c20_i64, %c-3_i64 : i64
    %5 = llvm.and %arg0, %arg1 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.icmp "ult" %arg1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.lshr %arg1, %c14_i64 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.icmp "uge" %4, %arg0 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.or %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ule" %c16_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.and %c-40_i64, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.urem %c44_i64, %1 : i64
    %4 = llvm.icmp "sgt" %arg0, %c-32_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.select %2, %3, %5 : i1, i64
    %7 = llvm.icmp "uge" %6, %1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %arg1, %c-19_i64 : i64
    %2 = llvm.sdiv %arg1, %arg2 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "uge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.udiv %1, %c-13_i64 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.lshr %c4_i64, %c36_i64 : i64
    %5 = llvm.sdiv %c-19_i64, %4 : i64
    %6 = llvm.udiv %c-19_i64, %5 : i64
    %7 = llvm.ashr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.urem %arg0, %arg1 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.srem %c-40_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-2_i64 = arith.constant -2 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.urem %c-2_i64, %c-7_i64 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.select %false, %2, %3 : i1, i64
    %5 = llvm.and %2, %2 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.urem %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c-33_i64 = arith.constant -33 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.lshr %3, %c-33_i64 : i64
    %5 = llvm.xor %1, %0 : i64
    %6 = llvm.xor %5, %c33_i64 : i64
    %7 = llvm.icmp "uge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %true = arith.constant true
    %c-21_i64 = arith.constant -21 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.srem %c-21_i64, %c-9_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.select %true, %1, %1 : i1, i64
    %3 = llvm.srem %2, %c4_i64 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.lshr %0, %arg1 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.sdiv %6, %2 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c12_i64 = arith.constant 12 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.select %true, %c12_i64, %c32_i64 : i1, i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %arg0, %arg0 : i64
    %4 = llvm.select %1, %3, %3 : i1, i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "slt" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.and %c12_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "eq" %1, %c32_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "eq" %c-31_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "ule" %c29_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.sdiv %c36_i64, %1 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.icmp "slt" %4, %1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.ashr %0, %arg0 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.xor %arg0, %5 : i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %arg1, %arg0 : i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.icmp "ult" %4, %c-35_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "slt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-19_i64 = arith.constant -19 : i64
    %true = arith.constant true
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.select %true, %c40_i64, %arg0 : i1, i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c-17_i64, %c21_i64 : i64
    %4 = llvm.ashr %3, %3 : i64
    %5 = llvm.xor %c-19_i64, %4 : i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %1, %c14_i64 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.lshr %2, %arg0 : i64
    %5 = llvm.and %c-50_i64, %4 : i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.icmp "sgt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.urem %arg0, %c14_i64 : i64
    %1 = llvm.sdiv %0, %c-20_i64 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %c25_i64, %0 : i64
    %5 = llvm.select %2, %arg1, %c44_i64 : i1, i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.icmp "slt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.urem %arg0, %c-35_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.srem %4, %arg0 : i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.and %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c5_i64 = arith.constant 5 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.srem %c-50_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.or %0, %0 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.ashr %c5_i64, %4 : i64
    %6 = llvm.and %5, %2 : i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.udiv %c32_i64, %arg1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.xor %c-10_i64, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.sext %arg2 : i1 to i64
    %7 = llvm.icmp "sge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.or %arg0, %c-17_i64 : i64
    %1 = llvm.icmp "eq" %c50_i64, %0 : i64
    %2 = llvm.udiv %c-15_i64, %0 : i64
    %3 = llvm.icmp "uge" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %2, %2 : i64
    %6 = llvm.select %1, %4, %5 : i1, i64
    %7 = llvm.select %1, %6, %arg0 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.urem %c34_i64, %arg1 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.trunc %false : i1 to i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c48_i64 = arith.constant 48 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c49_i64, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ugt" %c48_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %c-13_i64, %0 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "uge" %4, %3 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sle" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.and %arg1, %c-44_i64 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.select %4, %c32_i64, %arg0 : i1, i64
    %6 = llvm.udiv %5, %c35_i64 : i64
    %7 = llvm.select %4, %2, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c40_i64 = arith.constant 40 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ne" %c40_i64, %c43_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %c-28_i64 : i64
    %3 = llvm.xor %c-20_i64, %2 : i64
    %4 = llvm.urem %3, %3 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sge" %6, %arg0 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %arg1, %arg1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %c-43_i64, %1 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "uge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "sgt" %c7_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %arg2, %4 : i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.lshr %arg0, %c40_i64 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.trunc %3 : i1 to i64
    %6 = llvm.lshr %arg1, %5 : i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.urem %c9_i64, %c-15_i64 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %3, %1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %c-33_i64 = arith.constant -33 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.and %c-33_i64, %c8_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.sdiv %5, %3 : i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.udiv %0, %arg0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.select %3, %arg2, %c0_i64 : i1, i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "eq" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %c-11_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c-36_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.sdiv %3, %5 : i64
    %7 = llvm.or %c-5_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c48_i64 = arith.constant 48 : i64
    %c9_i64 = arith.constant 9 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c9_i64, %c48_i64 : i64
    %3 = llvm.or %c30_i64, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.urem %arg2, %c-22_i64 : i64
    %6 = llvm.sdiv %1, %5 : i64
    %7 = llvm.urem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.xor %arg0, %c-31_i64 : i64
    %1 = llvm.and %c44_i64, %0 : i64
    %2 = llvm.xor %arg1, %c-21_i64 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.sdiv %4, %0 : i64
    %6 = llvm.udiv %arg2, %c0_i64 : i64
    %7 = llvm.or %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c39_i64 = arith.constant 39 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %c-15_i64, %arg1 : i64
    %1 = llvm.sdiv %arg0, %arg2 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.or %c-9_i64, %0 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.urem %c39_i64, %4 : i64
    %6 = llvm.ashr %2, %5 : i64
    %7 = llvm.icmp "slt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "ult" %c-45_i64, %c36_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.lshr %c-46_i64, %2 : i64
    %4 = llvm.urem %2, %c-44_i64 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c17_i64, %arg1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.srem %arg2, %2 : i64
    %5 = llvm.ashr %3, %c-25_i64 : i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.udiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %c21_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %1, %2, %2 : i1, i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "ule" %4, %c32_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.xor %c-20_i64, %1 : i64
    %4 = llvm.select %arg2, %3, %3 : i1, i64
    %5 = llvm.sdiv %arg0, %4 : i64
    %6 = llvm.and %2, %5 : i64
    %7 = llvm.urem %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "uge" %c-39_i64, %c13_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "sgt" %3, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %5, %arg1 : i64
    %7 = llvm.icmp "slt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c41_i64 = arith.constant 41 : i64
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.select %true, %arg2, %0 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.srem %arg0, %c41_i64 : i64
    %4 = llvm.sdiv %c49_i64, %arg2 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.and %2, %5 : i64
    %7 = llvm.icmp "sge" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-28_i64 = arith.constant -28 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %c-8_i64, %0 : i64
    %2 = llvm.urem %c-28_i64, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.ashr %3, %arg1 : i64
    %5 = llvm.select %false, %arg0, %arg2 : i1, i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "sge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.ashr %1, %arg2 : i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.lshr %4, %0 : i64
    %6 = llvm.select %2, %3, %5 : i1, i64
    %7 = llvm.icmp "sgt" %c-26_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %c-22_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sgt" %4, %2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.udiv %arg0, %c-39_i64 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.lshr %arg0, %0 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.sdiv %6, %arg1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.udiv %c21_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.lshr %0, %arg0 : i64
    %3 = llvm.icmp "ugt" %1, %0 : i64
    %4 = llvm.select %3, %c-14_i64, %2 : i1, i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ule" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.lshr %c26_i64, %arg1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.icmp "slt" %arg1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.icmp "sge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.sdiv %c31_i64, %c-47_i64 : i64
    %3 = llvm.icmp "uge" %2, %c5_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    %6 = llvm.or %1, %0 : i64
    %7 = llvm.select %5, %6, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c-11_i64 = arith.constant -11 : i64
    %true = arith.constant true
    %c-40_i64 = arith.constant -40 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "ne" %arg0, %arg2 : i64
    %1 = llvm.select %0, %c24_i64, %c-40_i64 : i1, i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.select %true, %c-11_i64, %c-28_i64 : i1, i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.srem %arg1, %4 : i64
    %6 = llvm.udiv %arg0, %5 : i64
    %7 = llvm.xor %6, %c24_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.srem %c27_i64, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "ult" %2, %c3_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %arg0, %2 : i64
    %6 = llvm.or %1, %5 : i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %arg1, %c31_i64 : i64
    %2 = llvm.srem %c-11_i64, %arg1 : i64
    %3 = llvm.select %arg0, %arg2, %2 : i1, i64
    %4 = llvm.and %3, %2 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.or %arg0, %c-31_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "ule" %2, %c-23_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %arg0, %1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.and %arg1, %0 : i64
    %3 = llvm.xor %2, %c22_i64 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.select %4, %1, %0 : i1, i64
    %7 = llvm.xor %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "sge" %1, %2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.ashr %3, %5 : i64
    %7 = llvm.lshr %6, %0 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c10_i64 = arith.constant 10 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.srem %arg0, %c-18_i64 : i64
    %3 = llvm.and %arg1, %arg2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.icmp "eq" %c10_i64, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-3_i64 = arith.constant -3 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.srem %c-39_i64, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.trunc %true : i1 to i64
    %6 = llvm.srem %c-3_i64, %5 : i64
    %7 = llvm.icmp "eq" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %false = arith.constant false
    %c-49_i64 = arith.constant -49 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.xor %c-49_i64, %c-23_i64 : i64
    %1 = llvm.select %false, %0, %c-18_i64 : i1, i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    %6 = llvm.select %5, %0, %arg2 : i1, i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c-11_i64 = arith.constant -11 : i64
    %c41_i64 = arith.constant 41 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.ashr %c40_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.lshr %0, %0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    %5 = llvm.select %4, %c41_i64, %c-11_i64 : i1, i64
    %6 = llvm.trunc %true : i1 to i64
    %7 = llvm.srem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.urem %arg0, %arg2 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %false, %arg1, %1 : i1, i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ne" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.icmp "ugt" %arg0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c49_i64 = arith.constant 49 : i64
    %c14_i64 = arith.constant 14 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.urem %c14_i64, %c5_i64 : i64
    %1 = llvm.and %c49_i64, %c-26_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %arg0, %c41_i64 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c3_i64 = arith.constant 3 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %c-27_i64, %c3_i64 : i64
    %2 = llvm.and %0, %arg0 : i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.select %1, %c-3_i64, %0 : i1, i64
    %5 = llvm.udiv %4, %arg1 : i64
    %6 = llvm.select %1, %3, %5 : i1, i64
    %7 = llvm.xor %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.or %0, %c3_i64 : i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "uge" %4, %1 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sle" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.ashr %c49_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %arg1 : i64
    %2 = llvm.select %1, %arg0, %arg2 : i1, i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.xor %c-5_i64, %4 : i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c14_i64 = arith.constant 14 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.or %c4_i64, %arg0 : i64
    %1 = llvm.and %c14_i64, %0 : i64
    %2 = llvm.xor %c-12_i64, %1 : i64
    %3 = llvm.lshr %c-27_i64, %0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.xor %arg0, %c-12_i64 : i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "eq" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.select %1, %2, %arg0 : i1, i64
    %4 = llvm.lshr %3, %c-40_i64 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.xor %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.urem %c-14_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "eq" %arg0, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %c-36_i64 : i64
    %5 = llvm.icmp "sge" %arg1, %4 : i64
    %6 = llvm.select %5, %4, %c-46_i64 : i1, i64
    %7 = llvm.icmp "ugt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.select %arg1, %arg0, %c-3_i64 : i1, i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %arg2, %c47_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.or %arg2, %c-6_i64 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.urem %c8_i64, %4 : i64
    %6 = llvm.sdiv %0, %5 : i64
    %7 = llvm.icmp "slt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %arg2, %c46_i64 : i64
    %2 = llvm.srem %arg0, %arg0 : i64
    %3 = llvm.sdiv %2, %c-41_i64 : i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.srem %5, %arg1 : i64
    %7 = llvm.icmp "sge" %6, %c-13_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %0, %0 : i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sge" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.ashr %c-5_i64, %arg0 : i64
    %1 = llvm.udiv %c35_i64, %arg0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.udiv %arg0, %5 : i64
    %7 = llvm.ashr %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c38_i64 = arith.constant 38 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.xor %c38_i64, %c-20_i64 : i64
    %1 = llvm.and %c-17_i64, %0 : i64
    %2 = llvm.or %0, %c-30_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.udiv %c-41_i64, %5 : i64
    %7 = llvm.icmp "sgt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %c18_i64 : i64
    %3 = llvm.icmp "ne" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %arg1, %2 : i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.ashr %0, %c37_i64 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %3, %arg2, %4 : i1, i64
    %6 = llvm.select %arg0, %arg2, %5 : i1, i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %arg0, %c-13_i64 : i64
    %4 = llvm.xor %c-23_i64, %3 : i64
    %5 = llvm.urem %arg2, %4 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %arg2, %c13_i64 : i64
    %3 = llvm.lshr %arg0, %c-40_i64 : i64
    %4 = llvm.and %3, %c29_i64 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "slt" %2, %arg0 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.lshr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %c-28_i64, %arg0 : i64
    %1 = llvm.xor %0, %c-24_i64 : i64
    %2 = llvm.urem %c10_i64, %1 : i64
    %3 = llvm.icmp "sgt" %arg1, %1 : i64
    %4 = llvm.urem %0, %c-45_i64 : i64
    %5 = llvm.select %3, %4, %1 : i1, i64
    %6 = llvm.or %5, %4 : i64
    %7 = llvm.icmp "ult" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %arg2, %1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.xor %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.srem %arg0, %c-16_i64 : i64
    %1 = llvm.xor %c-22_i64, %0 : i64
    %2 = llvm.urem %c-3_i64, %1 : i64
    %3 = llvm.or %1, %1 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.srem %1, %arg1 : i64
    %6 = llvm.lshr %5, %arg2 : i64
    %7 = llvm.select %4, %1, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c42_i64 = arith.constant 42 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.select %arg0, %c-12_i64, %0 : i1, i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.ashr %c42_i64, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.xor %5, %1 : i64
    %7 = llvm.icmp "slt" %6, %c48_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-38_i64 = arith.constant -38 : i64
    %true = arith.constant true
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.select %true, %c-24_i64, %arg0 : i1, i64
    %1 = llvm.icmp "sle" %arg1, %c-38_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "sgt" %arg2, %c44_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %5, %5 : i64
    %7 = llvm.sdiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-7_i64 = arith.constant -7 : i64
    %true = arith.constant true
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.ashr %c-20_i64, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.select %true, %c-7_i64, %c18_i64 : i1, i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "ult" %4, %arg0 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "sgt" %c-26_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.select %false, %1, %3 : i1, i64
    %5 = llvm.or %4, %2 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.icmp "sge" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %arg1, %arg2 : i64
    %4 = llvm.xor %c38_i64, %3 : i64
    %5 = llvm.select %1, %2, %4 : i1, i64
    %6 = llvm.select %false, %5, %5 : i1, i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.select %true, %1, %3 : i1, i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.lshr %c-12_i64, %0 : i64
    %2 = llvm.icmp "ule" %c36_i64, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %arg2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.icmp "ne" %6, %1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.srem %4, %0 : i64
    %6 = llvm.srem %c5_i64, %c10_i64 : i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.lshr %c-32_i64, %c43_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.lshr %c-6_i64, %3 : i64
    %5 = llvm.sdiv %arg2, %c23_i64 : i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c37_i64 = arith.constant 37 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.lshr %arg0, %c-11_i64 : i64
    %1 = llvm.and %c37_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sle" %2, %c45_i64 : i64
    %4 = llvm.icmp "ult" %arg1, %2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.select %3, %0, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg1, %c-14_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.ashr %0, %5 : i64
    %7 = llvm.icmp "sgt" %c-30_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c32_i64 = arith.constant 32 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.select %1, %c10_i64, %0 : i1, i64
    %3 = llvm.and %2, %c32_i64 : i64
    %4 = llvm.lshr %3, %0 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "ule" %5, %c13_i64 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.or %arg0, %0 : i64
    %3 = llvm.select %1, %arg0, %2 : i1, i64
    %4 = llvm.icmp "sle" %c8_i64, %arg0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.select %arg1, %1, %c32_i64 : i1, i64
    %3 = llvm.select %arg1, %2, %arg0 : i1, i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "sle" %1, %3 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c36_i64 = arith.constant 36 : i64
    %c32_i64 = arith.constant 32 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "slt" %c32_i64, %c50_i64 : i64
    %1 = llvm.select %0, %arg0, %c36_i64 : i1, i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.trunc %0 : i1 to i64
    %4 = llvm.and %3, %c-1_i64 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.srem %arg2, %5 : i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c2_i64 = arith.constant 2 : i64
    %c32_i64 = arith.constant 32 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.select %arg0, %arg1, %c18_i64 : i1, i64
    %1 = llvm.urem %c32_i64, %0 : i64
    %2 = llvm.icmp "sle" %1, %c-11_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %arg1, %c13_i64 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ne" %c2_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c40_i64 = arith.constant 40 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %c40_i64, %c-37_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.select %3, %c36_i64, %1 : i1, i64
    %5 = llvm.icmp "ugt" %4, %c-20_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "uge" %c47_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ult" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.sext %arg2 : i1 to i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.select %arg2, %c-8_i64, %arg1 : i1, i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.urem %2, %5 : i64
    %7 = llvm.icmp "eq" %6, %1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %c-5_i64, %c-11_i64 : i64
    %6 = llvm.udiv %5, %1 : i64
    %7 = llvm.urem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c44_i64 = arith.constant 44 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %c44_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %arg0, %c28_i64 : i64
    %5 = llvm.xor %4, %4 : i64
    %6 = llvm.udiv %5, %5 : i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c9_i64 = arith.constant 9 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.and %c0_i64, %c-33_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.urem %c9_i64, %1 : i64
    %3 = llvm.srem %c-2_i64, %arg0 : i64
    %4 = llvm.lshr %3, %0 : i64
    %5 = llvm.xor %arg0, %4 : i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.icmp "sge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c33_i64 = arith.constant 33 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.srem %c11_i64, %arg0 : i64
    %1 = llvm.urem %c33_i64, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "sle" %c-23_i64, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %2, %arg0 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.udiv %arg2, %c12_i64 : i64
    %2 = llvm.xor %c-4_i64, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.select %arg0, %arg1, %3 : i1, i64
    %5 = llvm.or %4, %2 : i64
    %6 = llvm.urem %0, %5 : i64
    %7 = llvm.srem %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %arg0, %4 : i64
    %6 = llvm.sext %true : i1 to i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.udiv %c39_i64, %arg1 : i64
    %3 = llvm.udiv %arg1, %0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.srem %5, %3 : i64
    %7 = llvm.lshr %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.lshr %arg0, %c-24_i64 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.icmp "eq" %c12_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.urem %arg0, %c33_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c-44_i64, %2 : i64
    %4 = llvm.trunc %arg1 : i1 to i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "ugt" %c-21_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.trunc %arg1 : i1 to i64
    %6 = llvm.xor %5, %c5_i64 : i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c23_i64 = arith.constant 23 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.ashr %arg0, %c3_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.ashr %c23_i64, %c18_i64 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.select %arg1, %2, %3 : i1, i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.and %5, %1 : i64
    %7 = llvm.icmp "sle" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-33_i64 = arith.constant -33 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ne" %c-33_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %arg1, %arg2 : i64
    %6 = llvm.xor %5, %c29_i64 : i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.xor %c49_i64, %c-45_i64 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.udiv %arg0, %arg1 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.select %1, %0, %3 : i1, i64
    %5 = llvm.icmp "sle" %4, %c32_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "slt" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.and %c-12_i64, %arg0 : i64
    %1 = llvm.and %arg0, %c-13_i64 : i64
    %2 = llvm.lshr %arg1, %c-41_i64 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.and %3, %c40_i64 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c13_i64 = arith.constant 13 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %arg1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.srem %5, %c13_i64 : i64
    %7 = llvm.udiv %6, %c39_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %c-18_i64, %2 : i64
    %4 = llvm.trunc %arg2 : i1 to i64
    %5 = llvm.icmp "ule" %4, %0 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.ashr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c20_i64 = arith.constant 20 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.xor %c-48_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %c20_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %arg2, %c26_i64 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "ne" %c-18_i64, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c34_i64 = arith.constant 34 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ule" %c34_i64, %c48_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg1, %c42_i64 : i64
    %3 = llvm.ashr %arg1, %arg0 : i64
    %4 = llvm.select %2, %arg1, %3 : i1, i64
    %5 = llvm.urem %4, %1 : i64
    %6 = llvm.urem %arg0, %5 : i64
    %7 = llvm.icmp "uge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c26_i64 = arith.constant 26 : i64
    %false = arith.constant false
    %c-33_i64 = arith.constant -33 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ule" %arg0, %c-13_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.select %false, %2, %c26_i64 : i1, i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.ashr %c-46_i64, %c29_i64 : i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.icmp "slt" %c-33_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c-15_i64 = arith.constant -15 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "slt" %c-15_i64, %c-46_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.and %arg0, %arg1 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sle" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-22_i64 = arith.constant -22 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.select %1, %c-22_i64, %arg0 : i1, i64
    %3 = llvm.srem %2, %c-43_i64 : i64
    %4 = llvm.ashr %c-32_i64, %2 : i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.icmp "sle" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.lshr %c26_i64, %arg0 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %4, %arg2 : i64
    %6 = llvm.sdiv %c-23_i64, %5 : i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c39_i64 = arith.constant 39 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "sle" %c34_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %c-31_i64 : i64
    %3 = llvm.srem %c-40_i64, %c-43_i64 : i64
    %4 = llvm.sdiv %3, %2 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.xor %5, %2 : i64
    %7 = llvm.and %c39_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sdiv %c8_i64, %0 : i64
    %2 = llvm.icmp "uge" %c0_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %arg0, %arg2 : i64
    %5 = llvm.sdiv %arg1, %4 : i64
    %6 = llvm.and %arg0, %5 : i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c43_i64 = arith.constant 43 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.ashr %c-47_i64, %c30_i64 : i64
    %1 = llvm.ashr %c43_i64, %0 : i64
    %2 = llvm.or %arg0, %arg1 : i64
    %3 = llvm.ashr %arg0, %c-29_i64 : i64
    %4 = llvm.xor %3, %2 : i64
    %5 = llvm.ashr %4, %1 : i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.icmp "uge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.sdiv %c-38_i64, %c-49_i64 : i64
    %1 = llvm.urem %0, %c-29_i64 : i64
    %2 = llvm.icmp "uge" %1, %c48_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %3, %arg0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %5, %1 : i64
    %7 = llvm.sdiv %6, %arg1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c41_i64 = arith.constant 41 : i64
    %c26_i64 = arith.constant 26 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %c-7_i64, %0 : i64
    %2 = llvm.select %1, %c-26_i64, %arg2 : i1, i64
    %3 = llvm.icmp "ult" %c41_i64, %c-46_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %c26_i64, %4 : i64
    %6 = llvm.sdiv %5, %arg2 : i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.icmp "ne" %3, %arg1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.xor %c-50_i64, %3 : i64
    %5 = llvm.urem %c-3_i64, %4 : i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.urem %c-10_i64, %0 : i64
    %2 = llvm.lshr %1, %c15_i64 : i64
    %3 = llvm.xor %c-12_i64, %2 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ule" %arg2, %arg2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "ugt" %c14_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.srem %2, %c-46_i64 : i64
    %4 = llvm.select %arg1, %2, %c16_i64 : i1, i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.icmp "ule" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %c40_i64, %0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.urem %6, %arg2 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %arg0, %c-12_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.urem %c-35_i64, %0 : i64
    %3 = llvm.select %arg1, %2, %c50_i64 : i1, i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "ne" %c21_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sge" %c-23_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-12_i64 = arith.constant -12 : i64
    %c2_i64 = arith.constant 2 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.lshr %c42_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %c2_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %2, %arg1 : i64
    %4 = llvm.select %3, %c-12_i64, %arg0 : i1, i64
    %5 = llvm.trunc %true : i1 to i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.icmp "sgt" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %false = arith.constant false
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.select %false, %c33_i64, %arg0 : i1, i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.lshr %1, %c34_i64 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "ult" %c-38_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.icmp "ule" %arg0, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %arg1, %4 : i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.icmp "uge" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %c42_i64 = arith.constant 42 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.select %false, %c42_i64, %c-24_i64 : i1, i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.lshr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c16_i64 = arith.constant 16 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.ashr %c47_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.xor %2, %c16_i64 : i64
    %4 = llvm.select %true, %3, %arg1 : i1, i64
    %5 = llvm.sdiv %4, %4 : i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c20_i64, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.icmp "sgt" %4, %2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %c32_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %c32_i64, %3 : i64
    %5 = llvm.urem %0, %4 : i64
    %6 = llvm.ashr %5, %arg1 : i64
    %7 = llvm.sdiv %6, %3 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-15_i64 = arith.constant -15 : i64
    %true = arith.constant true
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %c44_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %c-15_i64, %arg2 : i64
    %4 = llvm.select %true, %2, %3 : i1, i64
    %5 = llvm.lshr %c49_i64, %arg2 : i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "ugt" %6, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c1_i64 = arith.constant 1 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c42_i64 = arith.constant 42 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %c42_i64, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "ne" %2, %c1_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %arg0, %c-23_i64 : i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "ne" %c-7_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-23_i64 = arith.constant -23 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "slt" %arg0, %c2_i64 : i64
    %1 = llvm.select %0, %c23_i64, %c-23_i64 : i1, i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.select %2, %arg0, %3 : i1, i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.ashr %5, %arg2 : i64
    %7 = llvm.icmp "ne" %c-35_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.ashr %1, %arg2 : i64
    %4 = llvm.ashr %3, %c27_i64 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.or %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.icmp "uge" %1, %1 : i64
    %4 = llvm.ashr %c-34_i64, %2 : i64
    %5 = llvm.select %3, %arg2, %4 : i1, i64
    %6 = llvm.and %2, %5 : i64
    %7 = llvm.srem %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %c26_i64, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.icmp "ne" %3, %1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.icmp "uge" %c-26_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c14_i64 = arith.constant 14 : i64
    %c10_i64 = arith.constant 10 : i64
    %true = arith.constant true
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.select %true, %arg0, %c-40_i64 : i1, i64
    %1 = llvm.and %0, %c-41_i64 : i64
    %2 = llvm.lshr %0, %c-8_i64 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "ule" %c10_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.or %c14_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c-10_i64 = arith.constant -10 : i64
    %false = arith.constant false
    %c34_i64 = arith.constant 34 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.xor %arg1, %c34_i64 : i64
    %2 = llvm.srem %c19_i64, %1 : i64
    %3 = llvm.select %arg0, %0, %2 : i1, i64
    %4 = llvm.select %false, %c-10_i64, %arg2 : i1, i64
    %5 = llvm.icmp "slt" %4, %c-21_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %false = arith.constant false
    %c13_i64 = arith.constant 13 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.and %c13_i64, %c44_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.select %false, %1, %c2_i64 : i1, i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.sdiv %3, %arg1 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ugt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.urem %arg0, %c-48_i64 : i64
    %1 = llvm.srem %arg2, %arg2 : i64
    %2 = llvm.icmp "ugt" %arg1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %c5_i64, %0 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.and %c-13_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.icmp "sle" %c-18_i64, %arg2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c39_i64 = arith.constant 39 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.ashr %c39_i64, %c8_i64 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.urem %c-50_i64, %1 : i64
    %3 = llvm.select %arg1, %0, %arg0 : i1, i64
    %4 = llvm.udiv %3, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.xor %0, %5 : i64
    %7 = llvm.icmp "ule" %c39_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-36_i64 = arith.constant -36 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.lshr %c1_i64, %arg2 : i64
    %4 = llvm.icmp "ult" %3, %c-36_i64 : i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.select %4, %5, %3 : i1, i64
    %7 = llvm.icmp "ugt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.xor %arg2, %c-37_i64 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.urem %3, %c35_i64 : i64
    %6 = llvm.select %4, %0, %5 : i1, i64
    %7 = llvm.icmp "ne" %c-14_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %c-41_i64, %4 : i64
    %6 = llvm.udiv %arg1, %arg2 : i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "ult" %c-28_i64, %c-32_i64 : i64
    %1 = llvm.select %arg1, %arg2, %c-41_i64 : i1, i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.icmp "eq" %c4_i64, %c-10_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %4, %c38_i64 : i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "uge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c9_i64 = arith.constant 9 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.urem %c9_i64, %c-1_i64 : i64
    %4 = llvm.and %c14_i64, %3 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    %7 = llvm.select %6, %c-37_i64, %arg1 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.udiv %arg0, %c44_i64 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.udiv %arg1, %0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.xor %1, %5 : i64
    %7 = llvm.and %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.lshr %c-25_i64, %0 : i64
    %2 = llvm.or %c-19_i64, %1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.xor %arg1, %4 : i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.icmp "ult" %c-37_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c50_i64 = arith.constant 50 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %c3_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.or %c50_i64, %3 : i64
    %5 = llvm.udiv %3, %c4_i64 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.srem %c-3_i64, %c-35_i64 : i64
    %1 = llvm.urem %c-5_i64, %c6_i64 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.ashr %c42_i64, %arg0 : i64
    %6 = llvm.lshr %c-36_i64, %5 : i64
    %7 = llvm.and %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %c-15_i64, %0 : i64
    %2 = llvm.or %0, %arg0 : i64
    %3 = llvm.ashr %c-18_i64, %2 : i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ugt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %c29_i64 : i64
    %2 = llvm.select %1, %arg2, %c-40_i64 : i1, i64
    %3 = llvm.urem %arg2, %2 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.sdiv %arg2, %c45_i64 : i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.srem %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "ule" %arg1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.xor %c18_i64, %3 : i64
    %5 = llvm.icmp "sgt" %4, %arg0 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %0, %c-6_i64 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.select %3, %arg1, %1 : i1, i64
    %5 = llvm.icmp "ne" %arg1, %arg2 : i64
    %6 = llvm.select %5, %c-14_i64, %c-45_i64 : i1, i64
    %7 = llvm.ashr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.sdiv %arg0, %c38_i64 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %0, %c-31_i64 : i64
    %5 = llvm.select %4, %arg1, %arg2 : i1, i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.xor %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %3, %1 : i64
    %5 = llvm.icmp "slt" %c35_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.ashr %6, %4 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %false = arith.constant false
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.or %c19_i64, %0 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.xor %3, %0 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.udiv %2, %5 : i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.ashr %c-5_i64, %c45_i64 : i64
    %1 = llvm.icmp "ugt" %0, %c-13_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %c47_i64, %2 : i64
    %4 = llvm.icmp "ugt" %3, %2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.icmp "ne" %6, %3 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "eq" %0, %c-39_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %arg1, %0 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c48_i64 = arith.constant 48 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.urem %arg0, %c-22_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.udiv %2, %c17_i64 : i64
    %4 = llvm.urem %c48_i64, %c8_i64 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.or %5, %5 : i64
    %7 = llvm.icmp "slt" %6, %4 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c-49_i64 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.or %1, %arg0 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.lshr %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.and %0, %0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %4, %arg1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "eq" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.select %arg0, %c6_i64, %arg1 : i1, i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.select %arg0, %1, %0 : i1, i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %5, %0 : i64
    %7 = llvm.icmp "ult" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c50_i64 = arith.constant 50 : i64
    %false = arith.constant false
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.select %false, %arg0, %c-43_i64 : i1, i64
    %1 = llvm.udiv %c31_i64, %arg1 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.urem %c50_i64, %3 : i64
    %5 = llvm.sdiv %4, %arg2 : i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c-18_i64 = arith.constant -18 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.ashr %0, %c10_i64 : i64
    %2 = llvm.lshr %arg0, %0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.srem %c-18_i64, %3 : i64
    %5 = llvm.icmp "ugt" %arg1, %3 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.and %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.and %arg1, %arg1 : i64
    %2 = llvm.icmp "sgt" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sle" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %false = arith.constant false
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.ashr %arg0, %c0_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.srem %arg2, %c-30_i64 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.ashr %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %c-32_i64, %0 : i64
    %2 = llvm.select %1, %arg1, %arg0 : i1, i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %4, %c46_i64 : i64
    %6 = llvm.udiv %arg2, %5 : i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.ashr %c-9_i64, %c-44_i64 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.icmp "slt" %0, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ule" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "uge" %c-4_i64, %c-19_i64 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.ashr %arg1, %arg1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.icmp "uge" %4, %c48_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.select %0, %c44_i64, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c14_i64 = arith.constant 14 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "ugt" %c14_i64, %c20_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.sdiv %c-11_i64, %2 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.trunc %arg0 : i1 to i64
    %7 = llvm.icmp "sge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.select %arg0, %c-34_i64, %c-40_i64 : i1, i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "ult" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %c36_i64, %c2_i64 : i64
    %5 = llvm.xor %4, %4 : i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %true = arith.constant true
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.lshr %arg0, %c40_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.udiv %arg1, %0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.sdiv %c47_i64, %arg0 : i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %0, %arg1, %arg1 : i1, i64
    %5 = llvm.and %c34_i64, %4 : i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.icmp "ugt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.srem %c-23_i64, %c29_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.srem %c50_i64, %0 : i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.select %arg0, %1, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c23_i64 = arith.constant 23 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "ult" %c44_i64, %arg0 : i64
    %1 = llvm.and %c23_i64, %arg1 : i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.udiv %3, %1 : i64
    %5 = llvm.icmp "ule" %c-49_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg2, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %4, %arg0 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.and %c-9_i64, %arg0 : i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.srem %1, %c-48_i64 : i64
    %3 = llvm.xor %c47_i64, %2 : i64
    %4 = llvm.ashr %3, %arg2 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    %6 = llvm.select %5, %c18_i64, %c-21_i64 : i1, i64
    %7 = llvm.urem %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %true = arith.constant true
    %c-24_i64 = arith.constant -24 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "uge" %c-18_i64, %c-11_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %1, %c-24_i64 : i64
    %3 = llvm.select %true, %1, %c-3_i64 : i1, i64
    %4 = llvm.trunc %0 : i1 to i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.urem %5, %2 : i64
    %7 = llvm.icmp "sge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c27_i64 = arith.constant 27 : i64
    %true = arith.constant true
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %c-11_i64, %arg0 : i64
    %1 = llvm.select %true, %arg0, %c27_i64 : i1, i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.and %c32_i64, %2 : i64
    %4 = llvm.and %c-19_i64, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.sdiv %c-48_i64, %5 : i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %false = arith.constant false
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.select %false, %c19_i64, %arg0 : i1, i64
    %1 = llvm.icmp "sge" %arg1, %0 : i64
    %2 = llvm.and %0, %arg2 : i64
    %3 = llvm.select %1, %2, %arg1 : i1, i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %c-7_i64, %3 : i64
    %7 = llvm.ashr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.and %c48_i64, %arg0 : i64
    %2 = llvm.srem %0, %0 : i64
    %3 = llvm.lshr %arg2, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.ashr %c-15_i64, %c-15_i64 : i64
    %3 = llvm.select %arg2, %arg0, %2 : i1, i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %arg0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "sge" %arg0, %c-20_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sext %2 : i1 to i64
    %5 = llvm.or %4, %4 : i64
    %6 = llvm.and %1, %5 : i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.select %2, %arg1, %arg1 : i1, i64
    %4 = llvm.srem %arg2, %arg1 : i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.sdiv %6, %c29_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c31_i64 = arith.constant 31 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "uge" %c31_i64, %c21_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %arg0, %c-27_i64 : i64
    %3 = llvm.sext %0 : i1 to i64
    %4 = llvm.icmp "ugt" %3, %arg0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.udiv %2, %5 : i64
    %7 = llvm.icmp "sge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.urem %arg0, %c26_i64 : i64
    %1 = llvm.icmp "eq" %c-37_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %c-2_i64, %2 : i64
    %4 = llvm.ashr %3, %2 : i64
    %5 = llvm.udiv %4, %arg1 : i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.icmp "slt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.udiv %c28_i64, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %0, %arg2 : i64
    %5 = llvm.srem %4, %c43_i64 : i64
    %6 = llvm.icmp "eq" %3, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.icmp "ule" %c-29_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %c8_i64, %2 : i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.lshr %4, %arg2 : i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.and %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c-4_i64 = arith.constant -4 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.xor %c-4_i64, %c-41_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.udiv %arg0, %5 : i64
    %7 = llvm.icmp "slt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %c13_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.lshr %6, %c46_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %true = arith.constant true
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.select %true, %arg1, %c11_i64 : i1, i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.urem %c-42_i64, %1 : i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.or %2, %arg2 : i64
    %5 = llvm.icmp "ult" %4, %arg2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "uge" %c9_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %arg1, %c14_i64 : i1, i64
    %3 = llvm.icmp "sgt" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %c24_i64, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.sdiv %3, %arg1 : i64
    %5 = llvm.or %arg2, %arg2 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.xor %arg0, %c-12_i64 : i64
    %3 = llvm.udiv %arg2, %1 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.sdiv %4, %c23_i64 : i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.srem %c-48_i64, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "eq" %5, %arg1 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.srem %arg0, %c-9_i64 : i64
    %1 = llvm.icmp "sgt" %arg1, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.or %arg2, %c-32_i64 : i64
    %5 = llvm.icmp "sge" %4, %c-4_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %c-25_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.srem %arg0, %3 : i64
    %6 = llvm.udiv %5, %4 : i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.urem %1, %c34_i64 : i64
    %3 = llvm.icmp "slt" %2, %c-48_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.ashr %c48_i64, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.ashr %4, %0 : i64
    %6 = llvm.lshr %c-49_i64, %5 : i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c42_i64 = arith.constant 42 : i64
    %c23_i64 = arith.constant 23 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.srem %arg1, %c14_i64 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.xor %arg1, %arg2 : i64
    %3 = llvm.icmp "ule" %c23_i64, %c42_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %1, %2, %4 : i1, i64
    %6 = llvm.udiv %c-6_i64, %c-23_i64 : i64
    %7 = llvm.ashr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c19_i64 = arith.constant 19 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "ne" %arg1, %c-8_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.select %2, %arg2, %arg2 : i1, i64
    %4 = llvm.udiv %arg0, %c19_i64 : i64
    %5 = llvm.icmp "ult" %4, %c-10_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "slt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %false = arith.constant false
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.xor %3, %arg2 : i64
    %5 = llvm.udiv %arg0, %4 : i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.xor %6, %c-17_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "ule" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %arg2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %arg1, %4 : i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.or %c-2_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "ult" %c-50_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg1, %c35_i64 : i64
    %3 = llvm.icmp "slt" %arg2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.lshr %5, %c29_i64 : i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.ashr %arg2, %c-13_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %c-45_i64, %3 : i64
    %5 = llvm.icmp "slt" %arg1, %arg2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.urem %c-17_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.and %arg1, %arg1 : i64
    %3 = llvm.icmp "sle" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sge" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c21_i64 = arith.constant 21 : i64
    %c24_i64 = arith.constant 24 : i64
    %c47_i64 = arith.constant 47 : i64
    %c9_i64 = arith.constant 9 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "ne" %c9_i64, %c12_i64 : i64
    %1 = llvm.xor %c47_i64, %c24_i64 : i64
    %2 = llvm.select %0, %1, %c21_i64 : i1, i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.urem %arg1, %c26_i64 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "ugt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.lshr %arg0, %c24_i64 : i64
    %1 = llvm.and %c-40_i64, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.xor %2, %0 : i64
    %4 = llvm.ashr %arg2, %1 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.urem %2, %5 : i64
    %7 = llvm.xor %c-12_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.lshr %arg0, %c3_i64 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.sdiv %arg0, %c-18_i64 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %4, %arg2 : i64
    %6 = llvm.or %5, %0 : i64
    %7 = llvm.icmp "ugt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %true, %arg1, %0 : i1, i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.or %3, %5 : i64
    %7 = llvm.icmp "sge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "slt" %arg2, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.select %0, %arg2, %1 : i1, i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %c-8_i64, %5 : i64
    %7 = llvm.icmp "sge" %6, %c-32_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %c-47_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %c7_i64, %arg0 : i64
    %5 = llvm.select %0, %3, %4 : i1, i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.icmp "uge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %4, %c1_i64 : i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c-34_i64 = arith.constant -34 : i64
    %true = arith.constant true
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.select %true, %arg0, %c-38_i64 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "sle" %1, %arg2 : i64
    %6 = llvm.select %5, %c-34_i64, %c-46_i64 : i1, i64
    %7 = llvm.urem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c48_i64 = arith.constant 48 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.xor %c-45_i64, %arg0 : i64
    %1 = llvm.srem %0, %c48_i64 : i64
    %2 = llvm.srem %c25_i64, %1 : i64
    %3 = llvm.or %arg1, %c14_i64 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.udiv %arg2, %0 : i64
    %7 = llvm.srem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c3_i64 = arith.constant 3 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "slt" %arg0, %c48_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %c-18_i64 : i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.srem %3, %c3_i64 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.icmp "ugt" %5, %c4_i64 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %c-1_i64, %0 : i64
    %2 = llvm.icmp "ne" %c10_i64, %1 : i64
    %3 = llvm.urem %arg0, %1 : i64
    %4 = llvm.icmp "sle" %3, %0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %c29_i64, %3 : i64
    %7 = llvm.select %2, %5, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c24_i64 = arith.constant 24 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.and %arg0, %c-36_i64 : i64
    %1 = llvm.sdiv %arg1, %c24_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ne" %c20_i64, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %arg2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.ashr %c-32_i64, %arg0 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.lshr %c41_i64, %1 : i64
    %3 = llvm.lshr %c-29_i64, %2 : i64
    %4 = llvm.icmp "ne" %arg1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sdiv %c-43_i64, %5 : i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg2, %arg0 : i64
    %3 = llvm.icmp "slt" %c-29_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ne" %arg1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.lshr %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c1_i64 = arith.constant 1 : i64
    %true = arith.constant true
    %c-9_i64 = arith.constant -9 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.or %arg1, %c16_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %true, %c1_i64, %c29_i64 : i1, i64
    %4 = llvm.select %arg2, %c-9_i64, %3 : i1, i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.sext %1 : i1 to i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.or %c4_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "sge" %arg1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.zext %arg2 : i1 to i64
    %6 = llvm.udiv %5, %c-19_i64 : i64
    %7 = llvm.select %4, %6, %arg0 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.icmp "uge" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %c-13_i64, %4 : i64
    %6 = llvm.icmp "slt" %arg0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %false = arith.constant false
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.or %arg1, %c26_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ugt" %3, %c4_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c12_i64 = arith.constant 12 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.urem %c12_i64, %c-16_i64 : i64
    %1 = llvm.udiv %c34_i64, %arg0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.srem %3, %arg0 : i64
    %5 = llvm.srem %0, %arg1 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.udiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ne" %c-47_i64, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %c-33_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.select %arg0, %0, %c35_i64 : i1, i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.srem %4, %4 : i64
    %6 = llvm.xor %5, %5 : i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c5_i64 = arith.constant 5 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %false, %c-17_i64, %0 : i1, i64
    %2 = llvm.urem %c5_i64, %1 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %2, %5 : i64
    %7 = llvm.icmp "uge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %c-50_i64 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.lshr %1, %2 : i64
    %7 = llvm.icmp "sle" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.srem %c-43_i64, %0 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.xor %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.sdiv %arg2, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %arg0, %5 : i64
    %7 = llvm.and %6, %2 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.xor %c8_i64, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %2, %arg1, %arg0 : i1, i64
    %5 = llvm.and %4, %c-49_i64 : i64
    %6 = llvm.urem %5, %arg2 : i64
    %7 = llvm.xor %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %0, %c-23_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %c-50_i64, %2 : i64
    %4 = llvm.icmp "sgt" %c34_i64, %2 : i64
    %5 = llvm.select %4, %3, %arg1 : i1, i64
    %6 = llvm.or %3, %5 : i64
    %7 = llvm.udiv %c-35_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.and %c-13_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.ashr %arg0, %arg1 : i64
    %3 = llvm.xor %2, %c14_i64 : i64
    %4 = llvm.ashr %3, %c-33_i64 : i64
    %5 = llvm.or %arg1, %4 : i64
    %6 = llvm.xor %1, %5 : i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c46_i64 = arith.constant 46 : i64
    %false = arith.constant false
    %c2_i64 = arith.constant 2 : i64
    %c4_i64 = arith.constant 4 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.urem %c44_i64, %arg1 : i64
    %1 = llvm.srem %0, %c4_i64 : i64
    %2 = llvm.select %arg2, %1, %c2_i64 : i1, i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.select %false, %1, %c46_i64 : i1, i64
    %5 = llvm.udiv %4, %c-20_i64 : i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.urem %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "sle" %c8_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.udiv %c-42_i64, %arg1 : i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %arg2 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %c-11_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.srem %arg0, %5 : i64
    %7 = llvm.icmp "slt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.trunc %true : i1 to i64
    %7 = llvm.sdiv %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    %4 = llvm.icmp "sgt" %c39_i64, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %arg0, %5 : i64
    %7 = llvm.lshr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.select %arg0, %c0_i64, %c-5_i64 : i1, i64
    %1 = llvm.urem %0, %c-30_i64 : i64
    %2 = llvm.icmp "sgt" %arg1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %3, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.or %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %c-22_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.zext %0 : i1 to i64
    %5 = llvm.icmp "ugt" %4, %1 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "uge" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %c-20_i64, %c-6_i64 : i64
    %6 = llvm.srem %5, %c33_i64 : i64
    %7 = llvm.or %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.xor %c-35_i64, %c12_i64 : i64
    %1 = llvm.or %0, %c22_i64 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.and %1, %5 : i64
    %7 = llvm.icmp "ult" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c12_i64 = arith.constant 12 : i64
    %c19_i64 = arith.constant 19 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.ashr %arg2, %c19_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.srem %c3_i64, %arg0 : i64
    %5 = llvm.udiv %4, %arg0 : i64
    %6 = llvm.select %3, %c12_i64, %5 : i1, i64
    %7 = llvm.icmp "sge" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c26_i64 = arith.constant 26 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %c-18_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %c26_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.trunc %true : i1 to i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.ashr %c-46_i64, %c34_i64 : i64
    %3 = llvm.icmp "sle" %c-35_i64, %2 : i64
    %4 = llvm.select %3, %c-8_i64, %arg1 : i1, i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %c9_i64, %c37_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.sdiv %arg1, %c37_i64 : i64
    %5 = llvm.zext %arg2 : i1 to i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.urem %c-21_i64, %arg0 : i64
    %1 = llvm.sdiv %c-16_i64, %0 : i64
    %2 = llvm.urem %arg0, %arg0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ult" %arg1, %arg0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.srem %c33_i64, %0 : i64
    %4 = llvm.icmp "ugt" %3, %c-46_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.icmp "slt" %6, %c-34_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %1, %5 : i64
    %7 = llvm.srem %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-49_i64 = arith.constant -49 : i64
    %true = arith.constant true
    %c22_i64 = arith.constant 22 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.xor %c22_i64, %c35_i64 : i64
    %1 = llvm.lshr %c-49_i64, %c17_i64 : i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %true, %0, %3 : i1, i64
    %5 = llvm.or %arg1, %arg2 : i64
    %6 = llvm.lshr %c-4_i64, %5 : i64
    %7 = llvm.icmp "sle" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c31_i64 = arith.constant 31 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "ne" %c45_i64, %arg0 : i64
    %1 = llvm.select %0, %c31_i64, %c-24_i64 : i1, i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.icmp "ult" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %c-11_i64, %4 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.srem %c-22_i64, %c4_i64 : i64
    %1 = llvm.icmp "slt" %0, %c-46_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.sext %1 : i1 to i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.ashr %6, %2 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c39_i64 = arith.constant 39 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.urem %c-7_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %arg1, %c39_i64 : i64
    %4 = llvm.srem %3, %c-42_i64 : i64
    %5 = llvm.srem %arg0, %c22_i64 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.ashr %arg0, %arg2 : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %c-27_i64, %c-16_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "slt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %c6_i64, %0 : i64
    %2 = llvm.udiv %1, %c43_i64 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "ult" %3, %arg0 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %2, %2 : i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg1, %arg2 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.ashr %3, %5 : i64
    %7 = llvm.select %4, %5, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c19_i64 = arith.constant 19 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg1, %arg0 : i1, i64
    %1 = llvm.select %arg2, %c-28_i64, %0 : i1, i64
    %2 = llvm.or %c19_i64, %1 : i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.srem %arg0, %4 : i64
    %6 = llvm.icmp "ne" %5, %4 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.sdiv %c44_i64, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "uge" %1, %arg1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.or %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "ugt" %arg1, %arg2 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.ashr %2, %c-35_i64 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sext %false : i1 to i64
    %7 = llvm.sdiv %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c6_i64 = arith.constant 6 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "ult" %arg2, %arg0 : i64
    %3 = llvm.icmp "ult" %0, %c-29_i64 : i64
    %4 = llvm.select %3, %c0_i64, %arg0 : i1, i64
    %5 = llvm.ashr %c6_i64, %c-2_i64 : i64
    %6 = llvm.select %2, %4, %5 : i1, i64
    %7 = llvm.icmp "sge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ugt" %c-37_i64, %c-49_i64 : i64
    %1 = llvm.lshr %c18_i64, %arg0 : i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.icmp "sle" %2, %2 : i64
    %4 = llvm.lshr %arg1, %arg1 : i64
    %5 = llvm.lshr %4, %c-47_i64 : i64
    %6 = llvm.srem %arg2, %c44_i64 : i64
    %7 = llvm.select %3, %5, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c6_i64 = arith.constant 6 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg1, %arg0 : i1, i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.sdiv %c9_i64, %0 : i64
    %5 = llvm.icmp "ult" %c6_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.udiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %1, %2, %arg1 : i1, i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.udiv %arg2, %arg1 : i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %false = arith.constant false
    %c-24_i64 = arith.constant -24 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.srem %arg1, %c-28_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.sdiv %arg2, %c-24_i64 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.select %4, %arg0, %c26_i64 : i1, i64
    %6 = llvm.select %4, %2, %5 : i1, i64
    %7 = llvm.urem %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c5_i64 = arith.constant 5 : i64
    %false = arith.constant false
    %c14_i64 = arith.constant 14 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.xor %c-40_i64, %c14_i64 : i64
    %5 = llvm.select %false, %c5_i64, %c0_i64 : i1, i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.sdiv %0, %arg0 : i64
    %5 = llvm.icmp "slt" %4, %c10_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "uge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %true = arith.constant true
    %c31_i64 = arith.constant 31 : i64
    %false = arith.constant false
    %c-7_i64 = arith.constant -7 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.select %false, %c-7_i64, %c-24_i64 : i1, i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ne" %c31_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.urem %4, %c18_i64 : i64
    %6 = llvm.urem %5, %arg1 : i64
    %7 = llvm.icmp "uge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %false = arith.constant false
    %c-1_i64 = arith.constant -1 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %c-1_i64, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.srem %5, %c27_i64 : i64
    %7 = llvm.icmp "ule" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c46_i64 = arith.constant 46 : i64
    %c26_i64 = arith.constant 26 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.udiv %c49_i64, %arg0 : i64
    %1 = llvm.udiv %c26_i64, %0 : i64
    %2 = llvm.udiv %arg2, %c46_i64 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %arg1, %5 : i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c12_i64 = arith.constant 12 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.xor %c20_i64, %arg0 : i64
    %1 = llvm.and %0, %c12_i64 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.icmp "sge" %c46_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.and %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c-14_i64 = arith.constant -14 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ugt" %c-14_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %c-44_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.icmp "sge" %5, %arg1 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.srem %c18_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %arg1 : i1, i64
    %3 = llvm.select %1, %arg0, %2 : i1, i64
    %4 = llvm.select %arg2, %c41_i64, %2 : i1, i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.udiv %0, %5 : i64
    %7 = llvm.sdiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.icmp "sge" %0, %c19_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.srem %5, %4 : i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sdiv %c-14_i64, %arg0 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.ashr %arg0, %arg1 : i64
    %4 = llvm.icmp "eq" %arg2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.xor %5, %c42_i64 : i64
    %7 = llvm.icmp "uge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.xor %c-43_i64, %arg0 : i64
    %2 = llvm.srem %arg2, %1 : i64
    %3 = llvm.or %c-18_i64, %2 : i64
    %4 = llvm.ashr %c43_i64, %1 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.select %0, %6, %arg2 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ne" %c-28_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.urem %c0_i64, %3 : i64
    %5 = llvm.or %arg1, %c-29_i64 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.icmp "sgt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.xor %c14_i64, %0 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "ugt" %4, %c49_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c33_i64 = arith.constant 33 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.ashr %arg0, %c4_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.urem %c33_i64, %c-20_i64 : i64
    %4 = llvm.and %3, %c-34_i64 : i64
    %5 = llvm.udiv %arg2, %4 : i64
    %6 = llvm.and %2, %5 : i64
    %7 = llvm.sdiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "eq" %c-42_i64, %arg0 : i64
    %6 = llvm.select %5, %4, %4 : i1, i64
    %7 = llvm.udiv %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c18_i64 = arith.constant 18 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "sle" %c31_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg1, %arg2 : i64
    %3 = llvm.ashr %c18_i64, %arg0 : i64
    %4 = llvm.urem %3, %c-28_i64 : i64
    %5 = llvm.select %2, %4, %arg0 : i1, i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.select %arg0, %0, %0 : i1, i64
    %3 = llvm.and %c48_i64, %c-47_i64 : i64
    %4 = llvm.and %arg2, %3 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.udiv %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %c-39_i64, %c-2_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.ashr %arg2, %3 : i64
    %5 = llvm.select %0, %2, %4 : i1, i64
    %6 = llvm.or %c-12_i64, %5 : i64
    %7 = llvm.icmp "eq" %6, %5 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.icmp "ugt" %c13_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.or %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %c18_i64, %arg0 : i64
    %3 = llvm.select %arg1, %1, %2 : i1, i64
    %4 = llvm.icmp "ule" %3, %arg0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.xor %5, %5 : i64
    %7 = llvm.sdiv %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c10_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.urem %0, %2 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c33_i64 = arith.constant 33 : i64
    %c41_i64 = arith.constant 41 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %arg1, %c32_i64 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.lshr %2, %c41_i64 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.trunc %true : i1 to i64
    %6 = llvm.urem %c33_i64, %5 : i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c43_i64 = arith.constant 43 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.lshr %arg0, %c-43_i64 : i64
    %1 = llvm.lshr %arg1, %c43_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.or %2, %c-26_i64 : i64
    %4 = llvm.and %3, %arg2 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.lshr %c-9_i64, %c5_i64 : i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.icmp "slt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %arg1, %arg1 : i64
    %2 = llvm.srem %arg2, %c-39_i64 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ule" %6, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.icmp "sge" %arg1, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.sext %true : i1 to i64
    %7 = llvm.icmp "ult" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c-50_i64 = arith.constant -50 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ugt" %c-50_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %2, %c-25_i64 : i64
    %4 = llvm.srem %arg0, %c29_i64 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    %6 = llvm.select %5, %arg1, %4 : i1, i64
    %7 = llvm.icmp "ult" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.srem %c45_i64, %c-33_i64 : i64
    %1 = llvm.ashr %c-8_i64, %0 : i64
    %2 = llvm.sdiv %arg0, %c-48_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.trunc %3 : i1 to i64
    %6 = llvm.udiv %5, %arg0 : i64
    %7 = llvm.icmp "uge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sdiv %c12_i64, %arg0 : i64
    %1 = llvm.and %arg0, %c-3_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "slt" %arg1, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "slt" %c-40_i64, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.and %c8_i64, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "uge" %3, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %c35_i64 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.urem %arg0, %arg1 : i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.udiv %1, %c40_i64 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %arg0, %4 : i64
    %6 = llvm.icmp "ule" %c-25_i64, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "sge" %c50_i64, %c-34_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %c-16_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.trunc %2 : i1 to i64
    %6 = llvm.lshr %c37_i64, %5 : i64
    %7 = llvm.ashr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.xor %c-12_i64, %c41_i64 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %c1_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.xor %5, %0 : i64
    %7 = llvm.and %c-26_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c45_i64 = arith.constant 45 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %c45_i64, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ult" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %c9_i64, %1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "uge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "slt" %arg0, %c-18_i64 : i64
    %3 = llvm.select %2, %c-2_i64, %arg1 : i1, i64
    %4 = llvm.icmp "sge" %c-28_i64, %3 : i64
    %5 = llvm.select %4, %arg2, %arg2 : i1, i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %arg1, %c-46_i64 : i64
    %2 = llvm.xor %arg2, %arg2 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.trunc %arg0 : i1 to i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "sge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c46_i64 = arith.constant 46 : i64
    %true = arith.constant true
    %0 = llvm.icmp "slt" %arg1, %arg2 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.icmp "sge" %c46_i64, %c-46_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.select %arg0, %2, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c20_i64 = arith.constant 20 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "ugt" %c45_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %c-31_i64, %1 : i64
    %3 = llvm.and %c20_i64, %2 : i64
    %4 = llvm.ashr %3, %arg1 : i64
    %5 = llvm.and %4, %arg1 : i64
    %6 = llvm.lshr %1, %5 : i64
    %7 = llvm.icmp "sge" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.or %c12_i64, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "slt" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %arg1, %4 : i64
    %6 = llvm.or %0, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %0, %c10_i64 : i64
    %2 = llvm.icmp "uge" %c32_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %3, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.urem %5, %0 : i64
    %7 = llvm.icmp "sge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c9_i64 = arith.constant 9 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.xor %c-43_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.sdiv %arg1, %c9_i64 : i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.or %arg0, %c-6_i64 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.select %2, %c6_i64, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %arg2, %c20_i64 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "ult" %arg1, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg2, %c40_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.sdiv %arg0, %3 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "ne" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.select %arg2, %0, %arg0 : i1, i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.select %arg1, %c-31_i64, %4 : i1, i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %0, %c49_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %2, %c-20_i64 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.sext %1 : i1 to i64
    %6 = llvm.lshr %5, %c-41_i64 : i64
    %7 = llvm.lshr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-42_i64 = arith.constant -42 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.lshr %c-42_i64, %c41_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.and %1, %0 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.urem %0, %4 : i64
    %6 = llvm.ashr %0, %5 : i64
    %7 = llvm.or %6, %1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.and %c-16_i64, %arg0 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.and %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c-26_i64 = arith.constant -26 : i64
    %false = arith.constant false
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %arg2, %c31_i64 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.xor %c-26_i64, %c12_i64 : i64
    %7 = llvm.urem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %false = arith.constant false
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.select %false, %arg0, %c50_i64 : i1, i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.ashr %2, %c38_i64 : i64
    %5 = llvm.icmp "ne" %arg2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.urem %arg2, %arg2 : i64
    %4 = llvm.and %c0_i64, %3 : i64
    %5 = llvm.icmp "ne" %4, %c0_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c-33_i64 : i64
    %2 = llvm.icmp "ne" %c-45_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.zext %arg1 : i1 to i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-49_i64 = arith.constant -49 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "sgt" %1, %c-17_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %3, %c-41_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %0, %5 : i64
    %7 = llvm.icmp "ule" %c-49_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %true = arith.constant true
    %c-17_i64 = arith.constant -17 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "sle" %c-18_i64, %c3_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %c-17_i64, %1 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ugt" %4, %c-30_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.sdiv %c46_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.sdiv %arg2, %2 : i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.or %0, %1 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sle" %2, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.sdiv %c-38_i64, %c-17_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.srem %c39_i64, %1 : i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.icmp "sle" %3, %1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.ashr %1, %5 : i64
    %7 = llvm.udiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.udiv %0, %arg2 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.urem %5, %2 : i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %arg2, %c21_i64 : i64
    %5 = llvm.udiv %c-4_i64, %arg2 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.and %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c33_i64 = arith.constant 33 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.and %arg0, %c-26_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.xor %c33_i64, %0 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.udiv %arg2, %4 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %4, %2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "slt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %c-11_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %0 : i64
    %4 = llvm.or %3, %0 : i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.icmp "uge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg1, %c24_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.xor %2, %arg1 : i64
    %5 = llvm.or %arg2, %4 : i64
    %6 = llvm.and %5, %arg2 : i64
    %7 = llvm.icmp "slt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.urem %c10_i64, %c-45_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %c21_i64, %arg1 : i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.or %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.udiv %arg2, %c-7_i64 : i64
    %2 = llvm.srem %0, %c43_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.urem %3, %3 : i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %6, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %arg0, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %5, %arg0 : i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.xor %c-49_i64, %c-13_i64 : i64
    %1 = llvm.srem %0, %c-50_i64 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.lshr %4, %2 : i64
    %6 = llvm.or %c21_i64, %5 : i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.udiv %arg0, %c27_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg0, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %2 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.lshr %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %false = arith.constant false
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %c-18_i64, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.select %false, %arg0, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "ult" %c0_i64, %c-37_i64 : i64
    %1 = llvm.select %0, %c17_i64, %arg0 : i1, i64
    %2 = llvm.icmp "ne" %c-5_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %arg1, %1 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.sdiv %5, %c24_i64 : i64
    %7 = llvm.icmp "slt" %6, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %c-35_i64, %arg2 : i64
    %4 = llvm.ashr %c25_i64, %c-20_i64 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ult" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %c-3_i64, %c-21_i64 : i64
    %5 = llvm.udiv %arg2, %4 : i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c40_i64 = arith.constant 40 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "sge" %c21_i64, %arg1 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.udiv %c-40_i64, %arg2 : i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.sdiv %c40_i64, %3 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sge" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c5_i64 = arith.constant 5 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.sdiv %arg0, %c48_i64 : i64
    %1 = llvm.ashr %c5_i64, %0 : i64
    %2 = llvm.icmp "ugt" %c40_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.udiv %1, %5 : i64
    %7 = llvm.icmp "slt" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.ashr %c-40_i64, %arg0 : i64
    %1 = llvm.lshr %c-9_i64, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.urem %arg2, %arg0 : i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "sgt" %c-25_i64, %c0_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.ashr %1, %arg1 : i64
    %5 = llvm.udiv %arg2, %2 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "slt" %c-6_i64, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.trunc %arg0 : i1 to i64
    %6 = llvm.or %c43_i64, %5 : i64
    %7 = llvm.udiv %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.urem %c-22_i64, %c9_i64 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %arg1, %arg0 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c48_i64 = arith.constant 48 : i64
    %false = arith.constant false
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.select %false, %c38_i64, %arg0 : i1, i64
    %1 = llvm.icmp "eq" %c-5_i64, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %c48_i64, %4 : i64
    %6 = llvm.ashr %0, %5 : i64
    %7 = llvm.icmp "sge" %6, %5 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.and %c26_i64, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %3, %arg2 : i64
    %5 = llvm.icmp "sle" %c-5_i64, %3 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c3_i64 = arith.constant 3 : i64
    %c43_i64 = arith.constant 43 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.lshr %c43_i64, %c12_i64 : i64
    %1 = llvm.icmp "ule" %0, %c3_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.icmp "ule" %arg0, %c-49_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %3, %5 : i64
    %7 = llvm.and %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %c21_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %arg1, %c-44_i64 : i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %arg1, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c17_i64 = arith.constant 17 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "eq" %c17_i64, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.lshr %c-23_i64, %c-1_i64 : i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.icmp "sge" %c4_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.srem %0, %arg2 : i64
    %2 = llvm.and %c-33_i64, %c-38_i64 : i64
    %3 = llvm.sdiv %2, %c34_i64 : i64
    %4 = llvm.icmp "ule" %3, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.xor %5, %c-19_i64 : i64
    %7 = llvm.xor %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.or %c-49_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.icmp "sgt" %c-3_i64, %c-47_i64 : i64
    %4 = llvm.select %3, %c9_i64, %arg1 : i1, i64
    %5 = llvm.select %3, %4, %c33_i64 : i1, i64
    %6 = llvm.and %2, %5 : i64
    %7 = llvm.srem %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.ashr %arg0, %c-46_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.urem %4, %0 : i64
    %6 = llvm.urem %5, %c-50_i64 : i64
    %7 = llvm.and %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.srem %arg0, %c-20_i64 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.icmp "uge" %3, %1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sdiv %0, %5 : i64
    %7 = llvm.icmp "ult" %6, %5 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.and %1, %c14_i64 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ugt" %c-25_i64, %c44_i64 : i64
    %6 = llvm.select %5, %2, %0 : i1, i64
    %7 = llvm.or %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "slt" %3, %c-14_i64 : i64
    %5 = llvm.srem %c-30_i64, %c-11_i64 : i64
    %6 = llvm.select %4, %arg2, %5 : i1, i64
    %7 = llvm.icmp "slt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.lshr %arg0, %c38_i64 : i64
    %1 = llvm.icmp "slt" %c4_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.udiv %arg1, %arg2 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.udiv %2, %5 : i64
    %7 = llvm.xor %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.udiv %arg1, %c35_i64 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.select %arg2, %3, %c-36_i64 : i1, i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "slt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c18_i64 = arith.constant 18 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.lshr %c22_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.icmp "ult" %arg2, %c18_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %4, %c13_i64 : i64
    %6 = llvm.and %2, %5 : i64
    %7 = llvm.icmp "slt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c-10_i64 = arith.constant -10 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %c-6_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %4, %arg0 : i64
    %6 = llvm.and %c-10_i64, %5 : i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c50_i64 = arith.constant 50 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %c5_i64, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.urem %arg2, %c50_i64 : i64
    %4 = llvm.ashr %0, %2 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.urem %5, %c32_i64 : i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.sext %arg2 : i1 to i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.trunc %arg2 : i1 to i64
    %5 = llvm.srem %4, %0 : i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.icmp "slt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c0_i64 = arith.constant 0 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sdiv %arg1, %c31_i64 : i64
    %1 = llvm.icmp "ult" %arg1, %c0_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c26_i64, %arg2 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %0, %5 : i64
    %7 = llvm.ashr %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c5_i64 = arith.constant 5 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.udiv %c5_i64, %c33_i64 : i64
    %1 = llvm.ashr %c-33_i64, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %6, %1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "ne" %arg1, %arg2 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "slt" %c-31_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %4, %c-49_i64 : i64
    %6 = llvm.srem %c-21_i64, %2 : i64
    %7 = llvm.xor %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.udiv %c27_i64, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.or %arg0, %4 : i64
    %6 = llvm.trunc %arg1 : i1 to i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c38_i64 = arith.constant 38 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.and %arg1, %c-24_i64 : i64
    %1 = llvm.icmp "eq" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %4, %2 : i64
    %6 = llvm.and %c38_i64, %c4_i64 : i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.sext %1 : i1 to i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    %6 = llvm.select %5, %arg2, %c34_i64 : i1, i64
    %7 = llvm.icmp "ult" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.udiv %arg1, %2 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.urem %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "ult" %arg1, %c-39_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %arg0, %c-1_i64, %1 : i1, i64
    %3 = llvm.or %arg2, %arg1 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.udiv %c-38_i64, %c33_i64 : i64
    %7 = llvm.xor %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c37_i64 = arith.constant 37 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c14_i64 = arith.constant 14 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.xor %arg0, %c-36_i64 : i64
    %1 = llvm.icmp "sgt" %0, %c5_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %c-1_i64, %c37_i64 : i64
    %4 = llvm.and %c14_i64, %3 : i64
    %5 = llvm.icmp "ugt" %4, %c3_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.and %c40_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.urem %arg0, %4 : i64
    %6 = llvm.and %1, %5 : i64
    %7 = llvm.udiv %c30_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %0, %c39_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %0, %0 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.or %arg0, %arg1 : i64
    %7 = llvm.srem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.lshr %c19_i64, %3 : i64
    %5 = llvm.udiv %3, %c-46_i64 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.icmp "sle" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "ult" %c47_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %arg2, %arg0 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.ashr %1, %arg1 : i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %c-11_i64, %c-30_i64 : i64
    %2 = llvm.icmp "sle" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %3, %c22_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.udiv %0, %5 : i64
    %7 = llvm.icmp "ule" %c-25_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c18_i64 = arith.constant 18 : i64
    %true = arith.constant true
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.urem %c-22_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.select %true, %arg2, %c18_i64 : i1, i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.sdiv %4, %c14_i64 : i64
    %6 = llvm.urem %5, %arg0 : i64
    %7 = llvm.xor %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %2, %2 : i64
    %7 = llvm.icmp "sge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.xor %arg0, %c-47_i64 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.select %arg2, %0, %1 : i1, i64
    %4 = llvm.icmp "sle" %1, %arg0 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.udiv %4, %c3_i64 : i64
    %6 = llvm.sdiv %3, %5 : i64
    %7 = llvm.urem %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %false = arith.constant false
    %c-41_i64 = arith.constant -41 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.select %false, %c-41_i64, %c5_i64 : i1, i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    %3 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %4 = llvm.select %2, %3, %arg1 : i1, i64
    %5 = llvm.sdiv %0, %4 : i64
    %6 = llvm.xor %5, %1 : i64
    %7 = llvm.icmp "ugt" %c-10_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "uge" %c-47_i64, %c22_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %c-7_i64, %c21_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.zext %0 : i1 to i64
    %5 = llvm.lshr %c-31_i64, %4 : i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.lshr %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c24_i64 = arith.constant 24 : i64
    %c3_i64 = arith.constant 3 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "slt" %c3_i64, %c36_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %c-26_i64, %c45_i64 : i1, i64
    %3 = llvm.icmp "eq" %c24_i64, %2 : i64
    %4 = llvm.and %2, %1 : i64
    %5 = llvm.xor %c-2_i64, %arg0 : i64
    %6 = llvm.select %3, %4, %5 : i1, i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %c9_i64, %0 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "eq" %arg2, %c-33_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.ashr %5, %c-1_i64 : i64
    %7 = llvm.udiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.sdiv %c31_i64, %c-22_i64 : i64
    %3 = llvm.xor %2, %c-7_i64 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "eq" %6, %arg0 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg1, %arg1 : i64
    %3 = llvm.icmp "ugt" %2, %c-48_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %4, %arg0 : i64
    %6 = llvm.lshr %1, %5 : i64
    %7 = llvm.urem %6, %c-21_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c-41_i64 = arith.constant -41 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.or %0, %c-41_i64 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.select %arg1, %3, %c0_i64 : i1, i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.sdiv %5, %3 : i64
    %7 = llvm.and %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %c41_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.sdiv %c45_i64, %c42_i64 : i64
    %4 = llvm.ashr %c-7_i64, %3 : i64
    %5 = llvm.select %arg2, %0, %4 : i1, i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.icmp "uge" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c0_i64 = arith.constant 0 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.xor %c0_i64, %c31_i64 : i64
    %1 = llvm.icmp "ult" %arg1, %c48_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.icmp "eq" %arg1, %2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.xor %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %false = arith.constant false
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "ult" %1, %c28_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %c-48_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %arg1, %3 : i64
    %5 = llvm.xor %c46_i64, %arg1 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.ashr %c42_i64, %1 : i64
    %3 = llvm.lshr %1, %arg0 : i64
    %4 = llvm.ashr %3, %arg1 : i64
    %5 = llvm.and %4, %1 : i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.srem %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c5_i64 = arith.constant 5 : i64
    %false = arith.constant false
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.select %false, %c-12_i64, %arg0 : i1, i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.or %2, %c5_i64 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "ne" %arg1, %c-44_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.icmp "ule" %5, %4 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c-32_i64 = arith.constant -32 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.select %1, %c-32_i64, %arg1 : i1, i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "ugt" %c-12_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.trunc %true : i1 to i64
    %7 = llvm.udiv %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-4_i64 = arith.constant -4 : i64
    %c43_i64 = arith.constant 43 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.urem %arg0, %c-49_i64 : i64
    %1 = llvm.lshr %c43_i64, %arg1 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.icmp "ult" %c-4_i64, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %2, %arg2, %4 : i1, i64
    %6 = llvm.trunc %false : i1 to i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.srem %c25_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ult" %5, %arg1 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.ashr %arg1, %c27_i64 : i64
    %4 = llvm.lshr %3, %c42_i64 : i64
    %5 = llvm.icmp "slt" %4, %3 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %0, %c-27_i64 : i64
    %2 = llvm.lshr %c23_i64, %1 : i64
    %3 = llvm.srem %c-26_i64, %2 : i64
    %4 = llvm.and %3, %c42_i64 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    %6 = llvm.select %5, %c-26_i64, %3 : i1, i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c49_i64 = arith.constant 49 : i64
    %false = arith.constant false
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %arg0, %c32_i64 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.select %false, %2, %c49_i64 : i1, i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.urem %arg2, %c-2_i64 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %1, %c47_i64 : i64
    %3 = llvm.udiv %arg0, %1 : i64
    %4 = llvm.or %3, %2 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-36_i64 = arith.constant -36 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.icmp "sle" %c-36_i64, %c40_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.or %0, %c-39_i64 : i64
    %7 = llvm.icmp "sle" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-17_i64 = arith.constant -17 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.or %arg0, %arg2 : i64
    %2 = llvm.icmp "sgt" %1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %2, %3, %c-17_i64 : i1, i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.sdiv %arg2, %c-40_i64 : i64
    %7 = llvm.urem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "ne" %arg0, %c3_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %c40_i64, %1 : i64
    %3 = llvm.select %2, %1, %arg1 : i1, i64
    %4 = llvm.icmp "ne" %3, %arg1 : i64
    %5 = llvm.select %4, %arg2, %1 : i1, i64
    %6 = llvm.icmp "ne" %3, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "eq" %c-29_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.srem %arg1, %c-50_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "sle" %c-15_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.xor %c-39_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c-34_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %c35_i64, %arg1 : i64
    %4 = llvm.lshr %3, %3 : i64
    %5 = llvm.udiv %0, %c26_i64 : i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.icmp "uge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %true = arith.constant true
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "ne" %c11_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %4, %c28_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sle" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.and %1, %arg1 : i64
    %4 = llvm.or %arg2, %c-23_i64 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c16_i64 = arith.constant 16 : i64
    %c43_i64 = arith.constant 43 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %c0_i64 : i64
    %2 = llvm.select %arg2, %arg0, %arg0 : i1, i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.ashr %3, %c43_i64 : i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.xor %c16_i64, %c-7_i64 : i64
    %7 = llvm.icmp "slt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.icmp "ule" %c-28_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %false, %4, %arg2 : i1, i64
    %6 = llvm.udiv %1, %0 : i64
    %7 = llvm.sdiv %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.srem %c-7_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c26_i64, %arg0 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.srem %c14_i64, %4 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %arg2, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.xor %arg1, %5 : i64
    %7 = llvm.xor %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "slt" %c-8_i64, %c-45_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %c-8_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.srem %5, %c-17_i64 : i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c31_i64 = arith.constant 31 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.lshr %c4_i64, %arg0 : i64
    %1 = llvm.ashr %0, %c31_i64 : i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.lshr %c-6_i64, %arg1 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.ashr %4, %1 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %c-1_i64 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.or %arg1, %c-4_i64 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.trunc %arg0 : i1 to i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.srem %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.select %1, %c-33_i64, %arg0 : i1, i64
    %3 = llvm.urem %arg1, %c-33_i64 : i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.xor %4, %3 : i64
    %6 = llvm.sdiv %5, %2 : i64
    %7 = llvm.or %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %true = arith.constant true
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %c45_i64, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %3, %c5_i64 : i64
    %5 = llvm.trunc %2 : i1 to i64
    %6 = llvm.icmp "ult" %4, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %true = arith.constant true
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.select %true, %c49_i64, %arg0 : i1, i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.select %arg1, %arg2, %1 : i1, i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "sge" %c-4_i64, %2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.icmp "ugt" %c44_i64, %0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.sdiv %3, %5 : i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "sgt" %0, %c-48_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %c38_i64, %2 : i64
    %4 = llvm.srem %3, %c10_i64 : i64
    %5 = llvm.urem %4, %c-31_i64 : i64
    %6 = llvm.or %2, %5 : i64
    %7 = llvm.urem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c48_i64 = arith.constant 48 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.urem %c48_i64, %arg1 : i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.xor %arg2, %0 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.ashr %5, %c11_i64 : i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.srem %arg2, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.and %c0_i64, %3 : i64
    %5 = llvm.icmp "sle" %c22_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sgt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.and %arg0, %c-2_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %0, %c35_i64 : i64
    %6 = llvm.lshr %0, %5 : i64
    %7 = llvm.urem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.udiv %c7_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.and %arg2, %c-33_i64 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.icmp "ne" %3, %2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c0_i64, %arg1 : i1, i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.xor %arg0, %1 : i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.urem %arg1, %5 : i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "ugt" %c-24_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.icmp "ule" %c-23_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %arg1, %arg0 : i64
    %5 = llvm.icmp "ne" %4, %arg2 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.lshr %arg2, %c19_i64 : i64
    %4 = llvm.icmp "eq" %arg2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.srem %3, %arg2 : i64
    %5 = llvm.udiv %c2_i64, %3 : i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.and %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.srem %c-12_i64, %c-7_i64 : i64
    %1 = llvm.select %arg0, %arg1, %c24_i64 : i1, i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %1, %1 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.icmp "ugt" %5, %3 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c29_i64 = arith.constant 29 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.xor %c-37_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.select %arg2, %c29_i64, %c-12_i64 : i1, i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.srem %c6_i64, %4 : i64
    %6 = llvm.sdiv %c-49_i64, %5 : i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c20_i64 : i64
    %2 = llvm.lshr %arg0, %0 : i64
    %3 = llvm.icmp "sle" %0, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "slt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c37_i64 = arith.constant 37 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %c4_i64, %0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.icmp "eq" %c37_i64, %c-34_i64 : i64
    %5 = llvm.select %4, %arg2, %c49_i64 : i1, i64
    %6 = llvm.or %3, %5 : i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c37_i64 = arith.constant 37 : i64
    %c19_i64 = arith.constant 19 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.lshr %c-46_i64, %c-39_i64 : i64
    %1 = llvm.urem %0, %c19_i64 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.srem %2, %c37_i64 : i64
    %4 = llvm.and %0, %arg1 : i64
    %5 = llvm.srem %c44_i64, %4 : i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-11_i64 = arith.constant -11 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.udiv %c-11_i64, %c34_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.xor %1, %5 : i64
    %7 = llvm.icmp "ne" %6, %3 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.and %arg1, %arg2 : i64
    %5 = llvm.srem %4, %c-30_i64 : i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.urem %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %arg2, %c21_i64 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.select %false, %4, %3 : i1, i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.urem %c-42_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.lshr %c-19_i64, %c-44_i64 : i64
    %4 = llvm.xor %3, %c-16_i64 : i64
    %5 = llvm.icmp "sge" %arg1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c36_i64 = arith.constant 36 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ne" %c32_i64, %1 : i64
    %3 = llvm.and %1, %arg2 : i64
    %4 = llvm.sdiv %c36_i64, %c-27_i64 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.select %2, %3, %5 : i1, i64
    %7 = llvm.icmp "sge" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c40_i64 = arith.constant 40 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.srem %c-14_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c25_i64 : i64
    %2 = llvm.srem %1, %c40_i64 : i64
    %3 = llvm.and %c-32_i64, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %c-45_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.icmp "slt" %arg2, %c-41_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.or %arg0, %5 : i64
    %7 = llvm.icmp "ult" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %arg0, %arg2 : i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.udiv %c26_i64, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.xor %c25_i64, %4 : i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %c-15_i64, %0 : i64
    %2 = llvm.urem %1, %c-23_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sext %arg1 : i1 to i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "uge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.sext %arg2 : i1 to i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.icmp "uge" %c37_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "uge" %arg0, %c47_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.lshr %arg1, %arg1 : i64
    %4 = llvm.lshr %3, %c-32_i64 : i64
    %5 = llvm.xor %arg2, %4 : i64
    %6 = llvm.select %0, %2, %5 : i1, i64
    %7 = llvm.udiv %6, %c-25_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c39_i64 = arith.constant 39 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.lshr %c-8_i64, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.ashr %arg0, %arg2 : i64
    %4 = llvm.srem %3, %arg2 : i64
    %5 = llvm.srem %4, %c-18_i64 : i64
    %6 = llvm.srem %c39_i64, %5 : i64
    %7 = llvm.icmp "ugt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.udiv %c14_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.ashr %c-31_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.srem %c-32_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %c24_i64, %1 : i64
    %3 = llvm.icmp "ule" %0, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %4, %arg1 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c11_i64 = arith.constant 11 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.sdiv %arg0, %c30_i64 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.xor %arg2, %arg1 : i64
    %4 = llvm.icmp "sgt" %c11_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %5, %c-48_i64 : i64
    %7 = llvm.icmp "ugt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c20_i64 = arith.constant 20 : i64
    %false = arith.constant false
    %c-11_i64 = arith.constant -11 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.ashr %c-11_i64, %c-26_i64 : i64
    %1 = llvm.icmp "sle" %0, %c-11_i64 : i64
    %2 = llvm.icmp "uge" %0, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %c20_i64, %c39_i64 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.select %false, %5, %3 : i1, i64
    %7 = llvm.select %1, %6, %arg0 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c43_i64 = arith.constant 43 : i64
    %c11_i64 = arith.constant 11 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "slt" %c0_i64, %c-46_i64 : i64
    %1 = llvm.urem %c11_i64, %arg0 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.icmp "uge" %c43_i64, %c45_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.and %5, %arg2 : i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.or %arg0, %c13_i64 : i64
    %1 = llvm.urem %arg1, %arg0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %c9_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.select %arg0, %0, %c-7_i64 : i1, i64
    %2 = llvm.xor %c36_i64, %c-19_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.lshr %c25_i64, %c-19_i64 : i64
    %6 = llvm.select %4, %5, %2 : i1, i64
    %7 = llvm.icmp "uge" %6, %c25_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c47_i64 = arith.constant 47 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.sdiv %c3_i64, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.urem %1, %c47_i64 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.srem %c29_i64, %4 : i64
    %6 = llvm.ashr %2, %5 : i64
    %7 = llvm.ashr %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c50_i64 = arith.constant 50 : i64
    %c7_i64 = arith.constant 7 : i64
    %c43_i64 = arith.constant 43 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.sdiv %c43_i64, %c-40_i64 : i64
    %1 = llvm.icmp "ne" %arg2, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.and %c7_i64, %c50_i64 : i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.icmp "sge" %6, %c4_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "sge" %c-50_i64, %c-45_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %arg0 : i1 to i64
    %3 = llvm.icmp "eq" %c-28_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.sdiv %arg2, %arg2 : i64
    %6 = llvm.urem %arg1, %5 : i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.srem %c34_i64, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.srem %arg2, %c-39_i64 : i64
    %5 = llvm.or %1, %0 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.srem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.srem %c24_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.urem %4, %4 : i64
    %6 = llvm.and %5, %5 : i64
    %7 = llvm.icmp "sle" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "eq" %c-1_i64, %c-14_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %c-5_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %0, %2, %arg1 : i1, i64
    %4 = llvm.and %arg2, %c-19_i64 : i64
    %5 = llvm.sext %1 : i1 to i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.urem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %c17_i64, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.udiv %1, %c-27_i64 : i64
    %4 = llvm.lshr %arg0, %c-42_i64 : i64
    %5 = llvm.or %4, %2 : i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c-37_i64 = arith.constant -37 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.xor %c-26_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.lshr %c-45_i64, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.icmp "sle" %c-37_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %2, %5 : i64
    %7 = llvm.xor %6, %arg2 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %false = arith.constant false
    %c45_i64 = arith.constant 45 : i64
    %c4_i64 = arith.constant 4 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.srem %c4_i64, %1 : i64
    %3 = llvm.select %arg2, %c45_i64, %arg1 : i1, i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.select %false, %c2_i64, %1 : i1, i64
    %7 = llvm.or %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.or %1, %c48_i64 : i64
    %3 = llvm.and %c-7_i64, %1 : i64
    %4 = llvm.ashr %0, %c2_i64 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.sdiv %5, %c34_i64 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %arg0, %arg2 : i64
    %3 = llvm.ashr %2, %c-8_i64 : i64
    %4 = llvm.select %arg1, %2, %arg0 : i1, i64
    %5 = llvm.srem %4, %arg2 : i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.icmp "slt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "sle" %arg1, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %c-22_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %1, %5 : i64
    %7 = llvm.icmp "uge" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c34_i64 = arith.constant 34 : i64
    %c46_i64 = arith.constant 46 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.xor %c11_i64, %c-36_i64 : i64
    %1 = llvm.urem %c46_i64, %arg1 : i64
    %2 = llvm.ashr %c34_i64, %1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.srem %0, %5 : i64
    %7 = llvm.icmp "sle" %6, %c28_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "sle" %c-13_i64, %c35_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.trunc %arg0 : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.lshr %4, %4 : i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.icmp "ugt" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.lshr %c-44_i64, %c41_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %c-2_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c-2_i64 = arith.constant -2 : i64
    %true = arith.constant true
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.select %true, %c-5_i64, %0 : i1, i64
    %2 = llvm.icmp "ne" %1, %arg2 : i64
    %3 = llvm.select %2, %arg2, %c-2_i64 : i1, i64
    %4 = llvm.or %arg0, %c-49_i64 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.and %6, %arg2 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %c9_i64, %0 : i64
    %2 = llvm.or %c-32_i64, %arg0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.and %3, %3 : i64
    %5 = llvm.icmp "slt" %4, %2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "slt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ne" %c-18_i64, %c8_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %c-12_i64, %2 : i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.udiv %arg2, %arg1 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "sle" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.and %c-5_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.urem %arg0, %0 : i64
    %6 = llvm.sdiv %5, %0 : i64
    %7 = llvm.and %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c22_i64 = arith.constant 22 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c-12_i64, %c22_i64 : i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.icmp "sle" %4, %c44_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c39_i64 = arith.constant 39 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "sle" %arg1, %arg0 : i64
    %1 = llvm.and %c-7_i64, %c39_i64 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.trunc %arg2 : i1 to i64
    %5 = llvm.icmp "ult" %c7_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "uge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-31_i64 = arith.constant -31 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.or %3, %c-48_i64 : i64
    %5 = llvm.ashr %c-31_i64, %4 : i64
    %6 = llvm.urem %2, %5 : i64
    %7 = llvm.icmp "ult" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.urem %arg0, %c-46_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.urem %arg2, %c-26_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.srem %2, %4 : i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %true = arith.constant true
    %c12_i64 = arith.constant 12 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.select %true, %c12_i64, %c-22_i64 : i1, i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %arg1, %arg2 : i64
    %4 = llvm.sdiv %3, %c40_i64 : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.icmp "slt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c13_i64 = arith.constant 13 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.urem %c13_i64, %c18_i64 : i64
    %1 = llvm.and %c-35_i64, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %arg0, %arg1 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.urem %0, %5 : i64
    %7 = llvm.and %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.select %false, %arg1, %0 : i1, i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.srem %0, %c37_i64 : i64
    %6 = llvm.select %4, %arg1, %5 : i1, i64
    %7 = llvm.icmp "sgt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.urem %arg0, %c-5_i64 : i64
    %1 = llvm.srem %arg1, %arg1 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.or %arg1, %1 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.and %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.udiv %arg0, %arg2 : i64
    %3 = llvm.icmp "ule" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %c-6_i64, %c46_i64 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-3_i64 = arith.constant -3 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.urem %arg1, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.srem %c-27_i64, %c18_i64 : i64
    %4 = llvm.or %arg2, %3 : i64
    %5 = llvm.udiv %c-12_i64, %4 : i64
    %6 = llvm.sdiv %c-3_i64, %5 : i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %true = arith.constant true
    %c42_i64 = arith.constant 42 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.urem %c42_i64, %c-6_i64 : i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.select %true, %c-32_i64, %0 : i1, i64
    %5 = llvm.ashr %arg0, %4 : i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.icmp "slt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.select %2, %0, %3 : i1, i64
    %5 = llvm.srem %0, %c4_i64 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "eq" %c37_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %c-5_i64, %arg0 : i64
    %3 = llvm.select %2, %c9_i64, %1 : i1, i64
    %4 = llvm.lshr %3, %c-19_i64 : i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.ashr %c-47_i64, %c8_i64 : i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.urem %arg0, %arg1 : i64
    %3 = llvm.or %2, %c-20_i64 : i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.select %1, %3, %4 : i1, i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.or %c-14_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %4 = llvm.select %1, %3, %0 : i1, i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "uge" %6, %c-27_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.lshr %c0_i64, %arg0 : i64
    %1 = llvm.sdiv %c-18_i64, %arg1 : i64
    %2 = llvm.sdiv %c15_i64, %1 : i64
    %3 = llvm.sdiv %arg0, %arg2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.xor %c-21_i64, %4 : i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.xor %arg0, %c-9_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %4, %c-30_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.xor %arg0, %c-46_i64 : i64
    %1 = llvm.and %arg1, %c6_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.icmp "sge" %1, %0 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %5, %2 : i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c42_i64 = arith.constant 42 : i64
    %c19_i64 = arith.constant 19 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.ashr %c19_i64, %c1_i64 : i64
    %1 = llvm.icmp "eq" %c42_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %2, %c-34_i64 : i64
    %6 = llvm.xor %5, %4 : i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.and %c6_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %c25_i64 : i64
    %2 = llvm.icmp "ne" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %c-48_i64, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.xor %6, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.lshr %c-15_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %c49_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %arg0, %c-17_i64 : i64
    %4 = llvm.and %arg1, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.icmp "sle" %5, %c-2_i64 : i64
    %7 = llvm.select %6, %arg0, %c6_i64 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.icmp "sle" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %c1_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %c43_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c22_i64 = arith.constant 22 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.srem %arg1, %c22_i64 : i64
    %3 = llvm.urem %arg2, %c-21_i64 : i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    %5 = llvm.srem %4, %c19_i64 : i64
    %6 = llvm.urem %c-8_i64, %5 : i64
    %7 = llvm.icmp "ule" %6, %3 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %false = arith.constant false
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.select %false, %arg0, %c-48_i64 : i1, i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.icmp "ugt" %c27_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.urem %5, %5 : i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.and %arg1, %arg2 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.or %0, %5 : i64
    %7 = llvm.icmp "uge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %c48_i64, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.ashr %c35_i64, %2 : i64
    %4 = llvm.icmp "sgt" %arg2, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.xor %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.lshr %c-33_i64, %c-14_i64 : i64
    %1 = llvm.ashr %0, %c-2_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.sdiv %c-7_i64, %c37_i64 : i64
    %1 = llvm.icmp "sge" %c11_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.and %arg2, %c-21_i64 : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.sdiv %c-28_i64, %c30_i64 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sgt" %0, %arg0 : i64
    %5 = llvm.urem %arg1, %arg0 : i64
    %6 = llvm.select %4, %5, %arg2 : i1, i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c-50_i64 = arith.constant -50 : i64
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "sgt" %2, %c-50_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %4, %c-3_i64 : i64
    %6 = llvm.and %1, %5 : i64
    %7 = llvm.udiv %6, %0 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "uge" %c16_i64, %arg0 : i64
    %1 = llvm.ashr %c-30_i64, %arg2 : i64
    %2 = llvm.icmp "slt" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %c-25_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.sdiv %5, %arg1 : i64
    %7 = llvm.select %0, %3, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c27_i64 = arith.constant 27 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %c-11_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %c27_i64 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.select %false, %2, %arg2 : i1, i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %c40_i64, %c-34_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %c-17_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.lshr %c-17_i64, %c-18_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.udiv %0, %arg0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "eq" %c-9_i64, %c10_i64 : i64
    %5 = llvm.select %arg1, %arg2, %c16_i64 : i1, i64
    %6 = llvm.select %4, %5, %2 : i1, i64
    %7 = llvm.srem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %arg0, %0 : i64
    %4 = llvm.icmp "uge" %c32_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %5, %arg1 : i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %0, %c15_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %arg2, %arg0 : i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.urem %arg1, %4 : i64
    %6 = llvm.or %5, %c-22_i64 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c8_i64 = arith.constant 8 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c1_i64 = arith.constant 1 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sdiv %c1_i64, %c28_i64 : i64
    %1 = llvm.icmp "slt" %c-18_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg0, %c45_i64 : i64
    %4 = llvm.udiv %arg2, %c8_i64 : i64
    %5 = llvm.select %arg1, %4, %c-38_i64 : i1, i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.select %1, %2, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.ashr %arg0, %c39_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    %6 = llvm.select %5, %2, %arg1 : i1, i64
    %7 = llvm.icmp "sle" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.zext %3 : i1 to i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.icmp "ule" %c8_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %false = arith.constant false
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.select %false, %2, %c-1_i64 : i1, i64
    %4 = llvm.select %arg2, %1, %3 : i1, i64
    %5 = llvm.icmp "ne" %4, %arg1 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.or %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c38_i64 = arith.constant 38 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.lshr %arg0, %c26_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.xor %arg2, %c38_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "ne" %c-16_i64, %3 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "slt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "sgt" %arg1, %arg2 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %arg0, %1, %arg2 : i1, i64
    %3 = llvm.icmp "sge" %1, %c-6_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    %6 = llvm.lshr %c-38_i64, %arg1 : i64
    %7 = llvm.select %5, %c9_i64, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.and %0, %c-19_i64 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.ashr %c-3_i64, %arg2 : i64
    %4 = llvm.icmp "uge" %3, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %5, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "uge" %arg1, %arg0 : i64
    %1 = llvm.select %0, %arg2, %c-28_i64 : i1, i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %c-47_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.lshr %5, %c-20_i64 : i64
    %7 = llvm.srem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %false = arith.constant false
    %c-31_i64 = arith.constant -31 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.ashr %c-31_i64, %c22_i64 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.urem %arg1, %c-24_i64 : i64
    %5 = llvm.or %4, %arg2 : i64
    %6 = llvm.sdiv %3, %5 : i64
    %7 = llvm.sdiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %c-31_i64 : i64
    %2 = llvm.xor %c6_i64, %1 : i64
    %3 = llvm.sdiv %arg2, %arg0 : i64
    %4 = llvm.icmp "ne" %3, %c44_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %2, %5 : i64
    %7 = llvm.icmp "ugt" %6, %0 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c45_i64 = arith.constant 45 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %arg0, %c45_i64 : i64
    %2 = llvm.select %false, %1, %0 : i1, i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.and %4, %c-13_i64 : i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %1, %arg1 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.srem %c1_i64, %3 : i64
    %6 = llvm.ashr %5, %0 : i64
    %7 = llvm.udiv %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c29_i64 = arith.constant 29 : i64
    %c23_i64 = arith.constant 23 : i64
    %c3_i64 = arith.constant 3 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.and %c-22_i64, %c41_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.lshr %2, %c23_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.xor %c29_i64, %c-41_i64 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.xor %c3_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %3 = llvm.select %arg1, %1, %2 : i1, i64
    %4 = llvm.xor %c-46_i64, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ne" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "slt" %c48_i64, %arg2 : i64
    %3 = llvm.sdiv %c-34_i64, %0 : i64
    %4 = llvm.select %2, %3, %c7_i64 : i1, i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.urem %1, %arg2 : i64
    %4 = llvm.select %false, %0, %3 : i1, i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.or %5, %c27_i64 : i64
    %7 = llvm.udiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c28_i64 = arith.constant 28 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.lshr %arg0, %c10_i64 : i64
    %1 = llvm.sdiv %c28_i64, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %c-48_i64, %3 : i64
    %7 = llvm.lshr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %arg0 : i64
    %2 = llvm.xor %arg1, %arg2 : i64
    %3 = llvm.select %1, %c39_i64, %2 : i1, i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.urem %c-6_i64, %c50_i64 : i64
    %6 = llvm.xor %5, %arg0 : i64
    %7 = llvm.urem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.xor %arg0, %arg2 : i64
    %4 = llvm.icmp "sge" %3, %arg0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.urem %1, %0 : i64
    %4 = llvm.and %c16_i64, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.lshr %1, %5 : i64
    %7 = llvm.icmp "ult" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.sdiv %c-49_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %c-34_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.sdiv %c-5_i64, %c-20_i64 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.or %c13_i64, %arg0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.icmp "sle" %arg2, %c-27_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %2, %4, %c-36_i64 : i1, i64
    %6 = llvm.lshr %5, %4 : i64
    %7 = llvm.icmp "slt" %6, %c31_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %false = arith.constant false
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.sdiv %c-19_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "ne" %1, %0 : i64
    %3 = llvm.select %2, %1, %1 : i1, i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.sdiv %c24_i64, %3 : i64
    %6 = llvm.select %arg1, %4, %5 : i1, i64
    %7 = llvm.icmp "ult" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "uge" %c-31_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.zext %0 : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ult" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %arg0, %arg2 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "uge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %true = arith.constant true
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %c12_i64, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.and %2, %c36_i64 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.srem %1, %5 : i64
    %7 = llvm.xor %6, %0 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c3_i64 = arith.constant 3 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %c-38_i64 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.select %0, %arg2, %2 : i1, i64
    %4 = llvm.srem %c3_i64, %1 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.trunc %false : i1 to i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %c-2_i64, %0 : i64
    %2 = llvm.lshr %c-49_i64, %1 : i64
    %3 = llvm.icmp "sgt" %c-46_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.zext %arg1 : i1 to i64
    %7 = llvm.srem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.icmp "sle" %c11_i64, %arg0 : i64
    %3 = llvm.select %2, %c-28_i64, %c-29_i64 : i1, i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "uge" %c-7_i64, %c12_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.xor %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %false = arith.constant false
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.udiv %arg0, %c12_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.ashr %arg2, %c35_i64 : i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg2, %c5_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c-39_i64, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %c39_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.srem %c-33_i64, %arg0 : i64
    %1 = llvm.and %c-50_i64, %arg1 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %arg2, %3 : i64
    %5 = llvm.icmp "ult" %arg1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c47_i64 = arith.constant 47 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "sge" %c47_i64, %c25_i64 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.select %0, %3, %2 : i1, i64
    %5 = llvm.icmp "sgt" %c38_i64, %2 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "uge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c28_i64 = arith.constant 28 : i64
    %false = arith.constant false
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %false, %0, %c28_i64 : i1, i64
    %2 = llvm.icmp "uge" %arg1, %c47_i64 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.lshr %3, %0 : i64
    %5 = llvm.lshr %arg1, %0 : i64
    %6 = llvm.select %2, %4, %5 : i1, i64
    %7 = llvm.udiv %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.ashr %arg0, %5 : i64
    %7 = llvm.lshr %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.ashr %arg2, %c13_i64 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.sdiv %arg1, %4 : i64
    %6 = llvm.udiv %arg0, %5 : i64
    %7 = llvm.udiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.xor %arg0, %c-10_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.sdiv %3, %arg2 : i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.urem %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c16_i64 = arith.constant 16 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ne" %arg0, %c-27_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.udiv %2, %1 : i64
    %4 = llvm.icmp "ule" %3, %arg1 : i64
    %5 = llvm.select %4, %arg2, %c10_i64 : i1, i64
    %6 = llvm.srem %c16_i64, %c-24_i64 : i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c4_i64 = arith.constant 4 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg2 : i64
    %2 = llvm.lshr %c12_i64, %0 : i64
    %3 = llvm.srem %arg1, %c33_i64 : i64
    %4 = llvm.or %c4_i64, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sdiv %c-27_i64, %c28_i64 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.select %2, %1, %c-38_i64 : i1, i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.and %3, %arg1 : i64
    %6 = llvm.sdiv %c-37_i64, %5 : i64
    %7 = llvm.urem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %arg0 : i64
    %2 = llvm.or %c-10_i64, %arg1 : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.srem %c-5_i64, %c19_i64 : i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.ashr %arg0, %c40_i64 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.srem %3, %2 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "eq" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c12_i64 = arith.constant 12 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.xor %c-25_i64, %c50_i64 : i64
    %1 = llvm.or %arg0, %c-1_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %c12_i64, %3 : i64
    %5 = llvm.urem %1, %0 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.or %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.and %0, %c-19_i64 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %c-26_i64, %4 : i64
    %6 = llvm.icmp "ult" %c-21_i64, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.xor %4, %1 : i64
    %6 = llvm.icmp "eq" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %arg2, %arg1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.udiv %arg1, %5 : i64
    %7 = llvm.xor %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.xor %arg0, %c-29_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.ashr %5, %c4_i64 : i64
    %7 = llvm.icmp "ugt" %6, %2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.xor %c17_i64, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %0, %4 : i64
    %6 = llvm.and %5, %0 : i64
    %7 = llvm.or %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %arg2, %c-1_i64 : i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.and %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.ashr %c-7_i64, %c31_i64 : i64
    %1 = llvm.ashr %c-16_i64, %0 : i64
    %2 = llvm.xor %c14_i64, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %c-42_i64, %5 : i64
    %7 = llvm.icmp "sge" %6, %1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.and %arg1, %c49_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "eq" %c-9_i64, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %3, %c-16_i64 : i64
    %5 = llvm.sdiv %4, %arg2 : i64
    %6 = llvm.and %c-39_i64, %5 : i64
    %7 = llvm.icmp "ule" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.sdiv %c38_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.icmp "ne" %arg1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %3, %c32_i64 : i64
    %5 = llvm.lshr %arg2, %4 : i64
    %6 = llvm.lshr %1, %5 : i64
    %7 = llvm.icmp "slt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c19_i64 = arith.constant 19 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c47_i64 : i64
    %2 = llvm.urem %arg1, %arg2 : i64
    %3 = llvm.or %2, %c19_i64 : i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.and %1, %5 : i64
    %7 = llvm.lshr %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c33_i64 = arith.constant 33 : i64
    %false = arith.constant false
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.select %false, %c33_i64, %arg0 : i1, i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.udiv %arg2, %c-1_i64 : i64
    %4 = llvm.srem %3, %arg2 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.and %arg0, %arg0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.lshr %1, %arg2 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.icmp "ugt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.lshr %1, %arg1 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.ashr %5, %3 : i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.icmp "sgt" %c42_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.select %arg0, %3, %c-16_i64 : i1, i64
    %5 = llvm.srem %0, %c-34_i64 : i64
    %6 = llvm.sdiv %arg2, %5 : i64
    %7 = llvm.icmp "eq" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "sge" %c-18_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.select %arg2, %arg0, %1 : i1, i64
    %3 = llvm.icmp "uge" %2, %c-35_i64 : i64
    %4 = llvm.select %3, %1, %2 : i1, i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.select %0, %arg1, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.ashr %arg0, %c-21_i64 : i64
    %1 = llvm.lshr %c7_i64, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.icmp "eq" %arg2, %2 : i64
    %5 = llvm.select %4, %3, %arg2 : i1, i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.lshr %c-12_i64, %1 : i64
    %3 = llvm.select %true, %1, %c-12_i64 : i1, i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "ult" %arg2, %c39_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.ashr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %true = arith.constant true
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.and %0, %c-34_i64 : i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.icmp "ule" %arg2, %c34_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.select %2, %3, %5 : i1, i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c44_i64 = arith.constant 44 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sdiv %c44_i64, %c27_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.xor %1, %c-46_i64 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.sdiv %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.select %1, %3, %4 : i1, i64
    %6 = llvm.trunc %true : i1 to i64
    %7 = llvm.lshr %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.udiv %c-19_i64, %c37_i64 : i64
    %1 = llvm.udiv %c21_i64, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.sdiv %2, %c-24_i64 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.and %1, %5 : i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c-42_i64, %1 : i64
    %3 = llvm.lshr %c-8_i64, %arg1 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.sdiv %4, %c18_i64 : i64
    %6 = llvm.udiv %arg2, %c48_i64 : i64
    %7 = llvm.icmp "slt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.xor %c30_i64, %c30_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.srem %arg1, %0 : i64
    %3 = llvm.udiv %c7_i64, %2 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c12_i64 = arith.constant 12 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.ashr %c-7_i64, %c18_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.xor %c12_i64, %1 : i64
    %3 = llvm.ashr %0, %c17_i64 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.urem %4, %arg0 : i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.icmp "uge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.ashr %arg0, %c-8_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.ashr %arg1, %arg2 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.icmp "sgt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c10_i64 = arith.constant 10 : i64
    %c25_i64 = arith.constant 25 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.xor %c50_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %2, %c25_i64 : i64
    %4 = llvm.and %c10_i64, %3 : i64
    %5 = llvm.or %4, %3 : i64
    %6 = llvm.or %5, %c35_i64 : i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "sle" %3, %0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.or %0, %5 : i64
    %7 = llvm.srem %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.srem %c-34_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.sdiv %1, %c-41_i64 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.urem %arg0, %arg0 : i64
    %5 = llvm.xor %c-24_i64, %4 : i64
    %6 = llvm.ashr %3, %5 : i64
    %7 = llvm.icmp "ule" %6, %1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.sdiv %arg0, %c-30_i64 : i64
    %1 = llvm.urem %c42_i64, %arg0 : i64
    %2 = llvm.urem %1, %c18_i64 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.xor %3, %arg0 : i64
    %5 = llvm.sext %arg1 : i1 to i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %true = arith.constant true
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %arg2, %c-43_i64 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.urem %0, %0 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.select %true, %3, %c-50_i64 : i1, i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.and %1, %5 : i64
    %7 = llvm.or %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %c-41_i64, %arg2 : i64
    %5 = llvm.icmp "ugt" %4, %arg1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.or %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.or %c-24_i64, %arg0 : i64
    %1 = llvm.urem %c48_i64, %arg2 : i64
    %2 = llvm.udiv %c-34_i64, %1 : i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.and %arg1, %5 : i64
    %7 = llvm.icmp "slt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c38_i64 = arith.constant 38 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.select %arg0, %c11_i64, %arg1 : i1, i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "sgt" %arg2, %c38_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %c-27_i64, %3 : i64
    %5 = llvm.srem %4, %c28_i64 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.lshr %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %c-10_i64 : i64
    %2 = llvm.icmp "sgt" %arg1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.ashr %5, %c-38_i64 : i64
    %7 = llvm.xor %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ule" %c50_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.udiv %arg2, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.and %1, %arg1 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "ne" %c45_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c37_i64 = arith.constant 37 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.ashr %c-45_i64, %c-18_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.ashr %c37_i64, %1 : i64
    %3 = llvm.lshr %arg0, %c35_i64 : i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.or %4, %4 : i64
    %6 = llvm.sdiv %2, %5 : i64
    %7 = llvm.xor %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.and %c48_i64, %c-27_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.trunc %arg1 : i1 to i64
    %5 = llvm.urem %4, %arg2 : i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.udiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.lshr %arg1, %c5_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "sle" %c-44_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.udiv %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %c29_i64, %2 : i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.zext %1 : i1 to i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.srem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.and %c-26_i64, %arg0 : i64
    %5 = llvm.and %4, %3 : i64
    %6 = llvm.udiv %5, %c-12_i64 : i64
    %7 = llvm.sdiv %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %true = arith.constant true
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.sdiv %c15_i64, %arg1 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.urem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.ashr %c-7_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.zext %3 : i1 to i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.icmp "ugt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.udiv %c3_i64, %arg0 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sge" %3, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %5, %2 : i64
    %7 = llvm.sdiv %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.sdiv %arg0, %c-50_i64 : i64
    %1 = llvm.icmp "sge" %arg1, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %c-35_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %c-7_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.and %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.select %1, %c-14_i64, %0 : i1, i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.lshr %3, %arg2 : i64
    %5 = llvm.sdiv %c11_i64, %4 : i64
    %6 = llvm.sdiv %2, %c-8_i64 : i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.udiv %c23_i64, %c-10_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.and %0, %arg0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.trunc %arg1 : i1 to i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.lshr %0, %5 : i64
    %7 = llvm.icmp "eq" %c19_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.xor %c-46_i64, %c39_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg1, %0 : i64
    %4 = llvm.icmp "slt" %3, %arg2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.icmp "eq" %6, %c-45_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.urem %arg0, %arg0 : i64
    %3 = llvm.lshr %arg2, %2 : i64
    %4 = llvm.select %1, %3, %arg0 : i1, i64
    %5 = llvm.icmp "uge" %4, %c31_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.lshr %6, %c-22_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.udiv %1, %c-36_i64 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.udiv %0, %arg2 : i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.xor %c-19_i64, %5 : i64
    %7 = llvm.icmp "sgt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "slt" %c46_i64, %arg0 : i64
    %1 = llvm.select %0, %c-47_i64, %arg1 : i1, i64
    %2 = llvm.sdiv %c-34_i64, %1 : i64
    %3 = llvm.lshr %arg2, %c-21_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "sgt" %c47_i64, %3 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "uge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %c-15_i64, %c-10_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.select %arg1, %2, %arg2 : i1, i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.icmp "ult" %4, %arg2 : i64
    %6 = llvm.select %5, %c-7_i64, %c-37_i64 : i1, i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.and %arg0, %c-10_i64 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.srem %c-10_i64, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sle" %6, %2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "slt" %arg0, %c26_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ult" %3, %arg0 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sext %0 : i1 to i64
    %7 = llvm.and %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.sdiv %c1_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c-32_i64, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.xor %c22_i64, %3 : i64
    %5 = llvm.ashr %arg2, %4 : i64
    %6 = llvm.and %2, %5 : i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.xor %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c-8_i64 = arith.constant -8 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.and %c-8_i64, %arg1 : i64
    %5 = llvm.icmp "uge" %4, %arg2 : i64
    %6 = llvm.select %5, %c9_i64, %arg2 : i1, i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c29_i64 : i64
    %2 = llvm.icmp "ne" %arg0, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %arg2, %c16_i64 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.srem %5, %arg2 : i64
    %7 = llvm.icmp "ugt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c14_i64 = arith.constant 14 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.urem %arg0, %c-9_i64 : i64
    %1 = llvm.icmp "ult" %0, %c-34_i64 : i64
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ult" %c14_i64, %c7_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.udiv %c50_i64, %5 : i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sdiv %arg0, %c27_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %3, %0 : i64
    %5 = llvm.and %c13_i64, %arg1 : i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.icmp "sle" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %0, %c36_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.icmp "sle" %3, %1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.or %c31_i64, %2 : i64
    %7 = llvm.icmp "slt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-24_i64 = arith.constant -24 : i64
    %false = arith.constant false
    %c-34_i64 = arith.constant -34 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.select %false, %c-34_i64, %c42_i64 : i1, i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.sdiv %3, %c-24_i64 : i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %6, %c-41_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %c4_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %arg0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.select %false, %arg1, %arg2 : i1, i64
    %2 = llvm.urem %arg2, %arg0 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.sdiv %0, %5 : i64
    %7 = llvm.icmp "sle" %c37_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c-36_i64 = arith.constant -36 : i64
    %true = arith.constant true
    %c7_i64 = arith.constant 7 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.lshr %c13_i64, %c-45_i64 : i64
    %1 = llvm.udiv %arg0, %c7_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.or %3, %c-36_i64 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.lshr %arg0, %5 : i64
    %7 = llvm.urem %6, %c38_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c12_i64 = arith.constant 12 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.urem %c-25_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c48_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %4, %c12_i64 : i64
    %6 = llvm.icmp "ugt" %5, %c-28_i64 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.udiv %c18_i64, %2 : i64
    %4 = llvm.icmp "eq" %arg1, %1 : i64
    %5 = llvm.and %0, %0 : i64
    %6 = llvm.select %4, %c30_i64, %5 : i1, i64
    %7 = llvm.xor %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c-10_i64, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.and %2, %1 : i64
    %5 = llvm.sdiv %4, %4 : i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.sdiv %c-25_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.icmp "eq" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %false, %arg0, %arg1 : i1, i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.select %true, %0, %3 : i1, i64
    %5 = llvm.icmp "ugt" %arg2, %c-10_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.or %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %c-12_i64, %arg0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.icmp "ule" %4, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.udiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %c0_i64 : i64
    %2 = llvm.icmp "uge" %0, %arg2 : i64
    %3 = llvm.select %2, %c-26_i64, %c15_i64 : i1, i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %0, %5 : i64
    %7 = llvm.icmp "uge" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %c23_i64, %1 : i64
    %3 = llvm.srem %c-12_i64, %c-8_i64 : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.select %0, %3, %4 : i1, i64
    %6 = llvm.urem %2, %5 : i64
    %7 = llvm.icmp "uge" %6, %c-26_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c36_i64 = arith.constant 36 : i64
    %c43_i64 = arith.constant 43 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %c5_i64, %c43_i64 : i64
    %3 = llvm.udiv %2, %1 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "ult" %c36_i64, %c24_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.srem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %arg0, %arg2 : i1, i64
    %3 = llvm.udiv %c-39_i64, %arg0 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.sdiv %c-36_i64, %2 : i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.icmp "ne" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %c9_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.and %0, %arg0 : i64
    %7 = llvm.or %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.or %c-48_i64, %1 : i64
    %3 = llvm.select %0, %2, %c40_i64 : i1, i64
    %4 = llvm.sdiv %c-3_i64, %c-30_i64 : i64
    %5 = llvm.udiv %c-35_i64, %4 : i64
    %6 = llvm.xor %5, %2 : i64
    %7 = llvm.srem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.ashr %c49_i64, %c-45_i64 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %c-20_i64, %arg0 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.sdiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.udiv %c-23_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.lshr %2, %c18_i64 : i64
    %4 = llvm.icmp "ne" %arg1, %arg2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.lshr %5, %c-22_i64 : i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c18_i64 = arith.constant 18 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %c26_i64 : i1, i64
    %3 = llvm.lshr %c18_i64, %arg1 : i64
    %4 = llvm.icmp "ule" %3, %arg2 : i64
    %5 = llvm.zext %1 : i1 to i64
    %6 = llvm.select %4, %5, %c-30_i64 : i1, i64
    %7 = llvm.lshr %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %arg1, %1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.xor %arg0, %c12_i64 : i64
    %1 = llvm.icmp "slt" %c-34_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "sgt" %c-32_i64, %c-43_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.udiv %5, %arg1 : i64
    %7 = llvm.icmp "ult" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "ne" %c-14_i64, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.icmp "ult" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.trunc %false : i1 to i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.icmp "eq" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c23_i64 = arith.constant 23 : i64
    %true = arith.constant true
    %c26_i64 = arith.constant 26 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.urem %c-12_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %c26_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %arg0, %c23_i64 : i64
    %4 = llvm.sdiv %0, %c-37_i64 : i64
    %5 = llvm.or %4, %arg1 : i64
    %6 = llvm.select %true, %3, %5 : i1, i64
    %7 = llvm.icmp "eq" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.srem %c-30_i64, %c1_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.and %c37_i64, %1 : i64
    %3 = llvm.ashr %arg2, %arg0 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "uge" %4, %0 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.urem %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.sdiv %arg0, %c-50_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %4, %arg1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ult" %6, %c-41_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c-36_i64 = arith.constant -36 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.select %2, %0, %c-36_i64 : i1, i64
    %4 = llvm.select %arg1, %0, %arg2 : i1, i64
    %5 = llvm.or %c23_i64, %4 : i64
    %6 = llvm.xor %5, %0 : i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "eq" %c-31_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "ult" %1, %arg0 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.ashr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c48_i64 = arith.constant 48 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.srem %c15_i64, %c-11_i64 : i64
    %1 = llvm.icmp "slt" %arg0, %c48_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.udiv %c-2_i64, %3 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.xor %5, %0 : i64
    %7 = llvm.icmp "slt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c12_i64 = arith.constant 12 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %c-46_i64, %0 : i64
    %2 = llvm.select %1, %arg1, %0 : i1, i64
    %3 = llvm.select %arg0, %arg2, %c12_i64 : i1, i64
    %4 = llvm.and %3, %c-45_i64 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.lshr %c46_i64, %arg2 : i64
    %7 = llvm.urem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.and %arg1, %arg0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.select %2, %1, %arg2 : i1, i64
    %6 = llvm.lshr %5, %arg2 : i64
    %7 = llvm.lshr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.urem %arg1, %arg2 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.sdiv %6, %c-7_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.urem %2, %c-13_i64 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.or %c-33_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.sdiv %arg0, %arg0 : i64
    %3 = llvm.xor %1, %arg2 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.select %arg1, %1, %4 : i1, i64
    %6 = llvm.lshr %0, %5 : i64
    %7 = llvm.icmp "sle" %c-34_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %arg1, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.sdiv %2, %c19_i64 : i64
    %4 = llvm.lshr %0, %c32_i64 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "ult" %3, %arg0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.lshr %arg1, %arg2 : i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c18_i64 = arith.constant 18 : i64
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %false, %c18_i64, %c-42_i64 : i1, i64
    %6 = llvm.urem %5, %1 : i64
    %7 = llvm.icmp "eq" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %c-16_i64, %c1_i64 : i64
    %5 = llvm.trunc %2 : i1 to i64
    %6 = llvm.udiv %4, %5 : i64
    %7 = llvm.icmp "ne" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "ult" %arg1, %arg1 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.srem %c-7_i64, %4 : i64
    %6 = llvm.ashr %1, %arg2 : i64
    %7 = llvm.xor %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.select %0, %c-13_i64, %1 : i1, i64
    %3 = llvm.and %arg2, %arg2 : i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %true = arith.constant true
    %c6_i64 = arith.constant 6 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.or %arg1, %c17_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.lshr %c6_i64, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.sext %arg2 : i1 to i64
    %6 = llvm.urem %0, %5 : i64
    %7 = llvm.srem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %arg2, %2 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "eq" %4, %3 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "slt" %c-48_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c37_i64 = arith.constant 37 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c27_i64 = arith.constant 27 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "uge" %c27_i64, %c45_i64 : i64
    %1 = llvm.select %0, %c-29_i64, %arg0 : i1, i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.lshr %c37_i64, %2 : i64
    %4 = llvm.and %c50_i64, %2 : i64
    %5 = llvm.or %arg0, %4 : i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %true = arith.constant true
    %c-43_i64 = arith.constant -43 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.or %c-38_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.srem %1, %c-43_i64 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "uge" %c24_i64, %0 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.lshr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.trunc %arg1 : i1 to i64
    %5 = llvm.and %4, %3 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.and %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c35_i64 = arith.constant 35 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.ashr %arg0, %arg2 : i64
    %2 = llvm.icmp "slt" %arg1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.udiv %c35_i64, %c31_i64 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.ashr %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "sgt" %arg1, %c15_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %c-42_i64, %c-49_i64 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    %6 = llvm.urem %c-24_i64, %arg0 : i64
    %7 = llvm.select %5, %6, %c33_i64 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.select %arg0, %c-38_i64, %arg1 : i1, i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.ashr %c25_i64, %arg1 : i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.lshr %2, %arg0 : i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.icmp "sle" %c19_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.srem %c-32_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.icmp "sgt" %arg1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.select %1, %5, %c-47_i64 : i1, i64
    %7 = llvm.icmp "sge" %6, %c-39_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.xor %c27_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.lshr %0, %arg2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.lshr %4, %3 : i64
    %6 = llvm.srem %5, %arg1 : i64
    %7 = llvm.and %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.lshr %c5_i64, %c-41_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.or %c-23_i64, %1 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.lshr %3, %c45_i64 : i64
    %5 = llvm.lshr %2, %3 : i64
    %6 = llvm.lshr %4, %5 : i64
    %7 = llvm.icmp "ugt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.ashr %arg2, %c-22_i64 : i64
    %5 = llvm.icmp "ult" %4, %arg1 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %c-5_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %2, %c-1_i64 : i64
    %4 = llvm.icmp "sgt" %3, %arg1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.udiv %5, %c12_i64 : i64
    %7 = llvm.icmp "slt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %arg0, %c14_i64 : i64
    %1 = llvm.select %arg1, %arg0, %0 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.and %arg2, %arg2 : i64
    %4 = llvm.xor %3, %c-46_i64 : i64
    %5 = llvm.and %4, %0 : i64
    %6 = llvm.and %5, %2 : i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "sgt" %arg0, %c21_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.icmp "eq" %c-13_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg2, %1 : i64
    %3 = llvm.icmp "ugt" %c22_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.sext %0 : i1 to i64
    %7 = llvm.sdiv %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.icmp "sgt" %c-10_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg1, %arg0 : i64
    %3 = llvm.icmp "slt" %2, %c-21_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %4, %2 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %c23_i64 : i64
    %2 = llvm.xor %arg0, %arg1 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.and %4, %c-41_i64 : i64
    %6 = llvm.xor %2, %3 : i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ule" %0, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.trunc %true : i1 to i64
    %6 = llvm.sdiv %5, %arg0 : i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c9_i64 = arith.constant 9 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "eq" %c6_i64, %c-44_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %c9_i64 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "sgt" %arg1, %3 : i64
    %5 = llvm.or %arg1, %arg2 : i64
    %6 = llvm.select %4, %5, %c23_i64 : i1, i64
    %7 = llvm.ashr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.urem %c-13_i64, %arg0 : i64
    %4 = llvm.icmp "ne" %arg1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.ashr %c0_i64, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c30_i64 = arith.constant 30 : i64
    %c48_i64 = arith.constant 48 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.or %c9_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c48_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %0, %c30_i64 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %5, %c47_i64 : i64
    %7 = llvm.icmp "ult" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %4, %arg2 : i64
    %6 = llvm.and %2, %5 : i64
    %7 = llvm.ashr %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.and %c25_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %arg1, %c7_i64 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %c-4_i64, %5 : i64
    %7 = llvm.sdiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %true = arith.constant true
    %c-47_i64 = arith.constant -47 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.lshr %arg2, %c-33_i64 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.select %arg0, %c42_i64, %1 : i1, i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.select %true, %c-47_i64, %4 : i1, i64
    %6 = llvm.trunc %true : i1 to i64
    %7 = llvm.select %false, %5, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c-37_i64 = arith.constant -37 : i64
    %true = arith.constant true
    %c-15_i64 = arith.constant -15 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %c-15_i64, %0 : i64
    %2 = llvm.or %c-37_i64, %arg0 : i64
    %3 = llvm.select %true, %2, %c-48_i64 : i1, i64
    %4 = llvm.or %3, %arg0 : i64
    %5 = llvm.ashr %4, %2 : i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-15_i64 = arith.constant -15 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.and %c-15_i64, %1 : i64
    %3 = llvm.lshr %arg0, %arg1 : i64
    %4 = llvm.ashr %3, %c-33_i64 : i64
    %5 = llvm.or %4, %4 : i64
    %6 = llvm.urem %2, %5 : i64
    %7 = llvm.icmp "ult" %c-30_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %true = arith.constant true
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.select %true, %c-25_i64, %arg0 : i1, i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.urem %c4_i64, %arg2 : i64
    %3 = llvm.select %1, %arg2, %2 : i1, i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.trunc %1 : i1 to i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.icmp "slt" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %arg1, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c4_i64 = arith.constant 4 : i64
    %true = arith.constant true
    %false = arith.constant false
    %c43_i64 = arith.constant 43 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %c-45_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.udiv %2, %1 : i64
    %4 = llvm.xor %c43_i64, %3 : i64
    %5 = llvm.select %true, %c4_i64, %c-2_i64 : i1, i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.icmp "sge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %c23_i64 : i64
    %2 = llvm.xor %1, %c-22_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.urem %4, %2 : i64
    %6 = llvm.xor %2, %4 : i64
    %7 = llvm.sdiv %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.urem %c7_i64, %c-3_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %c-7_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.udiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c45_i64 = arith.constant 45 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c14_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %4, %c45_i64 : i64
    %6 = llvm.xor %c-8_i64, %c48_i64 : i64
    %7 = llvm.icmp "sge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c47_i64 = arith.constant 47 : i64
    %c22_i64 = arith.constant 22 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.sdiv %c22_i64, %c40_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.xor %arg0, %0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.and %3, %c47_i64 : i64
    %5 = llvm.icmp "eq" %4, %arg1 : i64
    %6 = llvm.select %5, %arg2, %c-19_i64 : i1, i64
    %7 = llvm.sdiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.ashr %c9_i64, %arg0 : i64
    %1 = llvm.srem %c-37_i64, %arg0 : i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %3, %arg0 : i64
    %5 = llvm.sdiv %0, %4 : i64
    %6 = llvm.icmp "slt" %arg0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.srem %3, %0 : i64
    %5 = llvm.ashr %arg0, %4 : i64
    %6 = llvm.xor %5, %arg1 : i64
    %7 = llvm.srem %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg1, %arg2 : i64
    %4 = llvm.srem %3, %arg2 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.or %c29_i64, %arg1 : i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %c-32_i64 : i64
    %3 = llvm.xor %c27_i64, %arg0 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.srem %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c30_i64 = arith.constant 30 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "ule" %c30_i64, %c46_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.srem %arg0, %arg1 : i64
    %5 = llvm.srem %c16_i64, %arg1 : i64
    %6 = llvm.or %arg2, %5 : i64
    %7 = llvm.select %3, %4, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.or %c-49_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg1 : i64
    %2 = llvm.and %c-32_i64, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.srem %arg0, %4 : i64
    %6 = llvm.and %0, %5 : i64
    %7 = llvm.sdiv %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %c-47_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.udiv %arg1, %arg0 : i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.and %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-49_i64 = arith.constant -49 : i64
    %c13_i64 = arith.constant 13 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.ashr %c46_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.or %arg2, %c13_i64 : i64
    %3 = llvm.ashr %arg2, %2 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.srem %c-49_i64, %4 : i64
    %6 = llvm.sdiv %3, %5 : i64
    %7 = llvm.icmp "ule" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.or %arg1, %c-34_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.xor %arg1, %arg0 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.xor %4, %2 : i64
    %6 = llvm.and %4, %2 : i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c10_i64 = arith.constant 10 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %0, %c10_i64 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.ashr %3, %0 : i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.urem %1, %5 : i64
    %7 = llvm.urem %6, %c-25_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c22_i64 = arith.constant 22 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.srem %c-42_i64, %c18_i64 : i64
    %1 = llvm.icmp "eq" %0, %c22_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %c-24_i64, %5 : i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c31_i64 = arith.constant 31 : i64
    %c23_i64 = arith.constant 23 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.ashr %arg1, %c28_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.select %arg2, %1, %arg1 : i1, i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.xor %c31_i64, %c42_i64 : i64
    %5 = llvm.and %c23_i64, %4 : i64
    %6 = llvm.and %arg0, %5 : i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.and %1, %arg0 : i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.sdiv %c39_i64, %arg2 : i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c28_i64 = arith.constant 28 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.urem %arg0, %c1_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %c28_i64, %5 : i64
    %7 = llvm.icmp "ult" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c32_i64 = arith.constant 32 : i64
    %c39_i64 = arith.constant 39 : i64
    %c2_i64 = arith.constant 2 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sgt" %c2_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.urem %arg0, %c39_i64 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    %6 = llvm.select %5, %arg0, %c32_i64 : i1, i64
    %7 = llvm.select %5, %6, %c7_i64 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %c47_i64, %c-50_i64 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.or %3, %0 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.ashr %0, %5 : i64
    %7 = llvm.and %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %c-38_i64, %c35_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %c46_i64, %2 : i64
    %6 = llvm.select %3, %5, %arg0 : i1, i64
    %7 = llvm.icmp "sle" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c31_i64 = arith.constant 31 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %c-8_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %arg0, %c31_i64 : i64
    %4 = llvm.icmp "sge" %3, %c26_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %2, %5 : i64
    %7 = llvm.ashr %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c30_i64 = arith.constant 30 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.and %c39_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %2, %c30_i64 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.select %arg2, %c28_i64, %2 : i1, i64
    %7 = llvm.icmp "ugt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %c-15_i64 : i64
    %2 = llvm.icmp "eq" %c8_i64, %c-37_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c-33_i64 = arith.constant -33 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "eq" %c-33_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c12_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %arg0, %0 : i64
    %6 = llvm.select %5, %4, %4 : i1, i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.sdiv %c-18_i64, %c-25_i64 : i64
    %1 = llvm.lshr %0, %c8_i64 : i64
    %2 = llvm.icmp "eq" %c-39_i64, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "sge" %c15_i64, %c-50_i64 : i64
    %6 = llvm.select %5, %c30_i64, %4 : i1, i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c12_i64 = arith.constant 12 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c46_i64 : i64
    %2 = llvm.icmp "sgt" %arg0, %c12_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %arg1, %c-20_i64, %0 : i1, i64
    %5 = llvm.ashr %arg0, %4 : i64
    %6 = llvm.lshr %3, %5 : i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.select %arg1, %4, %arg2 : i1, i64
    %7 = llvm.icmp "sge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.udiv %arg0, %c26_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %arg0, %arg1 : i64
    %6 = llvm.xor %arg0, %5 : i64
    %7 = llvm.icmp "ule" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c33_i64 = arith.constant 33 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c15_i64 : i64
    %2 = llvm.urem %c33_i64, %arg0 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.or %arg2, %c5_i64 : i64
    %5 = llvm.udiv %4, %c33_i64 : i64
    %6 = llvm.or %3, %5 : i64
    %7 = llvm.icmp "eq" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %c34_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %arg2, %4 : i64
    %6 = llvm.or %arg0, %5 : i64
    %7 = llvm.icmp "ugt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.urem %2, %c49_i64 : i64
    %4 = llvm.sdiv %c42_i64, %3 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %6, %1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c46_i64 = arith.constant 46 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "slt" %c10_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %c46_i64, %1 : i64
    %3 = llvm.urem %c-37_i64, %2 : i64
    %4 = llvm.ashr %3, %2 : i64
    %5 = llvm.icmp "ult" %c23_i64, %c-26_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "uge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.udiv %c32_i64, %arg0 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %c20_i64, %arg1 : i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.xor %arg2, %arg1 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %c-8_i64 : i64
    %5 = llvm.select %4, %arg0, %arg2 : i1, i64
    %6 = llvm.lshr %arg0, %0 : i64
    %7 = llvm.icmp "eq" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-29_i64 = arith.constant -29 : i64
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sgt" %0, %c-29_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %4, %c-46_i64 : i64
    %6 = llvm.lshr %5, %c49_i64 : i64
    %7 = llvm.icmp "ult" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %true = arith.constant true
    %c12_i64 = arith.constant 12 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.xor %c12_i64, %c19_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.select %true, %arg2, %2 : i1, i64
    %5 = llvm.lshr %4, %c21_i64 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.icmp "sgt" %6, %arg1 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "sge" %arg1, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.srem %c31_i64, %arg0 : i64
    %4 = llvm.srem %3, %arg0 : i64
    %5 = llvm.icmp "uge" %4, %c0_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.xor %arg1, %c-30_i64 : i64
    %1 = llvm.and %c5_i64, %c-7_i64 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.urem %arg0, %c-6_i64 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.lshr %c35_i64, %c-3_i64 : i64
    %1 = llvm.xor %c-21_i64, %0 : i64
    %2 = llvm.icmp "ult" %1, %c42_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %3, %arg0 : i64
    %5 = llvm.udiv %4, %arg1 : i64
    %6 = llvm.urem %5, %1 : i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c6_i64 = arith.constant 6 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %c48_i64, %arg0 : i64
    %1 = llvm.srem %c-19_i64, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.icmp "ne" %c6_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %5, %3 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.select %arg0, %c30_i64, %c-44_i64 : i1, i64
    %1 = llvm.or %0, %c-18_i64 : i64
    %2 = llvm.icmp "ult" %c-44_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %1, %1 : i64
    %5 = llvm.icmp "ugt" %4, %arg1 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.urem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %c-15_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.srem %5, %1 : i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c-38_i64 = arith.constant -38 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.select %arg0, %c-30_i64, %c15_i64 : i1, i64
    %1 = llvm.icmp "ule" %0, %c-11_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %arg1 : i64
    %4 = llvm.xor %0, %c-38_i64 : i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.select %3, %4, %5 : i1, i64
    %7 = llvm.icmp "slt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %true = arith.constant true
    %c8_i64 = arith.constant 8 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.sdiv %c-36_i64, %arg2 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.ashr %2, %c8_i64 : i64
    %4 = llvm.select %true, %arg2, %c-39_i64 : i1, i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ule" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "ugt" %c23_i64, %arg0 : i64
    %1 = llvm.udiv %c-10_i64, %arg0 : i64
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %3 = llvm.select %2, %arg2, %arg0 : i1, i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.select %0, %4, %c6_i64 : i1, i64
    %6 = llvm.icmp "sgt" %c-2_i64, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %true = arith.constant true
    %c17_i64 = arith.constant 17 : i64
    %false = arith.constant false
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.xor %c45_i64, %arg0 : i64
    %1 = llvm.select %false, %arg1, %arg0 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.select %true, %arg1, %1 : i1, i64
    %4 = llvm.and %c17_i64, %3 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.ashr %c1_i64, %arg0 : i64
    %7 = llvm.icmp "sle" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %false = arith.constant false
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.select %false, %arg0, %0 : i1, i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.srem %c16_i64, %3 : i64
    %5 = llvm.trunc %arg2 : i1 to i64
    %6 = llvm.select %arg2, %5, %c50_i64 : i1, i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.urem %0, %c40_i64 : i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.select %4, %c-48_i64, %c41_i64 : i1, i64
    %6 = llvm.or %arg0, %5 : i64
    %7 = llvm.icmp "uge" %6, %0 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "ne" %arg0, %c2_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.lshr %c-40_i64, %2 : i64
    %4 = llvm.zext %0 : i1 to i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.udiv %3, %5 : i64
    %7 = llvm.urem %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.lshr %c33_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %c-36_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.urem %4, %c-15_i64 : i64
    %6 = llvm.srem %5, %c32_i64 : i64
    %7 = llvm.or %6, %c-9_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-20_i64 = arith.constant -20 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.lshr %c-13_i64, %arg1 : i64
    %1 = llvm.and %c-20_i64, %0 : i64
    %2 = llvm.lshr %arg2, %1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.ashr %arg0, %5 : i64
    %7 = llvm.icmp "sle" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-18_i64 = arith.constant -18 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %0, %c-44_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.sdiv %3, %c41_i64 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.icmp "sle" %c-18_i64, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %c-20_i64, %0 : i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    %3 = llvm.icmp "sle" %arg0, %c-40_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %2, %4, %c50_i64 : i1, i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %false = arith.constant false
    %c-2_i64 = arith.constant -2 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.xor %c31_i64, %arg0 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.lshr %2, %c-2_i64 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.trunc %false : i1 to i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.lshr %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.sdiv %arg1, %c-9_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c-10_i64, %2 : i64
    %4 = llvm.select %1, %arg1, %arg0 : i1, i64
    %5 = llvm.sdiv %4, %c28_i64 : i64
    %6 = llvm.xor %5, %arg2 : i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.and %c-12_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.ashr %arg0, %0 : i64
    %3 = llvm.ashr %c13_i64, %2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "ugt" %4, %c-47_i64 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-30_i64 = arith.constant -30 : i64
    %false = arith.constant false
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.select %false, %c40_i64, %arg0 : i1, i64
    %1 = llvm.srem %c-30_i64, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "uge" %arg2, %c47_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %arg1, %4 : i64
    %6 = llvm.or %2, %5 : i64
    %7 = llvm.icmp "sge" %6, %2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.srem %arg1, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sdiv %c39_i64, %c22_i64 : i64
    %7 = llvm.icmp "sle" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.ashr %c31_i64, %arg0 : i64
    %1 = llvm.xor %0, %c-15_i64 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.udiv %3, %c-25_i64 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.or %6, %3 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "eq" %2, %c26_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.sdiv %6, %2 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %c49_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.xor %6, %c-49_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c33_i64 = arith.constant 33 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.srem %c-31_i64, %arg2 : i64
    %1 = llvm.icmp "ne" %arg1, %0 : i64
    %2 = llvm.select %1, %arg2, %0 : i1, i64
    %3 = llvm.icmp "ugt" %2, %c47_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "eq" %c33_i64, %c5_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.select %arg0, %4, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.select %false, %0, %arg0 : i1, i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %arg1, %2 : i64
    %6 = llvm.urem %5, %arg2 : i64
    %7 = llvm.icmp "ult" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "ugt" %c-33_i64, %c24_i64 : i64
    %1 = llvm.select %0, %arg0, %c-48_i64 : i1, i64
    %2 = llvm.or %arg1, %arg0 : i64
    %3 = llvm.icmp "ugt" %c-48_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.and %6, %arg1 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c6_i64 = arith.constant 6 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.ashr %c6_i64, %1 : i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.srem %c11_i64, %3 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.lshr %arg0, %c-30_i64 : i64
    %4 = llvm.udiv %3, %c-25_i64 : i64
    %5 = llvm.select %2, %c-7_i64, %4 : i1, i64
    %6 = llvm.or %0, %arg2 : i64
    %7 = llvm.and %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %2, %c-35_i64 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.srem %2, %5 : i64
    %7 = llvm.lshr %c-4_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c-19_i64 = arith.constant -19 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.ashr %c1_i64, %arg0 : i64
    %1 = llvm.or %c-19_i64, %0 : i64
    %2 = llvm.icmp "sle" %arg1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %false, %0, %3 : i1, i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.zext %2 : i1 to i64
    %7 = llvm.icmp "ule" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ult" %3, %c-8_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sle" %5, %arg1 : i64
    %7 = llvm.sext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c-11_i64 = arith.constant -11 : i64
    %true = arith.constant true
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.or %0, %c-32_i64 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.xor %arg2, %c-11_i64 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "sge" %6, %c-25_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c24_i64 = arith.constant 24 : i64
    %c43_i64 = arith.constant 43 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.lshr %arg0, %c47_i64 : i64
    %1 = llvm.lshr %c43_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.and %c24_i64, %arg1 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.select %false, %1, %arg2 : i1, i64
    %6 = llvm.urem %5, %0 : i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %true = arith.constant true
    %c-48_i64 = arith.constant -48 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.or %arg1, %c-15_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.xor %arg0, %c-48_i64 : i64
    %3 = llvm.select %true, %c-4_i64, %2 : i1, i64
    %4 = llvm.or %arg2, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.select %arg0, %c-3_i64, %c21_i64 : i1, i64
    %1 = llvm.urem %c-18_i64, %0 : i64
    %2 = llvm.or %c38_i64, %arg1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %0, %4 : i64
    %6 = llvm.icmp "ule" %c2_i64, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %c2_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.srem %c-30_i64, %3 : i64
    %5 = llvm.trunc %arg0 : i1 to i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "ule" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %false = arith.constant false
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %c2_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %false, %c-7_i64, %arg2 : i1, i64
    %6 = llvm.urem %4, %5 : i64
    %7 = llvm.sdiv %6, %c2_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c39_i64 = arith.constant 39 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.sdiv %c-14_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sdiv %1, %c11_i64 : i64
    %3 = llvm.udiv %arg0, %c42_i64 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "ugt" %c39_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.or %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "sle" %arg0, %c-35_i64 : i64
    %1 = llvm.or %c-19_i64, %arg0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.srem %1, %arg0 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.select %0, %arg0, %5 : i1, i64
    %7 = llvm.icmp "ugt" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c35_i64 = arith.constant 35 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg2, %arg1 : i1, i64
    %2 = llvm.srem %c44_i64, %c35_i64 : i64
    %3 = llvm.urem %2, %c16_i64 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.zext %0 : i1 to i64
    %6 = llvm.select %0, %arg1, %5 : i1, i64
    %7 = llvm.icmp "sgt" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.udiv %c-17_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %c35_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg1, %0 : i64
    %4 = llvm.sdiv %arg0, %arg2 : i64
    %5 = llvm.urem %c27_i64, %4 : i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.lshr %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-45_i64 = arith.constant -45 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "slt" %0, %c-45_i64 : i64
    %2 = llvm.or %0, %arg0 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.sext %1 : i1 to i64
    %5 = llvm.lshr %4, %arg0 : i64
    %6 = llvm.sdiv %c-29_i64, %5 : i64
    %7 = llvm.icmp "sle" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c16_i64 = arith.constant 16 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.urem %c16_i64, %c-18_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.icmp "uge" %c-14_i64, %c13_i64 : i64
    %5 = llvm.select %4, %3, %c-18_i64 : i1, i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.icmp "uge" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.or %c9_i64, %0 : i64
    %2 = llvm.udiv %arg2, %1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.sdiv %c-26_i64, %3 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.xor %6, %c24_i64 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c45_i64 = arith.constant 45 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.udiv %c45_i64, %c11_i64 : i64
    %1 = llvm.icmp "slt" %c-15_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.and %arg1, %2 : i64
    %6 = llvm.srem %4, %5 : i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "ule" %c14_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.lshr %c-37_i64, %1 : i64
    %4 = llvm.and %3, %3 : i64
    %5 = llvm.and %arg1, %4 : i64
    %6 = llvm.or %2, %5 : i64
    %7 = llvm.icmp "sgt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %c-39_i64, %c47_i64 : i64
    %1 = llvm.icmp "ule" %c-36_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.icmp "ne" %c-6_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "eq" %5, %arg0 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.lshr %c-13_i64, %2 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.select %3, %5, %arg1 : i1, i64
    %7 = llvm.icmp "ult" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.trunc %arg2 : i1 to i64
    %6 = llvm.urem %arg1, %5 : i64
    %7 = llvm.icmp "uge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.or %3, %2 : i64
    %5 = llvm.icmp "ule" %4, %c-19_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.xor %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %arg0, %2, %c12_i64 : i1, i64
    %4 = llvm.srem %3, %2 : i64
    %5 = llvm.select %1, %c2_i64, %arg2 : i1, i64
    %6 = llvm.xor %3, %5 : i64
    %7 = llvm.icmp "eq" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c9_i64 = arith.constant 9 : i64
    %true = arith.constant true
    %c43_i64 = arith.constant 43 : i64
    %false = arith.constant false
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.ashr %c13_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.select %false, %c43_i64, %arg2 : i1, i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.select %true, %c-9_i64, %1 : i1, i64
    %5 = llvm.select %true, %c9_i64, %4 : i1, i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "eq" %c18_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg1, %arg2 : i64
    %3 = llvm.xor %1, %c21_i64 : i64
    %4 = llvm.icmp "ule" %3, %arg1 : i64
    %5 = llvm.select %4, %arg2, %2 : i1, i64
    %6 = llvm.ashr %2, %5 : i64
    %7 = llvm.icmp "sge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "ne" %c37_i64, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %c48_i64, %4 : i64
    %6 = llvm.srem %5, %1 : i64
    %7 = llvm.icmp "ule" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.or %c11_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.xor %arg0, %0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.zext %arg2 : i1 to i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %c0_i64, %0 : i64
    %2 = llvm.icmp "sle" %1, %0 : i64
    %3 = llvm.select %2, %0, %0 : i1, i64
    %4 = llvm.and %c-40_i64, %0 : i64
    %5 = llvm.icmp "ne" %4, %1 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.lshr %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.udiv %2, %c-34_i64 : i64
    %5 = llvm.xor %2, %c-41_i64 : i64
    %6 = llvm.ashr %4, %5 : i64
    %7 = llvm.srem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c15_i64 = arith.constant 15 : i64
    %false = arith.constant false
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.ashr %c13_i64, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.select %false, %c15_i64, %c-14_i64 : i1, i64
    %3 = llvm.icmp "ult" %arg2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.and %c-1_i64, %5 : i64
    %7 = llvm.xor %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %false = arith.constant false
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.xor %c0_i64, %arg0 : i64
    %1 = llvm.select %false, %arg0, %c-25_i64 : i1, i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.or %2, %2 : i64
    %5 = llvm.urem %4, %4 : i64
    %6 = llvm.sdiv %5, %0 : i64
    %7 = llvm.icmp "sge" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.srem %c-6_i64, %arg2 : i64
    %3 = llvm.icmp "ugt" %2, %c36_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %4, %c4_i64 : i64
    %6 = llvm.urem %c35_i64, %5 : i64
    %7 = llvm.icmp "ugt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c48_i64 = arith.constant 48 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.urem %c-30_i64, %arg0 : i64
    %1 = llvm.or %c13_i64, %arg1 : i64
    %2 = llvm.icmp "ule" %arg1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.xor %arg2, %c48_i64 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "eq" %6, %c-48_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.srem %c15_i64, %0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.lshr %3, %0 : i64
    %6 = llvm.sdiv %5, %1 : i64
    %7 = llvm.urem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.sdiv %2, %0 : i64
    %6 = llvm.select %1, %arg0, %5 : i1, i64
    %7 = llvm.ashr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.or %arg1, %arg2 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ugt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.ashr %c10_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg2, %arg2 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.icmp "ne" %3, %1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %false = arith.constant false
    %c1_i64 = arith.constant 1 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.select %false, %c1_i64, %c-19_i64 : i1, i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.and %c0_i64, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ne" %arg1, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.srem %arg1, %5 : i64
    %7 = llvm.icmp "slt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c6_i64 = arith.constant 6 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.xor %c-6_i64, %arg0 : i64
    %1 = llvm.or %0, %c49_i64 : i64
    %2 = llvm.xor %1, %c6_i64 : i64
    %3 = llvm.lshr %arg1, %arg1 : i64
    %4 = llvm.xor %c-32_i64, %c-33_i64 : i64
    %5 = llvm.ashr %4, %c48_i64 : i64
    %6 = llvm.or %3, %5 : i64
    %7 = llvm.icmp "slt" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.icmp "ne" %c-39_i64, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sgt" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %c13_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %c-21_i64 : i64
    %4 = llvm.select %3, %c-46_i64, %0 : i1, i64
    %5 = llvm.sdiv %4, %2 : i64
    %6 = llvm.srem %2, %arg1 : i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.select %0, %2, %arg0 : i1, i64
    %4 = llvm.trunc %0 : i1 to i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.lshr %5, %c-3_i64 : i64
    %7 = llvm.icmp "slt" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.icmp "slt" %c-10_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %c-48_i64, %c-39_i64 : i64
    %3 = llvm.lshr %2, %1 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.ashr %4, %2 : i64
    %6 = llvm.sdiv %c-43_i64, %5 : i64
    %7 = llvm.icmp "uge" %6, %5 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.zext %arg0 : i1 to i64
    %5 = llvm.urem %4, %3 : i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.icmp "ult" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.urem %c37_i64, %c-3_i64 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %arg1 : i64
    %5 = llvm.or %arg0, %arg2 : i64
    %6 = llvm.select %4, %3, %5 : i1, i64
    %7 = llvm.icmp "ule" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c36_i64 = arith.constant 36 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.or %c-6_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %c36_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %c-35_i64, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.lshr %0, %5 : i64
    %7 = llvm.icmp "ult" %c6_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c-13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.and %c27_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.select %arg1, %c-13_i64, %c-12_i64 : i1, i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.or %c-42_i64, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.icmp "ule" %4, %arg0 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %c-35_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %arg2, %arg1 : i64
    %1 = llvm.icmp "ule" %arg2, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.ashr %c40_i64, %2 : i64
    %5 = llvm.srem %c20_i64, %4 : i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.or %arg0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c48_i64 = arith.constant 48 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "ult" %c36_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c-38_i64 : i1, i64
    %2 = llvm.icmp "uge" %arg0, %arg1 : i64
    %3 = llvm.select %0, %c48_i64, %c-1_i64 : i1, i64
    %4 = llvm.udiv %c2_i64, %3 : i64
    %5 = llvm.and %4, %4 : i64
    %6 = llvm.select %2, %arg2, %5 : i1, i64
    %7 = llvm.icmp "sle" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c32_i64 = arith.constant 32 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "sle" %c32_i64, %c31_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "uge" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %4, %c15_i64 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c41_i64 = arith.constant 41 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.select %arg2, %0, %c28_i64 : i1, i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.urem %c41_i64, %0 : i64
    %6 = llvm.xor %4, %5 : i64
    %7 = llvm.icmp "sle" %6, %c-44_i64 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c9_i64 = arith.constant 9 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.ashr %c-12_i64, %arg0 : i64
    %1 = llvm.and %c50_i64, %0 : i64
    %2 = llvm.icmp "eq" %c9_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "slt" %3, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.lshr %5, %c46_i64 : i64
    %7 = llvm.icmp "sge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c29_i64 = arith.constant 29 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.srem %arg0, %c29_i64 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.srem %3, %c-43_i64 : i64
    %7 = llvm.icmp "sle" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.lshr %arg0, %c39_i64 : i64
    %1 = llvm.select %true, %arg1, %0 : i1, i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.select %3, %arg1, %arg0 : i1, i64
    %5 = llvm.lshr %4, %arg2 : i64
    %6 = llvm.xor %0, %5 : i64
    %7 = llvm.icmp "ule" %c-15_i64, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "eq" %c-18_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg0, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.xor %arg2, %c14_i64 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.lshr %5, %3 : i64
    %7 = llvm.xor %c-23_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %c-46_i64, %0 : i64
    %6 = llvm.or %arg1, %5 : i64
    %7 = llvm.urem %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.lshr %arg0, %c44_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.select %arg1, %0, %1 : i1, i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "sge" %arg0, %2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.icmp "ult" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.urem %arg0, %c36_i64 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.srem %c-50_i64, %arg2 : i64
    %4 = llvm.urem %c46_i64, %c-39_i64 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.urem %3, %5 : i64
    %7 = llvm.icmp "ne" %2, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %arg2, %0 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.trunc %arg0 : i1 to i64
    %3 = llvm.urem %0, %arg2 : i64
    %4 = llvm.srem %3, %3 : i64
    %5 = llvm.ashr %arg1, %4 : i64
    %6 = llvm.urem %2, %5 : i64
    %7 = llvm.icmp "sle" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.ashr %1, %c-12_i64 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "ult" %arg2, %c-21_i64 : i64
    %5 = llvm.select %4, %c15_i64, %c-22_i64 : i1, i64
    %6 = llvm.srem %3, %5 : i64
    %7 = llvm.udiv %0, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.lshr %0, %c49_i64 : i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.and %3, %arg0 : i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.lshr %c49_i64, %c22_i64 : i64
    %7 = llvm.and %5, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %true = arith.constant true
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.srem %c-18_i64, %arg0 : i64
    %1 = llvm.select %true, %0, %arg0 : i1, i64
    %2 = llvm.xor %1, %c3_i64 : i64
    %3 = llvm.xor %0, %0 : i64
    %4 = llvm.icmp "ugt" %arg1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.xor %1, %5 : i64
    %7 = llvm.select %true, %2, %6 : i1, i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %true = arith.constant true
    %c4_i64 = arith.constant 4 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "slt" %c4_i64, %c31_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %c4_i64, %1 : i64
    %3 = llvm.select %true, %2, %arg0 : i1, i64
    %4 = llvm.srem %arg0, %c-11_i64 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c48_i64 = arith.constant 48 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.srem %c48_i64, %c31_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "sgt" %c-8_i64, %c-28_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %c-14_i64, %c6_i64 : i64
    %7 = llvm.icmp "uge" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.xor %c6_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "ule" %c-34_i64, %1 : i64
    %3 = llvm.select %2, %arg0, %0 : i1, i64
    %4 = llvm.icmp "sle" %arg1, %c-34_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %3, %5 : i64
    %7 = llvm.and %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %c-48_i64, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %4, %2 : i64
    %6 = llvm.lshr %2, %arg1 : i64
    %7 = llvm.icmp "ne" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.ashr %c-27_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sext %1 : i1 to i64
    %6 = llvm.sdiv %arg2, %5 : i64
    %7 = llvm.lshr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %c-14_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %3, %1 : i64
    %5 = llvm.xor %4, %4 : i64
    %6 = llvm.or %4, %5 : i64
    %7 = llvm.icmp "uge" %arg0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.xor %c-8_i64, %2 : i64
    %4 = llvm.trunc %arg1 : i1 to i64
    %5 = llvm.icmp "ne" %4, %arg2 : i64
    %6 = llvm.zext %5 : i1 to i64
    %7 = llvm.urem %3, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "sgt" %c39_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %c8_i64, %arg0 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.srem %1, %2 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.lshr %2, %5 : i64
    %7 = llvm.xor %1, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c-22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %c25_i64 = arith.constant 25 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.select %true, %c25_i64, %c21_i64 : i1, i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.sdiv %c-22_i64, %c43_i64 : i64
    %3 = llvm.select %arg0, %1, %2 : i1, i64
    %4 = llvm.urem %3, %2 : i64
    %5 = llvm.select %arg0, %arg1, %1 : i1, i64
    %6 = llvm.xor %5, %1 : i64
    %7 = llvm.ashr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c14_i64 = arith.constant 14 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "uge" %c-12_i64, %c16_i64 : i64
    %1 = llvm.lshr %c8_i64, %c14_i64 : i64
    %2 = llvm.and %1, %c-24_i64 : i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    %5 = llvm.lshr %arg1, %c-7_i64 : i64
    %6 = llvm.select %arg0, %5, %arg2 : i1, i64
    %7 = llvm.icmp "ne" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.ashr %c-20_i64, %arg1 : i64
    %2 = llvm.icmp "ne" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %c15_i64, %c38_i64 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.or %c-11_i64, %0 : i64
    %2 = llvm.select %arg2, %arg1, %arg1 : i1, i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.srem %c-41_i64, %1 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.urem %4, %3 : i64
    %6 = llvm.or %0, %5 : i64
    %7 = llvm.icmp "ult" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.urem %arg1, %arg1 : i64
    %2 = llvm.icmp "ne" %c23_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.urem %5, %arg2 : i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.xor %arg0, %c15_i64 : i64
    %1 = llvm.sdiv %arg0, %c48_i64 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.urem %3, %1 : i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.icmp "ult" %5, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.and %c-17_i64, %c-46_i64 : i64
    %5 = llvm.icmp "sle" %c-7_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "ult" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c44_i64 = arith.constant 44 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %c44_i64, %c45_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.icmp "ne" %2, %c-24_i64 : i64
    %4 = llvm.icmp "ule" %c21_i64, %2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.select %3, %c21_i64, %5 : i1, i64
    %7 = llvm.icmp "slt" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %0, %arg1 : i64
    %4 = llvm.and %arg1, %3 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.or %4, %4 : i64
    %7 = llvm.icmp "slt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ult" %c31_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    %7 = llvm.zext %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %c-49_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "ult" %arg1, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.select %true, %5, %arg2 : i1, i64
    %7 = llvm.icmp "eq" %3, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c49_i64 = arith.constant 49 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.select %false, %c49_i64, %c12_i64 : i1, i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %4, %arg0 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sle" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.or %arg0, %c22_i64 : i64
    %1 = llvm.icmp "sge" %c32_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.and %3, %arg2 : i64
    %6 = llvm.sdiv %4, %5 : i64
    %7 = llvm.sdiv %2, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "sge" %c-19_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg0, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %3, %arg0 : i64
    %5 = llvm.ashr %4, %arg2 : i64
    %6 = llvm.udiv %1, %5 : i64
    %7 = llvm.icmp "uge" %6, %arg2 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %false = arith.constant false
    %c9_i64 = arith.constant 9 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %c-7_i64, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.select %false, %c50_i64, %0 : i1, i64
    %4 = llvm.zext %arg1 : i1 to i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.xor %2, %5 : i64
    %7 = llvm.ashr %c9_i64, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c38_i64 = arith.constant 38 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.select %arg1, %arg0, %c-25_i64 : i1, i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.srem %c38_i64, %c-34_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sext %arg1 : i1 to i64
    %6 = llvm.udiv %5, %c-25_i64 : i64
    %7 = llvm.icmp "eq" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %c39_i64, %0 : i64
    %2 = llvm.icmp "sle" %0, %arg1 : i64
    %3 = llvm.ashr %arg2, %arg1 : i64
    %4 = llvm.select %2, %arg2, %3 : i1, i64
    %5 = llvm.select %1, %4, %c-34_i64 : i1, i64
    %6 = llvm.urem %c12_i64, %0 : i64
    %7 = llvm.icmp "ult" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.and %c-12_i64, %c29_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "uge" %2, %c-20_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.icmp "sge" %4, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.trunc %arg2 : i1 to i64
    %1 = llvm.urem %c-46_i64, %0 : i64
    %2 = llvm.ashr %1, %c25_i64 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.xor %arg0, %4 : i64
    %6 = llvm.icmp "eq" %c-33_i64, %5 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.srem %c11_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.ashr %2, %c-11_i64 : i64
    %4 = llvm.urem %c34_i64, %c27_i64 : i64
    %5 = llvm.urem %1, %4 : i64
    %6 = llvm.and %3, %5 : i64
    %7 = llvm.icmp "sge" %1, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c-8_i64 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.lshr %arg0, %arg0 : i64
    %4 = llvm.srem %3, %c33_i64 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.icmp "ult" %5, %arg1 : i64
    %7 = llvm.trunc %6 : i1 to i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c26_i64 = arith.constant 26 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.udiv %c47_i64, %c-22_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.and %c26_i64, %c8_i64 : i64
    %4 = llvm.and %arg2, %3 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.udiv %2, %5 : i64
    %7 = llvm.icmp "ne" %0, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "ne" %c14_i64, %arg2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    %7 = llvm.lshr %4, %6 : i64
    return %7 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.or %c21_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %2, %arg0, %c20_i64 : i1, i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.and %arg2, %1 : i64
    %7 = llvm.icmp "sgt" %5, %6 : i64
    return %7 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.udiv %c-29_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.xor %3, %c-4_i64 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.icmp "sle" %2, %6 : i64
    return %7 : i1
  }
}
// -----
