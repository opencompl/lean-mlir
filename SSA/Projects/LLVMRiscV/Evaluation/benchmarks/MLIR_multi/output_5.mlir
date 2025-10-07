module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.ashr %arg1, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %c-40_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %c40_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.sdiv %arg2, %arg1 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    %3 = llvm.ashr %c-24_i64, %c36_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c30_i64 : i64
    %2 = llvm.lshr %c-37_i64, %1 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.and %c-2_i64, %c31_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %c40_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "sle" %arg2, %arg2 : i64
    %3 = llvm.select %2, %1, %c-4_i64 : i1, i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.or %arg0, %c-14_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.icmp "eq" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c31_i64 = arith.constant 31 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.lshr %c-40_i64, %arg0 : i64
    %1 = llvm.select %arg1, %c-30_i64, %c31_i64 : i1, i64
    %2 = llvm.and %arg2, %c8_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %c25_i64, %arg1 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.and %c-24_i64, %arg2 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "uge" %arg1, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.sdiv %c44_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.or %c40_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.sdiv %c-26_i64, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.select %0, %arg1, %arg0 : i1, i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c39_i64 = arith.constant 39 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.sdiv %c39_i64, %c-8_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %arg2, %c-32_i64 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "sge" %c34_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.or %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "uge" %c16_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.and %2, %c16_i64 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c2_i64 = arith.constant 2 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %0, %c2_i64 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.ashr %c10_i64, %arg0 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %false = arith.constant false
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "eq" %0, %c-14_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %false, %0, %2 : i1, i64
    %4 = llvm.icmp "sge" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.sdiv %c3_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ne" %arg1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c-11_i64 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.srem %c-38_i64, %2 : i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "sle" %0, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.select %arg0, %c46_i64, %c-6_i64 : i1, i64
    %1 = llvm.or %0, %c11_i64 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %c25_i64 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.select %3, %arg0, %arg2 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "ne" %arg0, %c6_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.ashr %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.icmp "sge" %c-38_i64, %c-10_i64 : i64
    %1 = llvm.select %0, %c35_i64, %c0_i64 : i1, i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.select %arg0, %c-50_i64, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "sge" %arg0, %c-9_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    %3 = llvm.xor %arg0, %c-46_i64 : i64
    %4 = llvm.select %2, %c27_i64, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.and %arg0, %c4_i64 : i64
    %1 = llvm.ashr %c-42_i64, %0 : i64
    %2 = llvm.sdiv %arg1, %0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "uge" %3, %c12_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "eq" %c-27_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "uge" %c-36_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "uge" %c29_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.lshr %2, %1 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.udiv %c-45_i64, %c9_i64 : i64
    %1 = llvm.sdiv %0, %c-9_i64 : i64
    %2 = llvm.lshr %arg0, %0 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.icmp "uge" %3, %c30_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c45_i64 = arith.constant 45 : i64
    %true = arith.constant true
    %c21_i64 = arith.constant 21 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %true, %c21_i64, %0 : i1, i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.ashr %2, %c45_i64 : i64
    %4 = llvm.icmp "sgt" %3, %c-44_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.or %arg0, %arg2 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c14_i64 = arith.constant 14 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.and %c17_i64, %arg1 : i64
    %1 = llvm.xor %c14_i64, %0 : i64
    %2 = llvm.xor %c-48_i64, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.and %c2_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c14_i64 = arith.constant 14 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %c20_i64 : i64
    %2 = llvm.or %c-28_i64, %arg1 : i64
    %3 = llvm.srem %c14_i64, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.and %arg0, %c34_i64 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.srem %arg1, %0 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "slt" %arg1, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.or %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "eq" %arg0, %c-7_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.srem %arg0, %c49_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.srem %0, %arg2 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg1, %2, %arg2 : i1, i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "ugt" %c48_i64, %c4_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "uge" %c-35_i64, %c12_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.lshr %1, %1 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.and %arg0, %c-44_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.select %true, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %c22_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.urem %arg2, %c-45_i64 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.srem %arg1, %c17_i64 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.icmp "ule" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c42_i64 = arith.constant 42 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.srem %c42_i64, %c25_i64 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.and %c-35_i64, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.and %arg1, %c-35_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.and %c6_i64, %1 : i64
    %3 = llvm.or %2, %c17_i64 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.urem %arg0, %c35_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.select %arg1, %1, %2 : i1, i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.select %arg0, %1, %c30_i64 : i1, i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.trunc %arg2 : i1 to i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.icmp "ne" %c-23_i64, %1 : i64
    %3 = llvm.select %2, %c-34_i64, %0 : i1, i64
    %4 = llvm.xor %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %c26_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.xor %c43_i64, %arg0 : i64
    %1 = llvm.ashr %0, %c-17_i64 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.urem %arg0, %c16_i64 : i64
    %1 = llvm.udiv %arg2, %arg1 : i64
    %2 = llvm.icmp "slt" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c49_i64, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "eq" %3, %c13_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c25_i64 = arith.constant 25 : i64
    %c2_i64 = arith.constant 2 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "sle" %c2_i64, %c40_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %c25_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %c30_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.urem %c-40_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %c-9_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %c-11_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.urem %arg0, %c-46_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.select %arg2, %c48_i64, %c-3_i64 : i1, i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.ashr %arg1, %arg1 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.and %0, %c17_i64 : i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %c-39_i64, %0 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.sdiv %c-38_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.srem %arg2, %c13_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "sge" %c-16_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ne" %c-2_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.icmp "ule" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.urem %c-14_i64, %arg0 : i64
    %1 = llvm.srem %c-28_i64, %0 : i64
    %2 = llvm.icmp "uge" %1, %c-31_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %c5_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.sdiv %c42_i64, %c-46_i64 : i64
    %1 = llvm.sdiv %0, %c-27_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %c-35_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "eq" %c-24_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c12_i64, %arg0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.sdiv %3, %1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.urem %c16_i64, %c-1_i64 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %c46_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %c-47_i64, %c45_i64 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %2, %c-7_i64 : i64
    %4 = llvm.ashr %c-24_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %false = arith.constant false
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "ult" %c-47_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.select %false, %1, %arg0 : i1, i64
    %3 = llvm.icmp "ugt" %c-35_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "ugt" %c11_i64, %c-37_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.or %arg1, %c22_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.xor %c-46_i64, %1 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %c-47_i64 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.srem %c-2_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c-26_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %c-35_i64, %arg1 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ugt" %c-25_i64, %c-11_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.xor %c40_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %false = arith.constant false
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %c32_i64 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %c-46_i64, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %c45_i64, %0 : i64
    %2 = llvm.icmp "sle" %c22_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.ashr %c28_i64, %0 : i64
    %2 = llvm.or %arg1, %arg0 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.srem %arg2, %arg2 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "uge" %c-17_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.sdiv %c-23_i64, %c-28_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "sle" %c49_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %c-31_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.sdiv %c-22_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.lshr %0, %arg0 : i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.select %1, %3, %arg1 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %c-36_i64, %0 : i64
    %2 = llvm.icmp "sgt" %arg1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c14_i64, %c9_i64 : i1, i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c24_i64 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.select %3, %1, %arg0 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %c-13_i64, %arg1 : i64
    %2 = llvm.urem %c-21_i64, %c30_i64 : i64
    %3 = llvm.select %1, %arg1, %2 : i1, i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %c18_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.icmp "eq" %3, %c7_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.select %true, %c-31_i64, %arg0 : i1, i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.ashr %arg2, %arg0 : i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.srem %c-37_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.urem %c-12_i64, %2 : i64
    %4 = llvm.icmp "slt" %c39_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.and %1, %c39_i64 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.sdiv %c25_i64, %arg0 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.ashr %c39_i64, %arg1 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.xor %arg2, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.and %0, %arg2 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.lshr %arg0, %c-5_i64 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.lshr %c-15_i64, %c-38_i64 : i64
    %3 = llvm.select %arg2, %arg1, %2 : i1, i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.and %c-39_i64, %arg1 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "slt" %c-17_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %arg2 : i64
    %2 = llvm.icmp "sgt" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c18_i64 = arith.constant 18 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "ult" %c18_i64, %c6_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %c-19_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.lshr %c-34_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "slt" %c49_i64, %c31_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.urem %c-50_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.xor %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %c-24_i64, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %c37_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %c32_i64 = arith.constant 32 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.and %c19_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "ule" %1, %c32_i64 : i64
    %3 = llvm.and %0, %0 : i64
    %4 = llvm.select %2, %c-10_i64, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ult" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.or %1, %c-44_i64 : i64
    %3 = llvm.ashr %2, %c-16_i64 : i64
    %4 = llvm.icmp "ne" %c-19_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-47_i64 = arith.constant -47 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.and %c-8_i64, %arg0 : i64
    %1 = llvm.srem %c10_i64, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.srem %c-47_i64, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %c4_i64, %c49_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %c27_i64, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.or %2, %1 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.lshr %c-8_i64, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.xor %c3_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %c-4_i64, %0 : i64
    %2 = llvm.lshr %0, %c-16_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "ult" %c-46_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.sdiv %1, %c-2_i64 : i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.ashr %c23_i64, %c-13_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.select %arg1, %arg2, %c-17_i64 : i1, i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.xor %arg1, %c-38_i64 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.sdiv %c-15_i64, %2 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.ashr %arg0, %c-17_i64 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.udiv %c29_i64, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.urem %c-4_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %2, %c-40_i64 : i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c41_i64 = arith.constant 41 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.ashr %c-19_i64, %c-24_i64 : i64
    %1 = llvm.urem %c41_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.srem %c-32_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %c41_i64 : i64
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.urem %c-30_i64, %arg0 : i64
    %1 = llvm.select %true, %0, %arg0 : i1, i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.xor %c-25_i64, %c-48_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.urem %arg0, %0 : i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sdiv %0, %c-28_i64 : i64
    %3 = llvm.select %true, %1, %2 : i1, i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %c27_i64 = arith.constant 27 : i64
    %c36_i64 = arith.constant 36 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.xor %c31_i64, %0 : i64
    %2 = llvm.icmp "eq" %c36_i64, %1 : i64
    %3 = llvm.lshr %arg2, %c-10_i64 : i64
    %4 = llvm.select %2, %c27_i64, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg2, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %arg1, %c45_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "uge" %c44_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.sdiv %arg1, %arg2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %arg1, %c-40_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.and %c-43_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.or %c-47_i64, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.srem %c47_i64, %c-50_i64 : i64
    %1 = llvm.and %c-35_i64, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.udiv %2, %1 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %c22_i64, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c34_i64 = arith.constant 34 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "sge" %arg0, %c40_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %c34_i64, %1 : i64
    %3 = llvm.icmp "uge" %2, %c20_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ne" %c-49_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %3 = llvm.select %true, %2, %arg0 : i1, i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "uge" %c-39_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.xor %c-8_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.and %arg1, %arg2 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c16_i64 = arith.constant 16 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "uge" %c16_i64, %c-36_i64 : i64
    %1 = llvm.select %0, %c21_i64, %arg0 : i1, i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.srem %3, %arg2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg1, %arg0 : i1, i64
    %2 = llvm.ashr %0, %arg2 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.xor %0, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c25_i64 = arith.constant 25 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.ashr %c25_i64, %c35_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.lshr %arg1, %c-14_i64 : i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %c33_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.xor %c30_i64, %c5_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "sgt" %c-28_i64, %arg0 : i64
    %1 = llvm.select %0, %arg2, %arg0 : i1, i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    %3 = llvm.lshr %2, %c-29_i64 : i64
    %4 = llvm.icmp "uge" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.xor %c-6_i64, %2 : i64
    %4 = llvm.icmp "ugt" %c38_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %2, %3, %1 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "sgt" %c-47_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %c-7_i64, %1 : i64
    %3 = llvm.or %2, %c-12_i64 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c-15_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %arg1, %0 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.urem %c-18_i64, %arg1 : i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %true = arith.constant true
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %arg0, %c-27_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.select %true, %1, %arg2 : i1, i64
    %3 = llvm.udiv %2, %c-33_i64 : i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.xor %c-7_i64, %c-39_i64 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %c48_i64, %0 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "sge" %c-7_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg1, %arg1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.ashr %c16_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ugt" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.xor %c5_i64, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.select %false, %arg2, %1 : i1, i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.lshr %c-43_i64, %c-40_i64 : i64
    %1 = llvm.srem %c-46_i64, %0 : i64
    %2 = llvm.srem %arg0, %0 : i64
    %3 = llvm.srem %2, %c-18_i64 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c6_i64 = arith.constant 6 : i64
    %c19_i64 = arith.constant 19 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.xor %c5_i64, %arg0 : i64
    %1 = llvm.xor %c-50_i64, %0 : i64
    %2 = llvm.urem %c19_i64, %1 : i64
    %3 = llvm.sdiv %c6_i64, %c-9_i64 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.srem %c50_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %c-25_i64 : i64
    %2 = llvm.icmp "eq" %1, %c14_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %c-32_i64, %1 : i64
    %3 = llvm.and %2, %c1_i64 : i64
    %4 = llvm.or %3, %1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.ashr %c-45_i64, %c2_i64 : i64
    %1 = llvm.icmp "sle" %c28_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.ashr %c-14_i64, %c41_i64 : i64
    %1 = llvm.sdiv %c40_i64, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.icmp "sgt" %c30_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %c32_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %c-23_i64 : i64
    %2 = llvm.lshr %c39_i64, %arg0 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.srem %c-14_i64, %c21_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %c-14_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %c46_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %3, %1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "ult" %arg2, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %c39_i64 = arith.constant 39 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.xor %c39_i64, %c9_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "ugt" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.and %arg0, %arg2 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.ashr %c-24_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %arg2, %c-18_i64 : i64
    %2 = llvm.select %1, %arg2, %c-19_i64 : i1, i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.icmp "ne" %2, %c-46_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %false = arith.constant false
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.select %false, %arg0, %c34_i64 : i1, i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "slt" %c2_i64, %2 : i64
    %4 = llvm.select %3, %1, %arg1 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.sdiv %c-20_i64, %c-47_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.lshr %1, %c-43_i64 : i64
    %3 = llvm.srem %arg0, %arg1 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.sdiv %arg2, %arg2 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.lshr %1, %c32_i64 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "sge" %c-26_i64, %c46_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.lshr %arg1, %c2_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.udiv %arg2, %c-47_i64 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.lshr %arg0, %c-7_i64 : i64
    %1 = llvm.udiv %0, %c-2_i64 : i64
    %2 = llvm.udiv %c-30_i64, %arg1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %c-11_i64, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.urem %c-40_i64, %arg2 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.urem %arg2, %arg0 : i64
    %1 = llvm.udiv %0, %c26_i64 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %c50_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c-46_i64 : i64
    %2 = llvm.icmp "uge" %c8_i64, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.or %c26_i64, %arg0 : i64
    %1 = llvm.ashr %c11_i64, %0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.lshr %3, %2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %arg0, %arg0 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.or %c-45_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "uge" %c39_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg1, %c-39_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.or %0, %c-48_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c35_i64 = arith.constant 35 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.icmp "eq" %c35_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg2, %c-31_i64, %arg0 : i1, i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.and %c-21_i64, %c-7_i64 : i64
    %1 = llvm.and %0, %c21_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %c-11_i64, %2 : i64
    %4 = llvm.icmp "slt" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %true = arith.constant true
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.select %true, %arg0, %c-2_i64 : i1, i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.lshr %arg1, %arg0 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.and %c20_i64, %arg1 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.select %arg0, %c-13_i64, %1 : i1, i64
    %3 = llvm.urem %0, %1 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.udiv %arg2, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.udiv %c31_i64, %2 : i64
    %4 = llvm.icmp "sge" %c28_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c29_i64 = arith.constant 29 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %c29_i64 : i64
    %2 = llvm.ashr %1, %c43_i64 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.or %c-12_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c8_i64 = arith.constant 8 : i64
    %c7_i64 = arith.constant 7 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.ashr %arg0, %c37_i64 : i64
    %1 = llvm.urem %c7_i64, %c8_i64 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.ashr %2, %c-17_i64 : i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c0_i64 = arith.constant 0 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "ugt" %c0_i64, %c14_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %c-43_i64, %arg0 : i64
    %3 = llvm.lshr %2, %c6_i64 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.select %arg0, %c8_i64, %c-28_i64 : i1, i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.urem %arg0, %c-16_i64 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %arg1, %c-13_i64 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %0, %c-24_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c6_i64 = arith.constant 6 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.and %c-46_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %c6_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "sle" %arg0, %c25_i64 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.select %0, %2, %1 : i1, i64
    %4 = llvm.icmp "sgt" %3, %c-35_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.or %c-36_i64, %0 : i64
    %2 = llvm.or %arg2, %arg0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.and %c19_i64, %arg0 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.select %0, %c-9_i64, %1 : i1, i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "eq" %c45_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.and %1, %c-18_i64 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.select %true, %1, %0 : i1, i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.lshr %arg2, %arg0 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.sdiv %c-4_i64, %c-16_i64 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.udiv %2, %c-45_i64 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.select %arg1, %1, %1 : i1, i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.srem %0, %arg2 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "eq" %2, %c2_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.srem %arg0, %c-9_i64 : i64
    %1 = llvm.icmp "ne" %0, %c26_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.sdiv %c18_i64, %arg0 : i64
    %1 = llvm.or %c-21_i64, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.urem %c41_i64, %c-6_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.or %0, %1 : i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.ashr %c-42_i64, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.select %2, %c50_i64, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %c-12_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %arg1, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.ashr %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c42_i64 = arith.constant 42 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.udiv %c33_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c42_i64, %arg0 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sge" %3, %c-42_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "ne" %c-26_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.udiv %c26_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.sdiv %c-44_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "sgt" %c47_i64, %c-35_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "eq" %arg0, %c-2_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c41_i64, %arg0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.urem %3, %c40_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.urem %c6_i64, %c-3_i64 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "uge" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.or %arg2, %arg2 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.ashr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c11_i64 = arith.constant 11 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "eq" %c11_i64, %c-2_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.ashr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.select %true, %1, %2 : i1, i64
    %4 = llvm.udiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "sge" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %true = arith.constant true
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.select %true, %0, %1 : i1, i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.srem %c-50_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.xor %c-42_i64, %c28_i64 : i64
    %1 = llvm.or %c27_i64, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.udiv %c14_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.xor %c-45_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ne" %c22_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "sle" %c19_i64, %c12_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.srem %arg0, %arg2 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "sge" %3, %c0_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.or %arg0, %arg2 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %c14_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %arg1, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.sdiv %c31_i64, %arg1 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "ule" %c-9_i64, %c-34_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %c-35_i64, %1 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.icmp "sle" %c3_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.and %3, %0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c43_i64 : i64
    %2 = llvm.or %0, %0 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.urem %c-25_i64, %c10_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "sge" %c8_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c-19_i64, %2 : i64
    %4 = llvm.lshr %c42_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.ashr %arg0, %c-38_i64 : i64
    %1 = llvm.select %arg1, %0, %0 : i1, i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c1_i64 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.or %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.icmp "ule" %c-19_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "ugt" %0, %c-15_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg2, %c19_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %c-45_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.xor %arg1, %arg1 : i64
    %4 = llvm.select %2, %3, %arg2 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c-19_i64 = arith.constant -19 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.select %arg1, %arg0, %c-19_i64 : i1, i64
    %3 = llvm.or %2, %c-35_i64 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c31_i64 = arith.constant 31 : i64
    %c7_i64 = arith.constant 7 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.xor %c7_i64, %c6_i64 : i64
    %1 = llvm.lshr %c31_i64, %0 : i64
    %2 = llvm.srem %c-47_i64, %1 : i64
    %3 = llvm.select %arg0, %arg1, %2 : i1, i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "ugt" %arg0, %c-24_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %c4_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %2, %c37_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sle" %c-46_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.select %arg1, %arg2, %c42_i64 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.sdiv %c21_i64, %2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.ashr %c37_i64, %arg0 : i64
    %2 = llvm.icmp "sle" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.ashr %c8_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.icmp "uge" %1, %c19_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %arg0, %c-8_i64 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.srem %1, %c25_i64 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "sgt" %arg1, %c39_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %c29_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.udiv %c38_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %c-41_i64, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.and %c0_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg2 : i64
    %2 = llvm.icmp "ne" %c-29_i64, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.urem %c27_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %true = arith.constant true
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.ashr %arg0, %c-35_i64 : i64
    %1 = llvm.select %true, %c-15_i64, %arg0 : i1, i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg1, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.urem %c-30_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.ashr %c0_i64, %c-21_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "slt" %c-46_i64, %1 : i64
    %3 = llvm.select %2, %c-3_i64, %1 : i1, i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.srem %c34_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg1 : i64
    %2 = llvm.icmp "sge" %1, %c-22_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.ashr %c-50_i64, %arg0 : i64
    %1 = llvm.udiv %c-11_i64, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.sdiv %arg1, %arg1 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.lshr %c-38_i64, %arg0 : i64
    %1 = llvm.ashr %c48_i64, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.select %arg1, %2, %1 : i1, i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.icmp "eq" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c20_i64 = arith.constant 20 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.urem %c20_i64, %c-13_i64 : i64
    %1 = llvm.icmp "sgt" %c16_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.ashr %c23_i64, %1 : i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.sdiv %0, %c-37_i64 : i64
    %2 = llvm.ashr %arg2, %arg1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "sge" %c-50_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %c-11_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.icmp "eq" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %c47_i64, %1 : i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.srem %c25_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c26_i64 = arith.constant 26 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "slt" %c26_i64, %c40_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.lshr %c30_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sdiv %arg1, %c-29_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "sle" %arg1, %arg1 : i64
    %1 = llvm.and %c26_i64, %arg1 : i64
    %2 = llvm.and %arg0, %arg2 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "slt" %c-37_i64, %c-23_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %arg0, %c-39_i64, %1 : i1, i64
    %3 = llvm.udiv %2, %1 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c37_i64 = arith.constant 37 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.urem %c-24_i64, %c-40_i64 : i64
    %1 = llvm.udiv %c37_i64, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "ult" %3, %c13_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c22_i64, %0 : i64
    %2 = llvm.icmp "uge" %c48_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.lshr %c-30_i64, %0 : i64
    %2 = llvm.sdiv %arg2, %arg2 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ule" %3, %c-10_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.or %c25_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.udiv %arg2, %c12_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.udiv %c6_i64, %c33_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %c-41_i64, %0 : i64
    %2 = llvm.ashr %c17_i64, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "ult" %3, %c2_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %c-38_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.trunc %arg0 : i1 to i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "eq" %arg0, %c-37_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %c-34_i64 : i64
    %3 = llvm.udiv %1, %1 : i64
    %4 = llvm.select %2, %3, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.select %arg1, %arg2, %c-16_i64 : i1, i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.srem %c21_i64, %1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.urem %arg1, %arg0 : i64
    %2 = llvm.icmp "slt" %1, %c44_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.and %arg0, %c16_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.srem %c6_i64, %1 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "uge" %c31_i64, %c30_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "slt" %arg0, %c43_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "sle" %c-7_i64, %c30_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.srem %c15_i64, %2 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "uge" %c-20_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg0, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.ashr %c44_i64, %arg2 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.icmp "eq" %1, %c22_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.icmp "eq" %arg1, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.urem %c7_i64, %2 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "uge" %c43_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.srem %c14_i64, %1 : i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.or %c-15_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.urem %arg0, %c8_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.xor %arg2, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.xor %c-48_i64, %1 : i64
    %3 = llvm.ashr %arg1, %0 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.icmp "ugt" %c28_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c-34_i64 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.udiv %c26_i64, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.icmp "ult" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.udiv %1, %c41_i64 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.ashr %3, %c33_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.xor %arg1, %arg1 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.urem %c-36_i64, %arg0 : i64
    %1 = llvm.udiv %c-12_i64, %c-21_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %c-42_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %false = arith.constant false
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %c-29_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %arg1, %arg1 : i64
    %2 = llvm.urem %1, %c38_i64 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "ule" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c22_i64 = arith.constant 22 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.and %c22_i64, %c35_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "ugt" %1, %c-41_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.sdiv %0, %0 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.ashr %c36_i64, %c6_i64 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.urem %0, %0 : i64
    %3 = llvm.select %arg0, %0, %2 : i1, i64
    %4 = llvm.select %1, %3, %2 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.urem %c16_i64, %c7_i64 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c27_i64 = arith.constant 27 : i64
    %c47_i64 = arith.constant 47 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %c27_i64, %0 : i64
    %2 = llvm.udiv %1, %c-48_i64 : i64
    %3 = llvm.or %c47_i64, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "slt" %c-25_i64, %c36_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c-50_i64, %c-22_i64 : i64
    %3 = llvm.lshr %2, %1 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-32_i64 = arith.constant -32 : i64
    %true = arith.constant true
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "sle" %1, %c38_i64 : i64
    %3 = llvm.select %true, %arg2, %c-32_i64 : i1, i64
    %4 = llvm.select %2, %3, %c-19_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %false = arith.constant false
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.urem %arg0, %c-3_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.lshr %arg1, %c-19_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c14_i64 = arith.constant 14 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "ugt" %c14_i64, %c35_i64 : i64
    %1 = llvm.udiv %c17_i64, %arg0 : i64
    %2 = llvm.sdiv %arg1, %arg2 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.icmp "uge" %c-25_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.urem %c4_i64, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "sgt" %arg2, %c-23_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c28_i64 = arith.constant 28 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.urem %c28_i64, %c18_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %1, %c-18_i64, %0 : i1, i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.ashr %arg1, %c-24_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c42_i64 = arith.constant 42 : i64
    %c17_i64 = arith.constant 17 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "uge" %c17_i64, %c30_i64 : i64
    %1 = llvm.select %0, %c42_i64, %c17_i64 : i1, i64
    %2 = llvm.xor %1, %c-4_i64 : i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.and %c-12_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.ashr %0, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.srem %c13_i64, %c46_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.or %c-29_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.srem %1, %c-49_i64 : i64
    %3 = llvm.and %arg2, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-19_i64 = arith.constant -19 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.and %c-19_i64, %1 : i64
    %3 = llvm.icmp "ne" %c25_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c5_i64 = arith.constant 5 : i64
    %c49_i64 = arith.constant 49 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.urem %c11_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c49_i64, %arg1 : i64
    %2 = llvm.srem %arg1, %c5_i64 : i64
    %3 = llvm.select %1, %2, %c33_i64 : i1, i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "eq" %c-30_i64, %arg0 : i64
    %1 = llvm.xor %arg1, %arg1 : i64
    %2 = llvm.select %0, %c-38_i64, %1 : i1, i64
    %3 = llvm.or %arg1, %c-29_i64 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.sdiv %arg2, %arg0 : i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.xor %c-49_i64, %c3_i64 : i64
    %1 = llvm.and %0, %c-25_i64 : i64
    %2 = llvm.or %arg0, %0 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ule" %c-10_i64, %c43_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c29_i64, %arg1 : i1, i64
    %2 = llvm.and %c-13_i64, %1 : i64
    %3 = llvm.udiv %arg1, %1 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c14_i64 = arith.constant 14 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "ne" %c14_i64, %c-46_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c46_i64 = arith.constant 46 : i64
    %false = arith.constant false
    %c-32_i64 = arith.constant -32 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.lshr %c-32_i64, %c-20_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.urem %c46_i64, %1 : i64
    %3 = llvm.select %false, %0, %2 : i1, i64
    %4 = llvm.icmp "sge" %3, %c-4_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %c-14_i64, %c14_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.sdiv %arg2, %c25_i64 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %c-34_i64, %arg0 : i64
    %2 = llvm.and %arg1, %arg2 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c7_i64 = arith.constant 7 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.or %c16_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "ult" %c7_i64, %c-26_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.lshr %c0_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "ule" %c26_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "sge" %c-19_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %c7_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %c46_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ult" %c-38_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c3_i64 = arith.constant 3 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.srem %c3_i64, %c43_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ule" %c9_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.or %c9_i64, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c44_i64 = arith.constant 44 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.srem %c19_i64, %arg0 : i64
    %1 = llvm.urem %c44_i64, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.urem %c-30_i64, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.ashr %c41_i64, %c-20_i64 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %c37_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.srem %c48_i64, %c-34_i64 : i64
    %1 = llvm.urem %0, %c-16_i64 : i64
    %2 = llvm.icmp "uge" %1, %c-38_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.select %arg0, %c10_i64, %arg1 : i1, i64
    %1 = llvm.xor %c-44_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.urem %arg0, %c18_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.or %arg0, %c-21_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sdiv %2, %c-43_i64 : i64
    %4 = llvm.srem %c4_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "ne" %arg0, %c-2_i64 : i64
    %1 = llvm.select %0, %c-13_i64, %arg0 : i1, i64
    %2 = llvm.ashr %1, %c-4_i64 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.lshr %3, %c-14_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.udiv %c28_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.lshr %c-1_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %3, %arg0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.udiv %arg1, %c-35_i64 : i64
    %1 = llvm.icmp "ult" %0, %arg2 : i64
    %2 = llvm.urem %c-1_i64, %0 : i64
    %3 = llvm.select %1, %c-31_i64, %2 : i1, i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.sdiv %c-15_i64, %arg0 : i64
    %1 = llvm.or %arg1, %c36_i64 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.lshr %arg0, %c-29_i64 : i64
    %1 = llvm.icmp "ne" %arg0, %arg1 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.lshr %3, %c12_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "ugt" %c36_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "sge" %arg0, %c9_i64 : i64
    %1 = llvm.select %0, %c-39_i64, %arg0 : i1, i64
    %2 = llvm.icmp "ule" %arg0, %arg0 : i64
    %3 = llvm.select %2, %arg1, %arg1 : i1, i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ne" %c7_i64, %c48_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %arg1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "sge" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c41_i64 = arith.constant 41 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %c41_i64, %c-50_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %c13_i64, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.lshr %c-10_i64, %c-50_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.urem %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %true = arith.constant true
    %c19_i64 = arith.constant 19 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %c-23_i64, %0 : i64
    %2 = llvm.select %true, %arg0, %c41_i64 : i1, i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "sle" %c19_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.srem %0, %c28_i64 : i64
    %3 = llvm.select %1, %2, %c-42_i64 : i1, i64
    %4 = llvm.and %3, %arg2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "uge" %c-20_i64, %c35_i64 : i64
    %1 = llvm.urem %c-21_i64, %arg0 : i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.select %2, %arg1, %arg2 : i1, i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %true = arith.constant true
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %true, %c-34_i64, %2 : i1, i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.srem %c28_i64, %c17_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.sdiv %arg0, %arg0 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "sle" %c-40_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c33_i64 = arith.constant 33 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.sdiv %c33_i64, %c19_i64 : i64
    %1 = llvm.icmp "ule" %c-4_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.or %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c-5_i64 = arith.constant -5 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ult" %c-5_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %c19_i64 : i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %c-7_i64, %0 : i64
    %2 = llvm.and %1, %c36_i64 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %true = arith.constant true
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %true, %c24_i64, %1 : i1, i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "sge" %arg0, %c-30_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "sle" %c15_i64, %c-30_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "sle" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.xor %c-5_i64, %c-4_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "slt" %c-29_i64, %c-1_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %c-10_i64, %1 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %c-14_i64, %c40_i64 : i64
    %1 = llvm.icmp "sge" %0, %c-29_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %arg0 : i1 to i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.urem %c1_i64, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %c-23_i64 : i64
    %2 = llvm.srem %arg1, %c-49_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "eq" %3, %c37_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.sdiv %arg0, %c-30_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.urem %c-6_i64, %c1_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.select %3, %c11_i64, %c-44_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.select %arg2, %c-32_i64, %arg0 : i1, i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %c42_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.udiv %arg0, %c-5_i64 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.xor %c39_i64, %0 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.srem %arg1, %arg2 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c14_i64 = arith.constant 14 : i64
    %c10_i64 = arith.constant 10 : i64
    %false = arith.constant false
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %c48_i64, %arg1 : i64
    %1 = llvm.sdiv %c10_i64, %c14_i64 : i64
    %2 = llvm.select %false, %arg1, %1 : i1, i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.select %arg0, %3, %c44_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.and %arg2, %arg2 : i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    %3 = llvm.ashr %arg0, %c46_i64 : i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "ugt" %c1_i64, %c34_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.zext %0 : i1 to i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c-12_i64 = arith.constant -12 : i64
    %true = arith.constant true
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %c-12_i64, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %true, %2, %c-42_i64 : i1, i64
    %4 = llvm.select %0, %arg0, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "uge" %c41_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c26_i64 = arith.constant 26 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.and %c26_i64, %c16_i64 : i64
    %1 = llvm.xor %0, %c28_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-18_i64 = arith.constant -18 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.srem %c-39_i64, %c-49_i64 : i64
    %1 = llvm.urem %c-18_i64, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-41_i64 = arith.constant -41 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.or %1, %c-35_i64 : i64
    %3 = llvm.or %c-41_i64, %2 : i64
    %4 = llvm.icmp "ule" %c0_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.sdiv %c-3_i64, %arg0 : i64
    %1 = llvm.lshr %c-43_i64, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %3, %c37_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.and %arg0, %c-33_i64 : i64
    %1 = llvm.udiv %c-32_i64, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.icmp "uge" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.urem %c33_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.urem %c-26_i64, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.select %false, %c-8_i64, %arg0 : i1, i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.and %c0_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c19_i64 = arith.constant 19 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "uge" %c19_i64, %c-26_i64 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.xor %c45_i64, %1 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.select %0, %3, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.or %c-16_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %0 : i1, i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.xor %arg0, %c-36_i64 : i64
    %1 = llvm.udiv %arg0, %c12_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ne" %arg1, %arg2 : i64
    %1 = llvm.srem %arg2, %c13_i64 : i64
    %2 = llvm.select %0, %c48_i64, %1 : i1, i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.and %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.and %arg0, %c34_i64 : i64
    %1 = llvm.and %c-27_i64, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.sdiv %arg0, %0 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %c-14_i64, %2 : i64
    %4 = llvm.or %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %c12_i64, %arg1 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.lshr %c-23_i64, %c-42_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "uge" %c-40_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "ne" %arg1, %c34_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-48_i64 = arith.constant -48 : i64
    %true = arith.constant true
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.or %arg0, %c-5_i64 : i64
    %1 = llvm.select %true, %c-48_i64, %c-19_i64 : i1, i64
    %2 = llvm.urem %arg2, %1 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %true = arith.constant true
    %c-33_i64 = arith.constant -33 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.select %true, %c-33_i64, %c-39_i64 : i1, i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.udiv %2, %c-49_i64 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "sge" %3, %c-13_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.lshr %c-17_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "slt" %c28_i64, %c-5_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.select %arg0, %c2_i64, %arg1 : i1, i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.select %arg0, %1, %arg1 : i1, i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "sge" %3, %c-30_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.xor %arg0, %c-47_i64 : i64
    %1 = llvm.and %0, %c-32_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.xor %c-36_i64, %2 : i64
    %4 = llvm.icmp "ult" %3, %c-39_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "ult" %c26_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.select %0, %arg0, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %c-28_i64 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.udiv %c-49_i64, %c39_i64 : i64
    %1 = llvm.or %0, %c34_i64 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %false = arith.constant false
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.select %false, %c-25_i64, %arg0 : i1, i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.lshr %c40_i64, %1 : i64
    %3 = llvm.select %false, %arg0, %0 : i1, i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %true = arith.constant true
    %c-35_i64 = arith.constant -35 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.lshr %c-35_i64, %c-49_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.select %true, %0, %1 : i1, i64
    %3 = llvm.lshr %c2_i64, %2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.lshr %c11_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "ult" %arg1, %arg2 : i64
    %3 = llvm.select %2, %1, %c-2_i64 : i1, i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %c48_i64, %0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "sle" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c-13_i64 = arith.constant -13 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.sdiv %c-13_i64, %c-43_i64 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.sdiv %c-47_i64, %c24_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.select %2, %arg0, %arg0 : i1, i64
    %4 = llvm.icmp "ult" %3, %c-17_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c-15_i64 = arith.constant -15 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %0, %c9_i64 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %c-15_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %false = arith.constant false
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.or %arg0, %c-26_i64 : i64
    %1 = llvm.or %arg1, %c18_i64 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.select %false, %2, %arg1 : i1, i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %c19_i64 : i64
    %2 = llvm.icmp "sgt" %c-17_i64, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.select %arg0, %c-29_i64, %arg1 : i1, i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %c-45_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c-38_i64, %arg1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ne" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "ule" %arg0, %c-48_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.urem %1, %arg1 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "sgt" %c-9_i64, %arg0 : i64
    %1 = llvm.select %arg2, %arg0, %arg0 : i1, i64
    %2 = llvm.and %1, %c-17_i64 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.select %0, %arg1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %c-32_i64, %c31_i64 : i64
    %2 = llvm.icmp "sle" %c37_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "sge" %c-7_i64, %c-7_i64 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.icmp "slt" %2, %c-18_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c25_i64, %c18_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "sle" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.icmp "sge" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.or %c0_i64, %0 : i64
    %2 = llvm.select %arg2, %arg0, %c1_i64 : i1, i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.or %c-39_i64, %arg0 : i64
    %1 = llvm.or %c2_i64, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.and %1, %arg0 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "sgt" %c-47_i64, %c-21_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %c-46_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %c35_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %3, %0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.icmp "sle" %c-10_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ule" %c-47_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.lshr %c-25_i64, %c-27_i64 : i64
    %3 = llvm.xor %c4_i64, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.or %c-47_i64, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.ashr %c-35_i64, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c0_i64 = arith.constant 0 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "sle" %c19_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %c18_i64, %arg0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "eq" %c0_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.urem %1, %c10_i64 : i64
    %3 = llvm.icmp "sgt" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.xor %arg0, %c-41_i64 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.xor %0, %c-48_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.urem %arg1, %c5_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.or %arg2, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c12_i64 = arith.constant 12 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.srem %arg0, %c50_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.lshr %c12_i64, %2 : i64
    %4 = llvm.icmp "eq" %3, %c-19_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.select %arg0, %c40_i64, %c35_i64 : i1, i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.icmp "slt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %c25_i64, %1 : i64
    %3 = llvm.zext %0 : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.lshr %c-33_i64, %arg1 : i64
    %3 = llvm.select %false, %arg0, %2 : i1, i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg2 : i64
    %3 = llvm.select %2, %arg1, %c-1_i64 : i1, i64
    %4 = llvm.lshr %c2_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "ule" %c10_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %c-18_i64 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.udiv %c-31_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "sge" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %c26_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.sdiv %arg0, %c-41_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %c-32_i64 = arith.constant -32 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sdiv %c-32_i64, %c44_i64 : i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c47_i64 : i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c-17_i64 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %c-40_i64, %c-47_i64 : i64
    %1 = llvm.urem %0, %c8_i64 : i64
    %2 = llvm.srem %c-38_i64, %1 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.ashr %3, %c-22_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.and %arg1, %c-7_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ne" %c-7_i64, %arg1 : i64
    %3 = llvm.select %2, %arg1, %0 : i1, i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "sge" %c-26_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %arg1, %1, %arg2 : i1, i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "uge" %c-5_i64, %c-42_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.select %arg0, %c-27_i64, %arg1 : i1, i64
    %1 = llvm.and %arg2, %arg2 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.udiv %c26_i64, %c-17_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "sle" %arg0, %c3_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.urem %arg0, %c44_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "sle" %1, %c6_i64 : i64
    %3 = llvm.select %2, %0, %arg1 : i1, i64
    %4 = llvm.ashr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.lshr %c-4_i64, %arg0 : i64
    %1 = llvm.and %c41_i64, %0 : i64
    %2 = llvm.sdiv %1, %c-28_i64 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.udiv %c25_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.urem %c32_i64, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "ne" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.sdiv %arg2, %0 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.urem %0, %c-15_i64 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.select %true, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c47_i64 = arith.constant 47 : i64
    %c15_i64 = arith.constant 15 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "sgt" %c15_i64, %c39_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %c47_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %c-10_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %c1_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %c14_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "slt" %c44_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.urem %c-40_i64, %c34_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.lshr %0, %arg1 : i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.udiv %1, %c32_i64 : i64
    %3 = llvm.sdiv %0, %arg2 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %c1_i64, %0 : i64
    %2 = llvm.srem %c50_i64, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "eq" %c21_i64, %arg2 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.xor %arg0, %1 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.and %c38_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.select %1, %arg0, %arg2 : i1, i64
    %3 = llvm.or %arg2, %c12_i64 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %false = arith.constant false
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.select %false, %c46_i64, %arg1 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.lshr %2, %c-50_i64 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "ne" %c12_i64, %c10_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.select %2, %1, %c10_i64 : i1, i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %c46_i64, %arg0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.and %c36_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "sle" %c25_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.and %c17_i64, %1 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.icmp "sge" %c-9_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %false = arith.constant false
    %c-31_i64 = arith.constant -31 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.select %false, %c-31_i64, %c22_i64 : i1, i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    %3 = llvm.udiv %2, %c-17_i64 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.sext %arg2 : i1 to i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.select %arg0, %1, %c49_i64 : i1, i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.icmp "ugt" %c15_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.and %0, %arg1 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.ashr %c-29_i64, %2 : i64
    %4 = llvm.icmp "slt" %3, %c-38_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.srem %c-15_i64, %c-21_i64 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %c18_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.urem %c-23_i64, %1 : i64
    %3 = llvm.sdiv %c-16_i64, %arg0 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ne" %c-12_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c-16_i64, %0 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %c-35_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.lshr %c43_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.udiv %arg0, %c6_i64 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.select %1, %c25_i64, %2 : i1, i64
    %4 = llvm.icmp "ult" %c-42_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.lshr %c-26_i64, %arg1 : i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.lshr %arg0, %c-13_i64 : i64
    %1 = llvm.or %0, %c-4_i64 : i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    %4 = llvm.icmp "sle" %c-7_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "ugt" %c-8_i64, %c-24_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %c-16_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c16_i64 = arith.constant 16 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg1, %arg0 : i1, i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.urem %1, %c-40_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.ashr %c16_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.urem %arg1, %c-14_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %c19_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.and %c26_i64, %c5_i64 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ule" %c-1_i64, %c-6_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.or %c-5_i64, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c-7_i64 = arith.constant -7 : i64
    %true = arith.constant true
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.select %true, %c-47_i64, %arg0 : i1, i64
    %1 = llvm.icmp "uge" %c-7_i64, %c-50_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %0 : i1, i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.and %c-2_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.or %arg0, %c12_i64 : i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %3, %c-7_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c-38_i64 : i64
    %2 = llvm.and %c18_i64, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.lshr %3, %c44_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %arg2 : i64
    %2 = llvm.urem %1, %c33_i64 : i64
    %3 = llvm.lshr %2, %c-24_i64 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c16_i64 = arith.constant 16 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %c1_i64, %arg2 : i64
    %3 = llvm.select %2, %c16_i64, %c10_i64 : i1, i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.xor %arg0, %c-40_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "sgt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "sge" %c33_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.select %3, %c-6_i64, %2 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.sdiv %arg2, %arg0 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c19_i64 = arith.constant 19 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.or %c-33_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.srem %c19_i64, %c10_i64 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.urem %c12_i64, %c50_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.select %2, %arg0, %1 : i1, i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "slt" %c28_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %c12_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.udiv %arg1, %arg1 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.or %arg2, %arg2 : i64
    %3 = llvm.and %c-12_i64, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.select %1, %arg1, %0 : i1, i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "ult" %c-26_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.lshr %c27_i64, %arg0 : i64
    %1 = llvm.urem %0, %c-11_i64 : i64
    %2 = llvm.or %1, %c10_i64 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %c-25_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.select %arg0, %0, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "ule" %arg1, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.select %3, %arg0, %c31_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.xor %c-23_i64, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.udiv %c8_i64, %0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.icmp "ult" %arg1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.select %arg0, %c-39_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ule" %c-8_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sdiv %c12_i64, %arg1 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.srem %0, %0 : i64
    %3 = llvm.select %1, %2, %2 : i1, i64
    %4 = llvm.icmp "slt" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.or %c47_i64, %2 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c38_i64 = arith.constant 38 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "ne" %c-2_i64, %c41_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %c38_i64, %c-43_i64 : i64
    %3 = llvm.or %2, %1 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "uge" %c41_i64, %c46_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %arg1 : i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-39_i64 = arith.constant -39 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "slt" %c8_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %c-39_i64, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.lshr %arg1, %c-34_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.and %c19_i64, %arg1 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.udiv %arg0, %c25_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %c-31_i64, %2 : i64
    %4 = llvm.icmp "sle" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "uge" %arg1, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.sdiv %c9_i64, %2 : i64
    %4 = llvm.icmp "sle" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.udiv %c-5_i64, %c-35_i64 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %3, %arg0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %c-7_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "ne" %arg0, %c-15_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.urem %c41_i64, %arg0 : i64
    %1 = llvm.or %0, %c6_i64 : i64
    %2 = llvm.xor %arg0, %arg1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %true = arith.constant true
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.urem %c50_i64, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.urem %c26_i64, %arg1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %arg0 : i64
    %2 = llvm.icmp "ne" %1, %c-22_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c33_i64 = arith.constant 33 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.select %arg0, %c6_i64, %arg1 : i1, i64
    %1 = llvm.or %arg2, %c33_i64 : i64
    %2 = llvm.ashr %1, %c-4_i64 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.and %c-41_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "sgt" %c43_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "ult" %1, %c5_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %c19_i64, %0 : i64
    %2 = llvm.icmp "sge" %c-18_i64, %c-10_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c15_i64 : i64
    %2 = llvm.lshr %c47_i64, %1 : i64
    %3 = llvm.or %c15_i64, %2 : i64
    %4 = llvm.icmp "ne" %c47_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.udiv %c-16_i64, %arg0 : i64
    %1 = llvm.select %true, %c-16_i64, %0 : i1, i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "sge" %c-2_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %arg1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.or %c42_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %c-19_i64 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.lshr %arg2, %arg0 : i64
    %4 = llvm.select %2, %3, %0 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.or %c35_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %c47_i64, %1 : i64
    %3 = llvm.udiv %c-1_i64, %c13_i64 : i64
    %4 = llvm.select %2, %3, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.xor %arg1, %arg0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.or %arg0, %c-25_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.or %c-43_i64, %1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %c2_i64, %arg0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c25_i64 = arith.constant 25 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.and %c6_i64, %c-25_i64 : i64
    %1 = llvm.and %c25_i64, %0 : i64
    %2 = llvm.sdiv %c-35_i64, %0 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.srem %3, %0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.udiv %c30_i64, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c50_i64 = arith.constant 50 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "ne" %c50_i64, %c12_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %c-45_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %c40_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "sgt" %c-42_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.select %0, %2, %arg2 : i1, i64
    %4 = llvm.icmp "sle" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %c27_i64, %0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %3, %1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.srem %c-24_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %3, %c48_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c32_i64 = arith.constant 32 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "ule" %c32_i64, %c23_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %true, %arg0, %arg1 : i1, i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.select %arg1, %arg2, %2 : i1, i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %c24_i64 : i64
    %3 = llvm.select %2, %arg1, %arg2 : i1, i64
    %4 = llvm.icmp "sgt" %3, %c-21_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.urem %1, %c-34_i64 : i64
    %3 = llvm.or %c46_i64, %2 : i64
    %4 = llvm.ashr %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.lshr %c15_i64, %c-21_i64 : i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %c-42_i64, %c-18_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg0, %arg1 : i64
    %3 = llvm.ashr %c14_i64, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %c14_i64, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.icmp "eq" %2, %c10_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %c-21_i64 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sdiv %c33_i64, %arg0 : i64
    %1 = llvm.select %arg2, %c5_i64, %c-3_i64 : i1, i64
    %2 = llvm.ashr %1, %c-8_i64 : i64
    %3 = llvm.select %arg1, %c-50_i64, %2 : i1, i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %false = arith.constant false
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.udiv %c-33_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.select %false, %arg1, %c-21_i64 : i1, i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c31_i64 = arith.constant 31 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "uge" %0, %c31_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %c30_i64, %2 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %c-35_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.xor %c31_i64, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "sge" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.icmp "sgt" %arg1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %c-14_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.lshr %c-5_i64, %arg0 : i64
    %1 = llvm.srem %0, %c-40_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.and %c-32_i64, %1 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.or %c-20_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg2 : i64
    %3 = llvm.select %2, %arg2, %c-11_i64 : i1, i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "ne" %c-29_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.srem %arg2, %c22_i64 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.udiv %c-7_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.srem %0, %c-11_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.udiv %1, %c-9_i64 : i64
    %3 = llvm.srem %arg2, %c-5_i64 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c19_i64 = arith.constant 19 : i64
    %false = arith.constant false
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.select %false, %arg0, %c0_i64 : i1, i64
    %1 = llvm.select %arg1, %c-27_i64, %0 : i1, i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.and %c19_i64, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.ashr %1, %c-9_i64 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.select %arg0, %c-22_i64, %arg1 : i1, i64
    %1 = llvm.ashr %0, %c-31_i64 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.lshr %2, %arg2 : i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.sdiv %c-37_i64, %arg0 : i64
    %1 = llvm.sdiv %c-26_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "sle" %3, %c6_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.xor %2, %c-40_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "slt" %c-22_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %c32_i64, %2 : i64
    %4 = llvm.icmp "eq" %3, %c38_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c45_i64 = arith.constant 45 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.ashr %c39_i64, %1 : i64
    %3 = llvm.urem %2, %c-8_i64 : i64
    %4 = llvm.icmp "uge" %c45_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c-3_i64 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %c-8_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.select %2, %c-9_i64, %c-1_i64 : i1, i64
    %4 = llvm.ashr %3, %arg0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "ne" %c-37_i64, %c17_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %arg0, %arg1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %c27_i64, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c37_i64 = arith.constant 37 : i64
    %false = arith.constant false
    %c36_i64 = arith.constant 36 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.sdiv %c36_i64, %c-12_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.select %false, %1, %c37_i64 : i1, i64
    %3 = llvm.or %2, %c27_i64 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c36_i64 : i1, i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %c4_i64 : i1, i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %c-1_i64, %c10_i64 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "uge" %c-35_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.or %c-42_i64, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %c-33_i64, %0 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.lshr %c-20_i64, %arg1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "sge" %arg0, %c26_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c5_i64, %1 : i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.icmp "eq" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.and %c-30_i64, %0 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.lshr %c26_i64, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.or %2, %c-20_i64 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "ule" %c46_i64, %c10_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.or %1, %c48_i64 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "ult" %c42_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg0, %arg1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "sgt" %3, %c24_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %c-27_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %arg1, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "eq" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.or %c-31_i64, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.select %arg0, %c-14_i64, %arg1 : i1, i64
    %1 = llvm.ashr %c-30_i64, %0 : i64
    %2 = llvm.icmp "sgt" %0, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.xor %c38_i64, %2 : i64
    %4 = llvm.icmp "eq" %3, %c13_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-44_i64 = arith.constant -44 : i64
    %true = arith.constant true
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %true, %c-44_i64, %c13_i64 : i1, i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c17_i64 = arith.constant 17 : i64
    %true = arith.constant true
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.ashr %c50_i64, %arg1 : i64
    %2 = llvm.select %true, %0, %1 : i1, i64
    %3 = llvm.xor %c17_i64, %2 : i64
    %4 = llvm.sdiv %3, %0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.select %arg0, %c-41_i64, %c18_i64 : i1, i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.lshr %c23_i64, %c-46_i64 : i64
    %1 = llvm.sdiv %c-11_i64, %0 : i64
    %2 = llvm.ashr %c-2_i64, %arg1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.select %arg0, %c-10_i64, %arg1 : i1, i64
    %1 = llvm.icmp "sge" %arg2, %c19_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "sle" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "ne" %arg1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %arg1 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.or %2, %c-43_i64 : i64
    %4 = llvm.icmp "ult" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "ule" %arg0, %c27_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "ult" %c-13_i64, %c16_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.and %arg0, %arg1 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ugt" %c-8_i64, %c43_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %true = arith.constant true
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.and %1, %c-33_i64 : i64
    %3 = llvm.srem %c-31_i64, %2 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.xor %arg2, %c-41_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "sge" %3, %c30_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %c26_i64 = arith.constant 26 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.select %true, %c26_i64, %c-45_i64 : i1, i64
    %1 = llvm.xor %c39_i64, %arg0 : i64
    %2 = llvm.xor %1, %c49_i64 : i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.urem %c32_i64, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %c-28_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %c2_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.sdiv %c-46_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %c-41_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c39_i64 = arith.constant 39 : i64
    %c43_i64 = arith.constant 43 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.ashr %c43_i64, %c-36_i64 : i64
    %1 = llvm.xor %0, %c39_i64 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.xor %c9_i64, %0 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c-32_i64, %c44_i64 : i64
    %3 = llvm.or %c-39_i64, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.xor %c-19_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %c-27_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c-20_i64 = arith.constant -20 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.srem %c-20_i64, %0 : i64
    %2 = llvm.ashr %0, %c7_i64 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.srem %c-18_i64, %1 : i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.lshr %arg0, %c-38_i64 : i64
    %1 = llvm.icmp "ule" %0, %c-8_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %arg1, %0 : i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %c33_i64, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c33_i64 = arith.constant 33 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.udiv %c-9_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %c-47_i64 : i64
    %2 = llvm.and %c33_i64, %1 : i64
    %3 = llvm.icmp "sgt" %c-3_i64, %2 : i64
    %4 = llvm.select %3, %arg1, %arg2 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %c35_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-3_i64 = arith.constant -3 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.lshr %c-20_i64, %c-4_i64 : i64
    %1 = llvm.icmp "ne" %0, %c-3_i64 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.trunc %arg2 : i1 to i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "uge" %c41_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %arg1, %arg0 : i64
    %2 = llvm.or %arg1, %c-17_i64 : i64
    %3 = llvm.select %1, %2, %c-39_i64 : i1, i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "sle" %c-20_i64, %c-40_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %c45_i64 : i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.sdiv %3, %c-43_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "slt" %arg0, %c-1_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %c18_i64, %arg0 : i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "ne" %arg0, %c25_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %c-7_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.urem %arg0, %c-41_i64 : i64
    %1 = llvm.icmp "sge" %0, %c48_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %c43_i64 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "sge" %c-44_i64, %c-49_i64 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.icmp "sle" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %c-34_i64, %0 : i64
    %2 = llvm.ashr %0, %arg0 : i64
    %3 = llvm.udiv %0, %arg0 : i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %c-34_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sdiv %c-21_i64, %c6_i64 : i64
    %1 = llvm.icmp "sle" %c-25_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %c7_i64, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %c-8_i64, %c-12_i64 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "eq" %c26_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.icmp "eq" %arg0, %c-28_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "ult" %c-36_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "slt" %c-33_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.xor %arg0, %c12_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %c-11_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.ashr %2, %c31_i64 : i64
    %4 = llvm.urem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.icmp "ugt" %c32_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.icmp "slt" %arg2, %c2_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.urem %c-38_i64, %c-49_i64 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "uge" %c46_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %c-6_i64, %c49_i64 : i64
    %1 = llvm.icmp "slt" %c11_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %c-41_i64, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %c-7_i64, %0 : i64
    %2 = llvm.icmp "uge" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.icmp "ugt" %c-39_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.icmp "slt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg0 : i1, i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.srem %arg2, %1 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %c33_i64, %0 : i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.select %arg0, %c-49_i64, %arg1 : i1, i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.and %c50_i64, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %c1_i64 = arith.constant 1 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.sdiv %arg0, %c3_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.and %1, %c-40_i64 : i64
    %3 = llvm.xor %c-5_i64, %2 : i64
    %4 = llvm.icmp "sge" %c1_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "uge" %c19_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.icmp "ule" %c-8_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.urem %arg0, %arg0 : i64
    %3 = llvm.select %1, %arg0, %2 : i1, i64
    %4 = llvm.ashr %3, %c28_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c29_i64 = arith.constant 29 : i64
    %false = arith.constant false
    %c1_i64 = arith.constant 1 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.select %false, %c1_i64, %c44_i64 : i1, i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.urem %1, %c40_i64 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "eq" %c29_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.sdiv %arg0, %c-39_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.urem %arg0, %arg0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg1, %c26_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "ult" %arg0, %c-47_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %0, %arg0, %arg1 : i1, i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "eq" %c50_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.udiv %arg0, %c35_i64 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.icmp "ult" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "ule" %arg0, %c15_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.ashr %arg0, %c9_i64 : i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.udiv %1, %c36_i64 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c-5_i64 = arith.constant -5 : i64
    %false = arith.constant false
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.select %false, %arg0, %c-4_i64 : i1, i64
    %1 = llvm.or %c-5_i64, %0 : i64
    %2 = llvm.urem %c-12_i64, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c-14_i64 = arith.constant -14 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.srem %0, %c-4_i64 : i64
    %3 = llvm.select %1, %2, %arg0 : i1, i64
    %4 = llvm.icmp "sge" %c-14_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "ule" %c-36_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %c5_i64, %c28_i64 : i64
    %2 = llvm.select %1, %arg1, %arg0 : i1, i64
    %3 = llvm.select %0, %2, %arg0 : i1, i64
    %4 = llvm.ashr %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.select %arg0, %c23_i64, %arg1 : i1, i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.select %false, %0, %0 : i1, i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %c36_i64 : i64
    %3 = llvm.select %2, %arg0, %arg1 : i1, i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.select %arg0, %arg1, %c-31_i64 : i1, i64
    %1 = llvm.and %arg2, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %3, %c-27_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c33_i64 = arith.constant 33 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.urem %c33_i64, %c-47_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.select %arg1, %1, %c37_i64 : i1, i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.select %arg0, %arg1, %c22_i64 : i1, i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %c40_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %c12_i64 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "ne" %c27_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.or %2, %1 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %c-36_i64, %0 : i64
    %2 = llvm.urem %c-27_i64, %1 : i64
    %3 = llvm.icmp "eq" %c26_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c20_i64 = arith.constant 20 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %c-29_i64 : i64
    %2 = llvm.icmp "ugt" %c20_i64, %0 : i64
    %3 = llvm.select %2, %arg1, %c34_i64 : i1, i64
    %4 = llvm.select %1, %3, %arg2 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.ashr %2, %c39_i64 : i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.srem %arg0, %c30_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "sle" %c-32_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %2, %c20_i64, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %c20_i64 = arith.constant 20 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.and %c-42_i64, %c30_i64 : i64
    %1 = llvm.ashr %c20_i64, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.select %2, %arg0, %c12_i64 : i1, i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.select %arg0, %c-11_i64, %arg1 : i1, i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.select %arg0, %2, %1 : i1, i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %true, %arg2, %arg1 : i1, i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %c13_i64, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.select %arg1, %c-49_i64, %arg0 : i1, i64
    %1 = llvm.srem %arg2, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %arg0, %c36_i64 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "sge" %c2_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %c-31_i64 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.xor %arg1, %arg0 : i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.urem %arg1, %c13_i64 : i64
    %3 = llvm.select %arg2, %2, %arg0 : i1, i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.and %c11_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.select %2, %0, %arg2 : i1, i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.urem %arg1, %c-19_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "eq" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %c-14_i64, %0 : i64
    %2 = llvm.lshr %c-4_i64, %0 : i64
    %3 = llvm.and %2, %c-19_i64 : i64
    %4 = llvm.select %1, %3, %arg1 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %1, %c-42_i64 : i64
    %3 = llvm.udiv %c-40_i64, %c-16_i64 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.udiv %arg2, %c-24_i64 : i64
    %2 = llvm.and %arg2, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.srem %0, %c45_i64 : i64
    %2 = llvm.or %c-27_i64, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "sge" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %3, %c-38_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %c30_i64, %arg0 : i1, i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.icmp "ugt" %1, %c-21_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "ult" %c-28_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg1, %arg0 : i64
    %3 = llvm.srem %2, %c-3_i64 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.xor %arg0, %c1_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c25_i64 = arith.constant 25 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.ashr %c25_i64, %c3_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.icmp "ne" %c-25_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c37_i64 = arith.constant 37 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.urem %c37_i64, %c7_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.or %arg1, %arg0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "uge" %3, %c16_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "eq" %c-38_i64, %c-33_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.srem %c-22_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %c-44_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "sgt" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.select %arg0, %c6_i64, %c-31_i64 : i1, i64
    %1 = llvm.icmp "sgt" %arg1, %c0_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %false = arith.constant false
    %true = arith.constant true
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.select %true, %c-44_i64, %arg0 : i1, i64
    %1 = llvm.icmp "ne" %0, %c-10_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %false, %0, %2 : i1, i64
    %4 = llvm.urem %3, %2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c5_i64 = arith.constant 5 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "ult" %c5_i64, %c19_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %1, %c7_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.sdiv %c-14_i64, %c-28_i64 : i64
    %1 = llvm.icmp "eq" %c9_i64, %0 : i64
    %2 = llvm.select %1, %arg0, %arg1 : i1, i64
    %3 = llvm.icmp "sgt" %c-17_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %arg0, %c-26_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.udiv %0, %0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.udiv %c-50_i64, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    %3 = llvm.select %2, %arg1, %arg1 : i1, i64
    %4 = llvm.ashr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.ashr %c11_i64, %0 : i64
    %2 = llvm.select %arg0, %1, %c25_i64 : i1, i64
    %3 = llvm.icmp "sge" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %c12_i64, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.icmp "eq" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %true = arith.constant true
    %c-18_i64 = arith.constant -18 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %c-33_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %true, %c-18_i64, %2 : i1, i64
    %4 = llvm.icmp "sge" %3, %c8_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.srem %c-38_i64, %c-44_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    %3 = llvm.select %2, %0, %0 : i1, i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.and %arg0, %0 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.or %c-39_i64, %arg0 : i64
    %1 = llvm.udiv %c-12_i64, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %c-14_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.urem %1, %arg1 : i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %c-11_i64, %c48_i64 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "ugt" %c-25_i64, %c18_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c-1_i64, %1 : i64
    %3 = llvm.icmp "sgt" %c0_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.or %c36_i64, %arg0 : i64
    %1 = llvm.srem %c-43_i64, %0 : i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c48_i64 = arith.constant 48 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.srem %c9_i64, %c-10_i64 : i64
    %1 = llvm.xor %0, %c-7_i64 : i64
    %2 = llvm.or %c48_i64, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.or %c35_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.ashr %c34_i64, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.or %arg1, %arg2 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.and %c-4_i64, %c-17_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c-26_i64, %c-30_i64 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.srem %arg0, %c-17_i64 : i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.ashr %0, %arg1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.select %2, %0, %1 : i1, i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.lshr %c4_i64, %c15_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.srem %1, %c-12_i64 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.urem %c-38_i64, %arg0 : i64
    %1 = llvm.urem %0, %c8_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "uge" %c-34_i64, %c35_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.urem %arg0, %arg0 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %c46_i64 = arith.constant 46 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %c-23_i64, %c45_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "ule" %c46_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "uge" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "ugt" %c13_i64, %c-18_i64 : i64
    %1 = llvm.select %0, %c-44_i64, %c-29_i64 : i1, i64
    %2 = llvm.and %c11_i64, %1 : i64
    %3 = llvm.or %2, %c12_i64 : i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.or %c-45_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %c19_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.ashr %arg0, %c-12_i64 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "slt" %c-25_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.srem %0, %c-14_i64 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.or %c46_i64, %2 : i64
    %4 = llvm.icmp "uge" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c29_i64 = arith.constant 29 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.urem %c29_i64, %c-2_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %c36_i64 : i64
    %3 = llvm.select %2, %1, %0 : i1, i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c-48_i64 = arith.constant -48 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.select %false, %c-48_i64, %c-45_i64 : i1, i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "uge" %c-6_i64, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.sdiv %arg1, %c39_i64 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "sge" %c29_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %1, %c-1_i64 : i64
    %3 = llvm.sdiv %arg1, %arg2 : i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.select %arg1, %arg0, %c46_i64 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.or %arg0, %c-14_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.sdiv %c48_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %c0_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %0, %0 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "slt" %arg0, %c-14_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.xor %3, %2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %c48_i64, %arg0 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %c-15_i64, %1 : i64
    %3 = llvm.zext %0 : i1 to i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.lshr %c-49_i64, %arg0 : i64
    %1 = llvm.lshr %c3_i64, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.ashr %c15_i64, %c15_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.sdiv %c-27_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.or %arg1, %0 : i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %false = arith.constant false
    %c49_i64 = arith.constant 49 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.urem %c49_i64, %c30_i64 : i64
    %1 = llvm.select %false, %c-29_i64, %0 : i1, i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.or %arg0, %arg0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.sdiv %c10_i64, %2 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %c40_i64, %1 : i64
    %3 = llvm.lshr %c0_i64, %2 : i64
    %4 = llvm.icmp "sle" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %1, %2, %arg1 : i1, i64
    %4 = llvm.icmp "sle" %3, %c-4_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c8_i64 = arith.constant 8 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.icmp "eq" %c7_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c-20_i64 : i1, i64
    %2 = llvm.icmp "ule" %c8_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %c-7_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c16_i64 = arith.constant 16 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ne" %arg0, %c43_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %c48_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %c16_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "uge" %1, %c-22_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c19_i64 = arith.constant 19 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.ashr %c30_i64, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.lshr %c19_i64, %1 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.and %c8_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "ne" %c-39_i64, %c-7_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %c-2_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %c-36_i64 : i64
    %4 = llvm.icmp "sle" %3, %c-33_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.and %c28_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.and %c5_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c-21_i64 = arith.constant -21 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %0, %c-42_i64 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.urem %c-21_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.or %2, %1 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.lshr %c36_i64, %c-24_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.udiv %c0_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.urem %arg2, %c33_i64 : i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "sgt" %c-29_i64, %c45_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.select %0, %1, %c-28_i64 : i1, i64
    %3 = llvm.icmp "ult" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %false = arith.constant false
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.ashr %c-21_i64, %0 : i64
    %2 = llvm.select %false, %arg0, %1 : i1, i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.udiv %c-5_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.ashr %arg0, %c-47_i64 : i64
    %1 = llvm.ashr %arg0, %c-48_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "ugt" %c19_i64, %c-30_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "uge" %arg0, %c0_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %c-6_i64, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.select %arg2, %arg1, %c-18_i64 : i1, i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.urem %c21_i64, %c40_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.ashr %arg0, %c-32_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.srem %1, %0 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.urem %arg0, %c0_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sge" %0, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.select %arg0, %c41_i64, %c-23_i64 : i1, i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %0, %c42_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ne" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-48_i64 = arith.constant -48 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.urem %c-48_i64, %c-11_i64 : i64
    %1 = llvm.select %false, %0, %arg0 : i1, i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.select %2, %1, %arg0 : i1, i64
    %4 = llvm.srem %3, %0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c21_i64 = arith.constant 21 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.udiv %c21_i64, %c30_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %1, %2, %c43_i64 : i1, i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c5_i64 = arith.constant 5 : i64
    %c7_i64 = arith.constant 7 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ugt" %c7_i64, %c50_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %c5_i64, %1 : i64
    %3 = llvm.icmp "sge" %c-38_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c10_i64 = arith.constant 10 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.or %c-6_i64, %0 : i64
    %2 = llvm.xor %1, %c10_i64 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.and %c23_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.sdiv %arg1, %arg0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.ashr %c-22_i64, %1 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %c47_i64, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c7_i64 = arith.constant 7 : i64
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.udiv %c7_i64, %c29_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.and %arg0, %c24_i64 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.or %arg1, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.and %arg2, %arg0 : i64
    %1 = llvm.select %arg1, %0, %c33_i64 : i1, i64
    %2 = llvm.icmp "sgt" %1, %c4_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %c2_i64, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "sge" %2, %c-50_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ule" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "ugt" %c-33_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %c15_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %c8_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %c-32_i64, %arg0 : i64
    %2 = llvm.urem %1, %c22_i64 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.and %c3_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.and %arg0, %c-20_i64 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "uge" %0, %c-22_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %c-43_i64, %0 : i64
    %2 = llvm.icmp "ule" %arg1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.sdiv %arg0, %c40_i64 : i64
    %1 = llvm.icmp "eq" %c-45_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %c-4_i64, %2 : i64
    %4 = llvm.icmp "eq" %3, %c-34_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "ult" %c17_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %c11_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ult" %c9_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c33_i64 = arith.constant 33 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.and %c33_i64, %c23_i64 : i64
    %1 = llvm.select %arg0, %c-11_i64, %0 : i1, i64
    %2 = llvm.srem %c2_i64, %0 : i64
    %3 = llvm.select %arg0, %1, %2 : i1, i64
    %4 = llvm.icmp "ugt" %c-27_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c24_i64 = arith.constant 24 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.udiv %c24_i64, %c34_i64 : i64
    %1 = llvm.udiv %c-31_i64, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %c-50_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c13_i64 = arith.constant 13 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "ule" %c13_i64, %c5_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %c-19_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "sle" %c45_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %1, %c-8_i64 : i1, i64
    %3 = llvm.icmp "sle" %2, %c17_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.urem %c-14_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %c-2_i64 : i64
    %2 = llvm.icmp "ne" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %c1_i64 : i64
    %3 = llvm.srem %arg1, %arg0 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.urem %c-24_i64, %c0_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "ne" %c-47_i64, %c-14_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c24_i64 = arith.constant 24 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.srem %c-9_i64, %arg0 : i64
    %1 = llvm.and %0, %c-46_i64 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.srem %c24_i64, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %c45_i64 = arith.constant 45 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sdiv %c45_i64, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ugt" %3, %c-38_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "slt" %c-9_i64, %arg0 : i64
    %1 = llvm.select %0, %c13_i64, %arg1 : i1, i64
    %2 = llvm.and %1, %c-7_i64 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.sdiv %c-28_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %c-3_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.ashr %2, %c-44_i64 : i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.srem %1, %c-43_i64 : i64
    %3 = llvm.sdiv %arg0, %arg0 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c23_i64 = arith.constant 23 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.sdiv %c5_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %c23_i64, %0 : i64
    %2 = llvm.select %1, %c7_i64, %arg1 : i1, i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %0, %c-42_i64 : i64
    %2 = llvm.select %1, %arg1, %c49_i64 : i1, i64
    %3 = llvm.srem %0, %c-25_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.xor %arg0, %c30_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c6_i64, %arg1 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.srem %arg0, %c-36_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.select %true, %arg1, %arg2 : i1, i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.udiv %c-13_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.sdiv %c-46_i64, %arg1 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.udiv %c-4_i64, %c4_i64 : i64
    %1 = llvm.icmp "sle" %arg1, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %arg2, %c-35_i64 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c18_i64 = arith.constant 18 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.ashr %c18_i64, %c38_i64 : i64
    %1 = llvm.and %arg0, %c-34_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.select %1, %c30_i64, %c9_i64 : i1, i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.select %arg1, %c-13_i64, %c40_i64 : i1, i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %0, %0 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %arg1, %c40_i64 : i64
    %2 = llvm.udiv %arg2, %c-14_i64 : i64
    %3 = llvm.select %1, %2, %c27_i64 : i1, i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.udiv %arg0, %c6_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.or %c8_i64, %arg2 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "ule" %arg0, %c-16_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.sext %0 : i1 to i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.srem %arg0, %c-6_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "sge" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %c-39_i64 = arith.constant -39 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.sdiv %c-39_i64, %c11_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.srem %c-36_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.or %c-43_i64, %0 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    %3 = llvm.select %2, %c-24_i64, %1 : i1, i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.urem %c10_i64, %arg0 : i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %c1_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.select %false, %c29_i64, %arg0 : i1, i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.urem %c-18_i64, %c-18_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %c10_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "ule" %c-44_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.select %3, %arg0, %1 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c46_i64 = arith.constant 46 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.and %c27_i64, %1 : i64
    %3 = llvm.icmp "ult" %2, %c46_i64 : i64
    %4 = llvm.select %3, %1, %c-13_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.lshr %c-37_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %c-29_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c-34_i64 = arith.constant -34 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %0, %c-34_i64 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.urem %2, %c38_i64 : i64
    %4 = llvm.icmp "sgt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c34_i64 = arith.constant 34 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.urem %c50_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c-1_i64 : i64
    %2 = llvm.xor %c34_i64, %1 : i64
    %3 = llvm.sdiv %c-39_i64, %2 : i64
    %4 = llvm.udiv %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.ashr %c-22_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.and %2, %c-42_i64 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.ashr %arg1, %arg1 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.and %2, %c-28_i64 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.select %arg0, %c0_i64, %arg1 : i1, i64
    %1 = llvm.ashr %c-4_i64, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "ugt" %2, %c-47_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %false = arith.constant false
    %c-37_i64 = arith.constant -37 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.select %false, %c-37_i64, %c19_i64 : i1, i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "ult" %c41_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %c11_i64, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "eq" %3, %c15_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.sdiv %c-49_i64, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.select %arg0, %c4_i64, %c-46_i64 : i1, i64
    %1 = llvm.and %0, %c-42_i64 : i64
    %2 = llvm.ashr %c-33_i64, %1 : i64
    %3 = llvm.icmp "sge" %c27_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.udiv %arg0, %c-45_i64 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.icmp "sge" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "ne" %c17_i64, %c36_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "slt" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.ashr %2, %c-35_i64 : i64
    %4 = llvm.udiv %3, %arg2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c24_i64 = arith.constant 24 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.srem %c-39_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %c-43_i64 : i64
    %2 = llvm.sdiv %c24_i64, %c1_i64 : i64
    %3 = llvm.select %1, %arg1, %2 : i1, i64
    %4 = llvm.icmp "ule" %c-1_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.and %c27_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "uge" %c38_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "sle" %c25_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.or %c-21_i64, %1 : i64
    %3 = llvm.or %2, %c-48_i64 : i64
    %4 = llvm.icmp "sge" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.ashr %arg0, %c-20_i64 : i64
    %1 = llvm.urem %c-21_i64, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.xor %arg0, %c-25_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.udiv %arg1, %c12_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.lshr %arg0, %c42_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ne" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-44_i64 = arith.constant -44 : i64
    %c22_i64 = arith.constant 22 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.xor %c22_i64, %c14_i64 : i64
    %1 = llvm.select %true, %arg0, %arg0 : i1, i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "uge" %c-44_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.srem %c-38_i64, %2 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.urem %c-17_i64, %c-50_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.sdiv %1, %c-26_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.or %3, %c-19_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.sdiv %2, %c-2_i64 : i64
    %4 = llvm.icmp "uge" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "sge" %c-20_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %c14_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %3, %c-18_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ule" %arg2, %c48_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-28_i64 = arith.constant -28 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %c-26_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c25_i64, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.select %1, %2, %2 : i1, i64
    %4 = llvm.sdiv %c-28_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.or %arg0, %c-40_i64 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.urem %c-16_i64, %1 : i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %false = arith.constant false
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "sgt" %c39_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.lshr %2, %c26_i64 : i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c10_i64 = arith.constant 10 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.ashr %c48_i64, %arg0 : i64
    %1 = llvm.urem %c10_i64, %0 : i64
    %2 = llvm.select %arg1, %0, %c8_i64 : i1, i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sdiv %c41_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %c1_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.icmp "sle" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %c-37_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.select %1, %arg1, %arg1 : i1, i64
    %3 = llvm.ashr %arg2, %0 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.sdiv %c-27_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c-22_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c47_i64 = arith.constant 47 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.or %arg0, %c30_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.or %c47_i64, %1 : i64
    %3 = llvm.or %2, %c-19_i64 : i64
    %4 = llvm.icmp "sle" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.select %0, %1, %c24_i64 : i1, i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.select %false, %1, %c-28_i64 : i1, i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.icmp "eq" %1, %c12_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.urem %3, %arg2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %0, %c-23_i64 : i64
    %2 = llvm.icmp "eq" %c18_i64, %1 : i64
    %3 = llvm.lshr %0, %c-24_i64 : i64
    %4 = llvm.select %2, %3, %arg0 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c45_i64 = arith.constant 45 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "sge" %c45_i64, %c14_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c18_i64, %1 : i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.icmp "ugt" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.select %arg0, %c-7_i64, %arg1 : i1, i64
    %1 = llvm.icmp "sle" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "uge" %c-25_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %false, %arg0, %1 : i1, i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c49_i64 = arith.constant 49 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.srem %c-3_i64, %0 : i64
    %2 = llvm.icmp "eq" %c49_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %3, %c50_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.xor %c7_i64, %0 : i64
    %2 = llvm.ashr %0, %arg1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.sdiv %c18_i64, %arg1 : i64
    %2 = llvm.icmp "sgt" %1, %c-3_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.urem %c-46_i64, %c-35_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.ashr %0, %c36_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c13_i64 = arith.constant 13 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %arg0, %c14_i64 : i64
    %1 = llvm.urem %c13_i64, %0 : i64
    %2 = llvm.icmp "ule" %c-20_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.select %arg1, %0, %0 : i1, i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.lshr %arg0, %c13_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %c-29_i64, %arg0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.xor %c-8_i64, %1 : i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.icmp "sle" %c40_i64, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.select %arg0, %0, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.icmp "sgt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.icmp "eq" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ult" %c14_i64, %c-27_i64 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.xor %arg1, %1 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.xor %arg0, %c23_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.ashr %0, %arg1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.udiv %c-26_i64, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %arg1, %arg2 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c39_i64 = arith.constant 39 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %c39_i64, %c-39_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.urem %1, %1 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.icmp "ne" %0, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c37_i64 = arith.constant 37 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.srem %c37_i64, %c4_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.lshr %2, %c13_i64 : i64
    %4 = llvm.icmp "ugt" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %c32_i64, %0 : i64
    %2 = llvm.icmp "ugt" %0, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %c-19_i64, %c48_i64 : i64
    %1 = llvm.lshr %0, %c-10_i64 : i64
    %2 = llvm.select %arg0, %c-30_i64, %1 : i1, i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c33_i64 = arith.constant 33 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.urem %arg0, %c8_i64 : i64
    %1 = llvm.urem %arg1, %c50_i64 : i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "ne" %c33_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %0, %c29_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.lshr %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.srem %c-43_i64, %c-45_i64 : i64
    %1 = llvm.xor %0, %c-7_i64 : i64
    %2 = llvm.icmp "ne" %c-27_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.icmp "ugt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
