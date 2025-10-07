module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.select %false, %1, %arg0 : i1, i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    %4 = llvm.select %3, %arg0, %arg1 : i1, i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.xor %c41_i64, %c-8_i64 : i64
    %1 = llvm.ashr %0, %c-33_i64 : i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "ule" %c-24_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c36_i64 = arith.constant 36 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.urem %c36_i64, %c46_i64 : i64
    %1 = llvm.lshr %c-10_i64, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.xor %2, %c40_i64 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.icmp "ne" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg0, %arg0 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %c42_i64 : i64
    %2 = llvm.ashr %0, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.ashr %arg1, %arg1 : i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.or %arg0, %c20_i64 : i64
    %1 = llvm.udiv %0, %c-47_i64 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.srem %c-12_i64, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "ne" %c-25_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %true = arith.constant true
    %false = arith.constant false
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.select %false, %c-3_i64, %arg0 : i1, i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ne" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg2, %arg1 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.or %3, %c-3_i64 : i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-16_i64 = arith.constant -16 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.xor %c-34_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.srem %c-16_i64, %3 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.ashr %arg0, %c-48_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ne" %1, %c15_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %0, %arg0 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.sdiv %arg1, %arg0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c39_i64 = arith.constant 39 : i64
    %false = arith.constant false
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.select %false, %c-34_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ne" %c39_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.icmp "ule" %c-27_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.select %true, %arg0, %c1_i64 : i1, i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "ne" %c39_i64, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.sdiv %1, %c43_i64 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "sle" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.or %c44_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.select %arg1, %2, %2 : i1, i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.select %true, %0, %arg0 : i1, i64
    %2 = llvm.or %arg1, %arg0 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.select %3, %2, %arg2 : i1, i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    %3 = llvm.select %2, %arg0, %c-23_i64 : i1, i64
    %4 = llvm.icmp "ult" %3, %arg1 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-37_i64 = arith.constant -37 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.and %c25_i64, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.icmp "eq" %c-37_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %true = arith.constant true
    %c37_i64 = arith.constant 37 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.ashr %arg0, %c-48_i64 : i64
    %1 = llvm.xor %0, %c37_i64 : i64
    %2 = llvm.select %true, %arg0, %arg1 : i1, i64
    %3 = llvm.urem %2, %c0_i64 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg1, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.sdiv %c42_i64, %0 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "slt" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c41_i64 = arith.constant 41 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.ashr %0, %c41_i64 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.ashr %arg1, %c14_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.xor %arg1, %c-45_i64 : i64
    %1 = llvm.srem %0, %c-29_i64 : i64
    %2 = llvm.udiv %c-40_i64, %1 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.xor %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.udiv %1, %c33_i64 : i64
    %3 = llvm.icmp "sle" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.urem %0, %arg2 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "eq" %0, %c-45_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.xor %c30_i64, %3 : i64
    %5 = llvm.icmp "uge" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.sdiv %c32_i64, %c-28_i64 : i64
    %1 = llvm.xor %c-41_i64, %0 : i64
    %2 = llvm.urem %0, %0 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.sdiv %3, %arg0 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.icmp "sgt" %c-10_i64, %c-50_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %arg0, %0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.and %c-9_i64, %arg0 : i64
    %1 = llvm.lshr %c-46_i64, %c-28_i64 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.udiv %c3_i64, %0 : i64
    %2 = llvm.lshr %arg0, %c7_i64 : i64
    %3 = llvm.icmp "uge" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.and %c-16_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.lshr %arg2, %1 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c19_i64 = arith.constant 19 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %c1_i64, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.xor %c19_i64, %c-15_i64 : i64
    %4 = llvm.xor %3, %1 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.sdiv %c-47_i64, %arg0 : i64
    %3 = llvm.urem %c44_i64, %0 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.xor %arg0, %c-27_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c-50_i64, %0 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.select %arg0, %1, %1 : i1, i64
    %3 = llvm.icmp "sge" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c-13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %c-26_i64 = arith.constant -26 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %c-26_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %c14_i64, %2 : i64
    %4 = llvm.select %false, %c-13_i64, %arg0 : i1, i64
    %5 = llvm.select %3, %4, %c38_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.lshr %arg0, %c-23_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.sdiv %1, %c1_i64 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "sge" %c-11_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.ashr %arg0, %c-25_i64 : i64
    %3 = llvm.icmp "sgt" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %true, %c-9_i64, %0 : i1, i64
    %2 = llvm.icmp "ne" %arg1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.urem %arg0, %c22_i64 : i64
    %1 = llvm.icmp "uge" %c-9_i64, %0 : i64
    %2 = llvm.and %arg0, %c-33_i64 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.udiv %3, %c-14_i64 : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c24_i64 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.icmp "ule" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.ashr %c26_i64, %arg1 : i64
    %1 = llvm.sdiv %c0_i64, %arg2 : i64
    %2 = llvm.ashr %arg2, %1 : i64
    %3 = llvm.select %arg0, %0, %2 : i1, i64
    %4 = llvm.or %3, %0 : i64
    %5 = llvm.or %4, %0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %arg2, %c-40_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %c18_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.udiv %c20_i64, %c21_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.ashr %0, %0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.or %3, %3 : i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "eq" %c21_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg0, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.udiv %4, %3 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.and %0, %c-20_i64 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.sdiv %arg2, %arg0 : i64
    %4 = llvm.srem %arg2, %3 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.or %arg0, %c29_i64 : i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %c4_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.srem %3, %c25_i64 : i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %c2_i64, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.xor %c-2_i64, %1 : i64
    %3 = llvm.icmp "ugt" %arg1, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.xor %arg0, %c-48_i64 : i64
    %1 = llvm.icmp "ugt" %0, %c-36_i64 : i64
    %2 = llvm.icmp "slt" %0, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %1, %3, %arg0 : i1, i64
    %5 = llvm.icmp "ugt" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ne" %c-49_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %c-26_i64 : i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %arg0, %c48_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.xor %0, %c10_i64 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c7_i64 = arith.constant 7 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %arg0, %c-1_i64 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.udiv %c7_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.xor %c49_i64, %c-6_i64 : i64
    %1 = llvm.icmp "uge" %0, %c-2_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %c20_i64, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.lshr %c13_i64, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.and %arg0, %c-19_i64 : i64
    %1 = llvm.lshr %c41_i64, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.or %arg1, %arg2 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.urem %4, %c-4_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.and %arg0, %arg0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %c-6_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.urem %c34_i64, %3 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %true = arith.constant true
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %c13_i64, %0 : i64
    %2 = llvm.select %true, %1, %0 : i1, i64
    %3 = llvm.srem %arg2, %c-28_i64 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %c1_i64, %c-19_i64 : i64
    %4 = llvm.sdiv %3, %c-38_i64 : i64
    %5 = llvm.srem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.select %true, %arg1, %arg2 : i1, i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.udiv %arg0, %c-22_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sext %2 : i1 to i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "sgt" %c-20_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %arg2, %1 : i64
    %3 = llvm.sdiv %2, %c9_i64 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.or %c-38_i64, %0 : i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %3, %3 : i64
    %5 = llvm.icmp "uge" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %true = arith.constant true
    %c-48_i64 = arith.constant -48 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.and %c-48_i64, %c18_i64 : i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.udiv %c14_i64, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "slt" %c-24_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %2, %3, %0 : i1, i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.sdiv %c44_i64, %c47_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "sle" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "uge" %0, %c-2_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c-12_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c28_i64 = arith.constant 28 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.and %c28_i64, %c2_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "sge" %c44_i64, %1 : i64
    %3 = llvm.select %arg0, %arg1, %1 : i1, i64
    %4 = llvm.select %2, %1, %3 : i1, i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c-46_i64 = arith.constant -46 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.and %c-46_i64, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "sle" %4, %c2_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.or %c-44_i64, %1 : i64
    %3 = llvm.srem %c12_i64, %1 : i64
    %4 = llvm.udiv %c-3_i64, %3 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.select %0, %1, %c41_i64 : i1, i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "ule" %c10_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.and %arg0, %c43_i64 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %c29_i64, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c3_i64 = arith.constant 3 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.and %c21_i64, %c-27_i64 : i64
    %1 = llvm.icmp "uge" %arg0, %arg0 : i64
    %2 = llvm.select %1, %c3_i64, %c-39_i64 : i1, i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.sdiv %3, %arg1 : i64
    %5 = llvm.urem %4, %3 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.srem %c-24_i64, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.and %0, %arg0 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.ashr %arg0, %c-20_i64 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.xor %arg2, %arg1 : i64
    %3 = llvm.icmp "sge" %c-6_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.srem %1, %arg1 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "ugt" %c-21_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %c-30_i64 : i64
    %3 = llvm.icmp "slt" %2, %c-8_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c50_i64 = arith.constant 50 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "slt" %c-24_i64, %c9_i64 : i64
    %1 = llvm.select %0, %arg0, %c-30_i64 : i1, i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    %3 = llvm.select %2, %arg1, %arg1 : i1, i64
    %4 = llvm.sdiv %c35_i64, %3 : i64
    %5 = llvm.icmp "ugt" %c50_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c42_i64 = arith.constant 42 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.ashr %c30_i64, %0 : i64
    %2 = llvm.srem %c42_i64, %1 : i64
    %3 = llvm.select %arg2, %arg1, %0 : i1, i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "eq" %c46_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.srem %arg0, %c-7_i64 : i64
    %1 = llvm.icmp "sge" %c49_i64, %c-44_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    %5 = llvm.select %4, %2, %c0_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "sge" %c39_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %c-47_i64, %c-5_i64 : i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    %5 = llvm.icmp "sle" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.icmp "sgt" %c-33_i64, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.or %4, %0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c27_i64 = arith.constant 27 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.srem %c31_i64, %2 : i64
    %4 = llvm.udiv %c27_i64, %3 : i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.and %c-25_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %c13_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %c23_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %c-11_i64, %0 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.udiv %c41_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %c6_i64 : i64
    %2 = llvm.urem %arg1, %arg0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "sgt" %c-34_i64, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %c-17_i64, %arg0 : i64
    %2 = llvm.or %arg1, %arg0 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.ashr %3, %2 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %1, %2, %arg0 : i1, i64
    %4 = llvm.urem %3, %c-23_i64 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.xor %c2_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.icmp "eq" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.udiv %c-11_i64, %c-30_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c-30_i64 = arith.constant -30 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.srem %c0_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.select %1, %c-30_i64, %3 : i1, i64
    %5 = llvm.udiv %4, %3 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.srem %c24_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %c-28_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %arg1, %arg1 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.select %4, %arg2, %arg2 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %c8_i64, %0 : i64
    %2 = llvm.select %true, %0, %0 : i1, i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.urem %c-47_i64, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.or %c32_i64, %3 : i64
    %5 = llvm.icmp "ult" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %false = arith.constant false
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.select %false, %arg1, %c18_i64 : i1, i64
    %1 = llvm.icmp "eq" %c-5_i64, %0 : i64
    %2 = llvm.ashr %0, %arg2 : i64
    %3 = llvm.select %1, %2, %arg0 : i1, i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.icmp "eq" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.lshr %c-43_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.xor %3, %2 : i64
    %5 = llvm.urem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.icmp "ult" %c46_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %c-17_i64, %2 : i64
    %4 = llvm.or %0, %arg0 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c42_i64 = arith.constant 42 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.select %arg0, %c-9_i64, %arg1 : i1, i64
    %1 = llvm.sdiv %0, %c9_i64 : i64
    %2 = llvm.icmp "sge" %c-5_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %c42_i64, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "ugt" %c17_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %c37_i64 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.and %3, %arg0 : i64
    %5 = llvm.srem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.select %arg0, %0, %c-26_i64 : i1, i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-41_i64 = arith.constant -41 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %c-41_i64, %0 : i64
    %2 = llvm.icmp "ugt" %c-11_i64, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %c34_i64, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.udiv %c-29_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.xor %2, %0 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.ashr %c-18_i64, %c4_i64 : i64
    %1 = llvm.icmp "ugt" %c49_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sdiv %c-10_i64, %c27_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %arg1, %c38_i64 : i64
    %3 = llvm.lshr %arg2, %arg0 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.urem %c46_i64, %c-35_i64 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.ashr %c18_i64, %c-23_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %arg2, %c-26_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "slt" %c-9_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sext %2 : i1 to i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %c-2_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %0, %arg0 : i64
    %4 = llvm.or %c-15_i64, %3 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.sdiv %2, %c-24_i64 : i64
    %4 = llvm.and %3, %c2_i64 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.udiv %c29_i64, %arg1 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    %3 = llvm.select %2, %arg1, %arg1 : i1, i64
    %4 = llvm.xor %3, %c-18_i64 : i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %c-27_i64 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.urem %2, %c-37_i64 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.and %c-29_i64, %arg0 : i64
    %1 = llvm.ashr %0, %c-48_i64 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.or %c-1_i64, %2 : i64
    %4 = llvm.icmp "ule" %c-12_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "ne" %c14_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %c-43_i64 : i64
    %3 = llvm.urem %arg0, %arg1 : i64
    %4 = llvm.select %2, %3, %c-27_i64 : i1, i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.or %c38_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %c-15_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.icmp "ne" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.srem %arg0, %c-1_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.urem %arg1, %arg1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "sgt" %4, %c-18_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "sgt" %c23_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.xor %c-28_i64, %arg0 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.or %c-19_i64, %arg0 : i64
    %1 = llvm.lshr %c-30_i64, %arg2 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %4, %c-7_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.udiv %c27_i64, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %c-21_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.urem %c8_i64, %c-24_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.urem %1, %c-44_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.icmp "sle" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.urem %c-46_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %c13_i64 : i64
    %2 = llvm.select %1, %0, %arg1 : i1, i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "ugt" %c-42_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.select %arg0, %c-34_i64, %arg1 : i1, i64
    %1 = llvm.urem %0, %c-22_i64 : i64
    %2 = llvm.icmp "slt" %0, %c6_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.srem %4, %0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %false = arith.constant false
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "eq" %arg1, %c36_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %false, %arg1, %1 : i1, i64
    %3 = llvm.select %arg0, %1, %2 : i1, i64
    %4 = llvm.lshr %2, %c-9_i64 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c-20_i64 = arith.constant -20 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg1, %arg2 : i1, i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.xor %arg1, %c-36_i64 : i64
    %4 = llvm.lshr %c-20_i64, %3 : i64
    %5 = llvm.lshr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.xor %c27_i64, %c-32_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %0, %c-20_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %1, %arg2, %0 : i1, i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "sgt" %c-10_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %0, %c-17_i64 : i64
    %2 = llvm.urem %arg0, %arg0 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.xor %c10_i64, %arg0 : i64
    %1 = llvm.udiv %c-6_i64, %0 : i64
    %2 = llvm.or %arg0, %arg1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.select %3, %0, %2 : i1, i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c10_i64 = arith.constant 10 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "uge" %c17_i64, %c-16_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %c10_i64 : i64
    %3 = llvm.icmp "sge" %2, %1 : i64
    %4 = llvm.select %3, %c-10_i64, %c-45_i64 : i1, i64
    %5 = llvm.or %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.sdiv %c36_i64, %c9_i64 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.select %arg1, %arg2, %1 : i1, i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.select %arg0, %c-11_i64, %c-38_i64 : i1, i64
    %1 = llvm.icmp "ule" %c9_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.urem %arg0, %c30_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %1 : i64
    %5 = llvm.ashr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.or %c-39_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %c-19_i64 : i64
    %2 = llvm.icmp "sle" %1, %c25_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.select %4, %c42_i64, %1 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ult" %c-11_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %3, %1 : i64
    %5 = llvm.or %c44_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.xor %c28_i64, %c-38_i64 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.icmp "sle" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.udiv %arg0, %c-40_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.urem %c-49_i64, %c9_i64 : i64
    %4 = llvm.select %2, %arg2, %3 : i1, i64
    %5 = llvm.icmp "eq" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "ne" %arg0, %c-47_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.icmp "uge" %c0_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %c-18_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.urem %c34_i64, %c18_i64 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.select %arg0, %arg1, %c39_i64 : i1, i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.icmp "slt" %c39_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %arg1, %0 : i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %c-25_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sgt" %arg1, %c-3_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.select %true, %c25_i64, %2 : i1, i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %c12_i64 : i64
    %2 = llvm.sdiv %c36_i64, %1 : i64
    %3 = llvm.select %false, %2, %arg0 : i1, i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.ashr %c22_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %c-21_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %c46_i64, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.lshr %c27_i64, %arg0 : i64
    %1 = llvm.or %0, %c-42_i64 : i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %arg0, %1 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.udiv %c-3_i64, %c-10_i64 : i64
    %1 = llvm.urem %c37_i64, %0 : i64
    %2 = llvm.urem %0, %0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.or %arg0, %c-10_i64 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "sgt" %c34_i64, %c-24_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.udiv %1, %c10_i64 : i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "sgt" %c29_i64, %c-35_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "sgt" %c-11_i64, %arg0 : i64
    %1 = llvm.xor %arg2, %arg1 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.select %0, %c-17_i64, %2 : i1, i64
    %4 = llvm.udiv %arg0, %c-16_i64 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %arg2, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.and %arg1, %3 : i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "sge" %c41_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %3, %arg1 : i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.lshr %c21_i64, %arg1 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.icmp "ule" %c-4_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.xor %arg0, %arg0 : i64
    %3 = llvm.icmp "ne" %arg2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %arg1, %arg2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "uge" %c13_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %c-32_i64, %c-35_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.ashr %1, %c-34_i64 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.xor %1, %c19_i64 : i64
    %3 = llvm.sdiv %0, %arg1 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.or %c1_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.udiv %0, %arg1 : i64
    %3 = llvm.icmp "ugt" %c-25_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i64
    %1 = llvm.and %c30_i64, %arg2 : i64
    %2 = llvm.icmp "sgt" %c9_i64, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.or %c7_i64, %arg1 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.select %2, %0, %c-42_i64 : i1, i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.udiv %c-48_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %c21_i64 : i1, i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.urem %arg2, %c-47_i64 : i64
    %4 = llvm.lshr %3, %c-17_i64 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "slt" %c44_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.and %1, %c-33_i64 : i64
    %3 = llvm.icmp "ne" %arg1, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %0, %2, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-7_i64 = arith.constant -7 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.or %c23_i64, %arg0 : i64
    %1 = llvm.xor %c-38_i64, %0 : i64
    %2 = llvm.and %c-7_i64, %arg1 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %arg2 : i1, i64
    %3 = llvm.ashr %c11_i64, %2 : i64
    %4 = llvm.or %c-17_i64, %2 : i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %arg0, %c25_i64 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.urem %c-33_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.and %c-46_i64, %arg2 : i64
    %4 = llvm.urem %c-16_i64, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c42_i64 = arith.constant 42 : i64
    %true = arith.constant true
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.urem %c-8_i64, %arg1 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.select %true, %c42_i64, %c-24_i64 : i1, i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-18_i64 = arith.constant -18 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "slt" %c-18_i64, %1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.select %2, %3, %c45_i64 : i1, i64
    %5 = llvm.icmp "sgt" %4, %c-30_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %c38_i64 = arith.constant 38 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.udiv %c-38_i64, %c-22_i64 : i64
    %1 = llvm.srem %c-31_i64, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.xor %c17_i64, %2 : i64
    %4 = llvm.icmp "ule" %c38_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.xor %arg0, %arg0 : i64
    %3 = llvm.select %1, %2, %arg1 : i1, i64
    %4 = llvm.select %1, %0, %3 : i1, i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %c48_i64, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.sdiv %c31_i64, %arg2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "sge" %c35_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %c35_i64 : i64
    %3 = llvm.icmp "ugt" %1, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c9_i64 = arith.constant 9 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "sle" %c-8_i64, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %c45_i64, %1 : i64
    %3 = llvm.select %arg2, %c9_i64, %c-5_i64 : i1, i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.sdiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.urem %c-33_i64, %c11_i64 : i64
    %1 = llvm.icmp "eq" %c-44_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %c42_i64, %c31_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %c1_i64, %0 : i64
    %2 = llvm.udiv %1, %c-50_i64 : i64
    %3 = llvm.sdiv %1, %0 : i64
    %4 = llvm.udiv %c40_i64, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "ugt" %c-13_i64, %c-30_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %c3_i64, %1 : i64
    %3 = llvm.select %2, %1, %1 : i1, i64
    %4 = llvm.udiv %1, %arg0 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c10_i64 = arith.constant 10 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c46_i64 : i64
    %2 = llvm.icmp "eq" %c10_i64, %arg0 : i64
    %3 = llvm.select %2, %arg1, %c-37_i64 : i1, i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c7_i64 = arith.constant 7 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.select %false, %arg2, %c7_i64 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.xor %c-3_i64, %3 : i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %c7_i64 : i1, i64
    %3 = llvm.urem %0, %0 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %c-36_i64, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c9_i64 : i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %1, %arg1 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.sdiv %arg0, %c-26_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    %3 = llvm.lshr %arg1, %1 : i64
    %4 = llvm.select %2, %3, %arg1 : i1, i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %4, %c35_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c38_i64 = arith.constant 38 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.sdiv %c36_i64, %arg1 : i64
    %1 = llvm.sdiv %arg1, %c38_i64 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.and %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %c38_i64, %0 : i1, i64
    %2 = llvm.sdiv %0, %0 : i64
    %3 = llvm.urem %arg2, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.ashr %c-7_i64, %arg2 : i64
    %4 = llvm.urem %arg1, %3 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %c-37_i64, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.lshr %3, %c15_i64 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.or %arg0, %c-32_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.or %arg0, %arg0 : i64
    %3 = llvm.lshr %c-39_i64, %2 : i64
    %4 = llvm.select %1, %c32_i64, %3 : i1, i64
    %5 = llvm.urem %c-25_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "eq" %2, %c-17_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.ashr %arg0, %c-27_i64 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    %5 = llvm.select %4, %arg2, %c-26_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c35_i64 = arith.constant 35 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.or %c44_i64, %arg0 : i64
    %1 = llvm.xor %c35_i64, %0 : i64
    %2 = llvm.urem %0, %0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %4, %c-39_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "slt" %c-20_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.ashr %2, %arg0 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.ashr %c-12_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %c-15_i64 = arith.constant -15 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.select %true, %c-15_i64, %c-8_i64 : i1, i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ult" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.ashr %c34_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.udiv %0, %arg2 : i64
    %3 = llvm.icmp "sgt" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.urem %c27_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.select %true, %0, %arg1 : i1, i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.select %arg2, %c48_i64, %c-11_i64 : i1, i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.urem %3, %2 : i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %c32_i64, %arg0 : i64
    %2 = llvm.select %false, %arg1, %1 : i1, i64
    %3 = llvm.udiv %2, %c-2_i64 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.and %arg1, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.urem %1, %arg2 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "ugt" %4, %c-44_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.xor %c-22_i64, %c-6_i64 : i64
    %1 = llvm.xor %c-2_i64, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.zext %arg0 : i1 to i64
    %5 = llvm.select %3, %4, %1 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.lshr %c-44_i64, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.udiv %arg1, %c-34_i64 : i64
    %3 = llvm.xor %arg1, %arg1 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "uge" %c30_i64, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-46_i64 = arith.constant -46 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.or %c39_i64, %arg0 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.select %false, %arg1, %arg2 : i1, i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.icmp "ult" %c-46_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.urem %c-19_i64, %c27_i64 : i64
    %1 = llvm.and %c31_i64, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "sge" %c-41_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %c-14_i64, %arg1 : i64
    %3 = llvm.ashr %c-30_i64, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.sdiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-50_i64 = arith.constant -50 : i64
    %true = arith.constant true
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.select %true, %c47_i64, %arg0 : i1, i64
    %1 = llvm.ashr %c-50_i64, %0 : i64
    %2 = llvm.srem %c-7_i64, %1 : i64
    %3 = llvm.xor %c7_i64, %2 : i64
    %4 = llvm.and %arg1, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.zext %arg1 : i1 to i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %c-13_i64, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.urem %3, %arg0 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c41_i64 = arith.constant 41 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.sdiv %c41_i64, %c19_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %c25_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.udiv %c8_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sle" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.urem %c4_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c-36_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.xor %3, %arg0 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ugt" %c48_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.udiv %3, %c-4_i64 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.and %0, %c-19_i64 : i64
    %2 = llvm.icmp "sle" %arg1, %c21_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.select %4, %1, %3 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "eq" %arg0, %c-49_i64 : i64
    %1 = llvm.select %0, %arg0, %c14_i64 : i1, i64
    %2 = llvm.and %arg0, %arg1 : i64
    %3 = llvm.icmp "uge" %2, %c-43_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.lshr %c39_i64, %0 : i64
    %3 = llvm.icmp "eq" %2, %c40_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %c13_i64 : i64
    %3 = llvm.ashr %arg0, %arg1 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %c-9_i64, %arg0 : i1, i64
    %3 = llvm.sdiv %2, %c-10_i64 : i64
    %4 = llvm.xor %3, %arg0 : i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c44_i64 = arith.constant 44 : i64
    %true = arith.constant true
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.select %true, %arg0, %c40_i64 : i1, i64
    %1 = llvm.or %0, %c44_i64 : i64
    %2 = llvm.xor %arg2, %c26_i64 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.urem %c-1_i64, %3 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.lshr %c-43_i64, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c23_i64 = arith.constant 23 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.or %c35_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.select %arg1, %c-11_i64, %1 : i1, i64
    %5 = llvm.select %3, %c23_i64, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c10_i64 = arith.constant 10 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.select %arg0, %arg1, %c36_i64 : i1, i64
    %1 = llvm.xor %c-5_i64, %arg2 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %c10_i64, %3 : i64
    %5 = llvm.icmp "ult" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.urem %c16_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %arg1, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %1, %arg0, %c-40_i64 : i1, i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "uge" %c-9_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sext %2 : i1 to i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.select %arg2, %c24_i64, %arg1 : i1, i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %c42_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "ne" %c48_i64, %c30_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %arg1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.lshr %2, %arg2 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c6_i64 = arith.constant 6 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.sdiv %c36_i64, %c-25_i64 : i64
    %1 = llvm.icmp "uge" %c6_i64, %0 : i64
    %2 = llvm.udiv %0, %0 : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    %4 = llvm.udiv %c-33_i64, %0 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.urem %c1_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.sdiv %c17_i64, %1 : i64
    %3 = llvm.icmp "ult" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "ult" %arg0, %c-39_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.xor %arg0, %arg1 : i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c47_i64 : i1, i64
    %2 = llvm.srem %arg0, %arg1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.xor %arg0, %c50_i64 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.sdiv %arg0, %c-15_i64 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.ashr %c-4_i64, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.sdiv %c-23_i64, %2 : i64
    %4 = llvm.udiv %2, %arg2 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-43_i64 = arith.constant -43 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.lshr %c21_i64, %arg1 : i64
    %1 = llvm.udiv %c-43_i64, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.select %false, %c50_i64, %arg0 : i1, i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.ashr %c11_i64, %c-34_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.urem %arg0, %c-33_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.urem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %arg0, %c-42_i64 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "eq" %arg0, %c3_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %arg1, %1, %1 : i1, i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.and %c-24_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.udiv %arg2, %c19_i64 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %c-40_i64 = arith.constant -40 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.lshr %c-40_i64, %c30_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c41_i64 = arith.constant 41 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %arg1, %arg1 : i64
    %2 = llvm.select %arg0, %1, %arg2 : i1, i64
    %3 = llvm.or %2, %c-44_i64 : i64
    %4 = llvm.lshr %c41_i64, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.ashr %c44_i64, %c-34_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.and %c-27_i64, %2 : i64
    %4 = llvm.trunc %arg1 : i1 to i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %arg1, %arg2 : i64
    %4 = llvm.udiv %3, %2 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %1, %arg0, %2 : i1, i64
    %4 = llvm.xor %c-20_i64, %c-20_i64 : i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c11_i64 = arith.constant 11 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sge" %c11_i64, %c27_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %4, %2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.srem %c-17_i64, %c-39_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.lshr %0, %0 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg1 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.xor %arg0, %c-23_i64 : i64
    %1 = llvm.select %arg2, %0, %arg0 : i1, i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %c-49_i64 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ult" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c27_i64 = arith.constant 27 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.lshr %c28_i64, %arg0 : i64
    %1 = llvm.udiv %c27_i64, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.udiv %c-13_i64, %2 : i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.sdiv %c34_i64, %c-35_i64 : i64
    %1 = llvm.srem %0, %c-32_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.icmp "ugt" %arg0, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c5_i64 = arith.constant 5 : i64
    %c6_i64 = arith.constant 6 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.xor %c6_i64, %c7_i64 : i64
    %1 = llvm.icmp "sge" %c5_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %c12_i64 : i64
    %4 = llvm.sext %1 : i1 to i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "eq" %c-23_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %3, %1 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %c-19_i64, %0 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %false = arith.constant false
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.select %false, %c-19_i64, %arg0 : i1, i64
    %1 = llvm.urem %c0_i64, %0 : i64
    %2 = llvm.srem %arg2, %1 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.lshr %3, %arg1 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.lshr %c-22_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %c49_i64 : i64
    %2 = llvm.lshr %arg0, %c-36_i64 : i64
    %3 = llvm.or %arg2, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c-41_i64 = arith.constant -41 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.select %false, %arg2, %arg1 : i1, i64
    %2 = llvm.select %true, %arg0, %c-41_i64 : i1, i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.sdiv %3, %c0_i64 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sdiv %arg0, %c-33_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "ugt" %arg2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.lshr %arg0, %c-1_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "sle" %c-2_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "sle" %arg0, %c29_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.and %4, %c-50_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "ugt" %c-14_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %c15_i64, %1 : i64
    %3 = llvm.icmp "sgt" %c-40_i64, %arg0 : i64
    %4 = llvm.select %3, %c-40_i64, %c39_i64 : i1, i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.urem %c-44_i64, %c20_i64 : i64
    %1 = llvm.lshr %c-40_i64, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.icmp "ule" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.xor %arg0, %c42_i64 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.xor %3, %arg2 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "sgt" %c49_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "sle" %c17_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "eq" %c-32_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c38_i64 = arith.constant 38 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %c38_i64, %0 : i64
    %2 = llvm.xor %arg1, %c27_i64 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.sdiv %3, %arg2 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.xor %c33_i64, %2 : i64
    %4 = llvm.xor %0, %arg1 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.udiv %c-39_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.icmp "slt" %c-26_i64, %c21_i64 : i64
    %3 = llvm.select %2, %arg0, %c-22_i64 : i1, i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.select %1, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %c32_i64 : i64
    %2 = llvm.srem %c-31_i64, %1 : i64
    %3 = llvm.icmp "ugt" %2, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "slt" %c-2_i64, %c11_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg1, %arg1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.or %3, %c12_i64 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.sdiv %c35_i64, %2 : i64
    %4 = llvm.urem %c29_i64, %3 : i64
    %5 = llvm.icmp "ne" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %3, %c19_i64 : i64
    %5 = llvm.icmp "ule" %c-29_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %true = arith.constant true
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.srem %c-37_i64, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.select %true, %0, %arg1 : i1, i64
    %4 = llvm.urem %arg2, %c42_i64 : i64
    %5 = llvm.select %2, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %c-40_i64, %0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c38_i64 = arith.constant 38 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ule" %c-13_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.udiv %1, %c1_i64 : i64
    %3 = llvm.xor %arg0, %arg0 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "slt" %c38_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %true = arith.constant true
    %c-8_i64 = arith.constant -8 : i64
    %c45_i64 = arith.constant 45 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.lshr %c45_i64, %c8_i64 : i64
    %1 = llvm.udiv %arg0, %c-8_i64 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.urem %2, %c29_i64 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "sgt" %c-38_i64, %c44_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.icmp "sle" %1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %c-26_i64, %arg2 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "slt" %c-31_i64, %c36_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.select %0, %c-33_i64, %1 : i1, i64
    %3 = llvm.trunc %arg0 : i1 to i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.srem %c50_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg1 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.lshr %4, %c49_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "slt" %c-7_i64, %c26_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.ashr %3, %2 : i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %true, %arg1, %c39_i64 : i1, i64
    %2 = llvm.or %1, %c2_i64 : i64
    %3 = llvm.srem %1, %arg2 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.or %arg0, %c-28_i64 : i64
    %1 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %2 = llvm.icmp "sge" %1, %c-4_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sle" %c-10_i64, %c42_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.trunc %arg2 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.icmp "sle" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.sdiv %c1_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.xor %arg2, %c-4_i64 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c44_i64 = arith.constant 44 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.xor %c44_i64, %c15_i64 : i64
    %1 = llvm.lshr %c40_i64, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.xor %arg1, %1 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c11_i64 = arith.constant 11 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %c11_i64, %0 : i64
    %2 = llvm.srem %c-45_i64, %1 : i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.udiv %3, %c12_i64 : i64
    %5 = llvm.icmp "ult" %c34_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %c-29_i64, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.srem %c2_i64, %2 : i64
    %4 = llvm.and %arg1, %0 : i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.udiv %c-47_i64, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.xor %arg2, %arg0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.srem %arg1, %0 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.urem %arg0, %c-28_i64 : i64
    %1 = llvm.udiv %c-29_i64, %arg1 : i64
    %2 = llvm.xor %c-19_i64, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.ashr %c11_i64, %3 : i64
    %5 = llvm.udiv %4, %arg2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.sdiv %c24_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.udiv %arg2, %arg0 : i64
    %4 = llvm.srem %3, %1 : i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %true = arith.constant true
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c18_i64 : i1, i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.udiv %3, %c31_i64 : i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-50_i64 = arith.constant -50 : i64
    %true = arith.constant true
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %true, %arg0, %c20_i64 : i1, i64
    %1 = llvm.or %0, %c-50_i64 : i64
    %2 = llvm.urem %1, %c22_i64 : i64
    %3 = llvm.icmp "sgt" %1, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.and %c-44_i64, %c-37_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %4, %arg1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.lshr %2, %c33_i64 : i64
    %4 = llvm.zext %arg1 : i1 to i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c-19_i64 = arith.constant -19 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.icmp "ule" %c-19_i64, %3 : i64
    %5 = llvm.select %4, %arg2, %c3_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.ashr %c25_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %c-36_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %2, %c42_i64 : i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %c-27_i64, %0 : i64
    %2 = llvm.trunc %arg0 : i1 to i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c43_i64 = arith.constant 43 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.xor %arg1, %c0_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.sdiv %c43_i64, %c9_i64 : i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.select %arg2, %3, %2 : i1, i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.or %arg0, %c26_i64 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "slt" %c-16_i64, %arg2 : i64
    %4 = llvm.select %3, %0, %c-15_i64 : i1, i64
    %5 = llvm.srem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.ashr %c41_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.and %2, %c-24_i64 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c24_i64 = arith.constant 24 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "sgt" %1, %c-33_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.icmp "ult" %c24_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %0, %c-25_i64 : i64
    %2 = llvm.or %0, %arg1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.udiv %c27_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %arg2, %1 : i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ne" %arg1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "ult" %c-50_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg1, %c-35_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %c34_i64, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.ashr %3, %c36_i64 : i64
    %5 = llvm.urem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.ashr %c20_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.sdiv %c-47_i64, %c-45_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.select %arg0, %2, %arg1 : i1, i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c-31_i64 = arith.constant -31 : i64
    %c50_i64 = arith.constant 50 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.urem %c50_i64, %c45_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "ne" %1, %c-31_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %true, %arg1, %0 : i1, i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.xor %c26_i64, %c-26_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c33_i64 = arith.constant 33 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.srem %c33_i64, %c-50_i64 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %c-17_i64, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %c24_i64, %c48_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.and %0, %arg1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.and %c19_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.icmp "ult" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %false = arith.constant false
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.select %false, %c-4_i64, %arg0 : i1, i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.ashr %c8_i64, %2 : i64
    %4 = llvm.srem %0, %arg1 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.lshr %2, %c9_i64 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "ult" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %c49_i64, %0 : i64
    %2 = llvm.select %arg0, %arg1, %0 : i1, i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.and %3, %arg2 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %false = arith.constant false
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.select %false, %arg1, %c35_i64 : i1, i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.sdiv %c22_i64, %1 : i64
    %3 = llvm.or %arg1, %arg2 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.udiv %c46_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %c29_i64, %3 : i64
    %5 = llvm.icmp "sgt" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %c46_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "eq" %c-13_i64, %c-1_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.ashr %c49_i64, %2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.icmp "eq" %4, %c-7_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.xor %arg0, %c-10_i64 : i64
    %1 = llvm.icmp "ult" %c-19_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "slt" %c-2_i64, %c4_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %3, %c-37_i64 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c28_i64 = arith.constant 28 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.sdiv %arg0, %c-41_i64 : i64
    %1 = llvm.sdiv %c28_i64, %0 : i64
    %2 = llvm.and %c-34_i64, %c-22_i64 : i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.xor %c-24_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %c41_i64, %c3_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.or %3, %arg0 : i64
    %5 = llvm.icmp "sge" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.or %arg2, %c4_i64 : i64
    %3 = llvm.udiv %arg2, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %c-24_i64, %0 : i64
    %2 = llvm.srem %c46_i64, %0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.or %c24_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.and %1, %0 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.or %arg1, %c-44_i64 : i64
    %4 = llvm.and %3, %arg2 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.lshr %0, %c6_i64 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.lshr %c-39_i64, %2 : i64
    %4 = llvm.urem %3, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %c-37_i64, %0 : i64
    %2 = llvm.urem %c-19_i64, %c15_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.urem %3, %0 : i64
    %5 = llvm.icmp "uge" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.lshr %c-43_i64, %c-15_i64 : i64
    %1 = llvm.srem %c22_i64, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "uge" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.or %c-7_i64, %arg0 : i64
    %1 = llvm.xor %c-28_i64, %0 : i64
    %2 = llvm.lshr %1, %c-21_i64 : i64
    %3 = llvm.ashr %c-32_i64, %2 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.and %4, %c-50_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %false = arith.constant false
    %c-31_i64 = arith.constant -31 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c-31_i64 : i64
    %2 = llvm.select %false, %c-9_i64, %arg1 : i1, i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.udiv %c36_i64, %3 : i64
    %5 = llvm.icmp "ule" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.sdiv %c-36_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %c18_i64, %arg1 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.sdiv %c-19_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "slt" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.or %c-27_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.ashr %arg1, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.xor %3, %arg2 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ne" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %arg0, %c-44_i64 : i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "ugt" %arg1, %arg2 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.srem %c1_i64, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "ule" %c14_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.srem %3, %1 : i64
    %5 = llvm.icmp "sge" %c-25_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c30_i64 = arith.constant 30 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %c35_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %c30_i64, %c-19_i64 : i64
    %5 = llvm.udiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.udiv %c-1_i64, %0 : i64
    %2 = llvm.ashr %c-3_i64, %arg2 : i64
    %3 = llvm.xor %2, %c-41_i64 : i64
    %4 = llvm.and %c-7_i64, %3 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c31_i64 = arith.constant 31 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.or %arg0, %c-50_i64 : i64
    %1 = llvm.srem %c-23_i64, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.udiv %1, %c-46_i64 : i64
    %4 = llvm.and %c31_i64, %3 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.xor %c-2_i64, %2 : i64
    %4 = llvm.or %3, %c-31_i64 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "eq" %c-38_i64, %c1_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.icmp "eq" %c-11_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %false = arith.constant false
    %c6_i64 = arith.constant 6 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.urem %c-25_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c27_i64 : i64
    %2 = llvm.select %false, %c6_i64, %1 : i1, i64
    %3 = llvm.ashr %0, %arg1 : i64
    %4 = llvm.or %3, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c20_i64 = arith.constant 20 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.srem %c0_i64, %0 : i64
    %2 = llvm.srem %c20_i64, %c-25_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.sdiv %3, %arg1 : i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.srem %c20_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.select %arg2, %c41_i64, %0 : i1, i64
    %3 = llvm.select %arg1, %2, %arg0 : i1, i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %c29_i64, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c25_i64 = arith.constant 25 : i64
    %c35_i64 = arith.constant 35 : i64
    %c38_i64 = arith.constant 38 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "sle" %c-48_i64, %c31_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %c38_i64, %c35_i64 : i64
    %3 = llvm.select %2, %c25_i64, %c-22_i64 : i1, i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "eq" %c-25_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg1, %c-11_i64 : i64
    %3 = llvm.sdiv %2, %c13_i64 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %c-39_i64, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.trunc %arg0 : i1 to i64
    %4 = llvm.select %2, %1, %3 : i1, i64
    %5 = llvm.icmp "eq" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %0, %c13_i64 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg1, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.sdiv %3, %c-44_i64 : i64
    %5 = llvm.icmp "slt" %4, %c11_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %false = arith.constant false
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.srem %2, %c-49_i64 : i64
    %4 = llvm.ashr %c5_i64, %3 : i64
    %5 = llvm.select %false, %arg0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.ashr %c37_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %c-43_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.sdiv %arg2, %c22_i64 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.urem %arg0, %c50_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.lshr %c-46_i64, %arg1 : i64
    %3 = llvm.icmp "sle" %2, %arg2 : i64
    %4 = llvm.select %3, %1, %1 : i1, i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "eq" %c-4_i64, %c9_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.ashr %c14_i64, %arg1 : i64
    %3 = llvm.or %1, %c27_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c-7_i64 = arith.constant -7 : i64
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %arg0, %c-7_i64 : i64
    %2 = llvm.srem %1, %c34_i64 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.select %true, %3, %arg1 : i1, i64
    %5 = llvm.icmp "sge" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "ugt" %c-24_i64, %c31_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %c-50_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %c-50_i64, %3 : i64
    %5 = llvm.lshr %4, %arg0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.sdiv %c-23_i64, %c19_i64 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.lshr %arg2, %c47_i64 : i64
    %3 = llvm.select %arg0, %arg1, %2 : i1, i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "ule" %4, %c25_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c39_i64 = arith.constant 39 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "uge" %arg0, %c-19_i64 : i64
    %1 = llvm.ashr %arg1, %arg0 : i64
    %2 = llvm.select %0, %c-6_i64, %1 : i1, i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %c39_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %c22_i64 : i64
    %2 = llvm.urem %c-7_i64, %c20_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.and %1, %arg1 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.or %c37_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.udiv %arg2, %c-1_i64 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.ashr %arg2, %c34_i64 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.xor %c-9_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %c29_i64, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.srem %arg2, %arg2 : i64
    %4 = llvm.srem %3, %arg2 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "slt" %c-39_i64, %arg0 : i64
    %1 = llvm.lshr %c-5_i64, %arg0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.select %0, %2, %arg0 : i1, i64
    %4 = llvm.icmp "sgt" %3, %1 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.sdiv %c-23_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.ashr %0, %c34_i64 : i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %arg1, %arg1 : i64
    %2 = llvm.urem %1, %c13_i64 : i64
    %3 = llvm.select %arg2, %2, %0 : i1, i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %c43_i64, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %4, %2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "sge" %c11_i64, %c-2_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "ult" %arg0, %c-50_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %c-18_i64, %0 : i64
    %2 = llvm.icmp "eq" %0, %c23_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.urem %arg2, %arg0 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.xor %arg2, %3 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c3_i64 = arith.constant 3 : i64
    %c33_i64 = arith.constant 33 : i64
    %c17_i64 = arith.constant 17 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "slt" %c17_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %c33_i64, %2 : i64
    %4 = llvm.select %arg0, %3, %c-1_i64 : i1, i64
    %5 = llvm.icmp "slt" %c3_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.and %arg0, %c29_i64 : i64
    %1 = llvm.and %arg0, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.icmp "ugt" %c27_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.select %arg0, %c-30_i64, %arg1 : i1, i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.icmp "sge" %c15_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %c-18_i64, %arg2 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %c37_i64, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.sdiv %arg1, %0 : i64
    %4 = llvm.sdiv %3, %arg2 : i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %c-34_i64, %arg0 : i64
    %1 = llvm.select %true, %0, %arg1 : i1, i64
    %2 = llvm.icmp "slt" %arg1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %true = arith.constant true
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.select %true, %c-41_i64, %arg0 : i1, i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.udiv %1, %c1_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c27_i64 = arith.constant 27 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "sle" %c36_i64, %c-39_i64 : i64
    %1 = llvm.lshr %c27_i64, %c47_i64 : i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %1, %arg0 : i64
    %5 = llvm.select %0, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.srem %0, %arg0 : i64
    %4 = llvm.sdiv %3, %arg2 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.xor %c-9_i64, %0 : i64
    %2 = llvm.select %false, %arg0, %arg2 : i1, i64
    %3 = llvm.icmp "uge" %arg2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c-9_i64 = arith.constant -9 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.or %c-9_i64, %arg2 : i64
    %4 = llvm.urem %3, %c28_i64 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "uge" %arg2, %c45_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.or %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "sgt" %c48_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg1, %c-11_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.trunc %arg2 : i1 to i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %c-43_i64, %arg1 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.srem %3, %c16_i64 : i64
    %5 = llvm.icmp "ne" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.sdiv %arg0, %c-39_i64 : i64
    %1 = llvm.icmp "sgt" %arg1, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.ashr %3, %c26_i64 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %3, %3 : i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "uge" %arg0, %c1_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg1, %arg2 : i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.and %3, %c9_i64 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sdiv %c-18_i64, %0 : i64
    %2 = llvm.or %0, %arg0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %c15_i64, %arg0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.zext %arg1 : i1 to i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.icmp "sge" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "sle" %arg1, %arg0 : i64
    %1 = llvm.ashr %c42_i64, %arg2 : i64
    %2 = llvm.icmp "ne" %c-28_i64, %c29_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    %5 = llvm.ashr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c38_i64 = arith.constant 38 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.udiv %c38_i64, %c-47_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.icmp "uge" %2, %c11_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.and %arg0, %c-29_i64 : i64
    %1 = llvm.icmp "ule" %0, %c-26_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %arg1, %arg1 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.srem %c-6_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "ne" %c22_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %c-40_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.zext %0 : i1 to i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %c19_i64, %arg1 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c15_i64 = arith.constant 15 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %c32_i64, %0 : i64
    %2 = llvm.or %1, %c20_i64 : i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.or %3, %arg2 : i64
    %5 = llvm.or %c15_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "eq" %c-8_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.ashr %c-6_i64, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.select %0, %3, %1 : i1, i64
    %5 = llvm.icmp "eq" %c6_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %arg1, %arg1 : i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c-9_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %4, %c-9_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sdiv %c49_i64, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %false = arith.constant false
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %false, %arg0, %arg1 : i1, i64
    %3 = llvm.sdiv %2, %c-37_i64 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "ult" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c3_i64 = arith.constant 3 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.xor %c3_i64, %c-14_i64 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.urem %3, %c-12_i64 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.sdiv %arg0, %c-40_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "sge" %0, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %c7_i64, %0 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c26_i64 = arith.constant 26 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.xor %0, %c26_i64 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.srem %c37_i64, %2 : i64
    %4 = llvm.ashr %3, %c43_i64 : i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.srem %3, %arg2 : i64
    %5 = llvm.icmp "uge" %4, %c-42_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.lshr %arg0, %c2_i64 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.udiv %arg0, %c20_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %c-24_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.urem %c43_i64, %c-17_i64 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg0, %arg0 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.srem %c-3_i64, %1 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.ashr %c-32_i64, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %4, %c-29_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %c4_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.sdiv %c-37_i64, %2 : i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %c-12_i64, %0 : i64
    %2 = llvm.icmp "ne" %c6_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c24_i64 : i64
    %2 = llvm.urem %c-26_i64, %1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.lshr %arg1, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c-22_i64 : i64
    %2 = llvm.xor %arg1, %c-29_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.udiv %0, %arg0 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c35_i64 = arith.constant 35 : i64
    %false = arith.constant false
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.select %false, %c-26_i64, %arg0 : i1, i64
    %1 = llvm.ashr %c35_i64, %0 : i64
    %2 = llvm.srem %1, %c-43_i64 : i64
    %3 = llvm.sdiv %1, %arg2 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.and %c-24_i64, %c35_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.sdiv %c-13_i64, %1 : i64
    %3 = llvm.or %0, %arg0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.and %4, %c-22_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %4, %0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.sdiv %c-27_i64, %2 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %1, %c-36_i64 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.or %4, %3 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %c-1_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %1, %2, %c17_i64 : i1, i64
    %4 = llvm.srem %c44_i64, %3 : i64
    %5 = llvm.xor %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %c-11_i64, %arg0 : i64
    %1 = llvm.xor %c44_i64, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c50_i64 = arith.constant 50 : i64
    %c11_i64 = arith.constant 11 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "ugt" %c-32_i64, %c2_i64 : i64
    %1 = llvm.select %0, %arg0, %c17_i64 : i1, i64
    %2 = llvm.icmp "ule" %c4_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %c11_i64, %3 : i64
    %5 = llvm.icmp "uge" %c50_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %c15_i64, %0 : i64
    %2 = llvm.select %1, %arg1, %0 : i1, i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.icmp "ule" %3, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "ult" %c-25_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.sdiv %arg0, %arg1 : i64
    %3 = llvm.sdiv %c15_i64, %2 : i64
    %4 = llvm.lshr %3, %1 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.select %arg0, %1, %arg1 : i1, i64
    %3 = llvm.xor %c-15_i64, %2 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "sgt" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %true = arith.constant true
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %true, %c20_i64, %arg0 : i1, i64
    %1 = llvm.ashr %arg1, %c-42_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ule" %arg1, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %0, %c-38_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %2, %c-17_i64 : i64
    %4 = llvm.lshr %c9_i64, %c31_i64 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.and %c-5_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c34_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %c-40_i64, %arg1 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.srem %3, %c-25_i64 : i64
    %5 = llvm.and %4, %arg1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.urem %arg0, %c-19_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.xor %arg1, %2 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.urem %c50_i64, %arg1 : i64
    %1 = llvm.udiv %arg1, %arg1 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c18_i64 = arith.constant 18 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.ashr %c44_i64, %c18_i64 : i64
    %4 = llvm.or %3, %c47_i64 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "eq" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.select %arg0, %arg2, %0 : i1, i64
    %2 = llvm.icmp "ne" %1, %c21_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.ashr %c2_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "sgt" %c-31_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %c-46_i64, %2 : i64
    %4 = llvm.lshr %c-46_i64, %2 : i64
    %5 = llvm.select %0, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-23_i64 = arith.constant -23 : i64
    %true = arith.constant true
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.select %true, %c15_i64, %arg0 : i1, i64
    %1 = llvm.lshr %0, %c-18_i64 : i64
    %2 = llvm.lshr %c-23_i64, %1 : i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.select %arg1, %c21_i64, %2 : i1, i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.sdiv %c-1_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg2, %c-48_i64 : i1, i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ult" %1, %c13_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.or %c14_i64, %0 : i64
    %3 = llvm.icmp "ult" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.srem %arg1, %0 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "slt" %arg0, %c12_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c-11_i64, %arg0 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "eq" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %c-20_i64, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.select %arg0, %c25_i64, %arg1 : i1, i64
    %1 = llvm.icmp "sgt" %arg2, %c-45_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %c-33_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.trunc %arg2 : i1 to i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.udiv %1, %c33_i64 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.urem %c-6_i64, %3 : i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %c-9_i64, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %3, %c48_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "eq" %arg0, %c-22_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %c18_i64, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "ne" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c48_i64 = arith.constant 48 : i64
    %c37_i64 = arith.constant 37 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.select %arg1, %c37_i64, %c1_i64 : i1, i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "sle" %c48_i64, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.select %4, %c43_i64, %arg0 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.srem %c-24_i64, %c41_i64 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %3, %c45_i64 : i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %0, %0 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %3, %c3_i64 : i64
    %5 = llvm.icmp "sge" %c12_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.and %c12_i64, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "slt" %0, %0 : i64
    %4 = llvm.select %3, %arg2, %c12_i64 : i1, i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.or %arg2, %c-39_i64 : i64
    %5 = llvm.select %true, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.icmp "slt" %c-13_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.ashr %c-24_i64, %arg1 : i64
    %1 = llvm.icmp "slt" %c-10_i64, %c-1_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    %5 = llvm.select %4, %0, %3 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg2, %c-37_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.urem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %c37_i64, %c-43_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c12_i64 = arith.constant 12 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c36_i64, %arg0 : i64
    %2 = llvm.select %1, %c12_i64, %arg1 : i1, i64
    %3 = llvm.and %arg2, %c-48_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %false = arith.constant false
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.select %false, %arg2, %c-45_i64 : i1, i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg2, %arg1 : i1, i64
    %2 = llvm.urem %c-43_i64, %arg1 : i64
    %3 = llvm.sext %0 : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c36_i64 = arith.constant 36 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "sle" %c36_i64, %c30_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.or %c1_i64, %1 : i64
    %3 = llvm.trunc %0 : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.and %c4_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.sdiv %1, %c-5_i64 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.select %3, %c-37_i64, %arg1 : i1, i64
    %5 = llvm.icmp "sle" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c-37_i64 = arith.constant -37 : i64
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.select %false, %1, %c31_i64 : i1, i64
    %3 = llvm.or %c-37_i64, %2 : i64
    %4 = llvm.trunc %arg2 : i1 to i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c-20_i64 = arith.constant -20 : i64
    %false = arith.constant false
    %c19_i64 = arith.constant 19 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %c-28_i64, %c-8_i64 : i64
    %1 = llvm.udiv %arg0, %c-20_i64 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.select %2, %c-44_i64, %arg0 : i1, i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.select %false, %c19_i64, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c4_i64 = arith.constant 4 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.srem %c13_i64, %arg0 : i64
    %1 = llvm.sdiv %c13_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.or %2, %c4_i64 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "ugt" %4, %c-32_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %c-30_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %3, %arg2 : i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c-23_i64 = arith.constant -23 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "sge" %c-23_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %c-49_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ule" %c48_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "ult" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg1, %arg2 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.udiv %c23_i64, %c-12_i64 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.urem %c-10_i64, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "sgt" %arg2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.and %arg2, %0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.sdiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "ult" %c-15_i64, %arg0 : i64
    %1 = llvm.select %0, %c-31_i64, %c37_i64 : i1, i64
    %2 = llvm.urem %c0_i64, %1 : i64
    %3 = llvm.urem %c0_i64, %2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.urem %c-29_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c19_i64 = arith.constant 19 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %c-45_i64, %0 : i64
    %2 = llvm.srem %c-42_i64, %c-20_i64 : i64
    %3 = llvm.xor %2, %c19_i64 : i64
    %4 = llvm.sdiv %3, %c22_i64 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.ashr %c25_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "sle" %2, %1 : i64
    %4 = llvm.select %3, %2, %0 : i1, i64
    %5 = llvm.icmp "slt" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.sdiv %c6_i64, %c46_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.and %0, %arg0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "sle" %arg0, %c4_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %3, %c-9_i64 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "ule" %c-19_i64, %arg0 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.srem %c30_i64, %c18_i64 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %c-36_i64, %c-35_i64 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %1, %2, %2 : i1, i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %c-15_i64, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.urem %c-23_i64, %c12_i64 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.lshr %0, %0 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.and %c-34_i64, %arg2 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.lshr %3, %c33_i64 : i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.xor %c-2_i64, %c-46_i64 : i64
    %1 = llvm.icmp "sgt" %0, %c-35_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %0, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c20_i64 = arith.constant 20 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.lshr %arg1, %c20_i64 : i64
    %2 = llvm.ashr %c-8_i64, %1 : i64
    %3 = llvm.icmp "uge" %2, %c10_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.ashr %c-26_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c-24_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg1, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %false, %0, %2 : i1, i64
    %4 = llvm.xor %3, %c18_i64 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "ugt" %arg1, %arg2 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.sdiv %c0_i64, %c46_i64 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.and %arg0, %c-39_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.urem %arg2, %1 : i64
    %3 = llvm.select %false, %arg0, %2 : i1, i64
    %4 = llvm.and %3, %c-27_i64 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c41_i64 = arith.constant 41 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.xor %c34_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.udiv %c41_i64, %c-19_i64 : i64
    %4 = llvm.ashr %3, %3 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.lshr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.lshr %c-16_i64, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.or %c8_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.lshr %2, %arg2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c17_i64 = arith.constant 17 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.srem %c17_i64, %c25_i64 : i64
    %1 = llvm.ashr %0, %c11_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.sdiv %c47_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.select %2, %arg1, %arg1 : i1, i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.udiv %arg0, %c19_i64 : i64
    %1 = llvm.select %false, %arg1, %arg2 : i1, i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    %3 = llvm.xor %0, %arg1 : i64
    %4 = llvm.select %2, %arg0, %3 : i1, i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.or %arg2, %arg1 : i64
    %2 = llvm.icmp "ult" %1, %c38_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %c26_i64 = arith.constant 26 : i64
    %c16_i64 = arith.constant 16 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %c-37_i64, %0 : i64
    %2 = llvm.icmp "ult" %c16_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %c26_i64, %c-14_i64 : i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.lshr %arg1, %0 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %arg2, %0, %arg0 : i1, i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.udiv %c21_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %3, %c33_i64 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.or %arg1, %c40_i64 : i64
    %1 = llvm.lshr %c-35_i64, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.srem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c12_i64 = arith.constant 12 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.lshr %c-22_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.or %1, %c12_i64 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.urem %arg2, %3 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %c6_i64, %arg0 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.lshr %c44_i64, %3 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sdiv %c28_i64, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.select %true, %1, %3 : i1, i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %c38_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.ashr %c39_i64, %1 : i64
    %3 = llvm.icmp "ult" %c46_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "sge" %2, %c42_i64 : i64
    %4 = llvm.select %3, %1, %c17_i64 : i1, i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %c-12_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.ashr %1, %c-7_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ule" %c17_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c20_i64 = arith.constant 20 : i64
    %c23_i64 = arith.constant 23 : i64
    %c44_i64 = arith.constant 44 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.icmp "ugt" %c44_i64, %c32_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %c23_i64, %1 : i64
    %3 = llvm.select %2, %1, %arg0 : i1, i64
    %4 = llvm.udiv %c20_i64, %c46_i64 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c44_i64 = arith.constant 44 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "sgt" %c44_i64, %c43_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.and %c-35_i64, %1 : i64
    %3 = llvm.udiv %c25_i64, %2 : i64
    %4 = llvm.srem %arg1, %1 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %arg0, %1 : i64
    %5 = llvm.srem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %3, %0 : i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %c48_i64, %arg0 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.urem %c-37_i64, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.srem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.lshr %c-27_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c33_i64 = arith.constant 33 : i64
    %c49_i64 = arith.constant 49 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.udiv %c49_i64, %c18_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.or %1, %c-12_i64 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.urem %c33_i64, %3 : i64
    %5 = llvm.icmp "sgt" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %arg0, %c24_i64, %0 : i1, i64
    %2 = llvm.or %0, %arg1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c47_i64 = arith.constant 47 : i64
    %false = arith.constant false
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.select %false, %c-32_i64, %arg0 : i1, i64
    %1 = llvm.srem %arg1, %arg1 : i64
    %2 = llvm.xor %1, %c47_i64 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.udiv %c-12_i64, %3 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.xor %c23_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %c21_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %arg0, %arg0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "eq" %arg1, %c11_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %c-28_i64, %1 : i64
    %3 = llvm.icmp "slt" %c40_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "sge" %c35_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.select %0, %c31_i64, %arg2 : i1, i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.ashr %arg2, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %arg2, %arg0 : i64
    %2 = llvm.and %arg2, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c40_i64 = arith.constant 40 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "ult" %c40_i64, %c12_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %c-13_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %c-40_i64, %3 : i64
    %5 = llvm.icmp "uge" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %c-30_i64, %c42_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %arg1, %arg1 : i64
    %2 = llvm.ashr %1, %c-43_i64 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.srem %arg2, %c24_i64 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.srem %arg1, %arg2 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "slt" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c10_i64 = arith.constant 10 : i64
    %c39_i64 = arith.constant 39 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.udiv %c-10_i64, %c-37_i64 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.select %1, %c39_i64, %c10_i64 : i1, i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.srem %c-5_i64, %2 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "sge" %c33_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.urem %c-31_i64, %arg2 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.or %c-30_i64, %arg0 : i64
    %1 = llvm.lshr %c-31_i64, %0 : i64
    %2 = llvm.urem %1, %c14_i64 : i64
    %3 = llvm.xor %arg1, %0 : i64
    %4 = llvm.or %3, %arg2 : i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %c-33_i64, %c37_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %c26_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %c17_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.urem %c-24_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %c-39_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg1, %arg2 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "sgt" %c2_i64, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.icmp "uge" %c-5_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c25_i64 = arith.constant 25 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %arg0, %c32_i64 : i64
    %1 = llvm.xor %c21_i64, %arg0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.ashr %c25_i64, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.urem %4, %arg1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c33_i64 = arith.constant 33 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.or %c-6_i64, %arg0 : i64
    %1 = llvm.ashr %0, %c33_i64 : i64
    %2 = llvm.ashr %arg1, %c19_i64 : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %c-1_i64, %0 : i64
    %2 = llvm.sdiv %c-45_i64, %c24_i64 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.and %4, %arg2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.select %false, %arg0, %c17_i64 : i1, i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "eq" %c6_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.or %c21_i64, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "sge" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.udiv %c18_i64, %arg1 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.lshr %arg2, %0 : i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.ashr %c49_i64, %c-21_i64 : i64
    %1 = llvm.sdiv %c44_i64, %0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.ashr %1, %1 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.and %1, %c-11_i64 : i64
    %3 = llvm.select %true, %arg2, %arg1 : i1, i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "ugt" %c-34_i64, %c35_i64 : i64
    %1 = llvm.or %arg0, %c29_i64 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.select %0, %arg0, %3 : i1, i64
    %5 = llvm.icmp "sge" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "sgt" %c-24_i64, %c4_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c-38_i64, %1 : i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %true = arith.constant true
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.select %true, %arg0, %c49_i64 : i1, i64
    %1 = llvm.srem %arg2, %c-8_i64 : i64
    %2 = llvm.icmp "ult" %arg2, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.select %false, %c16_i64, %arg0 : i1, i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.sdiv %3, %3 : i64
    %5 = llvm.select %2, %4, %arg2 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.or %c0_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %true = arith.constant true
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.select %true, %arg0, %c14_i64 : i1, i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %c-48_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.zext %arg1 : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %c14_i64, %0 : i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.udiv %c36_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c7_i64 = arith.constant 7 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.or %arg0, %c-8_i64 : i64
    %1 = llvm.or %0, %c7_i64 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.select %3, %2, %1 : i1, i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %c-11_i64, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %arg2, %arg0 : i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.select %true, %arg1, %arg1 : i1, i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.and %arg2, %c48_i64 : i64
    %3 = llvm.ashr %arg2, %1 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %true = arith.constant true
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.sdiv %c-9_i64, %arg1 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.icmp "sgt" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %true, %arg2, %c8_i64 : i1, i64
    %5 = llvm.ashr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.lshr %c15_i64, %c-22_i64 : i64
    %1 = llvm.icmp "sgt" %c-2_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %c39_i64, %c48_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.urem %0, %1 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.xor %4, %0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ult" %c35_i64, %c-40_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %3, %arg0 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c-22_i64, %0 : i64
    %2 = llvm.ashr %c16_i64, %arg1 : i64
    %3 = llvm.icmp "sgt" %2, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg2, %arg1 : i64
    %3 = llvm.udiv %2, %c16_i64 : i64
    %4 = llvm.or %3, %1 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sdiv %c22_i64, %0 : i64
    %2 = llvm.urem %1, %c-36_i64 : i64
    %3 = llvm.srem %1, %c0_i64 : i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg0, %arg0 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.sdiv %c38_i64, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.and %c-46_i64, %arg0 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.ashr %3, %0 : i64
    %5 = llvm.or %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.ashr %arg0, %c18_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg1, %0 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %c-18_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.srem %2, %c-29_i64 : i64
    %4 = llvm.icmp "sle" %3, %3 : i64
    %5 = llvm.select %4, %arg1, %3 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.and %c-39_i64, %c41_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %c9_i64, %3 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c3_i64, %1 : i64
    %3 = llvm.icmp "sle" %1, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %false = arith.constant false
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.select %false, %c18_i64, %0 : i1, i64
    %2 = llvm.icmp "eq" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "sgt" %4, %c38_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c25_i64 = arith.constant 25 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sdiv %c25_i64, %c27_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "uge" %c23_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %c-44_i64, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.select %arg1, %1, %c10_i64 : i1, i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "sle" %1, %c35_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %0, %0 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c16_i64 = arith.constant 16 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.urem %arg0, %c50_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.lshr %c16_i64, %arg1 : i64
    %3 = llvm.lshr %c37_i64, %0 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %c-9_i64, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ult" %arg1, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-38_i64 = arith.constant -38 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %0, %c-7_i64 : i64
    %2 = llvm.sdiv %1, %c-20_i64 : i64
    %3 = llvm.select %arg1, %2, %2 : i1, i64
    %4 = llvm.select %arg0, %c-38_i64, %3 : i1, i64
    %5 = llvm.or %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %false = arith.constant false
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %false, %c-27_i64, %arg1 : i1, i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %3, %3 : i64
    %5 = llvm.or %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.sdiv %c-32_i64, %c-38_i64 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %c-16_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "sle" %c-44_i64, %c-15_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %3, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "slt" %0, %c-43_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.udiv %3, %arg0 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %true = arith.constant true
    %c-46_i64 = arith.constant -46 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.and %c-46_i64, %c-13_i64 : i64
    %1 = llvm.select %true, %0, %c32_i64 : i1, i64
    %2 = llvm.select %arg0, %1, %0 : i1, i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %4, %arg1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %arg2 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.select %3, %c-48_i64, %c-33_i64 : i1, i64
    %5 = llvm.urem %4, %c25_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %1 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.or %c-25_i64, %arg1 : i64
    %3 = llvm.xor %2, %c14_i64 : i64
    %4 = llvm.ashr %3, %arg2 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.and %arg1, %c-15_i64 : i64
    %3 = llvm.select %1, %arg0, %2 : i1, i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.srem %4, %arg0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c32_i64 = arith.constant 32 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.urem %c26_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.and %c32_i64, %arg0 : i64
    %3 = llvm.and %2, %c25_i64 : i64
    %4 = llvm.ashr %3, %1 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %arg1, %arg1 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %c15_i64, %0 : i64
    %2 = llvm.or %arg1, %c-14_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.ashr %arg2, %arg0 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.lshr %c9_i64, %arg1 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.xor %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.or %arg1, %arg1 : i64
    %3 = llvm.select %arg2, %c-9_i64, %2 : i1, i64
    %4 = llvm.select %1, %3, %3 : i1, i64
    %5 = llvm.icmp "uge" %4, %c10_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %c26_i64 = arith.constant 26 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.ashr %c26_i64, %c3_i64 : i64
    %1 = llvm.icmp "sle" %c-29_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "sge" %c12_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %1, %c-39_i64 : i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.srem %1, %arg2 : i64
    %4 = llvm.ashr %3, %2 : i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %c-45_i64, %arg1 : i64
    %2 = llvm.icmp "sgt" %0, %arg2 : i64
    %3 = llvm.select %2, %c-48_i64, %0 : i1, i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.select %arg1, %arg0, %c-38_i64 : i1, i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.srem %3, %1 : i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.and %c-42_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.xor %c5_i64, %arg0 : i64
    %1 = llvm.select %false, %arg1, %0 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.xor %c-30_i64, %c-39_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.srem %c-48_i64, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.udiv %3, %1 : i64
    %5 = llvm.srem %c46_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.select %arg2, %3, %2 : i1, i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c16_i64 = arith.constant 16 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "slt" %c-46_i64, %c-33_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %c16_i64, %1 : i64
    %3 = llvm.ashr %2, %c-16_i64 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "ule" %c2_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.urem %c-1_i64, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "slt" %c14_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %1, %arg0 : i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c4_i64 = arith.constant 4 : i64
    %c42_i64 = arith.constant 42 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.ashr %c42_i64, %c26_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.and %c4_i64, %c46_i64 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.select %4, %arg0, %0 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c47_i64 = arith.constant 47 : i64
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "slt" %1, %c47_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "sle" %4, %c35_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c6_i64 = arith.constant 6 : i64
    %true = arith.constant true
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.select %arg1, %arg2, %c-26_i64 : i1, i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.xor %c6_i64, %c-50_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %c-46_i64, %0 : i64
    %2 = llvm.lshr %0, %arg1 : i64
    %3 = llvm.icmp "sge" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %c-49_i64, %0 : i64
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    %3 = llvm.icmp "sle" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %c-48_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.or %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c22_i64 : i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "slt" %arg0, %c-6_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %c13_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %arg1, %arg2 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.srem %arg0, %0 : i64
    %3 = llvm.or %c-45_i64, %2 : i64
    %4 = llvm.select %1, %3, %arg1 : i1, i64
    %5 = llvm.icmp "slt" %4, %c43_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.or %c-50_i64, %arg1 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c20_i64 = arith.constant 20 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.or %c20_i64, %1 : i64
    %3 = llvm.ashr %arg0, %0 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.udiv %c25_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.select %arg2, %0, %arg1 : i1, i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.or %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %c41_i64, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.zext %arg0 : i1 to i64
    %5 = llvm.select %3, %c33_i64, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c38_i64 = arith.constant 38 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.or %arg0, %c43_i64 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.and %c38_i64, %1 : i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.icmp "ult" %4, %c42_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.udiv %1, %c25_i64 : i64
    %3 = llvm.icmp "ult" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c46_i64 = arith.constant 46 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %c1_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %3, %c-6_i64 : i64
    %5 = llvm.icmp "ule" %c46_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %c29_i64, %0 : i64
    %2 = llvm.ashr %c-15_i64, %1 : i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.or %c-10_i64, %3 : i64
    %5 = llvm.icmp "ult" %4, %c-19_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.urem %1, %arg1 : i64
    %5 = llvm.srem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c-11_i64 = arith.constant -11 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.and %c-11_i64, %2 : i64
    %4 = llvm.or %c-3_i64, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.lshr %2, %1 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.icmp "uge" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.urem %c42_i64, %c-40_i64 : i64
    %3 = llvm.icmp "sle" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %arg0, %arg0 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.srem %0, %c-36_i64 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.ashr %3, %arg2 : i64
    %5 = llvm.icmp "ult" %4, %c7_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c14_i64 = arith.constant 14 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sge" %c14_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %c-29_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %c-42_i64, %0 : i64
    %2 = llvm.urem %arg0, %0 : i64
    %3 = llvm.icmp "ult" %2, %c38_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.lshr %c47_i64, %arg0 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.and %2, %c-11_i64 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.srem %c-12_i64, %c-48_i64 : i64
    %3 = llvm.srem %c14_i64, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.urem %c0_i64, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.select %false, %2, %2 : i1, i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.udiv %c35_i64, %arg1 : i64
    %2 = llvm.icmp "uge" %arg2, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %0, %arg0, %3 : i1, i64
    %5 = llvm.and %4, %c50_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %c5_i64 = arith.constant 5 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.xor %c5_i64, %c1_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.lshr %c-13_i64, %c44_i64 : i64
    %1 = llvm.xor %c-36_i64, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.ashr %2, %c-31_i64 : i64
    %4 = llvm.urem %arg0, %c-26_i64 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.lshr %arg1, %0 : i64
    %3 = llvm.icmp "ult" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.or %arg1, %c-44_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "ult" %c45_i64, %c-44_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.urem %3, %arg0 : i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "ne" %arg0, %c-33_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.and %2, %c-44_i64 : i64
    %4 = llvm.ashr %2, %1 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg2, %arg0 : i64
    %1 = llvm.icmp "uge" %arg1, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %c-49_i64, %1 : i64
    %3 = llvm.sdiv %2, %c-26_i64 : i64
    %4 = llvm.icmp "ne" %c34_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.or %c-8_i64, %arg0 : i64
    %1 = llvm.urem %c-35_i64, %0 : i64
    %2 = llvm.srem %arg1, %arg2 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.srem %c43_i64, %3 : i64
    %5 = llvm.icmp "uge" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.and %c50_i64, %c-43_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "ult" %arg1, %c-1_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c15_i64 = arith.constant 15 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c8_i64 : i64
    %3 = llvm.select %2, %c15_i64, %arg1 : i1, i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.or %c11_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.lshr %c-5_i64, %0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.and %arg2, %2 : i64
    %4 = llvm.xor %arg2, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.icmp "eq" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.udiv %c26_i64, %c-10_i64 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.or %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "ule" %arg0, %c-35_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %arg1 : i64
    %3 = llvm.icmp "ugt" %2, %arg2 : i64
    %4 = llvm.select %3, %arg1, %c25_i64 : i1, i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.udiv %c-1_i64, %c27_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.xor %1, %c-7_i64 : i64
    %3 = llvm.icmp "slt" %arg1, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %arg1, %arg0 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.xor %c44_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %1, %1 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.urem %c-18_i64, %c35_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.lshr %3, %arg2 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c-35_i64 = arith.constant -35 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg1, %arg1 : i1, i64
    %1 = llvm.srem %0, %c-35_i64 : i64
    %2 = llvm.or %arg2, %c-50_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.icmp "eq" %4, %c-10_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.lshr %arg0, %c-7_i64 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg1, %c-25_i64 : i64
    %4 = llvm.lshr %c49_i64, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.select %arg0, %arg1, %c-46_i64 : i1, i64
    %1 = llvm.icmp "ugt" %c-34_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.and %0, %c16_i64 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "uge" %2, %c25_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.or %arg0, %c13_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sdiv %0, %c-46_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c7_i64 = arith.constant 7 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.sdiv %c0_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %1, %c7_i64, %c28_i64 : i1, i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c13_i64 = arith.constant 13 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "eq" %c37_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.srem %arg0, %c13_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.lshr %c-22_i64, %c-3_i64 : i64
    %5 = llvm.srem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "sge" %c-9_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %4, %c13_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.select %0, %c-29_i64, %arg1 : i1, i64
    %2 = llvm.select %0, %arg0, %c-21_i64 : i1, i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.udiv %arg1, %arg2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c37_i64 = arith.constant 37 : i64
    %false = arith.constant false
    %c-50_i64 = arith.constant -50 : i64
    %c43_i64 = arith.constant 43 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.ashr %c43_i64, %c-7_i64 : i64
    %1 = llvm.srem %c37_i64, %arg0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.select %2, %arg1, %c39_i64 : i1, i64
    %4 = llvm.select %false, %c-50_i64, %3 : i1, i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c16_i64 = arith.constant 16 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c1_i64 = arith.constant 1 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.lshr %c45_i64, %arg0 : i64
    %1 = llvm.select %arg1, %c1_i64, %0 : i1, i64
    %2 = llvm.select %arg1, %c-43_i64, %c16_i64 : i1, i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.sdiv %3, %c-17_i64 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.lshr %arg0, %0 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c43_i64 = arith.constant 43 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "sle" %c42_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %c27_i64 : i64
    %2 = llvm.select %0, %c-19_i64, %1 : i1, i64
    %3 = llvm.xor %c43_i64, %c-45_i64 : i64
    %4 = llvm.or %c-15_i64, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "sgt" %arg2, %c-25_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c36_i64 = arith.constant 36 : i64
    %true = arith.constant true
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.sdiv %c-26_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.select %true, %c36_i64, %c-42_i64 : i1, i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.xor %1, %c30_i64 : i64
    %3 = llvm.srem %arg1, %arg1 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c2_i64 = arith.constant 2 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.xor %c18_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %c2_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %arg1, %arg2 : i64
    %4 = llvm.xor %c-20_i64, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.ashr %c1_i64, %arg0 : i64
    %1 = llvm.srem %0, %c32_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.sdiv %arg1, %arg2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-4_i64 = arith.constant -4 : i64
    %false = arith.constant false
    %c28_i64 = arith.constant 28 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.select %false, %c28_i64, %c-48_i64 : i1, i64
    %1 = llvm.ashr %arg0, %c-4_i64 : i64
    %2 = llvm.select %false, %1, %c22_i64 : i1, i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.udiv %0, %c30_i64 : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.ashr %arg0, %c-20_i64 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg2, %c-38_i64 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c-42_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %0, %c-20_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ult" %4, %c-7_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "sle" %c-13_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.urem %1, %c12_i64 : i64
    %3 = llvm.icmp "eq" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.ashr %c0_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c2_i64 = arith.constant 2 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.select %arg0, %arg1, %c33_i64 : i1, i64
    %1 = llvm.icmp "sgt" %0, %c11_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %c2_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "ugt" %c-26_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "ult" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %c14_i64 : i64
    %3 = llvm.select %2, %arg1, %arg0 : i1, i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "ne" %c14_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.lshr %c41_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "sle" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.ashr %arg1, %c0_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.icmp "ugt" %c-3_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %c4_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ugt" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.lshr %0, %c24_i64 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %c32_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.sdiv %4, %c12_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "eq" %0, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %2, %c12_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.srem %c-46_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.udiv %arg0, %arg1 : i64
    %3 = llvm.ashr %c25_i64, %arg1 : i64
    %4 = llvm.srem %3, %2 : i64
    %5 = llvm.select %1, %2, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.srem %c-30_i64, %2 : i64
    %4 = llvm.udiv %arg2, %3 : i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %c-12_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.urem %0, %c-26_i64 : i64
    %2 = llvm.or %arg1, %arg2 : i64
    %3 = llvm.urem %2, %c43_i64 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c11_i64 = arith.constant 11 : i64
    %c37_i64 = arith.constant 37 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.sdiv %arg0, %c19_i64 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.sdiv %c-5_i64, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.and %c37_i64, %3 : i64
    %5 = llvm.icmp "ule" %c11_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %true = arith.constant true
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.and %c46_i64, %arg0 : i64
    %1 = llvm.select %true, %0, %arg1 : i1, i64
    %2 = llvm.urem %c4_i64, %1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %true = arith.constant true
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.xor %c25_i64, %arg0 : i64
    %1 = llvm.select %true, %c47_i64, %0 : i1, i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %2, %c-14_i64 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.or %c6_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.lshr %3, %c-31_i64 : i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.or %c-34_i64, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.select %arg0, %c-36_i64, %c-33_i64 : i1, i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %arg1, %arg1 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.and %c-23_i64, %arg0 : i64
    %1 = llvm.or %arg1, %arg1 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.urem %arg2, %0 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.udiv %c-49_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.udiv %1, %c-31_i64 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.lshr %3, %c22_i64 : i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %c-30_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %c-20_i64, %c-12_i64 : i64
    %1 = llvm.icmp "slt" %c-32_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %2, %c-44_i64 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.urem %c5_i64, %c-45_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.lshr %2, %arg2 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.urem %c-26_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %c-41_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %arg2, %2 : i64
    %4 = llvm.and %arg1, %3 : i64
    %5 = llvm.select %1, %0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.udiv %arg0, %arg2 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.srem %c33_i64, %arg1 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg2, %c31_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.srem %4, %2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.or %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.or %c-17_i64, %arg2 : i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c15_i64 = arith.constant 15 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %c40_i64, %0 : i64
    %2 = llvm.sdiv %0, %0 : i64
    %3 = llvm.select %1, %2, %arg2 : i1, i64
    %4 = llvm.select %1, %c15_i64, %c12_i64 : i1, i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c24_i64 = arith.constant 24 : i64
    %c44_i64 = arith.constant 44 : i64
    %true = arith.constant true
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.select %true, %c35_i64, %0 : i1, i64
    %2 = llvm.srem %c44_i64, %1 : i64
    %3 = llvm.srem %c-46_i64, %2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "ne" %c24_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c1_i64 = arith.constant 1 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.or %c-18_i64, %arg0 : i64
    %1 = llvm.ashr %0, %c1_i64 : i64
    %2 = llvm.urem %c32_i64, %arg0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.select %3, %4, %arg2 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %c2_i64, %arg2 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %true = arith.constant true
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.urem %c32_i64, %arg0 : i64
    %1 = llvm.select %true, %arg1, %c49_i64 : i1, i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "ult" %3, %0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.lshr %c18_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "sgt" %c-12_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %c23_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.select %arg0, %c-17_i64, %arg1 : i1, i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.icmp "ule" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.or %arg1, %0 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "sgt" %c-42_i64, %c-28_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %c-16_i64, %c-41_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c39_i64 = arith.constant 39 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.srem %c32_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c39_i64 : i64
    %2 = llvm.srem %1, %c50_i64 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.udiv %c10_i64, %arg0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.xor %c-37_i64, %arg0 : i64
    %1 = llvm.or %c36_i64, %arg1 : i64
    %2 = llvm.xor %arg2, %0 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c41_i64 = arith.constant 41 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.xor %c-32_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %c41_i64, %c40_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %c13_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %c34_i64, %2 : i64
    %4 = llvm.ashr %2, %arg0 : i64
    %5 = llvm.udiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %c-13_i64 = arith.constant -13 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.sdiv %c-13_i64, %c-42_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.select %arg0, %c-30_i64, %c-36_i64 : i1, i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.and %c10_i64, %arg2 : i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.icmp "sle" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.udiv %c-22_i64, %arg0 : i64
    %1 = llvm.sdiv %c-3_i64, %c-5_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.ashr %arg0, %arg0 : i64
    %4 = llvm.ashr %3, %0 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %c-1_i64, %0 : i64
    %2 = llvm.or %arg0, %arg0 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-14_i64 = arith.constant -14 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.udiv %c-14_i64, %c13_i64 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.select %arg1, %1, %2 : i1, i64
    %4 = llvm.srem %3, %c-18_i64 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c39_i64 = arith.constant 39 : i64
    %c22_i64 = arith.constant 22 : i64
    %c34_i64 = arith.constant 34 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.sdiv %c34_i64, %c50_i64 : i64
    %1 = llvm.urem %c39_i64, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.lshr %2, %c3_i64 : i64
    %4 = llvm.udiv %c22_i64, %3 : i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.or %c35_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.icmp "sle" %3, %2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %true, %arg1, %arg0 : i1, i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "slt" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.lshr %c-13_i64, %c33_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.select %3, %arg1, %arg1 : i1, i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.sdiv %c-33_i64, %3 : i64
    %5 = llvm.icmp "ult" %c-24_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %c-10_i64, %0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.udiv %c46_i64, %arg2 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %arg2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %c26_i64, %0 : i64
    %2 = llvm.or %0, %c46_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.ashr %c-42_i64, %1 : i64
    %3 = llvm.ashr %1, %c-29_i64 : i64
    %4 = llvm.select %arg0, %2, %3 : i1, i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %c-44_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %true = arith.constant true
    %false = arith.constant false
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.lshr %arg0, %c-6_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.lshr %arg1, %c-36_i64 : i64
    %5 = llvm.select %false, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.srem %c-20_i64, %c-39_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "slt" %3, %0 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c11_i64 = arith.constant 11 : i64
    %false = arith.constant false
    %c-15_i64 = arith.constant -15 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.srem %arg0, %c43_i64 : i64
    %1 = llvm.ashr %0, %c-15_i64 : i64
    %2 = llvm.select %false, %arg0, %c11_i64 : i1, i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "sge" %4, %c-21_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.or %arg0, %arg1 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.srem %c10_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.and %arg0, %arg2 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c16_i64 = arith.constant 16 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %c-34_i64, %c48_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.xor %c16_i64, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "eq" %3, %c-23_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.ashr %c-7_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "uge" %c-10_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %c47_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c47_i64 = arith.constant 47 : i64
    %c31_i64 = arith.constant 31 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.xor %c31_i64, %c-10_i64 : i64
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %2 = llvm.ashr %1, %c-38_i64 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %c47_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.xor %c25_i64, %arg0 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.icmp "ne" %arg1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.icmp "ule" %4, %c13_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.udiv %arg0, %arg2 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.or %c47_i64, %2 : i64
    %4 = llvm.urem %c-14_i64, %c12_i64 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.or %c12_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "sge" %c-1_i64, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "ne" %4, %c-23_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c13_i64 = arith.constant 13 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "eq" %c13_i64, %c17_i64 : i64
    %1 = llvm.and %c19_i64, %arg0 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.urem %arg0, %arg2 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.xor %4, %arg0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %c48_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %c1_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c43_i64 = arith.constant 43 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.xor %c-20_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "eq" %c43_i64, %c33_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %3, %1 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %arg0, %c30_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.ashr %0, %arg0 : i64
    %4 = llvm.select %2, %0, %3 : i1, i64
    %5 = llvm.icmp "slt" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.xor %arg0, %c-25_i64 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.and %arg1, %c33_i64 : i64
    %3 = llvm.select %1, %arg0, %2 : i1, i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ne" %arg1, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.and %c-27_i64, %2 : i64
    %4 = llvm.or %2, %arg0 : i64
    %5 = llvm.srem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "slt" %4, %c-11_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.srem %c46_i64, %c40_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ule" %c-5_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.and %2, %c-29_i64 : i64
    %4 = llvm.udiv %2, %arg2 : i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c36_i64 = arith.constant 36 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "ne" %arg0, %c23_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c36_i64, %1 : i64
    %3 = llvm.udiv %arg1, %1 : i64
    %4 = llvm.srem %3, %c45_i64 : i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.xor %c44_i64, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.udiv %arg2, %c-16_i64 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %c36_i64, %0 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.srem %3, %c-23_i64 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sgt" %arg0, %c6_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.srem %c41_i64, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg0 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.and %c40_i64, %c-15_i64 : i64
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.urem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.sdiv %arg1, %c-14_i64 : i64
    %3 = llvm.srem %c43_i64, %2 : i64
    %4 = llvm.udiv %3, %c19_i64 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.sdiv %c-44_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %c43_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.and %arg2, %0 : i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %c-3_i64, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.and %1, %arg1 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.or %arg1, %c11_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.udiv %arg2, %arg1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %1, %4, %arg0 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %c48_i64, %0 : i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %c-44_i64, %c-14_i64 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-2_i64 = arith.constant -2 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.srem %c-2_i64, %c-11_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    %3 = llvm.select %2, %c-13_i64, %arg2 : i1, i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.and %c15_i64, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %arg1, %arg2 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "sgt" %arg0, %c43_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %c26_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "ult" %c-1_i64, %c-26_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %c19_i64 : i64
    %3 = llvm.icmp "sgt" %1, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.srem %c47_i64, %arg0 : i64
    %1 = llvm.urem %c33_i64, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %arg1, %3, %3 : i1, i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %arg2, %c-29_i64 : i1, i64
    %2 = llvm.icmp "ule" %c30_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %c-42_i64, %3 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.xor %c-42_i64, %c-9_i64 : i64
    %1 = llvm.ashr %0, %c50_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.srem %2, %arg0 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-33_i64 = arith.constant -33 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.lshr %c-33_i64, %arg0 : i64
    %3 = llvm.lshr %c-9_i64, %1 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.udiv %c-20_i64, %arg1 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.or %1, %c23_i64 : i64
    %3 = llvm.icmp "sle" %2, %c-46_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %4, %c11_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c18_i64 = arith.constant 18 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %arg1, %arg2, %c40_i64 : i1, i64
    %2 = llvm.select %arg0, %1, %c18_i64 : i1, i64
    %3 = llvm.xor %0, %c14_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.urem %1, %c4_i64 : i64
    %3 = llvm.icmp "slt" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "eq" %arg0, %c16_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg1, %arg2 : i64
    %3 = llvm.select %2, %arg2, %arg0 : i1, i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.or %4, %arg1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.select %arg0, %c-12_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ne" %0, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c-6_i64, %2 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "ne" %c50_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c16_i64 = arith.constant 16 : i64
    %c45_i64 = arith.constant 45 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.and %c45_i64, %c38_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %c16_i64, %3 : i64
    %5 = llvm.lshr %4, %c-35_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %c-29_i64 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %c-29_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-19_i64 = arith.constant -19 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %arg0, %c-19_i64 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.ashr %arg1, %c39_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.ashr %arg0, %c-42_i64 : i64
    %1 = llvm.ashr %c-34_i64, %0 : i64
    %2 = llvm.udiv %1, %c-33_i64 : i64
    %3 = llvm.icmp "ule" %c-40_i64, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c15_i64 = arith.constant 15 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.srem %c32_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.ashr %c15_i64, %c-12_i64 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "uge" %c-34_i64, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg1, %arg0 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %arg1 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.xor %arg2, %c25_i64 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %arg1, %c45_i64 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "uge" %c-38_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %c0_i64, %c30_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.xor %c-43_i64, %arg0 : i64
    %1 = llvm.and %c-27_i64, %arg0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %arg1, %0 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.udiv %c-30_i64, %arg0 : i64
    %1 = llvm.xor %c-47_i64, %0 : i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %2, %3, %1 : i1, i64
    %5 = llvm.sdiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.srem %c0_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %arg0, %c13_i64 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.select %false, %c-28_i64, %arg0 : i1, i64
    %1 = llvm.icmp "sge" %arg0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c4_i64 = arith.constant 4 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %c7_i64 : i64
    %2 = llvm.ashr %0, %c4_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.lshr %c-43_i64, %arg1 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.lshr %c-22_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "ugt" %c40_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.urem %c-12_i64, %1 : i64
    %3 = llvm.udiv %2, %c-24_i64 : i64
    %4 = llvm.icmp "sge" %3, %arg0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %c12_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.and %arg2, %c-18_i64 : i64
    %5 = llvm.ashr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.lshr %c-35_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.ashr %c-12_i64, %1 : i64
    %3 = llvm.lshr %c-49_i64, %arg0 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.xor %c-32_i64, %c24_i64 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.select %arg0, %1, %1 : i1, i64
    %3 = llvm.and %c14_i64, %2 : i64
    %4 = llvm.xor %3, %arg2 : i64
    %5 = llvm.select %arg0, %0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-3_i64 = arith.constant -3 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.or %1, %c-19_i64 : i64
    %3 = llvm.lshr %c-3_i64, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.sext %arg2 : i1 to i64
    %1 = llvm.or %c-38_i64, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "slt" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %c15_i64, %0 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.urem %c45_i64, %2 : i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %false = arith.constant false
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.select %2, %c-35_i64, %3 : i1, i64
    %5 = llvm.icmp "ult" %c39_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %c-9_i64, %c4_i64 : i64
    %4 = llvm.select %3, %2, %c-12_i64 : i1, i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c4_i64 = arith.constant 4 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.xor %c4_i64, %c23_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.ashr %c31_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %c-27_i64, %c-33_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.srem %arg0, %1 : i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.ashr %arg1, %c-35_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.icmp "ule" %3, %c-21_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %c-49_i64, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.lshr %2, %arg1 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c-6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %arg1, %c-6_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.select %false, %2, %c-31_i64 : i1, i64
    %4 = llvm.select %arg0, %0, %3 : i1, i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c49_i64 = arith.constant 49 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.urem %c31_i64, %arg0 : i64
    %1 = llvm.srem %c49_i64, %0 : i64
    %2 = llvm.sdiv %c-47_i64, %c47_i64 : i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "ugt" %4, %c-23_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "sge" %arg0, %c11_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.lshr %3, %arg2 : i64
    %5 = llvm.xor %c3_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.zext %arg2 : i1 to i64
    %1 = llvm.sdiv %0, %c49_i64 : i64
    %2 = llvm.urem %1, %c-30_i64 : i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.udiv %4, %c-44_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.srem %2, %c-38_i64 : i64
    %4 = llvm.and %3, %c21_i64 : i64
    %5 = llvm.select %1, %4, %c-47_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %c-13_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.or %4, %arg0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.sdiv %c-7_i64, %c-24_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %c-24_i64, %c41_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.xor %0, %0 : i64
    %3 = llvm.xor %2, %c47_i64 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "sge" %c44_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "ule" %arg1, %arg2 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.udiv %c1_i64, %c18_i64 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.srem %c9_i64, %c2_i64 : i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.urem %arg1, %arg2 : i64
    %3 = llvm.icmp "uge" %2, %c17_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.xor %c34_i64, %c-3_i64 : i64
    %1 = llvm.ashr %0, %c-46_i64 : i64
    %2 = llvm.lshr %c9_i64, %arg0 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %c-41_i64, %0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.srem %c10_i64, %0 : i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %c42_i64, %0 : i64
    %2 = llvm.icmp "ne" %arg1, %c-47_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %3, %arg2 : i64
    %5 = llvm.select %1, %4, %c3_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %c33_i64 = arith.constant 33 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "ugt" %c-44_i64, %c21_i64 : i64
    %1 = llvm.select %0, %c36_i64, %c33_i64 : i1, i64
    %2 = llvm.select %false, %1, %arg0 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.zext %arg1 : i1 to i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %c-9_i64, %c42_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.urem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.lshr %c-12_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.or %arg1, %arg2 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.udiv %4, %c-16_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %3, %1 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.sdiv %c5_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %c30_i64, %0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c-42_i64, %c-7_i64 : i64
    %3 = llvm.udiv %2, %c16_i64 : i64
    %4 = llvm.lshr %arg2, %3 : i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.lshr %c-11_i64, %c42_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "ugt" %c1_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %c-6_i64, %3 : i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %c31_i64, %0 : i64
    %2 = llvm.srem %c11_i64, %arg0 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %c-33_i64 : i1, i64
    %3 = llvm.icmp "eq" %c11_i64, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c7_i64 = arith.constant 7 : i64
    %c20_i64 = arith.constant 20 : i64
    %c45_i64 = arith.constant 45 : i64
    %c6_i64 = arith.constant 6 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ult" %c6_i64, %c43_i64 : i64
    %1 = llvm.icmp "ult" %c20_i64, %c7_i64 : i64
    %2 = llvm.select %1, %c18_i64, %arg0 : i1, i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.select %0, %3, %3 : i1, i64
    %5 = llvm.icmp "uge" %c45_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.sdiv %arg0, %c32_i64 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.sdiv %c-28_i64, %3 : i64
    %5 = llvm.icmp "ult" %c-15_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %c-38_i64 = arith.constant -38 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.urem %c-38_i64, %c31_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c32_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.udiv %c37_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sge" %c-38_i64, %3 : i64
    %5 = llvm.select %4, %arg2, %c48_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ne" %c14_i64, %0 : i64
    %2 = llvm.select %1, %0, %arg1 : i1, i64
    %3 = llvm.xor %c1_i64, %0 : i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.srem %arg2, %c15_i64 : i64
    %2 = llvm.urem %arg2, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "ult" %3, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg1, %0 : i1, i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.select %false, %arg1, %2 : i1, i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ugt" %c-50_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %3, %arg1, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.xor %1, %c-17_i64 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg1, %c9_i64, %arg0 : i1, i64
    %4 = llvm.xor %3, %c25_i64 : i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.icmp "uge" %arg1, %c10_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.ashr %1, %c19_i64 : i64
    %3 = llvm.icmp "eq" %arg1, %2 : i64
    %4 = llvm.select %3, %arg1, %c-36_i64 : i1, i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "eq" %c40_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.xor %3, %1 : i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "ugt" %c30_i64, %c-17_i64 : i64
    %1 = llvm.srem %arg0, %c-22_i64 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %0, %c-39_i64, %3 : i1, i64
    %5 = llvm.udiv %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.and %c26_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %c-25_i64, %0 : i64
    %2 = llvm.srem %arg0, %0 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.select %1, %4, %c-17_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.xor %c-16_i64, %arg0 : i64
    %1 = llvm.and %0, %c23_i64 : i64
    %2 = llvm.srem %arg1, %c9_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.ashr %c23_i64, %arg0 : i64
    %1 = llvm.or %c1_i64, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.lshr %3, %arg2 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.and %arg0, %c-9_i64 : i64
    %1 = llvm.icmp "ugt" %c-1_i64, %0 : i64
    %2 = llvm.urem %c-35_i64, %0 : i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    %5 = llvm.icmp "sle" %c21_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.lshr %c33_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %arg1, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c-30_i64, %c46_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %c-2_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %c26_i64, %1 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c0_i64 = arith.constant 0 : i64
    %c50_i64 = arith.constant 50 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.urem %c50_i64, %c40_i64 : i64
    %1 = llvm.sdiv %c0_i64, %arg0 : i64
    %2 = llvm.or %0, %c32_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.icmp "sge" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c33_i64 = arith.constant 33 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "eq" %c33_i64, %c35_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %arg2, %0, %2 : i1, i64
    %4 = llvm.lshr %arg1, %3 : i64
    %5 = llvm.srem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.and %c19_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "ne" %3, %arg2 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %c6_i64, %0 : i64
    %2 = llvm.icmp "sle" %c14_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.lshr %c-39_i64, %c-44_i64 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.icmp "ne" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.icmp "sgt" %2, %c27_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c48_i64 = arith.constant 48 : i64
    %true = arith.constant true
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.lshr %arg0, %c-18_i64 : i64
    %1 = llvm.select %true, %c48_i64, %arg1 : i1, i64
    %2 = llvm.xor %1, %c8_i64 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.srem %3, %2 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.lshr %arg1, %c-44_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ne" %c5_i64, %c-28_i64 : i64
    %3 = llvm.select %2, %c-37_i64, %0 : i1, i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %arg1, %arg2 : i64
    %4 = llvm.or %3, %2 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "ult" %c-5_i64, %c15_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.trunc %0 : i1 to i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "ule" %arg1, %c15_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg2, %c8_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg1, %arg2 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.ashr %arg2, %1 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.icmp "ne" %arg1, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.lshr %arg2, %3 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c5_i64 = arith.constant 5 : i64
    %c9_i64 = arith.constant 9 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.and %c9_i64, %c41_i64 : i64
    %1 = llvm.lshr %0, %c5_i64 : i64
    %2 = llvm.icmp "ule" %1, %c-43_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.icmp "ule" %c-33_i64, %c-10_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "sle" %3, %c-28_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "eq" %arg0, %c-14_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.srem %4, %c30_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sge" %0, %c-35_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.lshr %c4_i64, %arg0 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %4, %1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %c1_i64, %arg2 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.urem %c-30_i64, %c7_i64 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.sdiv %c22_i64, %arg0 : i64
    %1 = llvm.udiv %c-5_i64, %c-48_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.icmp "sle" %3, %arg0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %c-42_i64 : i64
    %2 = llvm.xor %c25_i64, %1 : i64
    %3 = llvm.icmp "slt" %arg1, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.lshr %arg1, %c-48_i64 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %4, %c31_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.lshr %c-49_i64, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.ashr %4, %arg1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %4, %0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ne" %arg1, %c31_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c32_i64 = arith.constant 32 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.srem %c30_i64, %arg0 : i64
    %1 = llvm.or %c-19_i64, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ne" %c32_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.urem %2, %c-28_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "sle" %c5_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.lshr %arg2, %c-32_i64 : i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.or %c-48_i64, %1 : i64
    %3 = llvm.or %2, %c-21_i64 : i64
    %4 = llvm.or %2, %1 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.or %c43_i64, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %c-8_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.or %3, %1 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.lshr %c-11_i64, %c50_i64 : i64
    %1 = llvm.icmp "ugt" %0, %c39_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %c21_i64, %2 : i64
    %4 = llvm.udiv %3, %0 : i64
    %5 = llvm.icmp "sge" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "ne" %c45_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.xor %4, %3 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.xor %c-23_i64, %c3_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.select %arg2, %arg0, %2 : i1, i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %arg0, %c-4_i64 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %c11_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.sdiv %c-42_i64, %arg0 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %1, %arg0 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "sle" %c50_i64, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "ult" %c-39_i64, %c-2_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %c45_i64, %c24_i64 : i1, i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %c-2_i64, %0 : i64
    %2 = llvm.select %false, %arg2, %c-34_i64 : i1, i64
    %3 = llvm.icmp "ult" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.lshr %arg1, %c-26_i64 : i64
    %1 = llvm.srem %arg2, %0 : i64
    %2 = llvm.sdiv %1, %c-44_i64 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.icmp "slt" %4, %c27_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c24_i64 = arith.constant 24 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.urem %c-32_i64, %c6_i64 : i64
    %1 = llvm.and %c-37_i64, %c9_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.urem %c24_i64, %2 : i64
    %4 = llvm.icmp "ne" %c-31_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c5_i64 = arith.constant 5 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %c5_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %4, %c-24_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.sdiv %c35_i64, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.or %c-8_i64, %arg1 : i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.srem %arg0, %c-11_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.select %1, %arg1, %0 : i1, i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.ashr %3, %arg0 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %0, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %4, %c-50_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "eq" %c44_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.icmp "ne" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sgt" %4, %c41_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.lshr %c-11_i64, %c-41_i64 : i64
    %1 = llvm.lshr %c50_i64, %c-37_i64 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.or %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.lshr %c-20_i64, %3 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.and %arg1, %0 : i64
    %3 = llvm.icmp "ult" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c35_i64 = arith.constant 35 : i64
    %c22_i64 = arith.constant 22 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "ule" %c22_i64, %c-2_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %c35_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %3, %c-35_i64 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c6_i64 = arith.constant 6 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %c6_i64, %0 : i64
    %2 = llvm.xor %c39_i64, %arg0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %false, %0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %false = arith.constant false
    %c-35_i64 = arith.constant -35 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.ashr %c12_i64, %arg0 : i64
    %1 = llvm.select %false, %c-35_i64, %0 : i1, i64
    %2 = llvm.srem %1, %c-5_i64 : i64
    %3 = llvm.select %arg1, %arg0, %1 : i1, i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.sdiv %c37_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "ne" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c1_i64 = arith.constant 1 : i64
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.sdiv %arg2, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.urem %c1_i64, %c-10_i64 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "eq" %c47_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %arg1, %arg0 : i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-31_i64 = arith.constant -31 : i64
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.select %false, %c-31_i64, %0 : i1, i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.select %arg1, %2, %c26_i64 : i1, i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "sgt" %c-27_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "ule" %1, %c0_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.and %arg0, %c-22_i64 : i64
    %1 = llvm.and %c-28_i64, %0 : i64
    %2 = llvm.udiv %arg1, %c-26_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %true = arith.constant true
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.select %true, %arg0, %1 : i1, i64
    %3 = llvm.icmp "eq" %c-46_i64, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c48_i64 = arith.constant 48 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "uge" %c48_i64, %c24_i64 : i64
    %1 = llvm.select %0, %c-38_i64, %c21_i64 : i1, i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %arg0, %1 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.ashr %arg1, %0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.ashr %c-22_i64, %c-23_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.lshr %1, %c-27_i64 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.srem %0, %arg0 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.sdiv %c-31_i64, %c0_i64 : i64
    %1 = llvm.lshr %c21_i64, %c-46_i64 : i64
    %2 = llvm.urem %0, %c-2_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.and %4, %1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %c49_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %c12_i64, %arg2 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %c8_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.urem %c15_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %arg1, %c38_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "uge" %3, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %true = arith.constant true
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.lshr %c-14_i64, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.zext %arg1 : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.ashr %c4_i64, %arg0 : i64
    %1 = llvm.or %0, %c-32_i64 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.xor %c-34_i64, %2 : i64
    %4 = llvm.icmp "sgt" %3, %arg1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "eq" %c41_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-11_i64 = arith.constant -11 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %0, %c-11_i64 : i64
    %2 = llvm.udiv %1, %c44_i64 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.udiv %c-23_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.ashr %0, %c-33_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.select %3, %arg1, %arg2 : i1, i64
    %5 = llvm.icmp "ne" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.sdiv %c22_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.lshr %2, %c-41_i64 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.udiv %arg0, %0 : i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c3_i64 = arith.constant 3 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.or %c-18_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %2, %c3_i64, %3 : i1, i64
    %5 = llvm.icmp "sgt" %4, %c28_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.or %arg2, %arg2 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.ashr %c-41_i64, %arg1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %false = arith.constant false
    %c47_i64 = arith.constant 47 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.srem %c-31_i64, %c-46_i64 : i64
    %1 = llvm.select %false, %arg0, %arg0 : i1, i64
    %2 = llvm.srem %c47_i64, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.sdiv %1, %c-45_i64 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.udiv %c5_i64, %arg0 : i64
    %1 = llvm.or %0, %c-31_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.or %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg2, %c-18_i64 : i64
    %3 = llvm.select %arg1, %arg0, %2 : i1, i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "ule" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %true = arith.constant true
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.xor %arg2, %c49_i64 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.sdiv %2, %c-3_i64 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c-44_i64 = arith.constant -44 : i64
    %false = arith.constant false
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %false, %0, %arg1 : i1, i64
    %2 = llvm.udiv %c-44_i64, %1 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.ashr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %c1_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %3, %c0_i64 : i64
    %5 = llvm.icmp "ne" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg1, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ne" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.srem %c-2_i64, %c-29_i64 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.trunc %arg2 : i1 to i64
    %1 = llvm.srem %0, %c45_i64 : i64
    %2 = llvm.icmp "sgt" %arg1, %1 : i64
    %3 = llvm.udiv %0, %0 : i64
    %4 = llvm.select %2, %3, %arg0 : i1, i64
    %5 = llvm.xor %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.urem %arg1, %arg2 : i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "ult" %c10_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %c47_i64, %3 : i64
    %5 = llvm.urem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "slt" %c-1_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg1, %c18_i64 : i64
    %3 = llvm.icmp "sgt" %2, %arg1 : i64
    %4 = llvm.select %3, %arg2, %arg0 : i1, i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c34_i64 = arith.constant 34 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "uge" %c34_i64, %c23_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c-22_i64, %1 : i64
    %3 = llvm.icmp "ne" %2, %c-11_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %4, %c-47_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.lshr %arg0, %c22_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "ne" %c34_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.urem %c-34_i64, %0 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
