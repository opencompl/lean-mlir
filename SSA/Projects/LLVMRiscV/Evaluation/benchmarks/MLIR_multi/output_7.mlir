module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "uge" %c-28_i64, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %4, %arg2 : i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.urem %c-4_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %arg2, %c-12_i64 : i64
    %4 = llvm.srem %3, %0 : i64
    %5 = llvm.xor %arg1, %4 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.trunc %arg2 : i1 to i64
    %1 = llvm.and %c12_i64, %0 : i64
    %2 = llvm.icmp "ne" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %c-49_i64, %0 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "eq" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.urem %c-7_i64, %c33_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.xor %1, %c-2_i64 : i64
    %3 = llvm.and %arg1, %arg2 : i64
    %4 = llvm.icmp "sgt" %3, %arg0 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %c26_i64, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.lshr %2, %1 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sle" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.sdiv %arg1, %4 : i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "sgt" %c-43_i64, %c-8_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %3, %c48_i64 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.ashr %5, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %c49_i64, %0 : i64
    %2 = llvm.udiv %c48_i64, %0 : i64
    %3 = llvm.lshr %1, %arg1 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c-11_i64 = arith.constant -11 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.srem %c-11_i64, %0 : i64
    %3 = llvm.icmp "uge" %2, %2 : i64
    %4 = llvm.or %c11_i64, %arg1 : i64
    %5 = llvm.select %3, %4, %1 : i1, i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.urem %c2_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %c-37_i64, %c-45_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.srem %3, %arg1 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "eq" %0, %c6_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %arg1, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %c-13_i64, %4 : i64
    %6 = llvm.or %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.ashr %arg0, %c-19_i64 : i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.sdiv %4, %4 : i64
    %6 = llvm.icmp "ule" %c-14_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ugt" %arg0, %c-27_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg1, %c42_i64 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.icmp "ne" %arg1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "ne" %4, %arg2 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "ugt" %arg0, %c-1_i64 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %c-30_i64 : i1, i64
    %3 = llvm.icmp "ult" %c-46_i64, %c6_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %4, %c-2_i64 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sext %2 : i1 to i64
    %5 = llvm.urem %arg2, %4 : i64
    %6 = llvm.icmp "eq" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c28_i64 = arith.constant 28 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.xor %c37_i64, %arg0 : i64
    %1 = llvm.srem %c28_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %c44_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.ashr %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %arg1, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.srem %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "sle" %arg0, %c46_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %c-45_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.sdiv %4, %3 : i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %2, %arg2, %3 : i1, i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sge" %4, %2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.udiv %c4_i64, %c-28_i64 : i64
    %1 = llvm.srem %c-8_i64, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.trunc %arg0 : i1 to i64
    %5 = llvm.srem %c-10_i64, %4 : i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %c29_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.or %arg1, %1 : i64
    %6 = llvm.urem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.udiv %c48_i64, %1 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.ashr %arg2, %2 : i64
    %6 = llvm.icmp "ult" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.icmp "ult" %c37_i64, %c-9_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c48_i64 = arith.constant 48 : i64
    %true = arith.constant true
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.or %c17_i64, %arg0 : i64
    %1 = llvm.select %true, %0, %arg1 : i1, i64
    %2 = llvm.and %c48_i64, %1 : i64
    %3 = llvm.icmp "sle" %2, %c-24_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %c-24_i64, %4 : i64
    %6 = llvm.lshr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.select %arg2, %1, %0 : i1, i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.xor %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.lshr %c10_i64, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.or %0, %0 : i64
    %4 = llvm.icmp "ult" %c46_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c10_i64 = arith.constant 10 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "sgt" %c14_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %c10_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.lshr %4, %3 : i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg1, %c-35_i64, %0 : i1, i64
    %2 = llvm.srem %1, %c10_i64 : i64
    %3 = llvm.sdiv %c-35_i64, %arg2 : i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.ashr %c-2_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.udiv %1, %c-20_i64 : i64
    %3 = llvm.or %arg2, %c23_i64 : i64
    %4 = llvm.ashr %c-23_i64, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c21_i64 = arith.constant 21 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "ult" %c21_i64, %1 : i64
    %3 = llvm.select %2, %0, %0 : i1, i64
    %4 = llvm.lshr %arg0, %c6_i64 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %c36_i64 = arith.constant 36 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.srem %c39_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.xor %1, %c36_i64 : i64
    %3 = llvm.and %c-29_i64, %c-29_i64 : i64
    %4 = llvm.srem %3, %arg1 : i64
    %5 = llvm.sdiv %4, %arg0 : i64
    %6 = llvm.udiv %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %true = arith.constant true
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.icmp "uge" %0, %c21_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %2, %c26_i64 : i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.and %arg1, %c22_i64 : i64
    %1 = llvm.urem %c-41_i64, %c7_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %arg0, %4 : i64
    %6 = llvm.or %5, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c15_i64 = arith.constant 15 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.ashr %c15_i64, %c28_i64 : i64
    %1 = llvm.select %arg0, %c-23_i64, %0 : i1, i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ule" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.select %true, %1, %arg0 : i1, i64
    %3 = llvm.xor %0, %0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.icmp "uge" %5, %arg0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.or %c-40_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.lshr %c-49_i64, %arg2 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.srem %4, %c12_i64 : i64
    %6 = llvm.icmp "uge" %c-6_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.xor %c-13_i64, %arg0 : i64
    %1 = llvm.urem %0, %c15_i64 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.select %arg1, %arg0, %c46_i64 : i1, i64
    %5 = llvm.ashr %4, %3 : i64
    %6 = llvm.udiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg1, %arg2 : i64
    %2 = llvm.or %arg1, %c-45_i64 : i64
    %3 = llvm.select %1, %2, %c-6_i64 : i1, i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.xor %2, %arg2 : i64
    %6 = llvm.select %0, %4, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.ashr %c-12_i64, %arg1 : i64
    %4 = llvm.lshr %arg2, %3 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.icmp "slt" %5, %arg0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %true = arith.constant true
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.udiv %c-9_i64, %arg0 : i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.and %c31_i64, %2 : i64
    %4 = llvm.ashr %arg0, %1 : i64
    %5 = llvm.sdiv %4, %1 : i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.ashr %c-14_i64, %arg0 : i64
    %1 = llvm.srem %c47_i64, %0 : i64
    %2 = llvm.sdiv %1, %c-2_i64 : i64
    %3 = llvm.srem %arg1, %c-23_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.urem %0, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c45_i64 = arith.constant 45 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.udiv %arg0, %c10_i64 : i64
    %1 = llvm.xor %c45_i64, %c-26_i64 : i64
    %2 = llvm.ashr %1, %c-47_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %0, %4 : i64
    %6 = llvm.icmp "sge" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c46_i64 = arith.constant 46 : i64
    %c10_i64 = arith.constant 10 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "sgt" %c9_i64, %c-5_i64 : i64
    %1 = llvm.or %arg0, %c10_i64 : i64
    %2 = llvm.lshr %1, %c46_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.sdiv %c17_i64, %arg1 : i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.select %0, %3, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %false = arith.constant false
    %c-5_i64 = arith.constant -5 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.select %false, %c-5_i64, %c42_i64 : i1, i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "ne" %arg0, %c5_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %c-8_i64 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "ugt" %arg2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.srem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c4_i64 = arith.constant 4 : i64
    %c8_i64 = arith.constant 8 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.select %1, %0, %c8_i64 : i1, i64
    %3 = llvm.and %2, %c4_i64 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.udiv %0, %c17_i64 : i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.xor %c-2_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sext %2 : i1 to i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.lshr %c-10_i64, %c-9_i64 : i64
    %1 = llvm.srem %c-23_i64, %0 : i64
    %2 = llvm.icmp "uge" %1, %c-50_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ne" %3, %c-35_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ult" %5, %arg0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %c-39_i64, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %arg2, %3 : i64
    %5 = llvm.select %arg1, %0, %4 : i1, i64
    %6 = llvm.sdiv %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.trunc %arg2 : i1 to i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c14_i64 = arith.constant 14 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.and %c14_i64, %c2_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "ult" %c-50_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %1, %c42_i64 : i64
    %5 = llvm.srem %c30_i64, %4 : i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c46_i64 = arith.constant 46 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "sge" %arg0, %c25_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %c13_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.udiv %3, %3 : i64
    %5 = llvm.or %c46_i64, %4 : i64
    %6 = llvm.or %5, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.udiv %c3_i64, %arg0 : i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.or %c-33_i64, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "slt" %3, %c-3_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sle" %5, %c28_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c50_i64 = arith.constant 50 : i64
    %false = arith.constant false
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.xor %arg0, %c10_i64 : i64
    %1 = llvm.select %false, %arg0, %arg0 : i1, i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.urem %arg1, %c50_i64 : i64
    %5 = llvm.urem %4, %c-36_i64 : i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %true = arith.constant true
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %c3_i64, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.urem %c-32_i64, %0 : i64
    %5 = llvm.ashr %4, %4 : i64
    %6 = llvm.sdiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %c27_i64, %0 : i64
    %2 = llvm.udiv %arg1, %c-23_i64 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.lshr %4, %1 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %c47_i64, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.select %arg1, %0, %2 : i1, i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.xor %4, %c-6_i64 : i64
    %6 = llvm.xor %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.udiv %arg0, %c-32_i64 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "sle" %arg2, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "uge" %4, %arg0 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %true = arith.constant true
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %arg0, %c20_i64, %arg1 : i1, i64
    %1 = llvm.select %true, %arg1, %arg2 : i1, i64
    %2 = llvm.or %arg2, %1 : i64
    %3 = llvm.ashr %c-11_i64, %0 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sdiv %c-11_i64, %c-30_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "ult" %1, %1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c16_i64 = arith.constant 16 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.and %arg2, %arg1 : i64
    %2 = llvm.srem %c15_i64, %arg2 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.srem %c16_i64, %2 : i64
    %5 = llvm.select %0, %3, %4 : i1, i64
    %6 = llvm.icmp "ule" %5, %c37_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.srem %arg1, %c-37_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.sdiv %0, %c-32_i64 : i64
    %4 = llvm.icmp "ule" %c13_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.udiv %arg2, %c-48_i64 : i64
    %2 = llvm.srem %1, %c-32_i64 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.ashr %c-47_i64, %3 : i64
    %5 = llvm.or %c8_i64, %4 : i64
    %6 = llvm.select %0, %arg2, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.lshr %0, %c41_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "eq" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.udiv %c-28_i64, %arg0 : i64
    %1 = llvm.srem %0, %c-22_i64 : i64
    %2 = llvm.urem %c-37_i64, %c44_i64 : i64
    %3 = llvm.srem %0, %arg1 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.or %arg2, %0 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.srem %c-49_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %c13_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.ashr %arg0, %arg2 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %arg0, %c48_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.icmp "sle" %c14_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "uge" %5, %2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %c-49_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.sdiv %0, %1 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.icmp "eq" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.xor %arg0, %c-49_i64 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %3, %c-2_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.and %5, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %c44_i64, %0 : i64
    %2 = llvm.urem %1, %c16_i64 : i64
    %3 = llvm.icmp "sgt" %c-46_i64, %2 : i64
    %4 = llvm.select %3, %1, %arg1 : i1, i64
    %5 = llvm.and %c18_i64, %4 : i64
    %6 = llvm.and %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c38_i64 = arith.constant 38 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %c-50_i64 : i64
    %3 = llvm.udiv %arg1, %c21_i64 : i64
    %4 = llvm.sdiv %c38_i64, %c-26_i64 : i64
    %5 = llvm.select %2, %3, %4 : i1, i64
    %6 = llvm.icmp "uge" %5, %4 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.udiv %arg0, %c45_i64 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.and %3, %3 : i64
    %5 = llvm.icmp "sgt" %4, %c-9_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.sdiv %c-8_i64, %arg0 : i64
    %5 = llvm.and %4, %c16_i64 : i64
    %6 = llvm.icmp "ne" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %c-3_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.ashr %1, %arg1 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.icmp "sgt" %c-30_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-38_i64 = arith.constant -38 : i64
    %false = arith.constant false
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %c38_i64, %0 : i64
    %2 = llvm.and %arg1, %arg2 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.xor %c-38_i64, %c14_i64 : i64
    %5 = llvm.select %false, %4, %c27_i64 : i1, i64
    %6 = llvm.icmp "ule" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c32_i64 = arith.constant 32 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "sle" %c32_i64, %c34_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.ashr %3, %c-28_i64 : i64
    %5 = llvm.lshr %c35_i64, %arg0 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.ashr %2, %c-24_i64 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.srem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c38_i64, %c-48_i64 : i64
    %3 = llvm.and %arg0, %1 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.icmp "sgt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.udiv %c-40_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.or %2, %c45_i64 : i64
    %4 = llvm.xor %arg2, %1 : i64
    %5 = llvm.urem %4, %c38_i64 : i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "ugt" %c-26_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.icmp "sge" %c-8_i64, %c0_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c-49_i64 = arith.constant -49 : i64
    %false = arith.constant false
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %c-24_i64, %arg2 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.select %false, %c-49_i64, %c-20_i64 : i1, i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.or %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.or %arg1, %c9_i64 : i64
    %1 = llvm.xor %0, %c16_i64 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.icmp "ult" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %4, %arg0 : i64
    %6 = llvm.icmp "sgt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %c-36_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.select %false, %0, %arg2 : i1, i64
    %5 = llvm.select %arg1, %3, %4 : i1, i64
    %6 = llvm.icmp "eq" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.or %c-40_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.icmp "ne" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.or %0, %arg2 : i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.urem %3, %c15_i64 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "sge" %c-14_i64, %c-4_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.lshr %2, %c48_i64 : i64
    %4 = llvm.xor %arg1, %arg2 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sgt" %5, %0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c35_i64 = arith.constant 35 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.sdiv %c32_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c35_i64 : i64
    %2 = llvm.lshr %0, %c0_i64 : i64
    %3 = llvm.icmp "ule" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.urem %c27_i64, %arg1 : i64
    %4 = llvm.udiv %3, %1 : i64
    %5 = llvm.and %4, %c39_i64 : i64
    %6 = llvm.and %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.sext %arg2 : i1 to i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.icmp "ne" %c-28_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.trunc %arg2 : i1 to i64
    %6 = llvm.srem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.icmp "uge" %5, %c14_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.udiv %c-7_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "ugt" %c-44_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c34_i64 = arith.constant 34 : i64
    %c2_i64 = arith.constant 2 : i64
    %c7_i64 = arith.constant 7 : i64
    %true = arith.constant true
    %c-8_i64 = arith.constant -8 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "ne" %c-8_i64, %c-38_i64 : i64
    %1 = llvm.select %true, %c7_i64, %c2_i64 : i1, i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %0, %3, %1 : i1, i64
    %5 = llvm.lshr %c34_i64, %c21_i64 : i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c22_i64 = arith.constant 22 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.ashr %arg0, %c-35_i64 : i64
    %1 = llvm.ashr %0, %c22_i64 : i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.sdiv %arg0, %arg1 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %arg1, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.srem %arg2, %c-10_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ule" %0, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %4, %arg1 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.ashr %c-12_i64, %c26_i64 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %c-26_i64, %arg2 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.ashr %c-31_i64, %4 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c7_i64 = arith.constant 7 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "sge" %arg1, %c19_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %arg0, %1, %1 : i1, i64
    %3 = llvm.lshr %arg1, %c-8_i64 : i64
    %4 = llvm.icmp "sgt" %c7_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.sdiv %3, %c45_i64 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c34_i64 = arith.constant 34 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.udiv %arg2, %c14_i64 : i64
    %2 = llvm.urem %c34_i64, %c13_i64 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.icmp "slt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg0 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.select %2, %arg2, %c-42_i64 : i1, i64
    %4 = llvm.sdiv %c49_i64, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c29_i64 = arith.constant 29 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c39_i64, %c29_i64 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.ashr %c-11_i64, %3 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.or %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %c-39_i64 = arith.constant -39 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.lshr %c-39_i64, %c-34_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.icmp "ule" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %c42_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %c-38_i64 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "ule" %arg0, %2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %false = arith.constant false
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %c38_i64, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.srem %3, %0 : i64
    %5 = llvm.or %4, %c-42_i64 : i64
    %6 = llvm.xor %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "slt" %c-33_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %c17_i64, %1 : i64
    %3 = llvm.lshr %1, %arg1 : i64
    %4 = llvm.ashr %3, %arg2 : i64
    %5 = llvm.udiv %4, %c33_i64 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %false = arith.constant false
    %c-43_i64 = arith.constant -43 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.urem %c-9_i64, %c26_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %c-43_i64, %3 : i64
    %5 = llvm.select %arg0, %arg1, %c34_i64 : i1, i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "ule" %c-19_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c27_i64, %1 : i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.urem %arg0, %c-45_i64 : i64
    %5 = llvm.or %arg1, %4 : i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "ule" %c20_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.ashr %arg2, %c47_i64 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c46_i64 = arith.constant 46 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %c20_i64, %arg0 : i64
    %1 = llvm.urem %c46_i64, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.udiv %arg1, %c6_i64 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.icmp "uge" %c-32_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "uge" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.icmp "sle" %arg2, %c32_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.srem %arg1, %4 : i64
    %6 = llvm.lshr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.and %c-34_i64, %1 : i64
    %3 = llvm.ashr %c-44_i64, %2 : i64
    %4 = llvm.udiv %1, %c-18_i64 : i64
    %5 = llvm.urem %4, %arg1 : i64
    %6 = llvm.or %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c18_i64 = arith.constant 18 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.and %c2_i64, %arg0 : i64
    %1 = llvm.and %c18_i64, %0 : i64
    %2 = llvm.icmp "slt" %c-44_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %3, %c36_i64 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %c-43_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %c-23_i64 : i64
    %2 = llvm.select %1, %arg1, %c-20_i64 : i1, i64
    %3 = llvm.select %1, %2, %2 : i1, i64
    %4 = llvm.icmp "uge" %3, %c48_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ule" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.srem %c39_i64, %arg1 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sge" %c26_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %false = arith.constant false
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %c23_i64, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.udiv %3, %c-42_i64 : i64
    %5 = llvm.and %4, %arg1 : i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c41_i64 = arith.constant 41 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.sdiv %c41_i64, %c23_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.select %arg0, %0, %arg1 : i1, i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.lshr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "sle" %c-31_i64, %c23_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c35_i64, %c1_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.zext %0 : i1 to i64
    %6 = llvm.urem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %c-36_i64, %c-46_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.udiv %5, %c43_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c21_i64 = arith.constant 21 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "ule" %c30_i64, %c-16_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c21_i64, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %4, %c-6_i64 : i64
    %6 = llvm.sdiv %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %0 : i1, i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.ashr %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.udiv %arg1, %2 : i64
    %6 = llvm.urem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %arg0, %arg1 : i1, i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.xor %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.srem %c45_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.xor %3, %c-2_i64 : i64
    %5 = llvm.ashr %arg0, %4 : i64
    %6 = llvm.xor %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %c-29_i64, %0 : i64
    %2 = llvm.icmp "ult" %arg1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %arg1, %0 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.lshr %0, %arg2 : i64
    %5 = llvm.srem %c2_i64, %4 : i64
    %6 = llvm.icmp "ne" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c-21_i64 = arith.constant -21 : i64
    %true = arith.constant true
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.select %true, %arg1, %c-30_i64 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.srem %1, %c-21_i64 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.ashr %3, %c-45_i64 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c25_i64 = arith.constant 25 : i64
    %c39_i64 = arith.constant 39 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c50_i64, %1 : i64
    %3 = llvm.udiv %2, %c39_i64 : i64
    %4 = llvm.icmp "eq" %c25_i64, %c-11_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.udiv %1, %c-11_i64 : i64
    %3 = llvm.lshr %c8_i64, %0 : i64
    %4 = llvm.srem %3, %c-24_i64 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.srem %0, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "sge" %c-16_i64, %c35_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "eq" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c26_i64 = arith.constant 26 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.ashr %arg2, %c3_i64 : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.xor %c26_i64, %c-2_i64 : i64
    %5 = llvm.urem %4, %c-8_i64 : i64
    %6 = llvm.icmp "sle" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.and %c20_i64, %c25_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %3, %arg0 : i64
    %5 = llvm.zext %2 : i1 to i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %c35_i64 = arith.constant 35 : i64
    %c12_i64 = arith.constant 12 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.urem %c12_i64, %c6_i64 : i64
    %1 = llvm.icmp "ne" %c35_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.urem %3, %c-29_i64 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c24_i64 = arith.constant 24 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.xor %c-13_i64, %1 : i64
    %3 = llvm.and %2, %c24_i64 : i64
    %4 = llvm.select %true, %arg1, %3 : i1, i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.zext %1 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %c8_i64 = arith.constant 8 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "ne" %c16_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %true, %c8_i64, %1 : i1, i64
    %3 = llvm.icmp "sgt" %c-22_i64, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c47_i64 = arith.constant 47 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "sge" %c34_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %c-41_i64 : i64
    %3 = llvm.icmp "ne" %c47_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %4, %arg1 : i64
    %6 = llvm.icmp "uge" %5, %2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.sdiv %c13_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.icmp "sgt" %5, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.sdiv %c1_i64, %arg1 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.udiv %4, %1 : i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.lshr %arg1, %arg2 : i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.and %c49_i64, %arg1 : i64
    %3 = llvm.or %2, %1 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.and %5, %arg2 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.xor %arg0, %c38_i64 : i64
    %1 = llvm.urem %c35_i64, %arg0 : i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c-38_i64 = arith.constant -38 : i64
    %false = arith.constant false
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.icmp "sgt" %arg1, %0 : i64
    %3 = llvm.urem %arg2, %c-21_i64 : i64
    %4 = llvm.select %2, %arg2, %3 : i1, i64
    %5 = llvm.ashr %c-38_i64, %4 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.select %false, %c-34_i64, %arg2 : i1, i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c11_i64 = arith.constant 11 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.urem %c14_i64, %c-49_i64 : i64
    %1 = llvm.xor %c21_i64, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.udiv %2, %c-49_i64 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.lshr %c11_i64, %4 : i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %false = arith.constant false
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.udiv %arg0, %c11_i64 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.srem %4, %c9_i64 : i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.sdiv %arg2, %2 : i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.and %4, %4 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %c6_i64, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ne" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %c7_i64, %0 : i64
    %2 = llvm.icmp "ule" %c-4_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %c-39_i64, %arg1 : i64
    %5 = llvm.select %4, %arg2, %c15_i64 : i1, i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %true = arith.constant true
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.srem %c3_i64, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.and %2, %c-39_i64 : i64
    %4 = llvm.icmp "ult" %3, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c8_i64 = arith.constant 8 : i64
    %false = arith.constant false
    %c0_i64 = arith.constant 0 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %c0_i64, %0 : i64
    %2 = llvm.select %false, %1, %c8_i64 : i1, i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.xor %3, %c6_i64 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c50_i64 = arith.constant 50 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.udiv %arg0, %c49_i64 : i64
    %1 = llvm.and %c-48_i64, %0 : i64
    %2 = llvm.udiv %c-36_i64, %c50_i64 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "ult" %c15_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.trunc %2 : i1 to i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg2, %arg2 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.srem %1, %c-26_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.ashr %arg2, %arg2 : i64
    %3 = llvm.udiv %2, %1 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.ashr %4, %arg0 : i64
    %6 = llvm.urem %5, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.lshr %c-16_i64, %2 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.sdiv %4, %arg0 : i64
    %6 = llvm.udiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "ult" %arg0, %c42_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.trunc %arg2 : i1 to i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c1_i64 = arith.constant 1 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.lshr %c-6_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c1_i64 : i64
    %2 = llvm.icmp "uge" %c-45_i64, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.and %5, %0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %4, %arg1 : i64
    %6 = llvm.ashr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c6_i64 : i64
    %2 = llvm.select %arg1, %0, %c48_i64 : i1, i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    %4 = llvm.select %3, %1, %arg2 : i1, i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.icmp "sge" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.and %c-49_i64, %c-15_i64 : i64
    %1 = llvm.sdiv %0, %c-33_i64 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.icmp "ne" %arg2, %arg1 : i64
    %5 = llvm.select %4, %arg1, %c7_i64 : i1, i64
    %6 = llvm.icmp "ule" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %0, %c2_i64 : i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.or %c7_i64, %4 : i64
    %6 = llvm.icmp "ule" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-33_i64 = arith.constant -33 : i64
    %true = arith.constant true
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.select %true, %arg0, %c-20_i64 : i1, i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.srem %arg2, %c-33_i64 : i64
    %4 = llvm.sdiv %c47_i64, %c-30_i64 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.lshr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.select %arg0, %arg1, %c-47_i64 : i1, i64
    %1 = llvm.and %c27_i64, %arg1 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.icmp "eq" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %c-28_i64, %4 : i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.xor %c-31_i64, %c-15_i64 : i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.srem %arg1, %4 : i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c50_i64 = arith.constant 50 : i64
    %c11_i64 = arith.constant 11 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.lshr %c11_i64, %c18_i64 : i64
    %1 = llvm.urem %0, %c-30_i64 : i64
    %2 = llvm.icmp "slt" %c41_i64, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.lshr %c50_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.udiv %c-41_i64, %c49_i64 : i64
    %1 = llvm.sdiv %c29_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.icmp "uge" %5, %3 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c36_i64 = arith.constant 36 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.xor %c-26_i64, %c25_i64 : i64
    %1 = llvm.icmp "sge" %c10_i64, %0 : i64
    %2 = llvm.srem %arg0, %0 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.icmp "sge" %3, %c-33_i64 : i64
    %5 = llvm.select %4, %2, %c18_i64 : i1, i64
    %6 = llvm.select %1, %c36_i64, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-44_i64 = arith.constant -44 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %c7_i64, %0 : i64
    %2 = llvm.icmp "ule" %c-44_i64, %1 : i64
    %3 = llvm.xor %0, %1 : i64
    %4 = llvm.select %2, %3, %3 : i1, i64
    %5 = llvm.select %true, %1, %arg1 : i1, i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c40_i64 = arith.constant 40 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "ule" %arg0, %c-8_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %c41_i64 : i64
    %3 = llvm.select %2, %arg1, %c40_i64 : i1, i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.sdiv %c-27_i64, %c-14_i64 : i64
    %6 = llvm.sdiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c43_i64 = arith.constant 43 : i64
    %c30_i64 = arith.constant 30 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.icmp "ule" %1, %arg2 : i64
    %3 = llvm.xor %c30_i64, %c43_i64 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.select %2, %3, %4 : i1, i64
    %6 = llvm.sdiv %c17_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg2, %c1_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %c-33_i64, %arg1 : i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.sdiv %5, %4 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "slt" %1, %c-40_i64 : i64
    %3 = llvm.select %2, %1, %1 : i1, i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.ashr %c-46_i64, %arg0 : i64
    %1 = llvm.and %c23_i64, %0 : i64
    %2 = llvm.udiv %arg1, %c9_i64 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.xor %4, %arg0 : i64
    %6 = llvm.sdiv %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.and %arg0, %c25_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c1_i64 = arith.constant 1 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "uge" %c1_i64, %c-13_i64 : i64
    %1 = llvm.sdiv %c-20_i64, %arg0 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.icmp "ugt" %arg1, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %arg1, %4 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.sdiv %arg1, %c34_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "eq" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.lshr %arg0, %c-46_i64 : i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.select %false, %0, %arg2 : i1, i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.udiv %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %c44_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "eq" %c-8_i64, %c20_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %c-35_i64 : i64
    %3 = llvm.or %c27_i64, %1 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.icmp "ne" %5, %2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-47_i64 = arith.constant -47 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.udiv %c-47_i64, %c-17_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.lshr %arg0, %1 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.ashr %c-40_i64, %arg0 : i64
    %1 = llvm.urem %c-42_i64, %0 : i64
    %2 = llvm.urem %c-35_i64, %arg0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "ugt" %c40_i64, %arg0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ne" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg0 : i1, i64
    %2 = llvm.srem %c-14_i64, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.icmp "eq" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.udiv %c-43_i64, %arg1 : i64
    %2 = llvm.urem %c44_i64, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.udiv %3, %3 : i64
    %5 = llvm.ashr %4, %c-37_i64 : i64
    %6 = llvm.or %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c24_i64 = arith.constant 24 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.srem %c-36_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c-16_i64, %c47_i64 : i64
    %2 = llvm.icmp "ugt" %arg0, %c-40_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %1, %c24_i64, %3 : i1, i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.icmp "uge" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.ashr %c-26_i64, %arg0 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.icmp "ule" %5, %c-50_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ule" %c-15_i64, %c36_i64 : i64
    %3 = llvm.or %c46_i64, %0 : i64
    %4 = llvm.and %arg2, %3 : i64
    %5 = llvm.select %2, %c-46_i64, %4 : i1, i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %c9_i64, %0 : i1, i64
    %2 = llvm.icmp "sgt" %c36_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %arg2, %3 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.icmp "ule" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.udiv %c-32_i64, %c-50_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.select %arg0, %0, %0 : i1, i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-4_i64 = arith.constant -4 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.select %arg1, %0, %c-4_i64 : i1, i64
    %3 = llvm.sdiv %2, %c-46_i64 : i64
    %4 = llvm.ashr %c-17_i64, %3 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.icmp "sgt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.sdiv %c-20_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.xor %3, %0 : i64
    %5 = llvm.sdiv %arg0, %arg1 : i64
    %6 = llvm.srem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.srem %c-44_i64, %c35_i64 : i64
    %1 = llvm.ashr %0, %c-37_i64 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.urem %3, %arg0 : i64
    %5 = llvm.xor %arg1, %c0_i64 : i64
    %6 = llvm.lshr %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.urem %arg0, %c-37_i64 : i64
    %5 = llvm.ashr %4, %arg1 : i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "slt" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.or %c-50_i64, %3 : i64
    %5 = llvm.urem %4, %4 : i64
    %6 = llvm.icmp "sle" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %c2_i64, %c35_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "eq" %c2_i64, %1 : i64
    %3 = llvm.urem %arg1, %0 : i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.select %2, %1, %4 : i1, i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %true = arith.constant true
    %false = arith.constant false
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.select %false, %c33_i64, %0 : i1, i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.srem %arg2, %c-21_i64 : i64
    %6 = llvm.icmp "ult" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.or %c46_i64, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.urem %c50_i64, %2 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.srem %arg2, %4 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.select %arg0, %c-9_i64, %arg1 : i1, i64
    %1 = llvm.ashr %c-34_i64, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %arg0, %3, %arg1 : i1, i64
    %5 = llvm.icmp "sgt" %4, %arg2 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.xor %c-28_i64, %c-49_i64 : i64
    %4 = llvm.and %arg2, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "sle" %5, %c29_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %3, %1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.lshr %c44_i64, %arg1 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.udiv %arg2, %arg2 : i64
    %3 = llvm.icmp "sgt" %2, %c40_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.srem %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "uge" %c46_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.and %1, %arg2 : i64
    %6 = llvm.icmp "ult" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.srem %c29_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %c-14_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "slt" %c-24_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c28_i64 = arith.constant 28 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.ashr %c28_i64, %c-16_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.select %false, %3, %4 : i1, i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.ashr %arg2, %c19_i64 : i64
    %3 = llvm.icmp "ugt" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %arg0, %1, %4 : i1, i64
    %6 = llvm.udiv %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg1, %c-45_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg2, %arg1 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "ule" %arg0, %c-33_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.trunc %0 : i1 to i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.sdiv %c43_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "ne" %c9_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "slt" %arg2, %arg2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c-25_i64 = arith.constant -25 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.lshr %0, %c-25_i64 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.or %2, %c31_i64 : i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.srem %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.or %c28_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %0, %arg0 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.urem %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %c13_i64, %0 : i64
    %2 = llvm.sdiv %arg1, %arg2 : i64
    %3 = llvm.srem %2, %c-48_i64 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ult" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c26_i64 = arith.constant 26 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "ne" %c27_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    %3 = llvm.ashr %c26_i64, %arg1 : i64
    %4 = llvm.icmp "ugt" %1, %c-18_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.select %2, %3, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "uge" %c-39_i64, %c-47_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    %6 = llvm.sdiv %5, %arg0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c-32_i64 = arith.constant -32 : i64
    %true = arith.constant true
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.select %true, %c-20_i64, %arg0 : i1, i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.and %arg0, %c-32_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "sgt" %5, %c17_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %c-37_i64 = arith.constant -37 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.sdiv %c-37_i64, %0 : i64
    %3 = llvm.sdiv %c-10_i64, %arg0 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.lshr %5, %arg1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.udiv %arg0, %c-2_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.ashr %c27_i64, %arg0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.select %3, %c-40_i64, %2 : i1, i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.and %2, %2 : i64
    %5 = llvm.udiv %4, %2 : i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.and %c-30_i64, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "sge" %4, %arg1 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c19_i64 = arith.constant 19 : i64
    %false = arith.constant false
    %c-39_i64 = arith.constant -39 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.select %false, %c-39_i64, %c38_i64 : i1, i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.and %c13_i64, %arg1 : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %c19_i64, %4 : i64
    %6 = llvm.icmp "eq" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.xor %c-27_i64, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %0, %4 : i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.ashr %c42_i64, %c-42_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.icmp "sgt" %c45_i64, %0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "ne" %c-24_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.lshr %c36_i64, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.or %arg0, %4 : i64
    %6 = llvm.icmp "ugt" %5, %arg0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.srem %2, %c4_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.xor %4, %3 : i64
    %6 = llvm.srem %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %c50_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sgt" %4, %arg1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "slt" %c22_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.or %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c43_i64 = arith.constant 43 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "slt" %c-27_i64, %c-11_i64 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.icmp "ugt" %1, %c43_i64 : i64
    %3 = llvm.udiv %c-25_i64, %1 : i64
    %4 = llvm.lshr %c22_i64, %arg1 : i64
    %5 = llvm.select %2, %3, %4 : i1, i64
    %6 = llvm.select %0, %c10_i64, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "sge" %1, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c13_i64 = arith.constant 13 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.xor %arg1, %c37_i64 : i64
    %1 = llvm.lshr %c13_i64, %arg0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.lshr %4, %c-28_i64 : i64
    %6 = llvm.icmp "ne" %5, %c-24_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.srem %c42_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ult" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "sle" %c-11_i64, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.lshr %2, %arg2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.select %4, %arg1, %3 : i1, i64
    %6 = llvm.icmp "ule" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %c3_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "ule" %arg0, %c-36_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.udiv %3, %c-28_i64 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.sdiv %arg1, %c26_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.urem %c-1_i64, %0 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.xor %arg0, %c-13_i64 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sge" %5, %0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.select %arg0, %arg1, %c49_i64 : i1, i64
    %1 = llvm.sdiv %arg1, %c-7_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.ashr %c33_i64, %arg2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.xor %c14_i64, %arg0 : i64
    %1 = llvm.xor %arg1, %arg1 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.icmp "ult" %arg1, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %c-29_i64 : i64
    %2 = llvm.select %0, %1, %arg2 : i1, i64
    %3 = llvm.ashr %2, %arg1 : i64
    %4 = llvm.urem %arg2, %arg1 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.srem %c22_i64, %0 : i64
    %2 = llvm.udiv %arg1, %c-30_i64 : i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.and %3, %2 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.lshr %arg2, %arg2 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %0, %c-16_i64 : i64
    %6 = llvm.and %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "ugt" %arg0, %c12_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg0, %arg1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.icmp "sge" %3, %c8_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c27_i64 = arith.constant 27 : i64
    %c29_i64 = arith.constant 29 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.and %arg0, %c21_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.udiv %c27_i64, %0 : i64
    %3 = llvm.select %false, %0, %arg1 : i1, i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    %6 = llvm.icmp "ule" %c29_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c17_i64 = arith.constant 17 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "slt" %arg0, %c0_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c17_i64, %arg1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %4, %c-21_i64 : i64
    %6 = llvm.icmp "ule" %5, %arg0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c-7_i64 = arith.constant -7 : i64
    %true = arith.constant true
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %arg0, %arg1 : i1, i64
    %3 = llvm.select %true, %c-7_i64, %c12_i64 : i1, i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.srem %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg1, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.and %arg1, %4 : i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c20_i64 = arith.constant 20 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "eq" %c4_i64, %arg0 : i64
    %1 = llvm.select %0, %c20_i64, %arg0 : i1, i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.sext %0 : i1 to i64
    %4 = llvm.sdiv %3, %2 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.ashr %5, %c-11_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.xor %c4_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %1, %c-30_i64, %2 : i1, i64
    %4 = llvm.icmp "ult" %arg2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.udiv %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c31_i64 = arith.constant 31 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "ugt" %arg0, %c-44_i64 : i64
    %1 = llvm.select %0, %arg1, %c31_i64 : i1, i64
    %2 = llvm.select %0, %arg2, %c-27_i64 : i1, i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c34_i64 = arith.constant 34 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "ne" %c34_i64, %c33_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.or %c20_i64, %2 : i64
    %4 = llvm.sext %0 : i1 to i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "sgt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.ashr %c18_i64, %c34_i64 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.select %4, %2, %arg0 : i1, i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %arg1, %arg2 : i64
    %5 = llvm.sdiv %4, %c-45_i64 : i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %c18_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "sle" %c25_i64, %arg2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "slt" %c30_i64, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.urem %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.udiv %arg1, %c-16_i64 : i64
    %1 = llvm.ashr %c26_i64, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.udiv %arg1, %0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.urem %arg2, %2 : i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c45_i64 = arith.constant 45 : i64
    %c11_i64 = arith.constant 11 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.or %c11_i64, %2 : i64
    %4 = llvm.or %c45_i64, %3 : i64
    %5 = llvm.and %c-3_i64, %0 : i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c9_i64 = arith.constant 9 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %c14_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %c9_i64 : i64
    %3 = llvm.select %2, %0, %c-37_i64 : i1, i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.trunc %arg1 : i1 to i64
    %6 = llvm.srem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.and %arg0, %c-50_i64 : i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg2, %c-31_i64 : i64
    %4 = llvm.icmp "ule" %3, %arg1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c7_i64 = arith.constant 7 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.select %arg0, %c35_i64, %c-9_i64 : i1, i64
    %1 = llvm.ashr %arg2, %c7_i64 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.lshr %2, %c17_i64 : i64
    %4 = llvm.xor %3, %c17_i64 : i64
    %5 = llvm.or %4, %c7_i64 : i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.xor %c45_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.lshr %arg0, %arg2 : i64
    %6 = llvm.select %4, %arg2, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "ult" %c0_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %1, %c-14_i64 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.urem %arg1, %3 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.or %5, %c16_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.ashr %arg1, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ugt" %5, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.select %arg0, %c-14_i64, %arg1 : i1, i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.udiv %c44_i64, %1 : i64
    %4 = llvm.and %arg1, %c-43_i64 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.and %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg2, %arg1 : i64
    %3 = llvm.ashr %c-17_i64, %2 : i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.and %c-28_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg2, %c-48_i64 : i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.srem %3, %1 : i64
    %5 = llvm.lshr %c42_i64, %4 : i64
    %6 = llvm.or %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c33_i64 = arith.constant 33 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.or %c20_i64, %arg0 : i64
    %1 = llvm.ashr %c33_i64, %0 : i64
    %2 = llvm.and %1, %c19_i64 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.lshr %3, %3 : i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.trunc %2 : i1 to i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.ashr %c-22_i64, %c-49_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.icmp "ule" %arg0, %c-15_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.select %arg0, %c-38_i64, %arg1 : i1, i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "ule" %3, %0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.icmp "sge" %c-45_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.urem %0, %c43_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "slt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ule" %arg0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.lshr %4, %2 : i64
    %6 = llvm.icmp "eq" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.lshr %c-35_i64, %0 : i64
    %2 = llvm.and %c2_i64, %arg0 : i64
    %3 = llvm.or %c50_i64, %2 : i64
    %4 = llvm.srem %3, %arg0 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %arg1, %c-22_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "uge" %4, %arg2 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %c-3_i64, %0 : i64
    %2 = llvm.and %arg0, %arg0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.lshr %c48_i64, %1 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.icmp "ule" %c40_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %true = arith.constant true
    %c-46_i64 = arith.constant -46 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "ult" %c-46_i64, %c-38_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %true, %1, %c-7_i64 : i1, i64
    %3 = llvm.sext %0 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.select %arg1, %arg0, %c44_i64 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %c41_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %c45_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "uge" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.udiv %c-26_i64, %2 : i64
    %4 = llvm.udiv %3, %1 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.xor %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.and %c44_i64, %arg0 : i64
    %1 = llvm.xor %arg1, %arg0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.icmp "ne" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %c33_i64, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %2, %c-12_i64 : i64
    %4 = llvm.zext %1 : i1 to i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.udiv %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %true = arith.constant true
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.udiv %arg2, %c9_i64 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.ashr %c49_i64, %arg0 : i64
    %1 = llvm.sdiv %c-8_i64, %0 : i64
    %2 = llvm.ashr %0, %arg1 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %5, %arg0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c12_i64 = arith.constant 12 : i64
    %true = arith.constant true
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.select %true, %c-49_i64, %arg0 : i1, i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.select %arg2, %0, %c12_i64 : i1, i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.udiv %c-32_i64, %2 : i64
    %5 = llvm.xor %arg0, %4 : i64
    %6 = llvm.and %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c7_i64 = arith.constant 7 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.udiv %c7_i64, %c24_i64 : i64
    %1 = llvm.and %c28_i64, %0 : i64
    %2 = llvm.urem %0, %0 : i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.xor %1, %1 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.xor %0, %c18_i64 : i64
    %2 = llvm.or %arg2, %c-7_i64 : i64
    %3 = llvm.or %2, %c18_i64 : i64
    %4 = llvm.or %3, %0 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "slt" %2, %c-10_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %4, %arg0 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.urem %c-20_i64, %c-17_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.udiv %3, %arg0 : i64
    %5 = llvm.udiv %2, %arg1 : i64
    %6 = llvm.lshr %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sgt" %arg2, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.srem %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c17_i64 = arith.constant 17 : i64
    %c2_i64 = arith.constant 2 : i64
    %false = arith.constant false
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.select %false, %c-35_i64, %arg0 : i1, i64
    %1 = llvm.icmp "ne" %0, %c2_i64 : i64
    %2 = llvm.or %c17_i64, %arg0 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.ashr %3, %c-21_i64 : i64
    %5 = llvm.lshr %4, %2 : i64
    %6 = llvm.select %1, %2, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.udiv %c18_i64, %c13_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.and %arg0, %0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.xor %3, %arg0 : i64
    %5 = llvm.udiv %0, %4 : i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c-44_i64 = arith.constant -44 : i64
    %true = arith.constant true
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %arg2, %c-44_i64 : i1, i64
    %2 = llvm.select %true, %1, %c-46_i64 : i1, i64
    %3 = llvm.udiv %c-19_i64, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-38_i64 = arith.constant -38 : i64
    %true = arith.constant true
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.select %true, %arg0, %c43_i64 : i1, i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.and %arg1, %arg2 : i64
    %3 = llvm.ashr %2, %c-3_i64 : i64
    %4 = llvm.sdiv %c47_i64, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    %6 = llvm.and %c-38_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %c18_i64, %arg2 : i64
    %5 = llvm.udiv %4, %c-24_i64 : i64
    %6 = llvm.lshr %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg1, %arg1 : i64
    %2 = llvm.lshr %c-36_i64, %arg2 : i64
    %3 = llvm.and %c5_i64, %2 : i64
    %4 = llvm.urem %arg2, %3 : i64
    %5 = llvm.select %1, %c-38_i64, %4 : i1, i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c14_i64 = arith.constant 14 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.urem %arg0, %c28_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.lshr %c-49_i64, %c-2_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.srem %3, %arg1 : i64
    %5 = llvm.or %c14_i64, %4 : i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c44_i64 = arith.constant 44 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.urem %c3_i64, %c44_i64 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.udiv %2, %c-42_i64 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "ult" %arg1, %c16_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.icmp "eq" %3, %c-4_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.sdiv %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %0 : i64
    %3 = llvm.udiv %arg1, %c11_i64 : i64
    %4 = llvm.sdiv %arg0, %1 : i64
    %5 = llvm.select %2, %3, %4 : i1, i64
    %6 = llvm.or %c41_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.srem %c10_i64, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ule" %c-16_i64, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "ult" %c-37_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.or %c15_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %c-14_i64 : i64
    %2 = llvm.xor %arg0, %c4_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.ashr %3, %0 : i64
    %5 = llvm.lshr %c10_i64, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %false = arith.constant false
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.select %false, %arg0, %c31_i64 : i1, i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %4, %c-12_i64 : i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.urem %1, %1 : i64
    %4 = llvm.xor %3, %2 : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.ashr %c12_i64, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %c-9_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %arg0, %4 : i64
    %6 = llvm.ashr %5, %arg1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.urem %c-4_i64, %arg2 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.sdiv %c-42_i64, %3 : i64
    %5 = llvm.or %4, %2 : i64
    %6 = llvm.udiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %true = arith.constant true
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "slt" %c47_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sext %true : i1 to i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %arg2, %0 : i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.xor %arg0, %arg1 : i64
    %6 = llvm.srem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.or %3, %2 : i64
    %5 = llvm.srem %c14_i64, %4 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %arg2, %3 : i64
    %5 = llvm.ashr %arg0, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.srem %arg0, %c-24_i64 : i64
    %1 = llvm.udiv %0, %c-12_i64 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.icmp "ult" %arg0, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %4, %c45_i64 : i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %false = arith.constant false
    %c27_i64 = arith.constant 27 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %c-43_i64, %c-12_i64 : i64
    %1 = llvm.select %false, %c27_i64, %0 : i1, i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "sle" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %4, %c47_i64 : i64
    %6 = llvm.or %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %0, %c22_i64 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.zext %3 : i1 to i64
    %6 = llvm.or %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.srem %0, %arg1 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "eq" %arg0, %c-47_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ule" %5, %c-7_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.xor %c-19_i64, %arg0 : i64
    %1 = llvm.or %c-4_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ult" %5, %0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c43_i64 = arith.constant 43 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "uge" %c43_i64, %c2_i64 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.icmp "sle" %c-11_i64, %c-13_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %arg2, %3 : i64
    %5 = llvm.or %arg2, %4 : i64
    %6 = llvm.select %arg0, %1, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c14_i64 = arith.constant 14 : i64
    %c24_i64 = arith.constant 24 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.lshr %c-49_i64, %c48_i64 : i64
    %1 = llvm.xor %c14_i64, %c-41_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.sdiv %c24_i64, %3 : i64
    %5 = llvm.and %4, %arg1 : i64
    %6 = llvm.icmp "eq" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.urem %c-1_i64, %c-20_i64 : i64
    %1 = llvm.icmp "ult" %arg1, %c37_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.lshr %arg2, %2 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.ashr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.select %arg0, %arg1, %c-39_i64 : i1, i64
    %1 = llvm.icmp "slt" %c9_i64, %0 : i64
    %2 = llvm.select %1, %arg1, %0 : i1, i64
    %3 = llvm.sdiv %0, %arg2 : i64
    %4 = llvm.and %3, %c47_i64 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.srem %c3_i64, %0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.icmp "sle" %2, %arg2 : i64
    %4 = llvm.icmp "eq" %c-28_i64, %0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.select %3, %arg1, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c29_i64 = arith.constant 29 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.srem %arg0, %c14_i64 : i64
    %1 = llvm.udiv %0, %c-9_i64 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.srem %c-36_i64, %arg1 : i64
    %4 = llvm.or %c29_i64, %3 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    %6 = llvm.select %5, %arg2, %c47_i64 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.lshr %c-17_i64, %3 : i64
    %5 = llvm.sdiv %arg0, %4 : i64
    %6 = llvm.and %c-45_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %c48_i64, %0 : i64
    %2 = llvm.icmp "sle" %arg1, %arg2 : i64
    %3 = llvm.lshr %c-28_i64, %c-41_i64 : i64
    %4 = llvm.select %2, %1, %3 : i1, i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.xor %arg0, %c-49_i64 : i64
    %1 = llvm.sdiv %c-10_i64, %arg1 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %1, %arg2 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %c36_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.select %arg1, %arg2, %c-7_i64 : i1, i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.icmp "sgt" %5, %2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.and %3, %arg2 : i64
    %5 = llvm.srem %arg0, %4 : i64
    %6 = llvm.icmp "sge" %c5_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c3_i64 = arith.constant 3 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sgt" %c6_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.icmp "ule" %c3_i64, %3 : i64
    %5 = llvm.select %4, %c-1_i64, %c18_i64 : i1, i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.select %0, %c6_i64, %c-44_i64 : i1, i64
    %2 = llvm.udiv %1, %c-44_i64 : i64
    %3 = llvm.srem %c-40_i64, %1 : i64
    %4 = llvm.lshr %c-41_i64, %c-41_i64 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.urem %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-24_i64 = arith.constant -24 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "slt" %c-27_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %c-24_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.or %c-7_i64, %3 : i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.sdiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.ashr %c7_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.sext %arg2 : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.udiv %2, %arg1 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.udiv %1, %c-3_i64 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %arg1, %2 : i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.srem %c29_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %0, %arg0 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c39_i64 = arith.constant 39 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "eq" %c39_i64, %c29_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %c-19_i64, %arg0 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.icmp "sge" %5, %c-2_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.udiv %c-17_i64, %c38_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %c39_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.urem %c13_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %c-47_i64, %arg2 : i64
    %4 = llvm.select %3, %c-40_i64, %c-14_i64 : i1, i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.icmp "sle" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ne" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.trunc %3 : i1 to i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %arg1, %arg0 : i64
    %3 = llvm.trunc %0 : i1 to i64
    %4 = llvm.srem %3, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.lshr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.xor %c21_i64, %arg0 : i64
    %1 = llvm.or %c-37_i64, %0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %3, %0 : i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.sdiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %0, %arg0 : i64
    %4 = llvm.select %1, %3, %arg0 : i1, i64
    %5 = llvm.urem %4, %arg1 : i64
    %6 = llvm.ashr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %false = arith.constant false
    %c45_i64 = arith.constant 45 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.select %false, %c45_i64, %c-40_i64 : i1, i64
    %1 = llvm.select %arg0, %c-47_i64, %0 : i1, i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %0, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %true = arith.constant true
    %c-50_i64 = arith.constant -50 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.lshr %arg0, %c48_i64 : i64
    %1 = llvm.xor %0, %c-18_i64 : i64
    %2 = llvm.udiv %arg1, %c-50_i64 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    %5 = llvm.select %true, %c27_i64, %3 : i1, i64
    %6 = llvm.select %4, %5, %3 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c10_i64 : i64
    %2 = llvm.lshr %c-20_i64, %arg2 : i64
    %3 = llvm.udiv %1, %c34_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.and %arg1, %4 : i64
    %6 = llvm.xor %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %c-43_i64 = arith.constant -43 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.select %true, %c-43_i64, %c41_i64 : i1, i64
    %1 = llvm.sdiv %0, %c39_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.or %2, %c-45_i64 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ne" %5, %2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.xor %c-9_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.select %arg1, %0, %c49_i64 : i1, i64
    %3 = llvm.srem %c-33_i64, %1 : i64
    %4 = llvm.xor %3, %c44_i64 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c-36_i64 = arith.constant -36 : i64
    %false = arith.constant false
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg1, %c-49_i64 : i1, i64
    %2 = llvm.udiv %arg2, %c-36_i64 : i64
    %3 = llvm.udiv %2, %c15_i64 : i64
    %4 = llvm.select %false, %3, %3 : i1, i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.xor %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-29_i64 = arith.constant -29 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.srem %c-15_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.and %c-29_i64, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.and %3, %arg0 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.xor %3, %2 : i64
    %5 = llvm.udiv %c37_i64, %4 : i64
    %6 = llvm.udiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.select %2, %arg1, %1 : i1, i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    %5 = llvm.lshr %0, %arg2 : i64
    %6 = llvm.select %4, %5, %c10_i64 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.and %c-18_i64, %c5_i64 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.select %4, %c-13_i64, %c-13_i64 : i1, i64
    %6 = llvm.icmp "sle" %5, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %c30_i64, %0 : i64
    %2 = llvm.lshr %0, %c47_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.lshr %4, %arg1 : i64
    %6 = llvm.ashr %5, %4 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %c-24_i64, %c-31_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sdiv %arg0, %c29_i64 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c19_i64 = arith.constant 19 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.ashr %c19_i64, %c-47_i64 : i64
    %1 = llvm.srem %0, %c-43_i64 : i64
    %2 = llvm.srem %arg0, %c-1_i64 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.xor %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c2_i64 = arith.constant 2 : i64
    %true = arith.constant true
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "slt" %arg0, %c46_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.xor %c2_i64, %c-23_i64 : i64
    %4 = llvm.srem %3, %c-8_i64 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.and %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %3, %c23_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c38_i64 = arith.constant 38 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.sdiv %c-6_i64, %c-48_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %c38_i64, %c10_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.urem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %c-21_i64, %0 : i64
    %2 = llvm.and %1, %c-29_i64 : i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %true = arith.constant true
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.select %true, %c-46_i64, %arg0 : i1, i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    %6 = llvm.icmp "ule" %5, %c26_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %arg2, %c49_i64 : i64
    %2 = llvm.select %arg1, %0, %1 : i1, i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.select %3, %4, %4 : i1, i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c24_i64 = arith.constant 24 : i64
    %c33_i64 = arith.constant 33 : i64
    %true = arith.constant true
    %c4_i64 = arith.constant 4 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "sge" %c4_i64, %c-36_i64 : i64
    %1 = llvm.select %true, %c33_i64, %c24_i64 : i1, i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %c-41_i64, %3 : i64
    %5 = llvm.urem %4, %3 : i64
    %6 = llvm.select %0, %3, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.ashr %arg0, %c40_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.srem %4, %c8_i64 : i64
    %6 = llvm.icmp "eq" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.ashr %c-35_i64, %arg1 : i64
    %3 = llvm.and %arg2, %c-19_i64 : i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %arg1, %arg2 : i1, i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.udiv %c-31_i64, %arg2 : i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c26_i64 = arith.constant 26 : i64
    %false = arith.constant false
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.select %false, %0, %c26_i64 : i1, i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.ashr %c-33_i64, %0 : i64
    %4 = llvm.urem %3, %c17_i64 : i64
    %5 = llvm.lshr %c26_i64, %arg0 : i64
    %6 = llvm.select %2, %4, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.urem %c18_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "slt" %c-8_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ult" %5, %0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %true = arith.constant true
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.or %c-33_i64, %2 : i64
    %4 = llvm.urem %3, %c26_i64 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.ashr %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %c2_i64, %0 : i64
    %2 = llvm.icmp "ne" %0, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %3, %0 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.icmp "ugt" %c-22_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.xor %arg0, %c-24_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.sdiv %arg0, %arg0 : i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-27_i64 = arith.constant -27 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.ashr %c-6_i64, %c-16_i64 : i64
    %1 = llvm.xor %c-6_i64, %0 : i64
    %2 = llvm.ashr %0, %c-27_i64 : i64
    %3 = llvm.select %true, %2, %2 : i1, i64
    %4 = llvm.udiv %3, %arg0 : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.ashr %4, %arg1 : i64
    %6 = llvm.and %5, %c27_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.srem %c38_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.lshr %arg2, %arg1 : i64
    %3 = llvm.lshr %2, %arg2 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.udiv %0, %c-24_i64 : i64
    %3 = llvm.select %1, %2, %2 : i1, i64
    %4 = llvm.and %arg1, %arg2 : i64
    %5 = llvm.lshr %4, %c-45_i64 : i64
    %6 = llvm.icmp "eq" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.or %arg0, %c-32_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.udiv %c25_i64, %2 : i64
    %4 = llvm.lshr %3, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %c-11_i64, %0 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.select %true, %1, %arg1 : i1, i64
    %6 = llvm.select %4, %5, %arg2 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %c-46_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.xor %arg1, %c-35_i64 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.urem %c-10_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.urem %arg2, %c43_i64 : i64
    %4 = llvm.icmp "slt" %arg1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.udiv %arg0, %c20_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.icmp "sgt" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.xor %5, %2 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %true = arith.constant true
    %c31_i64 = arith.constant 31 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.select %arg0, %arg1, %c30_i64 : i1, i64
    %1 = llvm.and %0, %c31_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.udiv %0, %1 : i64
    %4 = llvm.select %true, %c-33_i64, %3 : i1, i64
    %5 = llvm.srem %arg2, %4 : i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.xor %c-5_i64, %c-1_i64 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.udiv %3, %arg0 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.srem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.sdiv %4, %4 : i64
    %6 = llvm.icmp "sgt" %5, %3 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.or %arg1, %c-24_i64 : i64
    %2 = llvm.ashr %c-25_i64, %1 : i64
    %3 = llvm.sdiv %2, %c45_i64 : i64
    %4 = llvm.udiv %3, %1 : i64
    %5 = llvm.sdiv %c37_i64, %4 : i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %c21_i64, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %c-6_i64, %arg0 : i64
    %6 = llvm.sdiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.ashr %c-5_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.srem %arg1, %arg2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c2_i64 = arith.constant 2 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %c6_i64, %1 : i64
    %3 = llvm.srem %c2_i64, %arg2 : i64
    %4 = llvm.icmp "sgt" %3, %c-44_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.select %true, %arg1, %c-41_i64 : i1, i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.ashr %arg1, %arg0 : i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.select %1, %0, %3 : i1, i64
    %5 = llvm.srem %4, %0 : i64
    %6 = llvm.icmp "ult" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c5_i64 = arith.constant 5 : i64
    %false = arith.constant false
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.ashr %c41_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.select %false, %0, %2 : i1, i64
    %4 = llvm.sdiv %c5_i64, %c1_i64 : i64
    %5 = llvm.or %arg1, %4 : i64
    %6 = llvm.and %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c0_i64 = arith.constant 0 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.xor %c-24_i64, %c47_i64 : i64
    %1 = llvm.sdiv %c14_i64, %0 : i64
    %2 = llvm.icmp "sge" %c-12_i64, %c-18_i64 : i64
    %3 = llvm.select %2, %1, %arg0 : i1, i64
    %4 = llvm.xor %c0_i64, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.urem %arg2, %arg1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.select %3, %c18_i64, %arg2 : i1, i64
    %5 = llvm.trunc %3 : i1 to i64
    %6 = llvm.and %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %true = arith.constant true
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.xor %c-39_i64, %arg0 : i64
    %1 = llvm.select %true, %arg1, %c11_i64 : i1, i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "ult" %arg2, %arg0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.and %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.select %arg0, %c5_i64, %c-15_i64 : i1, i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.sdiv %3, %c2_i64 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.and %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.ashr %arg1, %0 : i64
    %3 = llvm.udiv %2, %c7_i64 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.ashr %5, %c-39_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %true = arith.constant true
    %c-29_i64 = arith.constant -29 : i64
    %false = arith.constant false
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %false, %0, %c-29_i64 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.select %true, %3, %4 : i1, i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.ashr %c-11_i64, %c31_i64 : i64
    %1 = llvm.icmp "ne" %c-23_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.icmp "ult" %3, %arg1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c26_i64 = arith.constant 26 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.ashr %arg0, %c-13_i64 : i64
    %1 = llvm.or %arg0, %c11_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %c-23_i64, %arg1 : i64
    %5 = llvm.lshr %c26_i64, %4 : i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %true = arith.constant true
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.xor %c21_i64, %arg1 : i64
    %1 = llvm.icmp "eq" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %true, %2, %c-31_i64 : i1, i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.sdiv %arg0, %4 : i64
    %6 = llvm.srem %5, %3 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.udiv %2, %c-33_i64 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "eq" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.xor %c49_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %arg0, %c-10_i64 : i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.ashr %arg0, %c-33_i64 : i64
    %1 = llvm.and %c50_i64, %0 : i64
    %2 = llvm.srem %c-35_i64, %c23_i64 : i64
    %3 = llvm.xor %c-15_i64, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.urem %3, %arg0 : i64
    %6 = llvm.sdiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c28_i64 = arith.constant 28 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.and %c-12_i64, %arg0 : i64
    %1 = llvm.sdiv %c28_i64, %c-14_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.srem %4, %arg1 : i64
    %6 = llvm.icmp "ule" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.or %arg2, %arg2 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %arg0, %c-4_i64 : i64
    %4 = llvm.icmp "sgt" %3, %1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c19_i64 = arith.constant 19 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.urem %c-4_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.icmp "sgt" %c19_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %c44_i64, %arg0 : i64
    %3 = llvm.icmp "sge" %2, %c-11_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c36_i64 = arith.constant 36 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.or %c41_i64, %arg0 : i64
    %1 = llvm.and %0, %c43_i64 : i64
    %2 = llvm.icmp "ne" %arg0, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.and %4, %arg2 : i64
    %6 = llvm.icmp "eq" %c36_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "ult" %c9_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    %4 = llvm.select %3, %arg0, %1 : i1, i64
    %5 = llvm.srem %4, %arg1 : i64
    %6 = llvm.icmp "ne" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c-14_i64 = arith.constant -14 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ult" %c-14_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %c28_i64, %arg0 : i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.icmp "sle" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "sge" %c31_i64, %arg2 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %5, %c33_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.xor %arg1, %arg1 : i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg0 : i64
    %2 = llvm.urem %c47_i64, %1 : i64
    %3 = llvm.urem %arg2, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c17_i64 = arith.constant 17 : i64
    %c35_i64 = arith.constant 35 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.srem %c35_i64, %c16_i64 : i64
    %1 = llvm.or %c-33_i64, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.ashr %c17_i64, %4 : i64
    %6 = llvm.or %c-39_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.ashr %c-17_i64, %c33_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg1, %0 : i64
    %3 = llvm.xor %c-17_i64, %arg0 : i64
    %4 = llvm.select %2, %3, %arg2 : i1, i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.sdiv %c47_i64, %arg0 : i64
    %1 = llvm.or %arg2, %c-5_i64 : i64
    %2 = llvm.icmp "sle" %arg1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.zext %2 : i1 to i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %c16_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "sge" %c-5_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %c-13_i64, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.urem %arg0, %c-48_i64 : i64
    %1 = llvm.select %arg2, %c-33_i64, %arg0 : i1, i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.icmp "sgt" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.icmp "sge" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.urem %0, %arg1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.sdiv %c12_i64, %3 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.ashr %c44_i64, %c-8_i64 : i64
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %c-15_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %4, %arg0 : i64
    %6 = llvm.srem %5, %arg2 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.select %1, %c24_i64, %arg1 : i1, i64
    %3 = llvm.ashr %arg2, %arg1 : i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    %5 = llvm.and %4, %2 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %true = arith.constant true
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.or %c-50_i64, %arg1 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.xor %2, %c37_i64 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %false = arith.constant false
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.ashr %0, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.urem %arg1, %c-5_i64 : i64
    %6 = llvm.and %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "eq" %c-50_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c-44_i64, %c-20_i64 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.select %4, %3, %3 : i1, i64
    %6 = llvm.lshr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.ashr %c-44_i64, %c4_i64 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.or %4, %2 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.or %4, %4 : i64
    %6 = llvm.icmp "sle" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-44_i64 = arith.constant -44 : i64
    %false = arith.constant false
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.select %false, %c44_i64, %arg0 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.and %c-44_i64, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.icmp "ult" %c18_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c-41_i64 = arith.constant -41 : i64
    %true = arith.constant true
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.select %true, %arg0, %arg1 : i1, i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %c-41_i64, %c-28_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "sgt" %c-22_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %c25_i64, %arg1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %5, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c42_i64 = arith.constant 42 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "ugt" %c42_i64, %c1_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %c-37_i64, %1 : i64
    %3 = llvm.sdiv %c45_i64, %1 : i64
    %4 = llvm.udiv %3, %arg0 : i64
    %5 = llvm.and %c4_i64, %4 : i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %c11_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.select %1, %4, %c31_i64 : i1, i64
    %6 = llvm.srem %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.srem %c-39_i64, %arg1 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.and %c-48_i64, %arg2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.icmp "sge" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %c-31_i64 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.or %1, %c49_i64 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.lshr %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-4_i64 = arith.constant -4 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "eq" %c-39_i64, %c-5_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg0, %c-4_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.urem %arg0, %4 : i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.or %c-19_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %c-38_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %4, %0 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.and %arg1, %c-37_i64 : i64
    %1 = llvm.icmp "ugt" %arg2, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %2, %c-39_i64 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.urem %arg0, %4 : i64
    %6 = llvm.xor %5, %c28_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-24_i64 = arith.constant -24 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "ult" %c-20_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %c36_i64, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.urem %3, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.icmp "sge" %c-24_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg0, %arg0 : i1, i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.icmp "ugt" %2, %c26_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.sdiv %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.ashr %arg0, %c12_i64 : i64
    %1 = llvm.icmp "sgt" %arg1, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.trunc %1 : i1 to i64
    %5 = llvm.lshr %4, %2 : i64
    %6 = llvm.udiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c31_i64 = arith.constant 31 : i64
    %c8_i64 = arith.constant 8 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.select %0, %c31_i64, %arg0 : i1, i64
    %2 = llvm.icmp "ule" %c12_i64, %1 : i64
    %3 = llvm.udiv %1, %c32_i64 : i64
    %4 = llvm.select %2, %arg2, %3 : i1, i64
    %5 = llvm.icmp "uge" %c8_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c50_i64 = arith.constant 50 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.srem %c-17_i64, %arg0 : i64
    %1 = llvm.or %c10_i64, %arg1 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.ashr %c50_i64, %1 : i64
    %4 = llvm.or %1, %arg2 : i64
    %5 = llvm.srem %4, %c-22_i64 : i64
    %6 = llvm.select %2, %3, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %c41_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %4, %arg2 : i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %c-31_i64, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "eq" %c30_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %1, %1 : i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c-47_i64 = arith.constant -47 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %2, %c-47_i64 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sle" %5, %c-13_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c20_i64 = arith.constant 20 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.and %c-28_i64, %c19_i64 : i64
    %1 = llvm.udiv %c20_i64, %0 : i64
    %2 = llvm.ashr %arg0, %0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.udiv %c-32_i64, %4 : i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.urem %c-49_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %3, %c-42_i64 : i64
    %5 = llvm.and %c17_i64, %0 : i64
    %6 = llvm.lshr %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %c42_i64, %0 : i64
    %2 = llvm.select %arg0, %c-39_i64, %c-15_i64 : i1, i64
    %3 = llvm.lshr %0, %arg1 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "sge" %arg1, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.srem %arg2, %arg0 : i64
    %4 = llvm.udiv %3, %c-25_i64 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "slt" %arg0, %c-35_i64 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    %3 = llvm.icmp "ule" %c-49_i64, %c-21_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %4, %c4_i64 : i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "sge" %c-22_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.urem %c30_i64, %1 : i64
    %3 = llvm.icmp "uge" %c35_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %arg0, %arg1 : i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "sgt" %arg1, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.ashr %c-40_i64, %1 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.select %arg0, %1, %4 : i1, i64
    %6 = llvm.icmp "uge" %c-32_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-22_i64 = arith.constant -22 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.select %arg1, %arg2, %arg2 : i1, i64
    %3 = llvm.udiv %2, %c-33_i64 : i64
    %4 = llvm.xor %c-22_i64, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.icmp "sgt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %c-37_i64, %c-32_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %c14_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %false = arith.constant false
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "sgt" %c27_i64, %arg0 : i64
    %1 = llvm.select %false, %arg0, %c42_i64 : i1, i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.icmp "ne" %arg1, %arg2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.select %arg1, %arg2, %arg2 : i1, i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg2, %arg0 : i64
    %4 = llvm.sdiv %arg0, %arg2 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg1, %arg1 : i64
    %2 = llvm.select %1, %arg0, %c10_i64 : i1, i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.or %3, %arg1 : i64
    %6 = llvm.select %0, %4, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %false = arith.constant false
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.select %true, %c-19_i64, %arg0 : i1, i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "sge" %1, %c-18_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sge" %c39_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.xor %3, %0 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-28_i64 = arith.constant -28 : i64
    %true = arith.constant true
    %c-24_i64 = arith.constant -24 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.select %true, %c-24_i64, %c-1_i64 : i1, i64
    %1 = llvm.urem %0, %c-28_i64 : i64
    %2 = llvm.xor %1, %c-41_i64 : i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    %4 = llvm.sext %arg0 : i1 to i64
    %5 = llvm.select %3, %4, %4 : i1, i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "slt" %c-12_i64, %c-16_i64 : i64
    %1 = llvm.or %arg0, %c41_i64 : i64
    %2 = llvm.srem %c-18_i64, %1 : i64
    %3 = llvm.and %c-32_i64, %2 : i64
    %4 = llvm.ashr %arg1, %2 : i64
    %5 = llvm.sdiv %4, %1 : i64
    %6 = llvm.select %0, %3, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %0, %arg0 : i64
    %4 = llvm.lshr %3, %0 : i64
    %5 = llvm.ashr %4, %arg0 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.srem %c41_i64, %arg1 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %2, %arg1, %c-25_i64 : i1, i64
    %5 = llvm.or %arg0, %4 : i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c-29_i64 = arith.constant -29 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.icmp "ne" %2, %c-29_i64 : i64
    %4 = llvm.select %3, %c-24_i64, %arg1 : i1, i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.srem %arg2, %2 : i64
    %4 = llvm.ashr %c-23_i64, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %c-25_i64, %arg1 : i64
    %2 = llvm.ashr %c-42_i64, %arg2 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.sdiv %0, %3 : i64
    %6 = llvm.and %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.and %3, %2 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.urem %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %c36_i64, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "sle" %4, %1 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "slt" %c-14_i64, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "sle" %c-9_i64, %c23_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.icmp "sgt" %5, %1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.and %1, %c32_i64 : i64
    %3 = llvm.urem %arg0, %1 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.and %4, %3 : i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %true = arith.constant true
    %c35_i64 = arith.constant 35 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.ashr %c35_i64, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.zext %arg0 : i1 to i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.urem %c-28_i64, %c44_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.ashr %arg0, %c-49_i64 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.lshr %arg2, %c-32_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "sgt" %4, %c-14_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "sle" %arg1, %arg2 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg2, %c-50_i64 : i64
    %3 = llvm.sdiv %2, %c-44_i64 : i64
    %4 = llvm.udiv %3, %c34_i64 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.icmp "eq" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-1_i64 = arith.constant -1 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.ashr %3, %c41_i64 : i64
    %5 = llvm.srem %c-1_i64, %4 : i64
    %6 = llvm.icmp "eq" %c15_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c11_i64 = arith.constant 11 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.icmp "sge" %0, %c4_i64 : i64
    %2 = llvm.select %1, %0, %arg2 : i1, i64
    %3 = llvm.xor %c11_i64, %2 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.udiv %arg0, %4 : i64
    %6 = llvm.icmp "sgt" %5, %c31_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.and %c5_i64, %arg2 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %c-36_i64, %0 : i64
    %2 = llvm.icmp "ugt" %c-49_i64, %c25_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.urem %c-39_i64, %c-32_i64 : i64
    %4 = llvm.select %arg0, %arg2, %3 : i1, i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.icmp "ugt" %5, %c32_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %true = arith.constant true
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "uge" %arg0, %c26_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %true, %arg0, %c15_i64 : i1, i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.and %3, %2 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.select %arg1, %0, %1 : i1, i64
    %3 = llvm.select %arg0, %c-25_i64, %2 : i1, i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.and %4, %2 : i64
    %6 = llvm.and %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.or %arg0, %c2_i64 : i64
    %4 = llvm.ashr %3, %arg0 : i64
    %5 = llvm.sdiv %arg2, %4 : i64
    %6 = llvm.xor %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sdiv %1, %c21_i64 : i64
    %3 = llvm.icmp "slt" %arg1, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %4, %arg2 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c33_i64 = arith.constant 33 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.and %c33_i64, %c3_i64 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.lshr %0, %0 : i64
    %3 = llvm.sdiv %c-1_i64, %0 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.select %1, %0, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %c50_i64, %1 : i64
    %3 = llvm.and %c21_i64, %2 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.lshr %c-8_i64, %4 : i64
    %6 = llvm.or %c-28_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %arg1 : i64
    %2 = llvm.icmp "sle" %arg0, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c39_i64 = arith.constant 39 : i64
    %c29_i64 = arith.constant 29 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "ugt" %c29_i64, %c-34_i64 : i64
    %1 = llvm.select %0, %c39_i64, %c-22_i64 : i1, i64
    %2 = llvm.icmp "ne" %arg0, %c18_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.and %5, %arg0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %c22_i64, %0 : i64
    %2 = llvm.icmp "sle" %arg1, %arg2 : i64
    %3 = llvm.select %2, %c-8_i64, %c-4_i64 : i1, i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.srem %c-8_i64, %c19_i64 : i64
    %1 = llvm.lshr %c12_i64, %0 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c40_i64 = arith.constant 40 : i64
    %c39_i64 = arith.constant 39 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.srem %c39_i64, %c-27_i64 : i64
    %1 = llvm.or %arg0, %c40_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %arg1, %c30_i64 : i64
    %4 = llvm.ashr %3, %c14_i64 : i64
    %5 = llvm.and %c-49_i64, %4 : i64
    %6 = llvm.lshr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %false = arith.constant false
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %c-47_i64, %0 : i64
    %2 = llvm.xor %arg0, %arg1 : i64
    %3 = llvm.select %true, %1, %2 : i1, i64
    %4 = llvm.or %3, %1 : i64
    %5 = llvm.select %false, %2, %4 : i1, i64
    %6 = llvm.or %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.urem %c-47_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %0 : i64
    %4 = llvm.udiv %3, %c-47_i64 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.select %2, %0, %1 : i1, i64
    %4 = llvm.icmp "eq" %1, %arg0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ne" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.srem %c-32_i64, %arg0 : i64
    %2 = llvm.icmp "sle" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %3, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c14_i64 = arith.constant 14 : i64
    %true = arith.constant true
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.select %true, %arg1, %c-39_i64 : i1, i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.ashr %c14_i64, %1 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.urem %c36_i64, %c-39_i64 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.icmp "eq" %5, %4 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "uge" %c-28_i64, %c38_i64 : i64
    %1 = llvm.and %c50_i64, %arg0 : i64
    %2 = llvm.srem %c-40_i64, %1 : i64
    %3 = llvm.zext %0 : i1 to i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.select %0, %c-40_i64, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.icmp "ugt" %arg2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.srem %c7_i64, %c-23_i64 : i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.or %3, %c-22_i64 : i64
    %5 = llvm.srem %3, %arg1 : i64
    %6 = llvm.and %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.select %false, %1, %c29_i64 : i1, i64
    %3 = llvm.sdiv %arg2, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.urem %1, %c-9_i64 : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %0, %4 : i64
    %6 = llvm.urem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %false = arith.constant false
    %c14_i64 = arith.constant 14 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.ashr %c14_i64, %c16_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.and %arg0, %arg1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.lshr %5, %c-48_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-41_i64 = arith.constant -41 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "sge" %c-41_i64, %c16_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %arg1 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.trunc %true : i1 to i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c6_i64 = arith.constant 6 : i64
    %false = arith.constant false
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.udiv %1, %c6_i64 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ugt" %4, %c-44_i64 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c0_i64 = arith.constant 0 : i64
    %false = arith.constant false
    %c-43_i64 = arith.constant -43 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.select %false, %c-43_i64, %c-46_i64 : i1, i64
    %1 = llvm.icmp "sle" %c0_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %2, %c-34_i64 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.or %arg0, %0 : i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c15_i64 = arith.constant 15 : i64
    %c20_i64 = arith.constant 20 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ugt" %c20_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %c15_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %arg0, %c-43_i64 : i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.urem %c16_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %arg2, %c1_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c-7_i64, %2 : i64
    %4 = llvm.icmp "sge" %arg1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %c26_i64 : i64
    %3 = llvm.zext %0 : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.select %arg0, %c-21_i64, %arg1 : i1, i64
    %1 = llvm.xor %c-23_i64, %c-48_i64 : i64
    %2 = llvm.icmp "sge" %1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %arg2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c41_i64 = arith.constant 41 : i64
    %c31_i64 = arith.constant 31 : i64
    %c4_i64 = arith.constant 4 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "ne" %c4_i64, %c21_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %c31_i64 : i64
    %3 = llvm.xor %c-33_i64, %arg0 : i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.srem %c41_i64, %4 : i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.and %c-34_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %arg1, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.sdiv %arg2, %arg2 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.ashr %c-29_i64, %arg0 : i64
    %1 = llvm.urem %c20_i64, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.select %1, %c-20_i64, %arg1 : i1, i64
    %3 = llvm.sdiv %c-37_i64, %arg1 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.urem %4, %0 : i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c40_i64 = arith.constant 40 : i64
    %false = arith.constant false
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.urem %c-36_i64, %arg0 : i64
    %1 = llvm.xor %c29_i64, %arg1 : i64
    %2 = llvm.xor %c40_i64, %1 : i64
    %3 = llvm.icmp "slt" %0, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %false, %2, %4 : i1, i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c21_i64 = arith.constant 21 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.and %c21_i64, %c22_i64 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %c32_i64, %4 : i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c10_i64 = arith.constant 10 : i64
    %c20_i64 = arith.constant 20 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "ule" %c20_i64, %c-17_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %c21_i64 : i64
    %3 = llvm.sdiv %c10_i64, %2 : i64
    %4 = llvm.srem %1, %1 : i64
    %5 = llvm.lshr %4, %3 : i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.xor %c-23_i64, %c42_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.and %c47_i64, %1 : i64
    %3 = llvm.sdiv %1, %0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.xor %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.ashr %c36_i64, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %arg1, %arg2 : i64
    %3 = llvm.icmp "ult" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.srem %arg1, %c-19_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "sgt" %c-48_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.icmp "ule" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %true = arith.constant true
    %c22_i64 = arith.constant 22 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.and %c22_i64, %c4_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sext %2 : i1 to i64
    %5 = llvm.ashr %c-24_i64, %4 : i64
    %6 = llvm.icmp "sle" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "ule" %c-44_i64, %c39_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.sext %0 : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.urem %4, %c27_i64 : i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %true = arith.constant true
    %c14_i64 = arith.constant 14 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.srem %c44_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.select %true, %0, %c-15_i64 : i1, i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ugt" %3, %arg0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sdiv %c14_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c41_i64 = arith.constant 41 : i64
    %c14_i64 = arith.constant 14 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.udiv %c8_i64, %arg1 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "uge" %c14_i64, %c41_i64 : i64
    %4 = llvm.select %3, %1, %c-15_i64 : i1, i64
    %5 = llvm.srem %4, %arg2 : i64
    %6 = llvm.urem %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.sdiv %c-37_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c-22_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %c-17_i64, %arg0 : i64
    %4 = llvm.urem %arg1, %arg2 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.or %arg0, %c-22_i64 : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    %2 = llvm.select %1, %arg2, %arg0 : i1, i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.lshr %c14_i64, %arg1 : i64
    %6 = llvm.select %4, %arg2, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %true = arith.constant true
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.ashr %c36_i64, %0 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ne" %c-12_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %c40_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %arg2, %3 : i64
    %5 = llvm.udiv %arg1, %4 : i64
    %6 = llvm.and %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %arg2, %c-44_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c37_i64, %arg1 : i64
    %4 = llvm.sdiv %c-17_i64, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c33_i64 = arith.constant 33 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.select %false, %c33_i64, %c25_i64 : i1, i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.ashr %0, %arg0 : i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.ashr %arg2, %c-23_i64 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "slt" %c-23_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.select %1, %arg2, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c-11_i64 = arith.constant -11 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.select %2, %arg1, %c-11_i64 : i1, i64
    %4 = llvm.lshr %3, %1 : i64
    %5 = llvm.xor %arg2, %c40_i64 : i64
    %6 = llvm.select %2, %4, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.or %c24_i64, %2 : i64
    %4 = llvm.select %arg0, %2, %3 : i1, i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.udiv %5, %1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.sdiv %arg0, %c-43_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.srem %1, %c12_i64 : i64
    %3 = llvm.srem %1, %1 : i64
    %4 = llvm.or %3, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.urem %c-24_i64, %c-18_i64 : i64
    %1 = llvm.ashr %c-8_i64, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "uge" %5, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.icmp "eq" %arg2, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %3, %c-10_i64 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.lshr %c-33_i64, %4 : i64
    %6 = llvm.udiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.select %arg1, %3, %c12_i64 : i1, i64
    %5 = llvm.select %arg1, %c-14_i64, %4 : i1, i64
    %6 = llvm.icmp "eq" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %5, %arg0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c24_i64 = arith.constant 24 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %c24_i64, %c-8_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.select %true, %0, %1 : i1, i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.udiv %arg1, %arg2 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.and %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    %4 = llvm.udiv %2, %arg1 : i64
    %5 = llvm.select %3, %4, %c-44_i64 : i1, i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.sdiv %c-50_i64, %arg0 : i64
    %1 = llvm.ashr %c-35_i64, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %c-16_i64, %arg1 : i64
    %5 = llvm.and %4, %0 : i64
    %6 = llvm.srem %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c23_i64 = arith.constant 23 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %arg0, %c14_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.select %arg1, %1, %arg2 : i1, i64
    %3 = llvm.lshr %2, %c23_i64 : i64
    %4 = llvm.and %3, %c9_i64 : i64
    %5 = llvm.urem %4, %3 : i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.sdiv %c45_i64, %c-26_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.ashr %0, %c-23_i64 : i64
    %4 = llvm.srem %arg1, %c-9_i64 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %arg1, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sle" %2, %0 : i64
    %4 = llvm.urem %c-28_i64, %arg2 : i64
    %5 = llvm.ashr %c-30_i64, %arg2 : i64
    %6 = llvm.select %3, %4, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "sgt" %arg0, %c1_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "sgt" %arg1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ule" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c0_i64 = arith.constant 0 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.urem %c0_i64, %c11_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "eq" %c-16_i64, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.zext %arg1 : i1 to i64
    %6 = llvm.udiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.select %arg0, %3, %2 : i1, i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.icmp "slt" %c14_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %arg2 : i64
    %2 = llvm.ashr %c-2_i64, %1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.and %3, %c-21_i64 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.and %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c-10_i64 = arith.constant -10 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "ne" %c-32_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.lshr %1, %c-10_i64 : i64
    %3 = llvm.icmp "ne" %c-31_i64, %2 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.select %3, %arg2, %4 : i1, i64
    %6 = llvm.select %0, %arg0, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c9_i64 = arith.constant 9 : i64
    %true = arith.constant true
    %c17_i64 = arith.constant 17 : i64
    %false = arith.constant false
    %c13_i64 = arith.constant 13 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.select %false, %c13_i64, %c30_i64 : i1, i64
    %1 = llvm.or %c17_i64, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.select %true, %3, %arg2 : i1, i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.select %5, %c9_i64, %c-3_i64 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %1, %c-13_i64 : i64
    %3 = llvm.xor %arg1, %arg0 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.xor %c-34_i64, %arg0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.select %3, %1, %c31_i64 : i1, i64
    %5 = llvm.select %0, %arg0, %4 : i1, i64
    %6 = llvm.xor %c26_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %c48_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %arg1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c1_i64 = arith.constant 1 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.lshr %c-30_i64, %arg0 : i64
    %1 = llvm.ashr %0, %c1_i64 : i64
    %2 = llvm.srem %c47_i64, %arg1 : i64
    %3 = llvm.icmp "sgt" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.xor %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.udiv %arg0, %c-4_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.udiv %0, %arg0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.udiv %arg1, %arg0 : i64
    %5 = llvm.select %3, %arg0, %4 : i1, i64
    %6 = llvm.icmp "uge" %5, %arg0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c15_i64 = arith.constant 15 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.xor %arg0, %c-39_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.or %4, %0 : i64
    %6 = llvm.icmp "ugt" %c15_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.sdiv %arg2, %arg0 : i64
    %2 = llvm.select %arg1, %arg2, %1 : i1, i64
    %3 = llvm.select %arg1, %c-35_i64, %2 : i1, i64
    %4 = llvm.select %arg1, %0, %3 : i1, i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.urem %c-37_i64, %4 : i64
    %6 = llvm.icmp "sge" %5, %1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-34_i64 = arith.constant -34 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.urem %c9_i64, %c-33_i64 : i64
    %1 = llvm.lshr %arg0, %c-34_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.udiv %3, %1 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg1, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.srem %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c37_i64 = arith.constant 37 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %c37_i64, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.or %arg1, %c-29_i64 : i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "eq" %c-43_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %c18_i64 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.xor %arg1, %c-3_i64 : i64
    %5 = llvm.and %arg1, %4 : i64
    %6 = llvm.select %0, %3, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c26_i64 = arith.constant 26 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %c32_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %c26_i64, %1 : i64
    %3 = llvm.sdiv %arg1, %0 : i64
    %4 = llvm.icmp "sle" %3, %c-6_i64 : i64
    %5 = llvm.select %4, %arg0, %arg1 : i1, i64
    %6 = llvm.lshr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.and %4, %1 : i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.icmp "sgt" %5, %2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c19_i64 = arith.constant 19 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %arg1, %c-26_i64 : i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.select %arg0, %1, %c19_i64 : i1, i64
    %3 = llvm.ashr %c-32_i64, %arg1 : i64
    %4 = llvm.sdiv %3, %c-30_i64 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "ule" %c44_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg1, %c-17_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.select %0, %arg1, %arg2 : i1, i64
    %5 = llvm.srem %4, %c-19_i64 : i64
    %6 = llvm.and %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c32_i64 = arith.constant 32 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.and %c32_i64, %c40_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.lshr %0, %c-20_i64 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %4, %4 : i64
    %6 = llvm.or %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "uge" %c-14_i64, %c43_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.urem %arg1, %arg2 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.ashr %arg1, %c-2_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.and %5, %c-27_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.and %c-46_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %arg1, %4 : i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %false = arith.constant false
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.or %c9_i64, %0 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.ashr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c13_i64 = arith.constant 13 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "sge" %arg0, %c-18_i64 : i64
    %1 = llvm.srem %c5_i64, %c13_i64 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.udiv %c-50_i64, %arg0 : i64
    %5 = llvm.urem %4, %2 : i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "ugt" %arg0, %c25_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %c-4_i64, %1 : i64
    %3 = llvm.udiv %2, %c-46_i64 : i64
    %4 = llvm.icmp "ult" %arg1, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ne" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %arg0, %4 : i64
    %6 = llvm.xor %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.and %c36_i64, %c-39_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.srem %arg0, %c-4_i64 : i64
    %3 = llvm.udiv %2, %c32_i64 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %5, %3 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.lshr %0, %arg0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.lshr %arg2, %c45_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.sext %2 : i1 to i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "ne" %c30_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg2, %1 : i64
    %3 = llvm.xor %2, %c24_i64 : i64
    %4 = llvm.icmp "eq" %arg1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %c-19_i64, %0 : i64
    %2 = llvm.icmp "eq" %c-15_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %3, %3 : i64
    %5 = llvm.ashr %4, %c-23_i64 : i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg0, %arg0 : i64
    %3 = llvm.lshr %c31_i64, %arg2 : i64
    %4 = llvm.select %2, %arg0, %3 : i1, i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.ashr %c42_i64, %c28_i64 : i64
    %3 = llvm.xor %arg1, %arg1 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %c-34_i64, %arg1 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.urem %c-19_i64, %arg1 : i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.srem %c-5_i64, %c34_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.and %c-12_i64, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.sdiv %4, %arg0 : i64
    %6 = llvm.urem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c5_i64 = arith.constant 5 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg1, %arg2 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.select %3, %arg0, %c5_i64 : i1, i64
    %5 = llvm.select %3, %c-9_i64, %c-15_i64 : i1, i64
    %6 = llvm.urem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.urem %arg1, %c-45_i64 : i64
    %4 = llvm.icmp "ule" %3, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c35_i64 = arith.constant 35 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.srem %c35_i64, %arg2 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.icmp "ne" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "ule" %arg0, %c-35_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %c-14_i64, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-32_i64 = arith.constant -32 : i64
    %false = arith.constant false
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.select %2, %c-32_i64, %c-31_i64 : i1, i64
    %4 = llvm.or %3, %0 : i64
    %5 = llvm.ashr %arg1, %c-21_i64 : i64
    %6 = llvm.icmp "uge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c43_i64 = arith.constant 43 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "sgt" %c40_i64, %arg1 : i64
    %1 = llvm.or %arg1, %c43_i64 : i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    %3 = llvm.select %arg0, %2, %2 : i1, i64
    %4 = llvm.sdiv %c-15_i64, %c49_i64 : i64
    %5 = llvm.ashr %4, %4 : i64
    %6 = llvm.select %arg0, %3, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.urem %c-44_i64, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.srem %1, %c30_i64 : i64
    %3 = llvm.icmp "sle" %c-38_i64, %1 : i64
    %4 = llvm.select %3, %arg2, %c-8_i64 : i1, i64
    %5 = llvm.xor %arg2, %4 : i64
    %6 = llvm.lshr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.urem %c38_i64, %c-50_i64 : i64
    %2 = llvm.and %arg2, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.udiv %c11_i64, %1 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %c-33_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.or %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.and %arg0, %0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %c37_i64, %arg2 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "uge" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %4, %arg0 : i64
    %6 = llvm.or %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c-49_i64 = arith.constant -49 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "ule" %2, %c-20_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "eq" %c-49_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.udiv %c28_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %arg1, %arg1 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.ashr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.lshr %c-5_i64, %arg2 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.urem %c14_i64, %c17_i64 : i64
    %6 = llvm.select %4, %2, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %arg2 : i64
    %3 = llvm.select %2, %arg1, %arg0 : i1, i64
    %4 = llvm.sdiv %arg0, %c1_i64 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "sle" %c-44_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.select %0, %c-29_i64, %1 : i1, i64
    %3 = llvm.icmp "ult" %2, %c-15_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %arg2, %arg0 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.ashr %c-22_i64, %c23_i64 : i64
    %1 = llvm.icmp "ule" %0, %c-5_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %c-26_i64, %2 : i64
    %4 = llvm.sdiv %c3_i64, %3 : i64
    %5 = llvm.or %arg0, %4 : i64
    %6 = llvm.sdiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c50_i64 = arith.constant 50 : i64
    %true = arith.constant true
    %c-20_i64 = arith.constant -20 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %0, %c50_i64 : i64
    %2 = llvm.select %true, %c-20_i64, %1 : i1, i64
    %3 = llvm.icmp "sge" %2, %arg0 : i64
    %4 = llvm.select %3, %2, %2 : i1, i64
    %5 = llvm.urem %c-44_i64, %c-50_i64 : i64
    %6 = llvm.urem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %2, %c16_i64 : i64
    %4 = llvm.xor %3, %c-48_i64 : i64
    %5 = llvm.select %arg1, %0, %4 : i1, i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.and %c14_i64, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.xor %c-8_i64, %4 : i64
    %6 = llvm.icmp "sge" %5, %4 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c34_i64 = arith.constant 34 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.and %c34_i64, %c26_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.sdiv %arg0, %c0_i64 : i64
    %4 = llvm.icmp "sgt" %3, %arg0 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c16_i64 = arith.constant 16 : i64
    %c7_i64 = arith.constant 7 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.and %c7_i64, %c16_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.select %false, %5, %c-1_i64 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.srem %0, %arg2 : i64
    %2 = llvm.or %arg2, %arg2 : i64
    %3 = llvm.icmp "sgt" %2, %c-37_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %arg1, %1, %4 : i1, i64
    %6 = llvm.icmp "eq" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.udiv %c47_i64, %c32_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.ashr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %arg1, %1, %arg2 : i1, i64
    %5 = llvm.xor %4, %c-18_i64 : i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %c-1_i64 : i1, i64
    %2 = llvm.icmp "ugt" %c35_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %c7_i64, %0 : i64
    %2 = llvm.and %0, %0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %3, %4, %c-16_i64 : i1, i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %c-3_i64, %0 : i64
    %2 = llvm.or %arg1, %c-17_i64 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.urem %c-49_i64, %c-43_i64 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.srem %c-14_i64, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.urem %c-1_i64, %0 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.udiv %4, %arg1 : i64
    %6 = llvm.xor %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "ule" %c-31_i64, %c35_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %c21_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.lshr %arg1, %arg1 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.lshr %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %c23_i64, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.ashr %3, %1 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c32_i64 = arith.constant 32 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.or %arg0, %c5_i64 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.srem %0, %c32_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "slt" %0, %c-50_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c-2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %0, %c-2_i64 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "sge" %arg2, %0 : i64
    %5 = llvm.select %4, %c12_i64, %1 : i1, i64
    %6 = llvm.or %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %c-32_i64, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ne" %c-19_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.udiv %c-22_i64, %arg2 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.urem %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %c-7_i64, %2 : i64
    %4 = llvm.sdiv %3, %2 : i64
    %5 = llvm.and %c-14_i64, %arg2 : i64
    %6 = llvm.icmp "ult" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c11_i64 = arith.constant 11 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %c30_i64, %0 : i64
    %2 = llvm.select %1, %arg2, %c11_i64 : i1, i64
    %3 = llvm.icmp "sgt" %c-7_i64, %c-28_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %false = arith.constant false
    %c7_i64 = arith.constant 7 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.select %false, %c7_i64, %c-4_i64 : i1, i64
    %1 = llvm.select %arg1, %arg0, %c-44_i64 : i1, i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.lshr %arg2, %3 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "uge" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.srem %arg0, %c-24_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "ne" %0, %arg0 : i64
    %3 = llvm.and %0, %0 : i64
    %4 = llvm.urem %3, %c39_i64 : i64
    %5 = llvm.select %2, %4, %3 : i1, i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.lshr %0, %c15_i64 : i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %arg2, %4 : i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c16_i64 = arith.constant 16 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.or %c-38_i64, %arg1 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.sdiv %arg2, %arg0 : i64
    %4 = llvm.urem %3, %c34_i64 : i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.icmp "ule" %c16_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %c-9_i64 : i64
    %2 = llvm.sdiv %1, %c29_i64 : i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sext %3 : i1 to i64
    %6 = llvm.select %0, %4, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %3 = llvm.udiv %2, %c-44_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.select %arg0, %1, %4 : i1, i64
    %6 = llvm.udiv %5, %arg1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c0_i64 = arith.constant 0 : i64
    %c24_i64 = arith.constant 24 : i64
    %c3_i64 = arith.constant 3 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.or %c20_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %c3_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.sdiv %2, %c0_i64 : i64
    %4 = llvm.and %c21_i64, %2 : i64
    %5 = llvm.select %1, %3, %4 : i1, i64
    %6 = llvm.icmp "slt" %c24_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.srem %c-38_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.udiv %c-29_i64, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.icmp "ule" %3, %arg0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.xor %5, %arg2 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c14_i64 = arith.constant 14 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.select %arg2, %c14_i64, %c38_i64 : i1, i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "ugt" %1, %c-25_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.sdiv %arg0, %4 : i64
    %6 = llvm.icmp "sgt" %5, %c35_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.srem %c-7_i64, %arg0 : i64
    %1 = llvm.udiv %c-25_i64, %arg0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.icmp "eq" %arg0, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.srem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %0, %c8_i64 : i64
    %2 = llvm.srem %c-13_i64, %1 : i64
    %3 = llvm.icmp "uge" %2, %c3_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %4, %arg1 : i64
    %6 = llvm.icmp "ugt" %c-40_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c34_i64 = arith.constant 34 : i64
    %c29_i64 = arith.constant 29 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %0, %arg2 : i64
    %2 = llvm.select %1, %c29_i64, %arg2 : i1, i64
    %3 = llvm.lshr %c11_i64, %2 : i64
    %4 = llvm.srem %c18_i64, %2 : i64
    %5 = llvm.sdiv %c34_i64, %4 : i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.urem %c-24_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "eq" %c44_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %4, %4 : i64
    %6 = llvm.and %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.select %arg1, %arg2, %c-33_i64 : i1, i64
    %5 = llvm.udiv %c-32_i64, %4 : i64
    %6 = llvm.icmp "sle" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.icmp "ule" %c-36_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.sdiv %arg2, %2 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.and %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c11_i64 = arith.constant 11 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.and %arg2, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.sdiv %c9_i64, %2 : i64
    %4 = llvm.and %c11_i64, %c23_i64 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.icmp "ule" %5, %2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %c46_i64, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "sgt" %0, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %4, %arg2 : i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.ashr %c4_i64, %c2_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    %5 = llvm.select %4, %0, %3 : i1, i64
    %6 = llvm.or %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %c-47_i64 : i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    %3 = llvm.xor %2, %c36_i64 : i64
    %4 = llvm.xor %3, %c5_i64 : i64
    %5 = llvm.urem %4, %2 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %c50_i64, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.srem %c-19_i64, %1 : i64
    %6 = llvm.icmp "ult" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.icmp "slt" %c8_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %4, %c28_i64 : i64
    %6 = llvm.lshr %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.and %arg0, %c-15_i64 : i64
    %1 = llvm.sdiv %arg1, %arg1 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %arg2, %c6_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.udiv %c-31_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sle" %c-32_i64, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "eq" %arg0, %c11_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %c39_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ult" %5, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.or %c16_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.lshr %arg2, %1 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.ashr %4, %3 : i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.urem %c-50_i64, %arg0 : i64
    %1 = llvm.ashr %0, %c-12_i64 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.urem %3, %c-41_i64 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.udiv %c2_i64, %c-10_i64 : i64
    %4 = llvm.icmp "ule" %3, %2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.or %arg0, %c-20_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.srem %c-28_i64, %c-26_i64 : i64
    %4 = llvm.udiv %3, %c-27_i64 : i64
    %5 = llvm.udiv %4, %arg2 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.xor %c-19_i64, %c-14_i64 : i64
    %1 = llvm.icmp "uge" %c-27_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %4, %2 : i64
    %6 = llvm.icmp "eq" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %c39_i64, %0 : i64
    %2 = llvm.ashr %0, %arg0 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sle" %c47_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "uge" %c30_i64, %c-25_i64 : i64
    %1 = llvm.udiv %c-4_i64, %arg0 : i64
    %2 = llvm.xor %arg1, %arg0 : i64
    %3 = llvm.icmp "sge" %arg1, %c-33_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.select %0, %1, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.select %true, %0, %arg0 : i1, i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.or %3, %3 : i64
    %5 = llvm.urem %arg0, %4 : i64
    %6 = llvm.icmp "ult" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "sge" %c29_i64, %c-2_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %c-30_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %c21_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %arg2, %2 : i64
    %6 = llvm.ashr %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "ule" %arg1, %c1_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "ule" %c-25_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %arg1, %4 : i64
    %6 = llvm.icmp "sgt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.or %c-42_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.icmp "sge" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %4, %c11_i64 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %0, %arg2 : i64
    %4 = llvm.icmp "ule" %c22_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "ule" %c18_i64, %c-38_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.lshr %1, %arg0 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.srem %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %c3_i64 : i64
    %2 = llvm.ashr %arg0, %c-32_i64 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.trunc %arg2 : i1 to i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c15_i64 = arith.constant 15 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg2, %arg0 : i1, i64
    %1 = llvm.icmp "sle" %arg1, %0 : i64
    %2 = llvm.icmp "ule" %0, %c15_i64 : i64
    %3 = llvm.select %2, %arg1, %arg1 : i1, i64
    %4 = llvm.select %1, %arg2, %3 : i1, i64
    %5 = llvm.srem %arg0, %4 : i64
    %6 = llvm.icmp "uge" %5, %c9_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.srem %arg2, %c-7_i64 : i64
    %2 = llvm.udiv %arg0, %arg0 : i64
    %3 = llvm.srem %2, %c18_i64 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.icmp "ult" %c-44_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %c43_i64, %arg1 : i64
    %6 = llvm.and %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %false = arith.constant false
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.sext %0 : i1 to i64
    %5 = llvm.lshr %c30_i64, %4 : i64
    %6 = llvm.icmp "eq" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %false = arith.constant false
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %c46_i64 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.sext %arg2 : i1 to i64
    %5 = llvm.xor %4, %0 : i64
    %6 = llvm.sdiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c48_i64 = arith.constant 48 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.or %arg2, %c5_i64 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.or %2, %c48_i64 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.urem %4, %c-6_i64 : i64
    %6 = llvm.sdiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "eq" %arg0, %c-5_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.urem %c-10_i64, %arg0 : i64
    %5 = llvm.ashr %arg1, %c-9_i64 : i64
    %6 = llvm.select %3, %4, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.and %c38_i64, %arg0 : i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.or %2, %c-24_i64 : i64
    %4 = llvm.icmp "sgt" %3, %arg2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c27_i64 = arith.constant 27 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.srem %c50_i64, %1 : i64
    %3 = llvm.icmp "ule" %1, %c20_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %c27_i64, %4 : i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "ult" %c10_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg1, %c-16_i64 : i64
    %3 = llvm.lshr %arg2, %arg0 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.urem %4, %4 : i64
    %6 = llvm.icmp "ugt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %true = arith.constant true
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "sle" %c-7_i64, %2 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.ashr %2, %c9_i64 : i64
    %6 = llvm.select %3, %4, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.sdiv %c50_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "sle" %arg2, %arg2 : i64
    %3 = llvm.sdiv %arg1, %arg2 : i64
    %4 = llvm.select %2, %3, %c-45_i64 : i1, i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.or %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.udiv %c3_i64, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.lshr %4, %3 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.or %c48_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %c-26_i64 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.and %arg2, %c-16_i64 : i64
    %4 = llvm.icmp "ugt" %arg1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %c24_i64, %arg1 : i64
    %2 = llvm.icmp "ne" %arg1, %1 : i64
    %3 = llvm.select %2, %1, %arg2 : i1, i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.xor %arg1, %c-46_i64 : i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c18_i64 = arith.constant 18 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "eq" %c18_i64, %c17_i64 : i64
    %1 = llvm.select %0, %c48_i64, %c-7_i64 : i1, i64
    %2 = llvm.srem %c-32_i64, %1 : i64
    %3 = llvm.sdiv %arg0, %arg1 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.xor %4, %1 : i64
    %6 = llvm.srem %5, %2 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.or %3, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %0, %arg1 : i64
    %4 = llvm.udiv %3, %c-42_i64 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg1, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.icmp "eq" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.or %c-39_i64, %1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %arg1, %4 : i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.lshr %c-19_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %arg2, %c41_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.sdiv %5, %c12_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.urem %c-48_i64, %0 : i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.and %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.udiv %c-5_i64, %c7_i64 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.urem %c39_i64, %3 : i64
    %5 = llvm.sdiv %arg1, %0 : i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-4_i64 = arith.constant -4 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.and %c30_i64, %arg0 : i64
    %1 = llvm.and %0, %c-4_i64 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.trunc %true : i1 to i64
    %6 = llvm.srem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c37_i64 = arith.constant 37 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.urem %c-15_i64, %c15_i64 : i64
    %1 = llvm.icmp "sle" %0, %c37_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.srem %0, %c-25_i64 : i64
    %5 = llvm.or %4, %c25_i64 : i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.lshr %c9_i64, %arg0 : i64
    %1 = llvm.xor %0, %c6_i64 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %c-6_i64, %arg0 : i64
    %2 = llvm.ashr %1, %c48_i64 : i64
    %3 = llvm.sdiv %c-4_i64, %c-39_i64 : i64
    %4 = llvm.srem %3, %2 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c32_i64 = arith.constant 32 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.udiv %c-34_i64, %arg0 : i64
    %1 = llvm.select %true, %c32_i64, %0 : i1, i64
    %2 = llvm.srem %arg1, %arg0 : i64
    %3 = llvm.or %arg2, %2 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.udiv %c-27_i64, %1 : i64
    %5 = llvm.and %arg2, %4 : i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c20_i64 = arith.constant 20 : i64
    %c32_i64 = arith.constant 32 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %c19_i64, %0 : i64
    %2 = llvm.udiv %c32_i64, %1 : i64
    %3 = llvm.xor %arg1, %c20_i64 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.sdiv %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.ashr %arg0, %c-21_i64 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.sdiv %arg0, %0 : i64
    %3 = llvm.and %c-7_i64, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.udiv %c3_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.and %c-41_i64, %1 : i64
    %4 = llvm.icmp "ult" %c-20_i64, %3 : i64
    %5 = llvm.select %4, %1, %arg0 : i1, i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.zext %arg2 : i1 to i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.icmp "ult" %c-11_i64, %c-33_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "ugt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.or %c-24_i64, %arg2 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.udiv %c6_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c24_i64 = arith.constant 24 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c35_i64 = arith.constant 35 : i64
    %true = arith.constant true
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.select %arg0, %c0_i64, %arg1 : i1, i64
    %1 = llvm.select %true, %0, %arg2 : i1, i64
    %2 = llvm.urem %c-18_i64, %c24_i64 : i64
    %3 = llvm.udiv %c35_i64, %2 : i64
    %4 = llvm.or %c-28_i64, %0 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg2 : i64
    %4 = llvm.or %arg1, %2 : i64
    %5 = llvm.select %3, %4, %0 : i1, i64
    %6 = llvm.select %1, %2, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %c-17_i64, %arg1 : i64
    %3 = llvm.select %2, %arg2, %c-44_i64 : i1, i64
    %4 = llvm.lshr %arg1, %c11_i64 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.sdiv %c-1_i64, %arg0 : i64
    %1 = llvm.or %c-14_i64, %0 : i64
    %2 = llvm.icmp "eq" %1, %c-3_i64 : i64
    %3 = llvm.select %2, %arg1, %0 : i1, i64
    %4 = llvm.icmp "sgt" %0, %c-4_i64 : i64
    %5 = llvm.select %4, %arg2, %3 : i1, i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c31_i64 = arith.constant 31 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.urem %c22_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ult" %arg1, %c-21_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.udiv %c31_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %arg0, %1 : i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.icmp "ult" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.udiv %c15_i64, %c-42_i64 : i64
    %1 = llvm.icmp "sge" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.select %3, %0, %arg2 : i1, i64
    %5 = llvm.urem %4, %c50_i64 : i64
    %6 = llvm.icmp "ugt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c20_i64 = arith.constant 20 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ult" %c-45_i64, %c50_i64 : i64
    %1 = llvm.select %0, %c11_i64, %c-8_i64 : i1, i64
    %2 = llvm.icmp "ule" %1, %c40_i64 : i64
    %3 = llvm.xor %c20_i64, %arg0 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.select %2, %5, %c-19_i64 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.udiv %arg0, %c4_i64 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.xor %arg2, %1 : i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.select %arg1, %arg0, %3 : i1, i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c22_i64 = arith.constant 22 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.or %arg0, %c28_i64 : i64
    %1 = llvm.icmp "ugt" %0, %c22_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.icmp "eq" %3, %c-48_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.udiv %c-40_i64, %0 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %2 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.udiv %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.ashr %c-25_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %0 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %c-39_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c13_i64 = arith.constant 13 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %c25_i64, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.and %arg0, %c-49_i64 : i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.srem %c13_i64, %4 : i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg2 : i1, i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %c4_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ugt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %c-35_i64, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.urem %arg0, %c-4_i64 : i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.urem %3, %3 : i64
    %5 = llvm.select %1, %2, %4 : i1, i64
    %6 = llvm.sdiv %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.sdiv %c-40_i64, %c27_i64 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %c-6_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.ashr %c49_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "sgt" %1, %c-15_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %3, %3 : i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.icmp "sgt" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c18_i64 = arith.constant 18 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %c36_i64, %0 : i64
    %2 = llvm.udiv %c18_i64, %1 : i64
    %3 = llvm.icmp "sle" %c-2_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %arg1, %0 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.urem %c14_i64, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.and %arg1, %0 : i64
    %4 = llvm.sdiv %3, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.udiv %arg0, %arg1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %c19_i64, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "ult" %c-11_i64, %c-19_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.srem %arg1, %1 : i64
    %4 = llvm.select %0, %c-4_i64, %3 : i1, i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    %6 = llvm.select %5, %c-10_i64, %1 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "ne" %c-18_i64, %c28_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.trunc %0 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.udiv %4, %arg0 : i64
    %6 = llvm.sdiv %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %c41_i64, %0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.lshr %c-40_i64, %arg1 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %c-14_i64, %0 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.xor %2, %c17_i64 : i64
    %4 = llvm.srem %3, %2 : i64
    %5 = llvm.xor %arg1, %4 : i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.or %5, %1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c-43_i64 : i64
    %2 = llvm.or %arg1, %c16_i64 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c42_i64 = arith.constant 42 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %c34_i64, %0 : i64
    %2 = llvm.udiv %c42_i64, %1 : i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.xor %c39_i64, %3 : i64
    %5 = llvm.trunc %arg2 : i1 to i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.srem %arg0, %c-16_i64 : i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.xor %2, %0 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.udiv %4, %arg2 : i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c13_i64 = arith.constant 13 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.lshr %c13_i64, %c43_i64 : i64
    %1 = llvm.and %0, %c-50_i64 : i64
    %2 = llvm.trunc %arg0 : i1 to i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.urem %0, %c46_i64 : i64
    %5 = llvm.select %3, %0, %4 : i1, i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.urem %c-38_i64, %c45_i64 : i64
    %1 = llvm.xor %arg1, %c14_i64 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.select %arg0, %0, %2 : i1, i64
    %4 = llvm.icmp "ult" %3, %c-44_i64 : i64
    %5 = llvm.select %4, %arg2, %1 : i1, i64
    %6 = llvm.icmp "eq" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %false = arith.constant false
    %c-38_i64 = arith.constant -38 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.xor %c14_i64, %arg1 : i64
    %1 = llvm.srem %c-38_i64, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.select %false, %0, %c-5_i64 : i1, i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.lshr %c7_i64, %4 : i64
    %6 = llvm.icmp "sgt" %5, %3 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c35_i64 = arith.constant 35 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.lshr %c35_i64, %c39_i64 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.srem %c-10_i64, %c19_i64 : i64
    %4 = llvm.or %arg0, %0 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.xor %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.or %0, %c-22_i64 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.or %c29_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.sdiv %c-48_i64, %c-4_i64 : i64
    %1 = llvm.select %arg0, %c-19_i64, %0 : i1, i64
    %2 = llvm.srem %1, %c45_i64 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %4, %c-31_i64 : i64
    %6 = llvm.icmp "sgt" %c27_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c-29_i64 = arith.constant -29 : i64
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.select %true, %arg1, %c-29_i64 : i1, i64
    %2 = llvm.or %c16_i64, %arg2 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c37_i64 = arith.constant 37 : i64
    %c9_i64 = arith.constant 9 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.xor %arg0, %c15_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.or %1, %c37_i64 : i64
    %3 = llvm.or %c9_i64, %2 : i64
    %4 = llvm.and %arg1, %c47_i64 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %c32_i64, %arg0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.ashr %arg2, %2 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    %6 = llvm.select %5, %c16_i64, %arg2 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "sle" %arg0, %c-27_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.ashr %arg0, %c-23_i64 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.or %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c30_i64 = arith.constant 30 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %c17_i64, %c30_i64 : i64
    %2 = llvm.select %arg1, %arg2, %c-48_i64 : i1, i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.and %3, %c9_i64 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.srem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.sdiv %arg0, %arg2 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-1_i64 = arith.constant -1 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.select %arg1, %c-46_i64, %arg2 : i1, i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %c-1_i64, %3 : i64
    %5 = llvm.trunc %true : i1 to i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "uge" %c-25_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %3, %arg0 : i64
    %5 = llvm.srem %c48_i64, %0 : i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %c32_i64, %arg0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.trunc %arg1 : i1 to i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.icmp "ne" %5, %2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c-19_i64 = arith.constant -19 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "sge" %c-19_i64, %c22_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.ashr %arg0, %arg1 : i64
    %5 = llvm.urem %1, %4 : i64
    %6 = llvm.ashr %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "ugt" %c37_i64, %c28_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %c28_i64, %3 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %2, %arg0 : i64
    %4 = llvm.select %3, %2, %c-35_i64 : i1, i64
    %5 = llvm.xor %arg0, %4 : i64
    %6 = llvm.icmp "ule" %5, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %false = arith.constant false
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.xor %arg2, %1 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.udiv %3, %c-17_i64 : i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.srem %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.lshr %c-29_i64, %arg0 : i64
    %1 = llvm.xor %c8_i64, %arg2 : i64
    %2 = llvm.select %arg1, %0, %1 : i1, i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.udiv %3, %3 : i64
    %5 = llvm.urem %c-25_i64, %4 : i64
    %6 = llvm.and %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "ult" %c-25_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %0, %c36_i64, %1 : i1, i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.urem %c-14_i64, %3 : i64
    %5 = llvm.srem %arg0, %4 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.or %c41_i64, %arg2 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.select %0, %arg2, %2 : i1, i64
    %4 = llvm.trunc %0 : i1 to i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.or %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.sdiv %arg1, %c-8_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %0, %c-33_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.urem %c23_i64, %arg1 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "ugt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.ashr %c24_i64, %2 : i64
    %4 = llvm.select %arg2, %2, %arg0 : i1, i64
    %5 = llvm.srem %4, %arg1 : i64
    %6 = llvm.lshr %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.select %arg1, %2, %3 : i1, i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.udiv %5, %arg0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.xor %c-26_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.trunc %2 : i1 to i64
    %6 = llvm.urem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "sge" %c-6_i64, %c-9_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.srem %c5_i64, %arg2 : i64
    %3 = llvm.icmp "ne" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %4, %c-23_i64 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-32_i64 = arith.constant -32 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.and %c-32_i64, %c39_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sge" %3, %arg0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c27_i64 = arith.constant 27 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "sgt" %c27_i64, %c46_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg1, %c-41_i64 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.icmp "eq" %5, %arg0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.lshr %arg0, %c16_i64 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.lshr %3, %c-35_i64 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.icmp "ult" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.xor %1, %c-7_i64 : i64
    %3 = llvm.xor %arg2, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.ashr %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %c11_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %3, %c17_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c13_i64 = arith.constant 13 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.urem %c13_i64, %c16_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.ashr %2, %c-31_i64 : i64
    %4 = llvm.icmp "eq" %arg1, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "sge" %c-26_i64, %c41_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %c25_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.urem %0, %0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.and %c-23_i64, %3 : i64
    %5 = llvm.and %2, %1 : i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.ashr %4, %2 : i64
    %6 = llvm.icmp "sgt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c34_i64 = arith.constant 34 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.xor %c24_i64, %0 : i64
    %2 = llvm.sdiv %0, %0 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.lshr %1, %c34_i64 : i64
    %5 = llvm.select %3, %4, %c44_i64 : i1, i64
    %6 = llvm.icmp "ne" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c0_i64 = arith.constant 0 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %c18_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %c0_i64, %3 : i64
    %5 = llvm.and %arg2, %c31_i64 : i64
    %6 = llvm.urem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.or %c7_i64, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.urem %arg0, %4 : i64
    %6 = llvm.icmp "ule" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.ashr %c2_i64, %c-23_i64 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.ashr %0, %0 : i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.and %3, %c23_i64 : i64
    %6 = llvm.select %2, %4, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %c-7_i64, %arg1 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "sge" %c-14_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.udiv %4, %arg2 : i64
    %6 = llvm.xor %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c41_i64 = arith.constant 41 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %c41_i64, %arg0 : i64
    %2 = llvm.ashr %c33_i64, %arg1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.udiv %c25_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.ashr %arg0, %c-7_i64 : i64
    %4 = llvm.srem %c-23_i64, %3 : i64
    %5 = llvm.select %2, %4, %c40_i64 : i1, i64
    %6 = llvm.icmp "uge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.sdiv %c33_i64, %c48_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ule" %3, %arg1 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c21_i64 = arith.constant 21 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.sdiv %arg0, %c2_i64 : i64
    %1 = llvm.sdiv %0, %c21_i64 : i64
    %2 = llvm.udiv %1, %c-15_i64 : i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.udiv %5, %arg0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "eq" %c-4_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %c25_i64, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %arg1, %4 : i64
    %6 = llvm.ashr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "uge" %c-33_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %c-9_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.udiv %c-42_i64, %c42_i64 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.icmp "sgt" %5, %1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.xor %c-16_i64, %c-22_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %c-24_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "sge" %arg1, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.select %3, %1, %arg2 : i1, i64
    %5 = llvm.select %3, %arg0, %c-17_i64 : i1, i64
    %6 = llvm.ashr %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.srem %c-48_i64, %c-35_i64 : i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ugt" %c-6_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.lshr %1, %c47_i64 : i64
    %3 = llvm.xor %arg2, %2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.select %0, %arg0, %4 : i1, i64
    %6 = llvm.icmp "ule" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.lshr %c40_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.ashr %1, %c-21_i64 : i64
    %3 = llvm.icmp "sgt" %2, %c-15_i64 : i64
    %4 = llvm.select %3, %c-8_i64, %2 : i1, i64
    %5 = llvm.and %4, %0 : i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %c17_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %arg1, %c30_i64 : i64
    %4 = llvm.sdiv %3, %arg2 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c19_i64 = arith.constant 19 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "ult" %c19_i64, %c16_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %c49_i64, %arg0 : i64
    %3 = llvm.lshr %c-42_i64, %2 : i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.icmp "eq" %5, %4 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-41_i64 = arith.constant -41 : i64
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %c-41_i64 : i64
    %2 = llvm.icmp "ult" %0, %c-39_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %true, %1, %3 : i1, i64
    %5 = llvm.and %4, %c-38_i64 : i64
    %6 = llvm.icmp "sge" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ule" %c-50_i64, %c50_i64 : i64
    %1 = llvm.icmp "sle" %arg1, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.icmp "sge" %arg2, %c-49_i64 : i64
    %5 = llvm.select %4, %arg2, %arg0 : i1, i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.and %arg0, %c-34_i64 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.or %3, %arg0 : i64
    %5 = llvm.and %4, %4 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %c25_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c40_i64 = arith.constant 40 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.sdiv %c5_i64, %0 : i64
    %2 = llvm.lshr %1, %c40_i64 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.srem %0, %c-40_i64 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.ashr %5, %4 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %c-49_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.select %2, %0, %c44_i64 : i1, i64
    %4 = llvm.and %arg2, %c-43_i64 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "sgt" %5, %c8_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %c48_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.and %c-29_i64, %arg2 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %0, %c-30_i64 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ule" %5, %arg0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.ashr %5, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c32_i64 = arith.constant 32 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sdiv %arg0, %c31_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %c32_i64, %4 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.or %c19_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.or %arg0, %arg0 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.lshr %c-33_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %c-39_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %c-36_i64, %0 : i64
    %4 = llvm.xor %3, %c21_i64 : i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.icmp "sle" %c-22_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "uge" %arg0, %c-3_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "eq" %3, %c43_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "sle" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "ule" %arg2, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %c6_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %c-6_i64 : i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.icmp "ugt" %1, %c9_i64 : i64
    %3 = llvm.select %2, %arg1, %1 : i1, i64
    %4 = llvm.xor %3, %1 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.select %arg2, %c36_i64, %c12_i64 : i1, i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.sdiv %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "ne" %c11_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %c-13_i64 : i64
    %3 = llvm.and %c-29_i64, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "eq" %5, %c-30_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "sge" %c-44_i64, %c-12_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.urem %c24_i64, %arg2 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %4, %arg2 : i64
    %6 = llvm.lshr %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c15_i64 = arith.constant 15 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %c15_i64, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ult" %c11_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.srem %c15_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %c15_i64, %arg0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.or %4, %c35_i64 : i64
    %6 = llvm.udiv %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c12_i64 = arith.constant 12 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.lshr %c-49_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %c-27_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.xor %c12_i64, %3 : i64
    %5 = llvm.select %arg1, %4, %c-46_i64 : i1, i64
    %6 = llvm.urem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.urem %arg1, %c-29_i64 : i64
    %1 = llvm.and %c-40_i64, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.zext %3 : i1 to i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.select %arg0, %c34_i64, %arg1 : i1, i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.ashr %arg2, %2 : i64
    %4 = llvm.ashr %c45_i64, %3 : i64
    %5 = llvm.sdiv %arg1, %4 : i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-31_i64 = arith.constant -31 : i64
    %true = arith.constant true
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.select %true, %arg0, %c27_i64 : i1, i64
    %1 = llvm.urem %arg1, %c-31_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "eq" %arg2, %c-17_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.ashr %5, %c-50_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %c5_i64 = arith.constant 5 : i64
    %c8_i64 = arith.constant 8 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.lshr %0, %c8_i64 : i64
    %2 = llvm.udiv %1, %c5_i64 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.or %c18_i64, %3 : i64
    %5 = llvm.select %false, %2, %c36_i64 : i1, i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.lshr %c50_i64, %c-43_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.and %1, %c3_i64 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c45_i64 = arith.constant 45 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.udiv %c45_i64, %c23_i64 : i64
    %1 = llvm.sdiv %0, %c-12_i64 : i64
    %2 = llvm.srem %c-15_i64, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.xor %3, %0 : i64
    %5 = llvm.srem %3, %1 : i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.lshr %c31_i64, %1 : i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.icmp "ule" %3, %1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.ashr %arg1, %c13_i64 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.sext %arg0 : i1 to i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.or %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.select %2, %arg1, %arg0 : i1, i64
    %4 = llvm.icmp "ugt" %arg2, %c-20_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "sge" %arg1, %arg2 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.xor %1, %c-23_i64 : i64
    %4 = llvm.lshr %c23_i64, %3 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.srem %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %arg1, %arg1 : i64
    %2 = llvm.urem %arg0, %arg2 : i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.lshr %3, %c43_i64 : i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.zext %1 : i1 to i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.xor %arg0, %c-29_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %4, %arg2 : i64
    %6 = llvm.icmp "eq" %5, %c35_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.srem %arg0, %c-15_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.and %arg1, %0 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.lshr %c-36_i64, %3 : i64
    %5 = llvm.and %4, %3 : i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.xor %c-28_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.select %arg1, %3, %c39_i64 : i1, i64
    %5 = llvm.udiv %0, %4 : i64
    %6 = llvm.icmp "ule" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %c30_i64 : i64
    %4 = llvm.icmp "sle" %c48_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ugt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.sdiv %c42_i64, %arg0 : i64
    %3 = llvm.and %c9_i64, %2 : i64
    %4 = llvm.urem %arg2, %3 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.xor %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "sgt" %c-7_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "sge" %c0_i64, %c-45_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %arg1, %arg2 : i64
    %4 = llvm.or %3, %c-11_i64 : i64
    %5 = llvm.select %0, %2, %4 : i1, i64
    %6 = llvm.icmp "ugt" %5, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.udiv %c-41_i64, %0 : i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.urem %3, %c-14_i64 : i64
    %5 = llvm.xor %arg0, %4 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.ashr %arg1, %arg0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.icmp "slt" %4, %arg1 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.xor %c14_i64, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.sdiv %c-9_i64, %4 : i64
    %6 = llvm.srem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c-27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ult" %c-27_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.udiv %4, %arg0 : i64
    %6 = llvm.icmp "slt" %c41_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.srem %1, %c-34_i64 : i64
    %3 = llvm.icmp "ule" %arg2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.xor %arg1, %arg2 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.select %1, %3, %c-40_i64 : i1, i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.lshr %c0_i64, %arg1 : i64
    %3 = llvm.icmp "uge" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.icmp "slt" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c25_i64 = arith.constant 25 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sdiv %0, %c25_i64 : i64
    %2 = llvm.ashr %1, %c-44_i64 : i64
    %3 = llvm.and %0, %0 : i64
    %4 = llvm.xor %c-5_i64, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "ugt" %5, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %arg0, %c-27_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %c22_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c23_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "eq" %0, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %arg0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.urem %c-32_i64, %2 : i64
    %4 = llvm.lshr %c38_i64, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.srem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c5_i64 = arith.constant 5 : i64
    %c26_i64 = arith.constant 26 : i64
    %c15_i64 = arith.constant 15 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.and %c50_i64, %arg2 : i64
    %1 = llvm.select %arg1, %0, %c26_i64 : i1, i64
    %2 = llvm.ashr %1, %c5_i64 : i64
    %3 = llvm.icmp "ugt" %c15_i64, %2 : i64
    %4 = llvm.select %3, %1, %2 : i1, i64
    %5 = llvm.udiv %4, %c7_i64 : i64
    %6 = llvm.xor %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "ule" %arg1, %c14_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c-32_i64, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.sext %0 : i1 to i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c12_i64 = arith.constant 12 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.ashr %c-41_i64, %arg0 : i64
    %4 = llvm.sdiv %c12_i64, %c-42_i64 : i64
    %5 = llvm.srem %3, %4 : i64
    %6 = llvm.srem %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.select %arg2, %c35_i64, %c-47_i64 : i1, i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %c-35_i64, %2 : i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c-29_i64 = arith.constant -29 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.icmp "slt" %arg1, %arg2 : i64
    %2 = llvm.select %1, %c-29_i64, %c7_i64 : i1, i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.srem %arg2, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    %6 = llvm.icmp "sge" %5, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "ne" %c49_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c12_i64 = arith.constant 12 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %arg1, %c26_i64 : i64
    %2 = llvm.select %1, %arg2, %arg1 : i1, i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.ashr %3, %c12_i64 : i64
    %5 = llvm.sext %false : i1 to i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "slt" %4, %arg1 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.sdiv %3, %1 : i64
    %5 = llvm.lshr %4, %1 : i64
    %6 = llvm.urem %c6_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c28_i64 = arith.constant 28 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "ule" %c28_i64, %c-1_i64 : i64
    %1 = llvm.select %0, %c-11_i64, %c-48_i64 : i1, i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "ule" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %4, %c43_i64 : i64
    %6 = llvm.icmp "sgt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %c35_i64, %arg0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.urem %arg0, %c-7_i64 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.ashr %5, %arg2 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c2_i64 = arith.constant 2 : i64
    %c19_i64 = arith.constant 19 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "eq" %c19_i64, %c18_i64 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.or %c21_i64, %2 : i64
    %4 = llvm.or %c2_i64, %3 : i64
    %5 = llvm.select %0, %arg0, %4 : i1, i64
    %6 = llvm.icmp "eq" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c38_i64 = arith.constant 38 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.ashr %c-47_i64, %1 : i64
    %3 = llvm.lshr %c38_i64, %c-2_i64 : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.select %arg0, %c42_i64, %arg1 : i1, i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.select %2, %arg2, %c8_i64 : i1, i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.icmp "ne" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %c-35_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "eq" %2, %c-39_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %0, %4 : i64
    %6 = llvm.icmp "uge" %c-29_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.or %arg0, %c-6_i64 : i64
    %1 = llvm.xor %c-47_i64, %0 : i64
    %2 = llvm.sdiv %c-10_i64, %c46_i64 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.icmp "uge" %5, %4 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.or %arg0, %c36_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.srem %arg0, %arg2 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.udiv %arg0, %4 : i64
    %6 = llvm.ashr %c-40_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-30_i64 = arith.constant -30 : i64
    %true = arith.constant true
    %0 = llvm.icmp "eq" %arg1, %arg2 : i64
    %1 = llvm.select %true, %c-30_i64, %c15_i64 : i1, i64
    %2 = llvm.select %0, %1, %c-11_i64 : i1, i64
    %3 = llvm.icmp "ne" %c-18_i64, %c-9_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.icmp "ult" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.xor %0, %arg1 : i64
    %4 = llvm.srem %c8_i64, %c9_i64 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.and %arg2, %0 : i64
    %4 = llvm.and %c36_i64, %c49_i64 : i64
    %5 = llvm.select %2, %3, %4 : i1, i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ule" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %c-8_i64 : i64
    %2 = llvm.select %arg2, %1, %c-19_i64 : i1, i64
    %3 = llvm.select %0, %c23_i64, %2 : i1, i64
    %4 = llvm.sext %arg2 : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.ashr %5, %1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "ult" %arg2, %c41_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %0, %c48_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %c-33_i64, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.icmp "ult" %arg0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %arg1, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c46_i64 = arith.constant 46 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.xor %c27_i64, %0 : i64
    %2 = llvm.and %c46_i64, %1 : i64
    %3 = llvm.icmp "sge" %c-17_i64, %c17_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    %6 = llvm.xor %5, %arg1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "slt" %arg0, %c-24_i64 : i64
    %1 = llvm.and %arg1, %arg0 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.icmp "eq" %c-35_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %arg2, %c6_i64 : i64
    %6 = llvm.icmp "ult" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %arg1, %c10_i64 : i64
    %2 = llvm.sdiv %arg2, %c-31_i64 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.ashr %arg0, %c47_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.icmp "slt" %arg1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c49_i64 = arith.constant 49 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.urem %arg1, %c19_i64 : i64
    %1 = llvm.icmp "uge" %c49_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "sge" %c21_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.urem %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.or %arg1, %arg2 : i64
    %3 = llvm.select %1, %2, %arg0 : i1, i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.trunc %1 : i1 to i64
    %6 = llvm.and %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.icmp "ugt" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.ashr %c-27_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "uge" %c-36_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %arg0, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %c2_i64, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.sdiv %2, %c-40_i64 : i64
    %4 = llvm.xor %3, %c-40_i64 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.lshr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.icmp "sgt" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.urem %c-16_i64, %c12_i64 : i64
    %1 = llvm.icmp "sgt" %c-2_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %arg0, %arg1 : i64
    %4 = llvm.sdiv %3, %c15_i64 : i64
    %5 = llvm.ashr %c-31_i64, %4 : i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c-44_i64 = arith.constant -44 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.and %arg2, %c29_i64 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.srem %2, %c-44_i64 : i64
    %4 = llvm.urem %arg2, %arg1 : i64
    %5 = llvm.select %true, %arg2, %4 : i1, i64
    %6 = llvm.lshr %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-38_i64 = arith.constant -38 : i64
    %true = arith.constant true
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.select %true, %c-4_i64, %0 : i1, i64
    %2 = llvm.or %1, %c-38_i64 : i64
    %3 = llvm.lshr %arg0, %1 : i64
    %4 = llvm.select %false, %3, %arg2 : i1, i64
    %5 = llvm.sdiv %4, %3 : i64
    %6 = llvm.icmp "ule" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "eq" %c-46_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.xor %c32_i64, %2 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.sdiv %4, %arg2 : i64
    %6 = llvm.or %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c13_i64 = arith.constant 13 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.ashr %c-11_i64, %c14_i64 : i64
    %1 = llvm.sdiv %c34_i64, %c13_i64 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.ashr %c-1_i64, %c-23_i64 : i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.lshr %arg2, %0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %c-43_i64, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %c-35_i64, %c-33_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.srem %3, %arg0 : i64
    %5 = llvm.udiv %4, %2 : i64
    %6 = llvm.icmp "sge" %5, %4 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %c21_i64, %arg1 : i64
    %2 = llvm.xor %arg2, %arg1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.urem %arg1, %c46_i64 : i64
    %5 = llvm.sdiv %3, %4 : i64
    %6 = llvm.icmp "eq" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.urem %c-15_i64, %c24_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.icmp "sge" %c-3_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %arg1, %2 : i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.udiv %c-44_i64, %arg0 : i64
    %1 = llvm.ashr %c-3_i64, %0 : i64
    %2 = llvm.urem %c27_i64, %arg1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ult" %5, %c-5_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c11_i64 = arith.constant 11 : i64
    %true = arith.constant true
    %c38_i64 = arith.constant 38 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c18_i64 : i64
    %2 = llvm.urem %1, %c38_i64 : i64
    %3 = llvm.select %true, %c11_i64, %c-25_i64 : i1, i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.xor %arg0, %c-3_i64 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    %4 = llvm.xor %2, %arg0 : i64
    %5 = llvm.select %3, %4, %arg1 : i1, i64
    %6 = llvm.sdiv %5, %2 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %1, %arg0, %2 : i1, i64
    %4 = llvm.icmp "sgt" %arg1, %3 : i64
    %5 = llvm.select %4, %3, %arg2 : i1, i64
    %6 = llvm.sdiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "uge" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %c-27_i64, %c-17_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.ashr %arg0, %0 : i64
    %4 = llvm.and %3, %3 : i64
    %5 = llvm.srem %c-23_i64, %4 : i64
    %6 = llvm.and %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c3_i64 = arith.constant 3 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "ne" %c-45_i64, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "ult" %c3_i64, %1 : i64
    %4 = llvm.select %3, %c-49_i64, %arg1 : i1, i64
    %5 = llvm.urem %4, %4 : i64
    %6 = llvm.icmp "ult" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.and %arg0, %c1_i64 : i64
    %1 = llvm.urem %c0_i64, %0 : i64
    %2 = llvm.icmp "ult" %arg1, %1 : i64
    %3 = llvm.udiv %arg1, %1 : i64
    %4 = llvm.select %2, %3, %1 : i1, i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.or %arg0, %c8_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %2, %c-36_i64 : i64
    %4 = llvm.and %c-50_i64, %3 : i64
    %5 = llvm.or %c24_i64, %2 : i64
    %6 = llvm.icmp "sgt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "slt" %arg1, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c42_i64, %1 : i64
    %3 = llvm.srem %arg2, %c-9_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.lshr %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg2, %c-38_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %4, %c26_i64 : i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %c-5_i64, %c10_i64 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.select %3, %arg2, %c-41_i64 : i1, i64
    %5 = llvm.ashr %c-4_i64, %c-41_i64 : i64
    %6 = llvm.or %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.sdiv %c-23_i64, %c-29_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.select %arg1, %arg2, %c-28_i64 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.and %c-39_i64, %3 : i64
    %5 = llvm.zext %arg1 : i1 to i64
    %6 = llvm.icmp "ule" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "slt" %c-46_i64, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "slt" %5, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c2_i64 = arith.constant 2 : i64
    %false = arith.constant false
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.select %false, %arg0, %c25_i64 : i1, i64
    %1 = llvm.lshr %c2_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.or %0, %0 : i64
    %4 = llvm.select %2, %c10_i64, %3 : i1, i64
    %5 = llvm.xor %arg1, %arg2 : i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %3, %arg0 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.icmp "sgt" %5, %c48_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %true = arith.constant true
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.select %true, %arg2, %c41_i64 : i1, i64
    %3 = llvm.sdiv %c-15_i64, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.ashr %2, %0 : i64
    %6 = llvm.or %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c22_i64 = arith.constant 22 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "sge" %arg0, %c-39_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %arg1, %arg2, %c22_i64 : i1, i64
    %3 = llvm.udiv %2, %c-15_i64 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "eq" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c6_i64 = arith.constant 6 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.sdiv %c6_i64, %c47_i64 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.icmp "ne" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c46_i64 = arith.constant 46 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "ugt" %c46_i64, %c5_i64 : i64
    %1 = llvm.icmp "sge" %c12_i64, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %arg1, %arg0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.select %0, %arg0, %4 : i1, i64
    %6 = llvm.icmp "sgt" %5, %4 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.or %arg0, %c0_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.and %arg0, %c-7_i64 : i64
    %3 = llvm.or %1, %arg1 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "ult" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sdiv %c-47_i64, %arg2 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.lshr %2, %c-49_i64 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.icmp "sle" %4, %c16_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg1, %c-35_i64 : i64
    %2 = llvm.icmp "ne" %arg2, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %3, %arg1 : i64
    %5 = llvm.select %0, %4, %1 : i1, i64
    %6 = llvm.udiv %5, %4 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c15_i64 = arith.constant 15 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.and %c15_i64, %c21_i64 : i64
    %1 = llvm.icmp "sle" %c-39_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %c24_i64, %2 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.udiv %arg0, %4 : i64
    %6 = llvm.sdiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c13_i64 = arith.constant 13 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ne" %arg0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %c13_i64, %c-39_i64 : i64
    %4 = llvm.udiv %3, %arg0 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "ule" %1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.srem %5, %arg0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c35_i64 = arith.constant 35 : i64
    %false = arith.constant false
    %c-4_i64 = arith.constant -4 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.select %false, %c-4_i64, %c13_i64 : i1, i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.xor %1, %c35_i64 : i64
    %3 = llvm.icmp "ult" %c-49_i64, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.ashr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %false = arith.constant false
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.select %false, %c-45_i64, %arg0 : i1, i64
    %1 = llvm.srem %arg1, %c-36_i64 : i64
    %2 = llvm.and %arg1, %arg1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.udiv %arg1, %arg2 : i64
    %6 = llvm.icmp "ne" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %c22_i64, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "ule" %2, %c39_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.srem %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c18_i64 = arith.constant 18 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %c36_i64, %c-15_i64 : i64
    %1 = llvm.srem %0, %c18_i64 : i64
    %2 = llvm.lshr %0, %arg0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.select %arg1, %2, %c41_i64 : i1, i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.srem %c-43_i64, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.ashr %1, %c-27_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.ashr %3, %c50_i64 : i64
    %5 = llvm.trunc %arg1 : i1 to i64
    %6 = llvm.udiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.lshr %arg1, %arg0 : i64
    %3 = llvm.icmp "sgt" %0, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.xor %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "sge" %c-21_i64, %c30_i64 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.lshr %arg1, %arg0 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.select %0, %c38_i64, %2 : i1, i64
    %6 = llvm.icmp "ugt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.select %arg0, %c-5_i64, %arg1 : i1, i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.icmp "uge" %3, %0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "ule" %arg1, %arg2 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %arg2, %c-39_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %4, %arg2 : i64
    %6 = llvm.icmp "ne" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    %3 = llvm.and %2, %c34_i64 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.urem %c-28_i64, %4 : i64
    %6 = llvm.icmp "sle" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.urem %c-33_i64, %arg1 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.select %arg0, %c-27_i64, %1 : i1, i64
    %3 = llvm.udiv %c50_i64, %2 : i64
    %4 = llvm.or %c-30_i64, %3 : i64
    %5 = llvm.lshr %c-25_i64, %4 : i64
    %6 = llvm.icmp "ult" %c9_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.xor %c-39_i64, %1 : i64
    %3 = llvm.or %arg2, %c-23_i64 : i64
    %4 = llvm.icmp "eq" %arg1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %c2_i64, %0 : i64
    %2 = llvm.icmp "sle" %arg2, %c-13_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %arg1, %3 : i64
    %5 = llvm.or %arg1, %4 : i64
    %6 = llvm.select %1, %arg0, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c7_i64 = arith.constant 7 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.or %c25_i64, %arg0 : i64
    %1 = llvm.urem %c-20_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %c7_i64, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.sdiv %c-12_i64, %arg0 : i64
    %1 = llvm.udiv %c17_i64, %arg1 : i64
    %2 = llvm.ashr %0, %c-3_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.ashr %3, %arg2 : i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.icmp "uge" %c-45_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ule" %c25_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %true, %0, %0 : i1, i64
    %4 = llvm.and %2, %arg2 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.lshr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.and %arg2, %1 : i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.srem %c17_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.sdiv %arg2, %1 : i64
    %4 = llvm.sdiv %3, %0 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c0_i64 = arith.constant 0 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %0, %c32_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %c-45_i64, %2 : i64
    %4 = llvm.icmp "sle" %c0_i64, %0 : i64
    %5 = llvm.select %4, %c37_i64, %3 : i1, i64
    %6 = llvm.icmp "ult" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c2_i64 = arith.constant 2 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.udiv %c2_i64, %c-15_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.icmp "sle" %arg1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.sdiv %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.ashr %c-29_i64, %2 : i64
    %4 = llvm.icmp "ne" %arg1, %arg2 : i64
    %5 = llvm.select %4, %arg0, %c17_i64 : i1, i64
    %6 = llvm.icmp "sge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c37_i64 = arith.constant 37 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %c-46_i64, %0 : i64
    %2 = llvm.icmp "ugt" %c37_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %arg1, %c2_i64 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-10_i64 = arith.constant -10 : i64
    %true = arith.constant true
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.select %true, %arg0, %c-10_i64 : i1, i64
    %2 = llvm.and %arg0, %c30_i64 : i64
    %3 = llvm.sdiv %2, %c16_i64 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-19_i64 = arith.constant -19 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c21_i64 = arith.constant 21 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %c-21_i64, %c-19_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.udiv %c21_i64, %2 : i64
    %4 = llvm.sdiv %3, %arg0 : i64
    %5 = llvm.select %true, %0, %2 : i1, i64
    %6 = llvm.udiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.select %arg0, %c11_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ult" %arg2, %c-30_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "eq" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.or %c-21_i64, %arg0 : i64
    %1 = llvm.sdiv %c-34_i64, %arg1 : i64
    %2 = llvm.and %arg2, %c14_i64 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %4, %arg1 : i64
    %6 = llvm.srem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %c-6_i64, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c8_i64 = arith.constant 8 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.xor %c8_i64, %c47_i64 : i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %c2_i64, %c-18_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %c-6_i64, %4 : i64
    %6 = llvm.xor %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c15_i64 = arith.constant 15 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.udiv %c15_i64, %c38_i64 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "slt" %c43_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c15_i64 = arith.constant 15 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.lshr %c15_i64, %c13_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.ashr %c-1_i64, %1 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.select %4, %c33_i64, %arg1 : i1, i64
    %6 = llvm.xor %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %0, %c43_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %arg2, %2 : i64
    %4 = llvm.sdiv %3, %0 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.or %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c5_i64 : i64
    %2 = llvm.icmp "ult" %0, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.srem %arg0, %4 : i64
    %6 = llvm.icmp "ule" %c8_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.srem %arg0, %c-6_i64 : i64
    %1 = llvm.srem %c6_i64, %c-13_i64 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.lshr %4, %3 : i64
    %6 = llvm.and %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.and %c5_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.and %c25_i64, %1 : i64
    %3 = llvm.icmp "eq" %1, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.icmp "slt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "ne" %c28_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg0, %arg1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "sle" %c-45_i64, %c44_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.icmp "uge" %1, %c-25_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.lshr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.or %c-14_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %c-38_i64, %0 : i64
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    %3 = llvm.icmp "eq" %arg1, %c43_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %4, %2 : i64
    %6 = llvm.icmp "sgt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.icmp "sle" %3, %arg0 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.xor %arg2, %c-32_i64 : i64
    %2 = llvm.xor %1, %c-45_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.select %arg0, %0, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.ashr %c29_i64, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.lshr %5, %0 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.urem %c-45_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %c-3_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "slt" %5, %c-1_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "ule" %c-33_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c18_i64, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "ne" %arg1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "eq" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %c-47_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %c-43_i64, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.srem %arg1, %c-4_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.select %false, %arg2, %c-6_i64 : i1, i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.lshr %3, %arg1 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.and %c-15_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg2, %arg2 : i64
    %4 = llvm.udiv %3, %arg0 : i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.icmp "ugt" %5, %4 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c39_i64 = arith.constant 39 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %c39_i64, %c38_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %c22_i64, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "uge" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c31_i64 = arith.constant 31 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %c-6_i64, %0 : i64
    %2 = llvm.lshr %1, %c31_i64 : i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.select %arg1, %3, %c-4_i64 : i1, i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.icmp "uge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.ashr %c-36_i64, %c-23_i64 : i64
    %1 = llvm.ashr %arg1, %arg1 : i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.select %arg2, %1, %2 : i1, i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.xor %c-4_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %c-16_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.lshr %0, %c35_i64 : i64
    %5 = llvm.or %arg2, %4 : i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.select %true, %c23_i64, %arg0 : i1, i64
    %4 = llvm.icmp "slt" %3, %2 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %arg0, %c-48_i64 : i64
    %4 = llvm.sdiv %c-8_i64, %c-10_i64 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.icmp "sle" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c4_i64 = arith.constant 4 : i64
    %c14_i64 = arith.constant 14 : i64
    %c26_i64 = arith.constant 26 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %arg2 : i64
    %2 = llvm.icmp "eq" %c-19_i64, %c26_i64 : i64
    %3 = llvm.and %c14_i64, %c4_i64 : i64
    %4 = llvm.select %2, %3, %c37_i64 : i1, i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.icmp "ugt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %c-33_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %0, %0 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %5, %2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.and %c-2_i64, %c42_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.udiv %arg1, %arg2 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.icmp "sge" %c2_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.or %c34_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %true, %arg1, %arg2 : i1, i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "sle" %c17_i64, %c-6_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.srem %3, %1 : i64
    %5 = llvm.select %arg0, %4, %arg1 : i1, i64
    %6 = llvm.urem %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %c-35_i64, %c-9_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %c14_i64, %2 : i64
    %4 = llvm.lshr %arg0, %0 : i64
    %5 = llvm.srem %4, %1 : i64
    %6 = llvm.udiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c11_i64 = arith.constant 11 : i64
    %true = arith.constant true
    %false = arith.constant false
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.select %false, %arg0, %c-8_i64 : i1, i64
    %1 = llvm.srem %c11_i64, %arg1 : i64
    %2 = llvm.select %true, %1, %c40_i64 : i1, i64
    %3 = llvm.icmp "ugt" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c-4_i64 = arith.constant -4 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ule" %c-4_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %c-21_i64 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.icmp "sgt" %c-25_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "slt" %c-28_i64, %c26_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c5_i64, %c29_i64 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sle" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.urem %0, %c28_i64 : i64
    %4 = llvm.udiv %1, %c31_i64 : i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.icmp "slt" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg2, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c5_i64 = arith.constant 5 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %c5_i64, %c47_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.sdiv %3, %c14_i64 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %false = arith.constant false
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.udiv %c-45_i64, %arg1 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %0, %0 : i64
    %4 = llvm.srem %3, %arg2 : i64
    %5 = llvm.select %false, %2, %4 : i1, i64
    %6 = llvm.icmp "sgt" %c-11_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.lshr %c28_i64, %1 : i64
    %3 = llvm.select %arg2, %c8_i64, %2 : i1, i64
    %4 = llvm.sdiv %3, %arg1 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.and %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.icmp "slt" %arg1, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %c-18_i64, %4 : i64
    %6 = llvm.urem %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.sdiv %0, %c-29_i64 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.and %arg0, %arg0 : i64
    %4 = llvm.ashr %c-30_i64, %3 : i64
    %5 = llvm.udiv %4, %arg1 : i64
    %6 = llvm.srem %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c16_i64 = arith.constant 16 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.udiv %c14_i64, %arg0 : i64
    %1 = llvm.udiv %c-28_i64, %c-47_i64 : i64
    %2 = llvm.icmp "slt" %arg1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.xor %c16_i64, %4 : i64
    %6 = llvm.urem %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "uge" %2, %c-36_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-39_i64 = arith.constant -39 : i64
    %true = arith.constant true
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.urem %c44_i64, %arg1 : i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.urem %arg0, %arg2 : i64
    %3 = llvm.sdiv %arg1, %c-39_i64 : i64
    %4 = llvm.lshr %3, %c-30_i64 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.icmp "sge" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "ne" %c42_i64, %c-7_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.zext %0 : i1 to i64
    %6 = llvm.urem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c-32_i64 : i64
    %2 = llvm.icmp "ult" %c-6_i64, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.or %5, %arg2 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.ashr %c50_i64, %1 : i64
    %4 = llvm.icmp "eq" %c44_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.sdiv %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c-18_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    %6 = llvm.trunc %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c32_i64 = arith.constant 32 : i64
    %true = arith.constant true
    %false = arith.constant false
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.urem %c-11_i64, %arg0 : i64
    %1 = llvm.select %true, %c32_i64, %c-2_i64 : i1, i64
    %2 = llvm.select %false, %arg2, %1 : i1, i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.or %arg1, %4 : i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c46_i64 = arith.constant 46 : i64
    %c20_i64 = arith.constant 20 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.select %arg0, %c20_i64, %c-32_i64 : i1, i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.sdiv %c46_i64, %2 : i64
    %4 = llvm.ashr %3, %arg1 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.icmp "ugt" %c16_i64, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c2_i64 = arith.constant 2 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.ashr %c2_i64, %c6_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.ashr %c-31_i64, %arg0 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %c-30_i64, %4 : i64
    %6 = llvm.lshr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %c-26_i64, %0 : i64
    %2 = llvm.and %1, %c2_i64 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ne" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-2_i64 = arith.constant -2 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %arg1, %arg2 : i64
    %2 = llvm.sdiv %c43_i64, %c-18_i64 : i64
    %3 = llvm.or %2, %c-2_i64 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.select %1, %3, %4 : i1, i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.and %c-5_i64, %0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.icmp "ugt" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ne" %c-28_i64, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.xor %arg0, %c-5_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.lshr %arg1, %0 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.xor %c8_i64, %4 : i64
    %6 = llvm.icmp "ne" %5, %c6_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.urem %c-5_i64, %c43_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.ashr %arg1, %arg1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.and %arg2, %arg2 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c19_i64 = arith.constant 19 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.sdiv %c11_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %c-16_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %c19_i64, %2 : i64
    %4 = llvm.trunc %arg1 : i1 to i64
    %5 = llvm.udiv %c36_i64, %4 : i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
