module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %arg1, %arg1 : i64
    %2 = llvm.and %1, %c-22_i64 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.srem %c-50_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %false = arith.constant false
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.select %false, %arg1, %c24_i64 : i1, i64
    %1 = llvm.or %0, %c-10_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.sext %arg2 : i1 to i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.select %2, %arg1, %arg2 : i1, i64
    %4 = llvm.icmp "sgt" %c6_i64, %3 : i64
    %5 = llvm.select %4, %arg1, %3 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.and %c-2_i64, %c36_i64 : i64
    %1 = llvm.icmp "sge" %c22_i64, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %c41_i64, %1 : i64
    %3 = llvm.icmp "uge" %2, %c39_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.select %1, %3, %arg2 : i1, i64
    %5 = llvm.icmp "sle" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "eq" %arg0, %c-46_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c23_i64 = arith.constant 23 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.select %1, %c23_i64, %c22_i64 : i1, i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %c-28_i64 : i64
    %2 = llvm.and %1, %c22_i64 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.and %3, %arg2 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c7_i64, %arg0 : i64
    %3 = llvm.ashr %2, %c7_i64 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.sdiv %c45_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %4, %1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ule" %0, %c30_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %arg2, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ult" %c-28_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %c27_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "ne" %c17_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %c-50_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ne" %c-20_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg1, %0 : i64
    %2 = llvm.select %1, %c43_i64, %arg1 : i1, i64
    %3 = llvm.urem %2, %c9_i64 : i64
    %4 = llvm.select %1, %3, %3 : i1, i64
    %5 = llvm.icmp "ult" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "ne" %c16_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg1, %arg2 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ule" %3, %c-24_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.xor %1, %c29_i64 : i64
    %3 = llvm.select %arg2, %c21_i64, %1 : i1, i64
    %4 = llvm.lshr %arg1, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c-2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.select %false, %arg0, %c-7_i64 : i1, i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %c-2_i64, %0 : i64
    %4 = llvm.or %3, %c-34_i64 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.and %c35_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %0, %arg0 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ule" %c-27_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "sgt" %3, %c-42_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %c-5_i64, %0 : i64
    %2 = llvm.xor %c5_i64, %0 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.xor %c50_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c5_i64 = arith.constant 5 : i64
    %c37_i64 = arith.constant 37 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.srem %c37_i64, %c4_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %c5_i64, %c0_i64 : i64
    %3 = llvm.or %2, %1 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.select %arg1, %c20_i64, %2 : i1, i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "uge" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.lshr %c16_i64, %3 : i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.xor %arg2, %arg1 : i64
    %1 = llvm.lshr %c-47_i64, %0 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %c22_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %c12_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "slt" %arg1, %c19_i64 : i64
    %1 = llvm.udiv %arg2, %c-31_i64 : i64
    %2 = llvm.select %0, %c-29_i64, %1 : i1, i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %true = arith.constant true
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.xor %arg0, %c-41_i64 : i64
    %1 = llvm.select %true, %0, %c-49_i64 : i1, i64
    %2 = llvm.ashr %arg0, %arg1 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c17_i64 = arith.constant 17 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.select %true, %c17_i64, %c-1_i64 : i1, i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %3, %1 : i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %false = arith.constant false
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.lshr %c21_i64, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "ule" %c31_i64, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %2, %3, %1 : i1, i64
    %5 = llvm.select %false, %1, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "eq" %c37_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %c-5_i64, %3 : i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c24_i64 = arith.constant 24 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.or %arg1, %c-41_i64 : i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "ult" %c24_i64, %c19_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c-14_i64 = arith.constant -14 : i64
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.ashr %arg0, %c35_i64 : i64
    %3 = llvm.select %true, %c-14_i64, %2 : i1, i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.xor %arg0, %c-3_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %2, %c39_i64, %3 : i1, i64
    %5 = llvm.icmp "sle" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c5_i64 = arith.constant 5 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.select %arg0, %c45_i64, %arg1 : i1, i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.urem %3, %c5_i64 : i64
    %5 = llvm.icmp "sle" %4, %c10_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.or %4, %0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c50_i64 = arith.constant 50 : i64
    %true = arith.constant true
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %c-23_i64, %arg2 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.select %true, %c50_i64, %c29_i64 : i1, i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.and %arg0, %c30_i64 : i64
    %1 = llvm.udiv %c-22_i64, %c10_i64 : i64
    %2 = llvm.icmp "sle" %c-43_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.urem %c13_i64, %c-27_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.srem %2, %c-20_i64 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.ashr %c-48_i64, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "sle" %c8_i64, %arg0 : i64
    %3 = llvm.and %c7_i64, %arg1 : i64
    %4 = llvm.select %2, %3, %arg2 : i1, i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.xor %c39_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %c-31_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.select %arg1, %0, %arg0 : i1, i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "sgt" %c-22_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c47_i64, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.urem %c-15_i64, %3 : i64
    %5 = llvm.srem %c10_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.ashr %c-46_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %c-47_i64, %c-7_i64 : i64
    %4 = llvm.ashr %c-38_i64, %3 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "eq" %c4_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.sext %0 : i1 to i64
    %4 = llvm.urem %3, %c-10_i64 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "slt" %c-42_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %c20_i64 : i64
    %3 = llvm.icmp "sgt" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.and %c9_i64, %c-46_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %3, %arg0 : i64
    %5 = llvm.or %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c4_i64 = arith.constant 4 : i64
    %c41_i64 = arith.constant 41 : i64
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %true, %0, %c41_i64 : i1, i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.urem %c4_i64, %c46_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "ugt" %c-8_i64, %c18_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %c34_i64, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %false = arith.constant false
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.select %false, %arg0, %c-1_i64 : i1, i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %0, %c14_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.and %c26_i64, %arg2 : i64
    %3 = llvm.sdiv %arg2, %2 : i64
    %4 = llvm.srem %3, %c-9_i64 : i64
    %5 = llvm.select %0, %1, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %true = arith.constant true
    %c3_i64 = arith.constant 3 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %c-8_i64 : i64
    %2 = llvm.and %1, %c3_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %c21_i64, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.select %false, %arg1, %2 : i1, i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c2_i64 = arith.constant 2 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c32_i64 : i64
    %2 = llvm.ashr %c2_i64, %0 : i64
    %3 = llvm.lshr %2, %c38_i64 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.xor %c-1_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %arg1, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "sle" %c-7_i64, %arg0 : i64
    %1 = llvm.xor %arg2, %arg1 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.lshr %c-40_i64, %2 : i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.select %0, %c2_i64, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.srem %arg0, %c8_i64 : i64
    %1 = llvm.xor %arg1, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.and %arg0, %c-37_i64 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.ashr %c20_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.select %3, %arg1, %1 : i1, i64
    %5 = llvm.icmp "sle" %c19_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %c22_i64 : i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "sle" %arg0, %c-23_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.lshr %3, %arg2 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg1, %arg0 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.urem %1, %c-33_i64 : i64
    %3 = llvm.srem %2, %c-32_i64 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.icmp "sle" %4, %c32_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %arg0 : i64
    %2 = llvm.select %arg2, %arg1, %arg1 : i1, i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.or %c22_i64, %arg0 : i64
    %1 = llvm.urem %c22_i64, %0 : i64
    %2 = llvm.lshr %c43_i64, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg1, %arg2 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-48_i64 = arith.constant -48 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ult" %c0_i64, %c-13_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg1, %c-48_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.ashr %4, %arg2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.select %arg2, %c24_i64, %arg0 : i1, i64
    %2 = llvm.and %c36_i64, %0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.and %arg1, %3 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.srem %0, %arg1 : i64
    %3 = llvm.or %c-47_i64, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.urem %4, %c-27_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.xor %c-36_i64, %c-49_i64 : i64
    %1 = llvm.icmp "uge" %0, %c21_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.select %3, %2, %0 : i1, i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.lshr %c22_i64, %c22_i64 : i64
    %1 = llvm.or %c-2_i64, %arg0 : i64
    %2 = llvm.icmp "uge" %c4_i64, %arg1 : i64
    %3 = llvm.select %2, %arg0, %1 : i1, i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-14_i64 = arith.constant -14 : i64
    %false = arith.constant false
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %c-14_i64, %c-6_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %false, %0, %2 : i1, i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "ult" %4, %c-36_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %false = arith.constant false
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.select %false, %c-5_i64, %arg0 : i1, i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.urem %c2_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "ult" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %c-15_i64, %0 : i64
    %2 = llvm.srem %0, %arg1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %c-41_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %c50_i64, %3 : i64
    %5 = llvm.icmp "ult" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.urem %0, %arg0 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %1, %0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.xor %arg0, %c7_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.select %2, %0, %c8_i64 : i1, i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.icmp "sge" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c14_i64 = arith.constant 14 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.udiv %c14_i64, %c32_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %c-28_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.lshr %c-1_i64, %c-36_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.sdiv %2, %c24_i64 : i64
    %4 = llvm.or %3, %arg0 : i64
    %5 = llvm.icmp "slt" %c-17_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.srem %c-36_i64, %c46_i64 : i64
    %1 = llvm.lshr %0, %c34_i64 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-8_i64 = arith.constant -8 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "eq" %c-8_i64, %c-39_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c10_i64 = arith.constant 10 : i64
    %true = arith.constant true
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.xor %c20_i64, %arg0 : i64
    %1 = llvm.urem %c10_i64, %arg0 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.select %true, %0, %2 : i1, i64
    %4 = llvm.select %false, %arg0, %arg0 : i1, i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "eq" %c-14_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %arg1, %c-45_i64 : i64
    %4 = llvm.ashr %c44_i64, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %true = arith.constant true
    %c-27_i64 = arith.constant -27 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.select %true, %c-27_i64, %c29_i64 : i1, i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.or %1, %c-19_i64 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.srem %2, %0 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.srem %c-47_i64, %c3_i64 : i64
    %1 = llvm.ashr %c16_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.zext %arg0 : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-47_i64 = arith.constant -47 : i64
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.sdiv %c-47_i64, %arg0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-33_i64 = arith.constant -33 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.srem %c-33_i64, %c-12_i64 : i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.select %arg1, %1, %arg2 : i1, i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %c-15_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %c45_i64 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c29_i64 = arith.constant 29 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "ugt" %c-16_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c29_i64, %c-23_i64 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.lshr %c-15_i64, %c43_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "sle" %c-18_i64, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "eq" %c26_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    %4 = llvm.select %3, %1, %2 : i1, i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.ashr %arg0, %c-14_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %arg1 : i1, i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.udiv %arg1, %0 : i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "sle" %arg1, %c33_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %arg1, %3 : i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "ule" %c-34_i64, %arg0 : i64
    %1 = llvm.select %0, %c-30_i64, %arg0 : i1, i64
    %2 = llvm.srem %arg1, %arg0 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "ult" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.or %arg0, %c9_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "ult" %c-16_i64, %c-28_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.or %2, %1 : i64
    %4 = llvm.xor %3, %c29_i64 : i64
    %5 = llvm.icmp "ult" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "ult" %c12_i64, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.icmp "slt" %3, %c-17_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %arg1, %arg1 : i64
    %2 = llvm.udiv %c44_i64, %arg2 : i64
    %3 = llvm.select %1, %2, %arg2 : i1, i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %c27_i64 : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.lshr %c19_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %0, %c30_i64 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %false = arith.constant false
    %c-18_i64 = arith.constant -18 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %c-18_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.xor %c-22_i64, %2 : i64
    %4 = llvm.select %false, %arg1, %c-40_i64 : i1, i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.and %c1_i64, %arg0 : i64
    %1 = llvm.ashr %arg2, %arg2 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c8_i64 = arith.constant 8 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.sdiv %c8_i64, %c45_i64 : i64
    %1 = llvm.icmp "sgt" %c-35_i64, %arg0 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    %3 = llvm.or %c-41_i64, %arg2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c-14_i64 = arith.constant -14 : i64
    %false = arith.constant false
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.lshr %c-14_i64, %c40_i64 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.ashr %c16_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %arg1, %arg0 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.and %c24_i64, %c-13_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.xor %arg1, %c-7_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.ashr %c38_i64, %arg0 : i64
    %1 = llvm.udiv %c-43_i64, %c49_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %c38_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %c-15_i64 : i64
    %2 = llvm.lshr %1, %c-18_i64 : i64
    %3 = llvm.udiv %2, %1 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "sle" %c-33_i64, %c-28_i64 : i64
    %1 = llvm.or %c-19_i64, %arg0 : i64
    %2 = llvm.urem %c-35_i64, %1 : i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.icmp "sge" %c-42_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-45_i64 = arith.constant -45 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %arg1, %c6_i64 : i64
    %2 = llvm.and %c-45_i64, %c-36_i64 : i64
    %3 = llvm.xor %c-4_i64, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.urem %2, %1 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.ashr %arg1, %arg1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.udiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "ule" %c37_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %0, %c-44_i64 : i64
    %3 = llvm.sdiv %2, %c-13_i64 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.srem %arg1, %c1_i64 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "ne" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %0, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.and %c39_i64, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "uge" %arg1, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.lshr %2, %c-37_i64 : i64
    %4 = llvm.sext %0 : i1 to i64
    %5 = llvm.srem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.sdiv %c-47_i64, %c13_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.trunc %arg0 : i1 to i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.select %2, %3, %1 : i1, i64
    %5 = llvm.sdiv %4, %0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.lshr %2, %c-21_i64 : i64
    %4 = llvm.udiv %c-9_i64, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "uge" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.sdiv %c-14_i64, %c-3_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.select %arg0, %arg1, %0 : i1, i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.sdiv %c-6_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %c-41_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.srem %c-43_i64, %arg0 : i64
    %1 = llvm.and %c-47_i64, %0 : i64
    %2 = llvm.urem %c-10_i64, %1 : i64
    %3 = llvm.icmp "uge" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "uge" %arg0, %c-19_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %c10_i64, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %4, %c-14_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.select %arg0, %c-11_i64, %c-29_i64 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.icmp "ne" %c-9_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.icmp "uge" %2, %c-21_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %c-47_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ult" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %c-25_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "sle" %2, %c31_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.or %2, %c39_i64 : i64
    %4 = llvm.icmp "sgt" %3, %0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c16_i64 = arith.constant 16 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "sle" %c-24_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %c16_i64, %c-12_i64 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    %3 = llvm.select %0, %2, %arg0 : i1, i64
    %4 = llvm.select %1, %arg0, %3 : i1, i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "sgt" %arg0, %c21_i64 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.xor %2, %arg1 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.xor %c2_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %c-12_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.xor %1, %arg0 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.or %arg0, %c20_i64 : i64
    %1 = llvm.udiv %c-25_i64, %0 : i64
    %2 = llvm.sdiv %arg1, %c25_i64 : i64
    %3 = llvm.lshr %2, %c-29_i64 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.or %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.udiv %c-18_i64, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.lshr %2, %arg2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %false = arith.constant false
    %c25_i64 = arith.constant 25 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.ashr %arg0, %c-6_i64 : i64
    %1 = llvm.and %c25_i64, %arg0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.select %false, %arg2, %c24_i64 : i1, i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.lshr %0, %arg0 : i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.sdiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %arg1, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.and %2, %c-46_i64 : i64
    %4 = llvm.ashr %c-19_i64, %arg2 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.srem %c-21_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c-36_i64 : i64
    %2 = llvm.icmp "eq" %c-2_i64, %c-13_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.xor %4, %c-14_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c18_i64 = arith.constant 18 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.srem %arg0, %c1_i64 : i64
    %1 = llvm.sdiv %0, %c18_i64 : i64
    %2 = llvm.urem %0, %c-43_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.or %3, %arg0 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.sdiv %arg0, %c49_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.icmp "ule" %c27_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.xor %c-26_i64, %c33_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.sdiv %arg1, %arg1 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c10_i64 = arith.constant 10 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.udiv %c10_i64, %c-42_i64 : i64
    %1 = llvm.sdiv %c-11_i64, %0 : i64
    %2 = llvm.icmp "eq" %1, %c-44_i64 : i64
    %3 = llvm.ashr %c11_i64, %arg0 : i64
    %4 = llvm.select %2, %1, %3 : i1, i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c-1_i64 = arith.constant -1 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.ashr %c-1_i64, %c24_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "sle" %arg0, %c5_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %arg0, %arg1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "uge" %arg0, %c17_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "ule" %c-44_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "sge" %c-28_i64, %c16_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %c-40_i64, %arg0 : i64
    %3 = llvm.select %2, %arg1, %c39_i64 : i1, i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %c23_i64, %c42_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %arg2, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.sdiv %arg0, %0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %4, %c47_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.ashr %arg0, %c-18_i64 : i64
    %1 = llvm.icmp "sgt" %c43_i64, %0 : i64
    %2 = llvm.select %1, %arg0, %arg2 : i1, i64
    %3 = llvm.select %1, %arg1, %2 : i1, i64
    %4 = llvm.zext %1 : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %3, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c26_i64 = arith.constant 26 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.xor %c20_i64, %arg0 : i64
    %1 = llvm.xor %0, %c26_i64 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %4, %c-41_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "uge" %c-24_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.or %c-6_i64, %arg0 : i64
    %5 = llvm.udiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %true = arith.constant true
    %c5_i64 = arith.constant 5 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.udiv %c-42_i64, %c34_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.urem %1, %c31_i64 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %c5_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.xor %4, %arg2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c2_i64 : i64
    %2 = llvm.icmp "slt" %arg0, %c2_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.sdiv %c-37_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c22_i64 = arith.constant 22 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.and %arg0, %c-26_i64 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.srem %arg2, %c22_i64 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "uge" %4, %c16_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %c-31_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.srem %0, %c-41_i64 : i64
    %4 = llvm.udiv %arg2, %3 : i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %c5_i64 = arith.constant 5 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.select %false, %c5_i64, %c-19_i64 : i1, i64
    %1 = llvm.urem %c-43_i64, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "sgt" %c21_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %c-14_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.sdiv %arg0, %c-15_i64 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %3, %1 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "ugt" %c4_i64, %c-1_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.or %2, %c-31_i64 : i64
    %4 = llvm.or %3, %1 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c22_i64 = arith.constant 22 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.or %arg1, %c50_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "sle" %c22_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %3, %arg0 : i64
    %5 = llvm.icmp "ugt" %4, %c-46_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c33_i64 = arith.constant 33 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.sdiv %c-9_i64, %c-24_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.or %c33_i64, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.ashr %arg0, %c-45_i64 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %4, %c-35_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.or %0, %c36_i64 : i64
    %2 = llvm.xor %c47_i64, %1 : i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %c-3_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.xor %c-45_i64, %arg0 : i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.urem %arg0, %arg1 : i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.urem %c-31_i64, %c34_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.and %3, %arg0 : i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.xor %arg1, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "sle" %arg0, %c-1_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg1, %arg0 : i64
    %3 = llvm.icmp "sgt" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.udiv %c29_i64, %c-38_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    %5 = llvm.select %4, %3, %arg1 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %c31_i64, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.urem %2, %arg1 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.or %c-22_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.and %0, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.lshr %c44_i64, %arg0 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %c43_i64 : i64
    %3 = llvm.ashr %1, %c-8_i64 : i64
    %4 = llvm.and %3, %c0_i64 : i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %arg1, %arg2 : i64
    %4 = llvm.udiv %3, %c-1_i64 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c26_i64 = arith.constant 26 : i64
    %c44_i64 = arith.constant 44 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.urem %c44_i64, %c40_i64 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.urem %1, %c26_i64 : i64
    %3 = llvm.or %arg1, %1 : i64
    %4 = llvm.urem %c-27_i64, %3 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %c45_i64, %arg0 : i64
    %1 = llvm.xor %c-45_i64, %0 : i64
    %2 = llvm.xor %0, %arg1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.xor %arg0, %c-28_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "ult" %1, %c25_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c6_i64 = arith.constant 6 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.lshr %c34_i64, %arg1 : i64
    %1 = llvm.udiv %c18_i64, %arg1 : i64
    %2 = llvm.and %c-50_i64, %1 : i64
    %3 = llvm.select %arg0, %0, %2 : i1, i64
    %4 = llvm.or %c6_i64, %3 : i64
    %5 = llvm.or %4, %3 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %c13_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %1, %arg1, %0 : i1, i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.srem %c41_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "sge" %c-8_i64, %c25_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c-39_i64, %arg0 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %c-29_i64, %arg1 : i1, i64
    %2 = llvm.udiv %1, %c-14_i64 : i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.select %0, %c-4_i64, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.srem %arg2, %c36_i64 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "ugt" %c-21_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.lshr %arg0, %arg0 : i64
    %3 = llvm.select %true, %arg0, %2 : i1, i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "slt" %c-33_i64, %c-25_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "slt" %c15_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.urem %arg1, %c3_i64 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "eq" %c41_i64, %c-19_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg0, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %true = arith.constant true
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.select %1, %0, %c1_i64 : i1, i64
    %3 = llvm.select %true, %c25_i64, %arg2 : i1, i64
    %4 = llvm.ashr %arg2, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ugt" %0, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %c37_i64, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sle" %2, %c46_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c-27_i64 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.icmp "slt" %arg1, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.icmp "ne" %c5_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.select %arg0, %c-2_i64, %arg2 : i1, i64
    %1 = llvm.icmp "sle" %0, %c17_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg0, %arg1, %2 : i1, i64
    %4 = llvm.ashr %arg1, %c29_i64 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.or %1, %1 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.srem %c-17_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c-29_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %2, %c-33_i64 : i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.sdiv %c4_i64, %arg0 : i64
    %1 = llvm.srem %0, %c-46_i64 : i64
    %2 = llvm.ashr %c18_i64, %1 : i64
    %3 = llvm.xor %c-27_i64, %0 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c-32_i64 : i64
    %2 = llvm.srem %arg0, %arg2 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.and %c-35_i64, %arg1 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-38_i64 = arith.constant -38 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.udiv %c-38_i64, %c23_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c33_i64 = arith.constant 33 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.icmp "sge" %c33_i64, %c32_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %c-41_i64 : i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.urem %c-31_i64, %3 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c43_i64 = arith.constant 43 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.select %arg0, %c-41_i64, %c0_i64 : i1, i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.xor %c43_i64, %c16_i64 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.xor %c-4_i64, %c42_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %c37_i64 : i64
    %4 = llvm.and %c-23_i64, %3 : i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.lshr %1, %c22_i64 : i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.lshr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.urem %arg1, %c3_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %false = arith.constant false
    %c34_i64 = arith.constant 34 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.lshr %c34_i64, %c6_i64 : i64
    %1 = llvm.select %arg1, %arg0, %0 : i1, i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.select %false, %arg2, %c38_i64 : i1, i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.and %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.and %arg0, %c-33_i64 : i64
    %1 = llvm.lshr %0, %c-6_i64 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.lshr %c-30_i64, %c-20_i64 : i64
    %4 = llvm.udiv %3, %1 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c29_i64 = arith.constant 29 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.xor %c29_i64, %c-25_i64 : i64
    %1 = llvm.select %false, %0, %arg0 : i1, i64
    %2 = llvm.icmp "slt" %arg0, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c22_i64 = arith.constant 22 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c12_i64 : i64
    %2 = llvm.and %c22_i64, %c10_i64 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-24_i64 = arith.constant -24 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.udiv %c-24_i64, %c11_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.ashr %4, %arg0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.urem %c-4_i64, %c-2_i64 : i64
    %1 = llvm.udiv %c49_i64, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %false = arith.constant false
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sdiv %arg1, %c41_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.select %false, %c-38_i64, %arg2 : i1, i64
    %3 = llvm.select %1, %arg2, %2 : i1, i64
    %4 = llvm.icmp "uge" %3, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %c-25_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %1, %c20_i64 : i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c19_i64 = arith.constant 19 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.srem %c-2_i64, %arg0 : i64
    %1 = llvm.xor %c-42_i64, %arg2 : i64
    %2 = llvm.select %arg1, %1, %c19_i64 : i1, i64
    %3 = llvm.udiv %c-12_i64, %1 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.or %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %c-21_i64, %0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.sdiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.and %c-42_i64, %c38_i64 : i64
    %1 = llvm.icmp "sge" %c-39_i64, %c-19_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %c3_i64, %0 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.lshr %c-47_i64, %c-26_i64 : i64
    %1 = llvm.icmp "eq" %c35_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %c49_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %1, %c3_i64 : i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %c-36_i64, %2 : i64
    %4 = llvm.icmp "ult" %3, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %true = arith.constant true
    %c48_i64 = arith.constant 48 : i64
    %c0_i64 = arith.constant 0 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.select %arg0, %c0_i64, %c23_i64 : i1, i64
    %1 = llvm.select %arg0, %c-1_i64, %0 : i1, i64
    %2 = llvm.select %true, %0, %1 : i1, i64
    %3 = llvm.srem %c48_i64, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "slt" %c29_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.srem %1, %arg1 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "sle" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.and %c14_i64, %arg0 : i64
    %1 = llvm.and %arg1, %arg0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.udiv %3, %c-9_i64 : i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "ult" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %c-11_i64, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.zext %1 : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ne" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c41_i64 = arith.constant 41 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.udiv %c41_i64, %c11_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.lshr %arg0, %arg1 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.or %4, %c47_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.sdiv %c-25_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %0 : i1, i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.or %c19_i64, %1 : i64
    %4 = llvm.udiv %3, %3 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %c40_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.udiv %4, %0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %true = arith.constant true
    %c-40_i64 = arith.constant -40 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c-40_i64 : i64
    %2 = llvm.select %true, %arg0, %c47_i64 : i1, i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "slt" %c50_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %c40_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %arg1, %arg1 : i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.urem %c-48_i64, %c-13_i64 : i64
    %1 = llvm.sdiv %arg1, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.sext %arg2 : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %c0_i64, %arg0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "sle" %3, %arg1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "uge" %c-9_i64, %c-40_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %c25_i64, %c10_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %2, %3, %1 : i1, i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "sle" %c50_i64, %c22_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %arg0 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    %4 = llvm.sdiv %3, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.xor %c6_i64, %0 : i64
    %2 = llvm.icmp "uge" %arg1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.srem %arg2, %c11_i64 : i64
    %1 = llvm.urem %arg2, %0 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.or %0, %c-37_i64 : i64
    %5 = llvm.srem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "ne" %c13_i64, %c23_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.and %1, %1 : i64
    %4 = llvm.select %2, %1, %3 : i1, i64
    %5 = llvm.sdiv %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.srem %arg0, %c2_i64 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "sgt" %arg2, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %c32_i64, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.select %true, %1, %arg0 : i1, i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c5_i64 = arith.constant 5 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.sdiv %c13_i64, %arg0 : i64
    %1 = llvm.and %c5_i64, %0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.srem %c10_i64, %2 : i64
    %4 = llvm.sext %arg2 : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg1, %c-11_i64 : i64
    %2 = llvm.select %1, %c34_i64, %arg1 : i1, i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.select %0, %2, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c13_i64 = arith.constant 13 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.lshr %c-34_i64, %c43_i64 : i64
    %1 = llvm.lshr %c13_i64, %0 : i64
    %2 = llvm.urem %arg0, %arg1 : i64
    %3 = llvm.select %true, %arg0, %2 : i1, i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %c47_i64, %arg0 : i64
    %1 = llvm.or %c-28_i64, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %arg2 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.urem %c-12_i64, %c34_i64 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.urem %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %3, %3 : i64
    %5 = llvm.icmp "sle" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "sle" %c-39_i64, %c5_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.xor %c45_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.urem %0, %c40_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.or %4, %c48_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.lshr %c-8_i64, %arg0 : i64
    %1 = llvm.ashr %c7_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.urem %c-1_i64, %3 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.or %c1_i64, %arg2 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.ashr %3, %c24_i64 : i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %true = arith.constant true
    %c-36_i64 = arith.constant -36 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.xor %c-36_i64, %c27_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "sle" %c-12_i64, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sdiv %c33_i64, %arg2 : i64
    %1 = llvm.icmp "sgt" %c44_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.urem %arg1, %arg1 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.ashr %c42_i64, %arg1 : i64
    %1 = llvm.urem %arg2, %c-30_i64 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.select %false, %c-40_i64, %0 : i1, i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %2, %0, %arg2 : i1, i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.and %c48_i64, %c25_i64 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %c16_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.urem %c11_i64, %arg1 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %c-47_i64, %1 : i64
    %3 = llvm.icmp "eq" %c-1_i64, %arg0 : i64
    %4 = llvm.select %3, %c-16_i64, %c-35_i64 : i1, i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c-32_i64 = arith.constant -32 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %c-32_i64, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "eq" %c4_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.srem %c47_i64, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.or %c19_i64, %arg2 : i64
    %2 = llvm.udiv %1, %c-35_i64 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.lshr %3, %c11_i64 : i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %c-43_i64, %c45_i64 : i64
    %1 = llvm.or %c-19_i64, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "uge" %arg1, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %0, %c11_i64, %1 : i1, i64
    %3 = llvm.xor %arg1, %1 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.sext %arg2 : i1 to i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.icmp "sle" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %2, %c-4_i64 : i64
    %4 = llvm.lshr %c-35_i64, %c9_i64 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %c-27_i64 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.srem %c24_i64, %3 : i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %c-11_i64, %0 : i64
    %2 = llvm.xor %c-22_i64, %arg0 : i64
    %3 = llvm.select %1, %c-38_i64, %2 : i1, i64
    %4 = llvm.urem %3, %2 : i64
    %5 = llvm.xor %c-3_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c11_i64 = arith.constant 11 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.ashr %c11_i64, %c32_i64 : i64
    %1 = llvm.srem %0, %c-3_i64 : i64
    %2 = llvm.xor %arg0, %c28_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg1 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %0 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.icmp "uge" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.icmp "sge" %c-3_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %arg2, %arg0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %c-6_i64, %arg0 : i64
    %2 = llvm.xor %0, %0 : i64
    %3 = llvm.select %arg1, %1, %2 : i1, i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.lshr %c-2_i64, %arg0 : i64
    %1 = llvm.sdiv %c20_i64, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.and %arg2, %0 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.and %arg0, %c-36_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.urem %0, %arg2 : i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c37_i64 = arith.constant 37 : i64
    %c-44_i64 = arith.constant -44 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.sdiv %arg0, %c-26_i64 : i64
    %1 = llvm.icmp "ult" %c-44_i64, %0 : i64
    %2 = llvm.udiv %c-44_i64, %c37_i64 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c33_i64 = arith.constant 33 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.and %c33_i64, %c19_i64 : i64
    %1 = llvm.sdiv %0, %c25_i64 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.xor %3, %c-8_i64 : i64
    %5 = llvm.xor %c-50_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c3_i64 = arith.constant 3 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.udiv %c-7_i64, %c46_i64 : i64
    %1 = llvm.xor %c3_i64, %0 : i64
    %2 = llvm.urem %c-20_i64, %1 : i64
    %3 = llvm.and %c11_i64, %2 : i64
    %4 = llvm.urem %1, %c-49_i64 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c44_i64 = arith.constant 44 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.and %c44_i64, %c-45_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.udiv %1, %c50_i64 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.ashr %c-40_i64, %c-26_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "eq" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.sdiv %c-47_i64, %c30_i64 : i64
    %1 = llvm.srem %0, %c-48_i64 : i64
    %2 = llvm.sdiv %arg0, %c45_i64 : i64
    %3 = llvm.ashr %2, %c4_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %4, %2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "ugt" %arg0, %c-2_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.or %c33_i64, %1 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.select %arg0, %c-20_i64, %c36_i64 : i1, i64
    %1 = llvm.ashr %c-11_i64, %0 : i64
    %2 = llvm.ashr %c-48_i64, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.srem %3, %c-44_i64 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.lshr %c45_i64, %arg2 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %c-7_i64 : i64
    %2 = llvm.lshr %c36_i64, %0 : i64
    %3 = llvm.and %c14_i64, %1 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.icmp "ule" %4, %c21_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.srem %c36_i64, %arg1 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %c20_i64, %2 : i64
    %4 = llvm.urem %2, %2 : i64
    %5 = llvm.select %3, %0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.xor %3, %arg0 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "slt" %c37_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %arg0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.xor %c-25_i64, %arg1 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.and %arg0, %c23_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %4, %c22_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "slt" %c33_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %false = arith.constant false
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.udiv %c32_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "ule" %2, %c-46_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %arg1, %c33_i64 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.srem %c19_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.ashr %arg0, %0 : i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.sdiv %3, %c30_i64 : i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.select %arg0, %c2_i64, %c-21_i64 : i1, i64
    %1 = llvm.lshr %c30_i64, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "uge" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "sgt" %c26_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %4, %arg0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "uge" %c12_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %c-17_i64 : i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %3, %c26_i64 : i64
    %5 = llvm.or %4, %c47_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c40_i64 = arith.constant 40 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.srem %c40_i64, %c35_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %0, %c4_i64 : i64
    %4 = llvm.udiv %3, %2 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.select %arg0, %c-33_i64, %c-18_i64 : i1, i64
    %1 = llvm.icmp "ult" %c47_i64, %0 : i64
    %2 = llvm.select %1, %arg1, %0 : i1, i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.icmp "sgt" %c18_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.select %arg0, %c-15_i64, %c50_i64 : i1, i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %c37_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "ne" %c-5_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c11_i64, %arg0 : i64
    %3 = llvm.trunc %0 : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.lshr %c-1_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.lshr %c11_i64, %arg0 : i64
    %1 = llvm.xor %c-1_i64, %c1_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "uge" %arg0, %c19_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "ne" %arg1, %c-17_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.udiv %arg2, %3 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %c22_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.or %4, %arg2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "uge" %c0_i64, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.and %arg2, %1 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "uge" %c-23_i64, %c49_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c-27_i64, %1 : i64
    %3 = llvm.udiv %1, %arg0 : i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.urem %arg1, %arg1 : i64
    %4 = llvm.srem %c29_i64, %3 : i64
    %5 = llvm.select %2, %0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.lshr %c1_i64, %c34_i64 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "ule" %arg1, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.sdiv %c29_i64, %c40_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-14_i64 = arith.constant -14 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.sdiv %c-38_i64, %arg0 : i64
    %1 = llvm.sdiv %c-14_i64, %0 : i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "ugt" %c21_i64, %c-18_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "sge" %arg1, %c38_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.or %c-7_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.urem %1, %0 : i64
    %4 = llvm.sdiv %3, %2 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c35_i64 = arith.constant 35 : i64
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.xor %0, %c35_i64 : i64
    %2 = llvm.select %true, %0, %1 : i1, i64
    %3 = llvm.ashr %2, %c12_i64 : i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.lshr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg0, %2, %0 : i1, i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.srem %c-7_i64, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.select %2, %arg1, %arg1 : i1, i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.icmp "sge" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "sgt" %c9_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %false = arith.constant false
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.urem %c-2_i64, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.sdiv %arg0, %c-21_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.icmp "sgt" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.select %0, %c-29_i64, %arg1 : i1, i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.lshr %c15_i64, %2 : i64
    %4 = llvm.or %3, %arg2 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.and %c-4_i64, %arg1 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.ashr %0, %arg1 : i64
    %3 = llvm.select %arg0, %1, %2 : i1, i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.srem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %2, %3, %c26_i64 : i1, i64
    %5 = llvm.icmp "ule" %c37_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c-42_i64 = arith.constant -42 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "slt" %c-10_i64, %c9_i64 : i64
    %1 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.select %0, %c-42_i64, %3 : i1, i64
    %5 = llvm.sdiv %4, %c4_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.lshr %arg2, %c-49_i64 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.urem %c-43_i64, %2 : i64
    %4 = llvm.ashr %arg2, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.srem %c-19_i64, %c17_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %arg0, %c18_i64 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "sle" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c10_i64 = arith.constant 10 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "sge" %c10_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %c-45_i64, %2 : i64
    %4 = llvm.select %3, %0, %2 : i1, i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.udiv %c-48_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %c46_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %arg0, %arg0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "ult" %c24_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "uge" %c43_i64, %arg1 : i64
    %4 = llvm.select %3, %0, %c27_i64 : i1, i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.srem %0, %c-26_i64 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "sgt" %4, %c-30_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %true = arith.constant true
    %c-26_i64 = arith.constant -26 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.lshr %arg0, %c8_i64 : i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.select %2, %c-14_i64, %arg1 : i1, i64
    %4 = llvm.urem %c-26_i64, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %arg2, %c-21_i64 : i1, i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ugt" %c37_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c35_i64 = arith.constant 35 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.xor %c46_i64, %arg0 : i64
    %1 = llvm.xor %0, %c35_i64 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.sdiv %3, %c49_i64 : i64
    %5 = llvm.or %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.select %arg0, %c39_i64, %arg1 : i1, i64
    %1 = llvm.icmp "slt" %c-19_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %c-33_i64, %arg1 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "sgt" %4, %c-10_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %c23_i64 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.select %0, %c-31_i64, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.select %1, %c24_i64, %0 : i1, i64
    %3 = llvm.icmp "slt" %c-19_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c-37_i64 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.icmp "ne" %c-28_i64, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %c-13_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %c-9_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %3, %arg0 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.sdiv %4, %c35_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.urem %arg0, %arg0 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "sle" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.sdiv %c-50_i64, %c40_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %3, %c39_i64 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.trunc %0 : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c-34_i64 = arith.constant -34 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg1, %arg1 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.udiv %1, %c-34_i64 : i64
    %3 = llvm.icmp "slt" %arg1, %c-19_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-26_i64 = arith.constant -26 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %c30_i64, %0 : i64
    %2 = llvm.urem %0, %c-26_i64 : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c24_i64 = arith.constant 24 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.xor %arg0, %c-45_i64 : i64
    %1 = llvm.icmp "sgt" %c30_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %c24_i64, %2 : i64
    %4 = llvm.sdiv %arg1, %c-29_i64 : i64
    %5 = llvm.select %3, %4, %c6_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.xor %c32_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.sdiv %c32_i64, %arg1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "ule" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "ugt" %arg0, %c37_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "ult" %2, %c-48_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %false = arith.constant false
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.srem %c-45_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.srem %c-20_i64, %arg0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c49_i64 = arith.constant 49 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.xor %c49_i64, %c15_i64 : i64
    %1 = llvm.and %c2_i64, %0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.xor %0, %arg0 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %4, %c11_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.urem %c27_i64, %arg0 : i64
    %1 = llvm.or %c-13_i64, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.urem %c8_i64, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.or %arg0, %c26_i64 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.icmp "sge" %c35_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.ashr %arg0, %c-6_i64 : i64
    %1 = llvm.sdiv %c32_i64, %0 : i64
    %2 = llvm.srem %c-31_i64, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c43_i64, %arg0 : i1, i64
    %2 = llvm.and %c-15_i64, %1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.udiv %c-32_i64, %c-12_i64 : i64
    %1 = llvm.ashr %c-49_i64, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg2 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.udiv %arg1, %arg1 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c26_i64 = arith.constant 26 : i64
    %c44_i64 = arith.constant 44 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.ashr %c44_i64, %c42_i64 : i64
    %1 = llvm.udiv %0, %c26_i64 : i64
    %2 = llvm.and %1, %c-43_i64 : i64
    %3 = llvm.icmp "eq" %c40_i64, %c11_i64 : i64
    %4 = llvm.select %3, %1, %arg0 : i1, i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c21_i64 = arith.constant 21 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.select %arg0, %arg1, %c25_i64 : i1, i64
    %1 = llvm.srem %0, %c21_i64 : i64
    %2 = llvm.icmp "sle" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %c40_i64, %3 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.ashr %c11_i64, %c-22_i64 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.icmp "sgt" %c46_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-30_i64 = arith.constant -30 : i64
    %c36_i64 = arith.constant 36 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.icmp "ugt" %c36_i64, %c7_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.udiv %c-30_i64, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.sdiv %arg0, %c46_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.and %2, %c-22_i64 : i64
    %4 = llvm.icmp "ult" %3, %arg1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %false = arith.constant false
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.select %false, %c33_i64, %0 : i1, i64
    %2 = llvm.icmp "uge" %0, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %3, %c23_i64 : i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.ashr %1, %arg1 : i64
    %4 = llvm.select %2, %3, %arg2 : i1, i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-40_i64 = arith.constant -40 : i64
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg2 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.select %true, %c-40_i64, %c-48_i64 : i1, i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.lshr %c-29_i64, %3 : i64
    %5 = llvm.icmp "slt" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-49_i64 = arith.constant -49 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.lshr %c-49_i64, %c10_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.zext %arg0 : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %2, %c-21_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.udiv %arg0, %arg2 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "sle" %c-4_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %arg1 : i64
    %3 = llvm.icmp "ule" %2, %c47_i64 : i64
    %4 = llvm.select %3, %arg1, %arg2 : i1, i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.xor %arg0, %c43_i64 : i64
    %1 = llvm.sdiv %0, %c29_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.or %c-46_i64, %1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.xor %arg0, %arg2 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.or %c-9_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %4, %1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %arg1, %arg0 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "ult" %c30_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %c14_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.srem %0, %c-18_i64 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.xor %c-30_i64, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "ugt" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.udiv %c-5_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c-40_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg2, %arg1, %0 : i1, i64
    %4 = llvm.urem %arg1, %3 : i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.lshr %c34_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "ne" %1, %c-2_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %c-44_i64 : i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.or %arg0, %c-40_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.and %c-48_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ne" %2, %c0_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.ashr %c-17_i64, %c-17_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c43_i64 = arith.constant 43 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.lshr %c-39_i64, %arg0 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.lshr %c43_i64, %c-40_i64 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %c29_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %1, %arg0, %arg2 : i1, i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.select %arg2, %2, %0 : i1, i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c23_i64 = arith.constant 23 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %c23_i64, %c-11_i64 : i64
    %1 = llvm.srem %c-6_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %1, %c-12_i64 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.ashr %c-39_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg1 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.xor %c34_i64, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %c-37_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %arg2, %arg1 : i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c-14_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.or %arg0, %c-34_i64 : i64
    %1 = llvm.ashr %0, %c-1_i64 : i64
    %2 = llvm.lshr %1, %c24_i64 : i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.ashr %arg0, %c11_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %3, %0 : i64
    %5 = llvm.or %4, %1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.and %arg1, %c30_i64 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.icmp "ugt" %4, %c-15_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %c46_i64, %0 : i64
    %2 = llvm.select %arg1, %1, %arg0 : i1, i64
    %3 = llvm.udiv %c29_i64, %2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.urem %arg0, %c-25_i64 : i64
    %1 = llvm.xor %arg1, %arg0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ne" %arg2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %c-34_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.srem %3, %arg1 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.lshr %c-15_i64, %arg0 : i64
    %1 = llvm.sdiv %c9_i64, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.or %c50_i64, %2 : i64
    %4 = llvm.lshr %3, %1 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "uge" %c6_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.or %arg2, %arg0 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.ashr %c3_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %c-25_i64, %0 : i1, i64
    %2 = llvm.srem %c-41_i64, %arg1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.lshr %3, %c-48_i64 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.select %arg0, %c17_i64, %c13_i64 : i1, i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %4, %1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c16_i64 = arith.constant 16 : i64
    %c4_i64 = arith.constant 4 : i64
    %c7_i64 = arith.constant 7 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.udiv %c7_i64, %c36_i64 : i64
    %1 = llvm.icmp "sle" %c4_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %2, %c16_i64 : i64
    %4 = llvm.urem %c4_i64, %c22_i64 : i64
    %5 = llvm.ashr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %0, %c-10_i64 : i64
    %2 = llvm.icmp "slt" %arg1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %c32_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %c30_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sdiv %arg1, %c6_i64 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %2, %c17_i64 : i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.icmp "slt" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c-20_i64 = arith.constant -20 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.urem %c-20_i64, %c-43_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "uge" %c45_i64, %c40_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c40_i64 = arith.constant 40 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.srem %arg1, %c10_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %c40_i64, %1 : i64
    %3 = llvm.icmp "eq" %arg2, %c-50_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "slt" %c-12_i64, %c-2_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c-34_i64, %1 : i64
    %3 = llvm.urem %1, %c13_i64 : i64
    %4 = llvm.xor %3, %arg0 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %false = arith.constant false
    %c-19_i64 = arith.constant -19 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.srem %c-10_i64, %c43_i64 : i64
    %1 = llvm.sdiv %c-19_i64, %0 : i64
    %2 = llvm.select %false, %1, %c20_i64 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.srem %3, %0 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.and %arg1, %c37_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "sle" %3, %c7_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ult" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %c50_i64, %arg2 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %arg1, %c-12_i64 : i64
    %3 = llvm.srem %1, %c43_i64 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.select %false, %1, %0 : i1, i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.urem %1, %arg0 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.urem %c1_i64, %c46_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sgt" %c-12_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c9_i64 = arith.constant 9 : i64
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "sle" %c-30_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %arg1, %arg0 : i1, i64
    %3 = llvm.urem %c9_i64, %c5_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %arg0, %c20_i64, %arg1 : i1, i64
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.select %arg0, %c-9_i64, %0 : i1, i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %true = arith.constant true
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.udiv %arg0, %c18_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.sdiv %3, %c-9_i64 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.udiv %c-29_i64, %1 : i64
    %3 = llvm.icmp "eq" %arg1, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.icmp "ule" %c-26_i64, %c32_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "ne" %arg1, %c-31_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.udiv %3, %arg0 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.urem %c28_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ugt" %arg0, %c43_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %c49_i64, %1 : i64
    %3 = llvm.xor %arg0, %1 : i64
    %4 = llvm.srem %3, %1 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.xor %c34_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.select %arg1, %2, %3 : i1, i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.select %arg0, %1, %c-21_i64 : i1, i64
    %3 = llvm.srem %c-1_i64, %c-21_i64 : i64
    %4 = llvm.lshr %arg1, %3 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %c-28_i64 : i64
    %2 = llvm.urem %c-8_i64, %1 : i64
    %3 = llvm.srem %arg1, %arg2 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %0, %c-8_i64 : i64
    %2 = llvm.srem %c-7_i64, %c-34_i64 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.udiv %3, %c-7_i64 : i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.xor %c-23_i64, %arg2 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "sle" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "ugt" %arg0, %c44_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.or %1, %c-33_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %true = arith.constant true
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.urem %arg1, %c49_i64 : i64
    %3 = llvm.select %true, %arg2, %c41_i64 : i1, i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.udiv %arg1, %arg1 : i64
    %3 = llvm.urem %0, %0 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.select %1, %4, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %c-37_i64, %arg2 : i64
    %2 = llvm.icmp "ule" %c-23_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %arg0, %c-15_i64 : i64
    %1 = llvm.sdiv %0, %c-19_i64 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.select %3, %c-17_i64, %c-9_i64 : i1, i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c23_i64 = arith.constant 23 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.and %arg0, %c11_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.srem %c23_i64, %1 : i64
    %3 = llvm.xor %arg0, %arg1 : i64
    %4 = llvm.select %true, %3, %1 : i1, i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c17_i64 = arith.constant 17 : i64
    %c14_i64 = arith.constant 14 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.urem %0, %c9_i64 : i64
    %2 = llvm.and %c14_i64, %c17_i64 : i64
    %3 = llvm.and %2, %c-16_i64 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.select %4, %c32_i64, %c-19_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.urem %arg0, %c-47_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "eq" %1, %c38_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.and %arg2, %arg2 : i64
    %4 = llvm.ashr %3, %c-17_i64 : i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.udiv %c-24_i64, %0 : i64
    %2 = llvm.xor %c37_i64, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.udiv %c11_i64, %c-1_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c0_i64 = arith.constant 0 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.and %arg0, %c19_i64 : i64
    %1 = llvm.lshr %c0_i64, %0 : i64
    %2 = llvm.or %arg1, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.urem %c-31_i64, %1 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.or %c32_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.xor %0, %arg1 : i64
    %3 = llvm.and %1, %arg1 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.urem %c23_i64, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %c17_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.select %true, %c46_i64, %arg0 : i1, i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.udiv %c-4_i64, %3 : i64
    %5 = llvm.icmp "ule" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.select %arg0, %c-8_i64, %arg1 : i1, i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.sdiv %c42_i64, %1 : i64
    %3 = llvm.ashr %2, %c-24_i64 : i64
    %4 = llvm.udiv %2, %arg1 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c13_i64 = arith.constant 13 : i64
    %c15_i64 = arith.constant 15 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "eq" %c26_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %2, %c16_i64 : i64
    %4 = llvm.sdiv %c15_i64, %3 : i64
    %5 = llvm.and %c13_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c46_i64 = arith.constant 46 : i64
    %c11_i64 = arith.constant 11 : i64
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.select %true, %0, %c11_i64 : i1, i64
    %2 = llvm.select %arg2, %1, %c25_i64 : i1, i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.lshr %c46_i64, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c14_i64 = arith.constant 14 : i64
    %true = arith.constant true
    %c41_i64 = arith.constant 41 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.select %true, %c41_i64, %c37_i64 : i1, i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.or %c10_i64, %1 : i64
    %3 = llvm.icmp "sle" %c14_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c7_i64 = arith.constant 7 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %c10_i64, %c7_i64 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.sdiv %3, %c27_i64 : i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.srem %arg0, %c-10_i64 : i64
    %1 = llvm.ashr %0, %c25_i64 : i64
    %2 = llvm.lshr %0, %c-37_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "sle" %3, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %0, %c-10_i64 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.icmp "ule" %0, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %2, %0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %c3_i64 : i1, i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.udiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c32_i64 = arith.constant 32 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.xor %c32_i64, %c17_i64 : i64
    %1 = llvm.icmp "slt" %c14_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "slt" %3, %0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %c-44_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %c49_i64 = arith.constant 49 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "slt" %c49_i64, %c27_i64 : i64
    %1 = llvm.select %0, %arg0, %c-8_i64 : i1, i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.trunc %0 : i1 to i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "slt" %arg1, %c-28_i64 : i64
    %1 = llvm.select %0, %c-50_i64, %arg1 : i1, i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %arg0, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %arg0 : i64
    %3 = llvm.urem %arg2, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.lshr %c34_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.xor %arg0, %0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.srem %3, %c-38_i64 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.and %c14_i64, %c47_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %arg1, %arg0 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "slt" %arg1, %c-2_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "ule" %arg0, %c-31_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c-16_i64, %arg1 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "sge" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c15_i64 = arith.constant 15 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.srem %c15_i64, %c-46_i64 : i64
    %1 = llvm.select %arg0, %arg1, %c-40_i64 : i1, i64
    %2 = llvm.and %0, %c-32_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.or %c-26_i64, %arg0 : i64
    %1 = llvm.udiv %c14_i64, %0 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.select %3, %arg0, %arg2 : i1, i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c4_i64 = arith.constant 4 : i64
    %true = arith.constant true
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.xor %c-14_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.select %true, %c4_i64, %c-6_i64 : i1, i64
    %3 = llvm.ashr %0, %c-28_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.or %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c36_i64 = arith.constant 36 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.or %c25_i64, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.ashr %1, %c36_i64 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.lshr %3, %arg1 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.sdiv %0, %arg2 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %arg2, %c40_i64 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.urem %3, %c32_i64 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.urem %c35_i64, %c-23_i64 : i64
    %1 = llvm.srem %c43_i64, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ne" %2, %arg1 : i64
    %4 = llvm.srem %0, %2 : i64
    %5 = llvm.select %3, %4, %arg2 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %c38_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.select %2, %0, %c20_i64 : i1, i64
    %4 = llvm.ashr %arg0, %arg0 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.and %c-26_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %c37_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c2_i64 = arith.constant 2 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.xor %c35_i64, %arg0 : i64
    %1 = llvm.and %0, %c-12_i64 : i64
    %2 = llvm.udiv %arg1, %c-14_i64 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %c2_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c1_i64 = arith.constant 1 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.xor %c1_i64, %c40_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.srem %0, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.ashr %0, %c-43_i64 : i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.udiv %3, %arg0 : i64
    %5 = llvm.icmp "sgt" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "sle" %c44_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg1, %c39_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %c-29_i64, %3 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.lshr %c-31_i64, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.or %c37_i64, %2 : i64
    %4 = llvm.trunc %arg1 : i1 to i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %arg1, %arg0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c28_i64 = arith.constant 28 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.or %c35_i64, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.urem %c28_i64, %1 : i64
    %3 = llvm.xor %arg1, %c-33_i64 : i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %true = arith.constant true
    %c12_i64 = arith.constant 12 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.urem %c12_i64, %c0_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.select %4, %arg2, %c-29_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "eq" %c37_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.xor %c-6_i64, %arg1 : i64
    %1 = llvm.icmp "uge" %c25_i64, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.and %c13_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c-32_i64 : i64
    %2 = llvm.icmp "sge" %c-41_i64, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "sge" %c-9_i64, %c34_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %1, %c27_i64 : i64
    %3 = llvm.select %arg1, %arg2, %c37_i64 : i1, i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.and %c-44_i64, %arg0 : i64
    %1 = llvm.lshr %c-4_i64, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-42_i64 = arith.constant -42 : i64
    %c34_i64 = arith.constant 34 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.or %c2_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %c-5_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c34_i64, %c-42_i64 : i64
    %4 = llvm.ashr %3, %arg1 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %c21_i64 = arith.constant 21 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.lshr %c21_i64, %c19_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c19_i64 = arith.constant 19 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.sdiv %c-19_i64, %arg0 : i64
    %1 = llvm.srem %c-25_i64, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.xor %c19_i64, %3 : i64
    %5 = llvm.icmp "ult" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %c-29_i64, %arg1 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %c-10_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c31_i64 = arith.constant 31 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.urem %c-6_i64, %c34_i64 : i64
    %1 = llvm.xor %c-30_i64, %0 : i64
    %2 = llvm.ashr %c31_i64, %1 : i64
    %3 = llvm.or %arg0, %0 : i64
    %4 = llvm.urem %c-36_i64, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "slt" %c24_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %arg0, %arg1 : i64
    %4 = llvm.or %3, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %true = arith.constant true
    %c37_i64 = arith.constant 37 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.sdiv %c26_i64, %arg0 : i64
    %1 = llvm.ashr %c37_i64, %0 : i64
    %2 = llvm.select %true, %0, %arg1 : i1, i64
    %3 = llvm.xor %c7_i64, %0 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c39_i64 = arith.constant 39 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.ashr %c39_i64, %c-15_i64 : i64
    %1 = llvm.or %arg0, %c-17_i64 : i64
    %2 = llvm.lshr %arg1, %c-11_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %c-13_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %3, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %c-9_i64, %c-27_i64 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %2, %c35_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c40_i64 = arith.constant 40 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.xor %c40_i64, %c-47_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.icmp "ugt" %c-25_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %c8_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %3, %arg0 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-12_i64 = arith.constant -12 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.xor %c-22_i64, %1 : i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.ashr %c-12_i64, %arg2 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %c-41_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.and %c-9_i64, %3 : i64
    %5 = llvm.or %c-7_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.xor %c29_i64, %0 : i64
    %3 = llvm.select %1, %2, %2 : i1, i64
    %4 = llvm.sdiv %c-19_i64, %arg2 : i64
    %5 = llvm.udiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.udiv %c12_i64, %arg1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.icmp "uge" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.udiv %3, %c-18_i64 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.ashr %c-7_i64, %c22_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.select %2, %arg0, %arg1 : i1, i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %2 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %c1_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %false = arith.constant false
    %c40_i64 = arith.constant 40 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "ne" %c40_i64, %c6_i64 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.srem %c49_i64, %1 : i64
    %3 = llvm.select %false, %arg0, %2 : i1, i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.select %0, %4, %arg1 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.ashr %c37_i64, %c41_i64 : i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.select %arg2, %3, %3 : i1, i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %c-10_i64, %c-41_i64 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.icmp "sge" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.srem %c21_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.ashr %c19_i64, %1 : i64
    %5 = llvm.srem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c4_i64 : i64
    %2 = llvm.and %c47_i64, %1 : i64
    %3 = llvm.or %0, %arg1 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "slt" %c-38_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %c18_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %c-5_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.ashr %c-39_i64, %2 : i64
    %4 = llvm.and %arg1, %3 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %false = arith.constant false
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %arg0, %c32_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.select %false, %3, %c38_i64 : i1, i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c-19_i64 : i64
    %2 = llvm.icmp "slt" %c-21_i64, %1 : i64
    %3 = llvm.select %2, %1, %arg1 : i1, i64
    %4 = llvm.udiv %c48_i64, %arg0 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.icmp "ne" %c-22_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %arg1, %c3_i64 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.xor %c45_i64, %arg2 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %true = arith.constant true
    %c-27_i64 = arith.constant -27 : i64
    %c19_i64 = arith.constant 19 : i64
    %false = arith.constant false
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.select %false, %c50_i64, %arg1 : i1, i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    %2 = llvm.or %1, %c19_i64 : i64
    %3 = llvm.select %true, %c-49_i64, %arg1 : i1, i64
    %4 = llvm.sdiv %c-27_i64, %3 : i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %c15_i64, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.srem %3, %1 : i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.xor %1, %c-17_i64 : i64
    %3 = llvm.icmp "ule" %c21_i64, %c50_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %false = arith.constant false
    %c21_i64 = arith.constant 21 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.lshr %c3_i64, %arg0 : i64
    %1 = llvm.select %false, %0, %arg1 : i1, i64
    %2 = llvm.sdiv %1, %c22_i64 : i64
    %3 = llvm.sdiv %c21_i64, %2 : i64
    %4 = llvm.udiv %3, %2 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.urem %arg0, %c-45_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.sdiv %3, %arg1 : i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c24_i64 = arith.constant 24 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.urem %arg0, %c-9_i64 : i64
    %1 = llvm.sdiv %0, %c24_i64 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.urem %c-19_i64, %2 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "ule" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.or %c39_i64, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.udiv %0, %c-45_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.sdiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.ashr %arg2, %arg2 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.srem %arg0, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.or %arg1, %c38_i64 : i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "eq" %c-17_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.select %2, %arg1, %arg1 : i1, i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %c-11_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %c-38_i64 : i64
    %2 = llvm.xor %c-16_i64, %0 : i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.sdiv %3, %0 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c9_i64 = arith.constant 9 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "sle" %c-18_i64, %c-22_i64 : i64
    %1 = llvm.and %c9_i64, %arg0 : i64
    %2 = llvm.urem %1, %c-50_i64 : i64
    %3 = llvm.trunc %0 : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.select %0, %c30_i64, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.lshr %c-49_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c-48_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %1 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.srem %4, %c22_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ult" %c4_i64, %c24_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %arg2, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c34_i64 = arith.constant 34 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %0, %c34_i64 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.xor %c15_i64, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c13_i64 = arith.constant 13 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "ugt" %c13_i64, %c8_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.sdiv %1, %c8_i64 : i64
    %4 = llvm.xor %3, %c-45_i64 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %true = arith.constant true
    %c-28_i64 = arith.constant -28 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "ugt" %c1_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sle" %c-28_i64, %1 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.and %3, %c-33_i64 : i64
    %5 = llvm.select %2, %1, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.xor %c30_i64, %arg0 : i64
    %1 = llvm.udiv %c-20_i64, %0 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.srem %arg0, %c12_i64 : i64
    %1 = llvm.or %0, %c-17_i64 : i64
    %2 = llvm.ashr %c-11_i64, %0 : i64
    %3 = llvm.ashr %c-14_i64, %c6_i64 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %c11_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %c48_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %3, %arg2 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c2_i64 = arith.constant 2 : i64
    %false = arith.constant false
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.sdiv %arg0, %c1_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.and %c13_i64, %1 : i64
    %4 = llvm.select %false, %c2_i64, %3 : i1, i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "ugt" %c26_i64, %c-37_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "slt" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %c-35_i64, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %c-2_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %c-39_i64 : i64
    %2 = llvm.urem %arg2, %c-35_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.sdiv %3, %c-40_i64 : i64
    %5 = llvm.sdiv %c9_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "eq" %c-27_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "eq" %c-15_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c-33_i64 : i1, i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.udiv %c-21_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg0, %arg2 : i64
    %4 = llvm.and %3, %0 : i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.ashr %c18_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.ashr %c9_i64, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.or %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.urem %arg1, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.xor %c-19_i64, %arg0 : i64
    %1 = llvm.and %arg1, %arg1 : i64
    %2 = llvm.sdiv %0, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.udiv %3, %1 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.or %arg2, %arg2 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sle" %c45_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %4, %c9_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c2_i64 = arith.constant 2 : i64
    %c42_i64 = arith.constant 42 : i64
    %false = arith.constant false
    %true = arith.constant true
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.select %true, %c16_i64, %arg0 : i1, i64
    %1 = llvm.icmp "ugt" %0, %c-32_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %false, %2, %c48_i64 : i1, i64
    %4 = llvm.urem %c42_i64, %3 : i64
    %5 = llvm.icmp "slt" %c2_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c3_i64 : i64
    %2 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "ult" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %0, %c7_i64 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.or %c39_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %2 : i64
    %4 = llvm.and %c-23_i64, %0 : i64
    %5 = llvm.select %3, %4, %arg2 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.and %c-13_i64, %0 : i64
    %2 = llvm.lshr %1, %c5_i64 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.select %3, %2, %c21_i64 : i1, i64
    %5 = llvm.srem %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %false = arith.constant false
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.select %false, %arg0, %c-15_i64 : i1, i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %0, %c29_i64 : i64
    %4 = llvm.srem %3, %arg0 : i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.urem %arg0, %c22_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.sdiv %1, %c-3_i64 : i64
    %3 = llvm.icmp "ugt" %2, %c-28_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c28_i64 = arith.constant 28 : i64
    %c39_i64 = arith.constant 39 : i64
    %c46_i64 = arith.constant 46 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.ashr %c46_i64, %c22_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.or %1, %c39_i64 : i64
    %3 = llvm.icmp "sle" %c28_i64, %c18_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %arg2, %2 : i64
    %4 = llvm.srem %3, %arg1 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %true = arith.constant true
    %c27_i64 = arith.constant 27 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.select %arg0, %c27_i64, %c-43_i64 : i1, i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %4, %2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.srem %c18_i64, %c42_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c-21_i64 = arith.constant -21 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ne" %c50_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %c-21_i64, %c26_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c18_i64, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.and %3, %c32_i64 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.xor %c32_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ugt" %c23_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-11_i64 = arith.constant -11 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.xor %c-11_i64, %c-48_i64 : i64
    %1 = llvm.sdiv %c-12_i64, %0 : i64
    %2 = llvm.or %1, %c-39_i64 : i64
    %3 = llvm.sdiv %1, %1 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c31_i64 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.select %arg1, %c-1_i64, %arg2 : i1, i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "ne" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "sge" %c18_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %3, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.ashr %3, %c18_i64 : i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %false, %arg2, %c50_i64 : i1, i64
    %4 = llvm.or %3, %arg0 : i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.udiv %c-43_i64, %c14_i64 : i64
    %1 = llvm.udiv %c21_i64, %0 : i64
    %2 = llvm.and %c14_i64, %1 : i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %arg1, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.urem %4, %3 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c31_i64 = arith.constant 31 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "ult" %c31_i64, %c-9_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c-32_i64, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    %4 = llvm.select %3, %2, %arg0 : i1, i64
    %5 = llvm.urem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %arg1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.select %3, %c22_i64, %arg2 : i1, i64
    %5 = llvm.icmp "sgt" %c-13_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c21_i64 = arith.constant 21 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.srem %c45_i64, %arg0 : i64
    %1 = llvm.ashr %c44_i64, %arg1 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "sle" %c21_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c19_i64 = arith.constant 19 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c12_i64, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %2, %c19_i64 : i64
    %4 = llvm.or %3, %c-21_i64 : i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.urem %3, %c-45_i64 : i64
    %5 = llvm.srem %4, %c-20_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %c-39_i64, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.srem %4, %1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.xor %arg0, %arg0 : i64
    %3 = llvm.select %arg1, %arg0, %2 : i1, i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c27_i64 = arith.constant 27 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.xor %c27_i64, %c-19_i64 : i64
    %1 = llvm.select %true, %0, %arg1 : i1, i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.select %true, %arg1, %arg2 : i1, i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c25_i64 = arith.constant 25 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.udiv %c-13_i64, %c-3_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.and %3, %c25_i64 : i64
    %5 = llvm.icmp "ugt" %4, %c29_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.sdiv %c-8_i64, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.sdiv %1, %arg2 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.or %3, %arg2 : i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.urem %c-44_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.srem %c-14_i64, %0 : i64
    %4 = llvm.or %3, %c-25_i64 : i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.sdiv %arg0, %c13_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "ule" %c-25_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.xor %c-9_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.urem %arg2, %c-9_i64 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg2, %c-9_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "ne" %3, %arg2 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.udiv %arg0, %c38_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.sdiv %c-17_i64, %1 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "sle" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.xor %arg0, %c37_i64 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.srem %3, %arg1 : i64
    %5 = llvm.icmp "ult" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c50_i64 = arith.constant 50 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.urem %c15_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.xor %1, %c50_i64 : i64
    %3 = llvm.srem %c-37_i64, %c15_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.ashr %4, %arg0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.ashr %c-25_i64, %c23_i64 : i64
    %1 = llvm.ashr %c17_i64, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %2, %c9_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.and %c-40_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %c-39_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %arg1, %0 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c-46_i64 = arith.constant -46 : i64
    %true = arith.constant true
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.select %true, %arg0, %1 : i1, i64
    %3 = llvm.icmp "uge" %c-46_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %4, %c29_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-19_i64 = arith.constant -19 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.udiv %c-19_i64, %c34_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "sge" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %c11_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %4, %c-45_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %false = arith.constant false
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %c18_i64, %0 : i64
    %2 = llvm.select %false, %1, %arg0 : i1, i64
    %3 = llvm.or %c-44_i64, %2 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "uge" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.xor %arg0, %arg2 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %arg2, %c-27_i64 : i64
    %1 = llvm.select %arg1, %arg2, %0 : i1, i64
    %2 = llvm.lshr %c-5_i64, %1 : i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.lshr %c5_i64, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.srem %3, %arg0 : i64
    %5 = llvm.icmp "slt" %c-50_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "sgt" %arg1, %c13_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "ugt" %4, %c-28_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.srem %c13_i64, %c11_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.srem %2, %arg1 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "sge" %arg0, %c-11_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %c9_i64, %1 : i64
    %3 = llvm.sdiv %arg1, %arg1 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.or %c10_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "sle" %3, %arg1 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c-8_i64 = arith.constant -8 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.xor %c-38_i64, %c-33_i64 : i64
    %1 = llvm.xor %c-9_i64, %0 : i64
    %2 = llvm.icmp "uge" %1, %c-8_i64 : i64
    %3 = llvm.select %2, %arg0, %arg1 : i1, i64
    %4 = llvm.icmp "uge" %3, %c49_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "sle" %arg0, %c-34_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "ne" %c18_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.sdiv %arg0, %c8_i64 : i64
    %1 = llvm.icmp "sge" %c-3_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.xor %arg1, %arg2 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c-39_i64 = arith.constant -39 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.ashr %c-50_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c-39_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %c-35_i64, %2 : i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-17_i64 = arith.constant -17 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.urem %c-44_i64, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.udiv %0, %arg2 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.or %3, %c-17_i64 : i64
    %5 = llvm.icmp "sge" %4, %c-9_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "slt" %c5_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %c-20_i64, %c43_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %3, %arg0 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-7_i64 = arith.constant -7 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg1, %arg1 : i1, i64
    %1 = llvm.xor %arg1, %c-7_i64 : i64
    %2 = llvm.udiv %1, %c-18_i64 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.urem %1, %c22_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.or %2, %c14_i64 : i64
    %4 = llvm.srem %c-23_i64, %arg1 : i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.urem %c-29_i64, %0 : i64
    %2 = llvm.xor %c44_i64, %arg2 : i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "ule" %c1_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "uge" %c49_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "ule" %arg0, %c10_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.select %arg1, %1, %c22_i64 : i1, i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %c22_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.urem %arg2, %c14_i64 : i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    %5 = llvm.sdiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "eq" %c21_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %c-27_i64, %1 : i64
    %3 = llvm.udiv %arg1, %1 : i64
    %4 = llvm.ashr %3, %arg0 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c39_i64 = arith.constant 39 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.select %arg0, %c-28_i64, %c31_i64 : i1, i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.xor %c39_i64, %2 : i64
    %4 = llvm.or %arg1, %c3_i64 : i64
    %5 = llvm.srem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %c-41_i64, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.icmp "ne" %1, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %false = arith.constant false
    %c8_i64 = arith.constant 8 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.select %false, %c8_i64, %c25_i64 : i1, i64
    %1 = llvm.urem %0, %c-8_i64 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.srem %c-33_i64, %c-13_i64 : i64
    %1 = llvm.lshr %c-29_i64, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "sgt" %1, %1 : i64
    %4 = llvm.select %3, %1, %c-37_i64 : i1, i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-16_i64 = arith.constant -16 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "uge" %0, %c-16_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.select %arg1, %arg0, %1 : i1, i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "ule" %c-48_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %true = arith.constant true
    %c-23_i64 = arith.constant -23 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.srem %c-23_i64, %c30_i64 : i64
    %1 = llvm.select %true, %arg0, %arg1 : i1, i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %c20_i64, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.lshr %arg2, %3 : i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %c-47_i64, %0 : i64
    %2 = llvm.sdiv %c30_i64, %0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %4, %arg1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c-27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.sdiv %c18_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg2, %c-27_i64 : i1, i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.select %true, %0, %2 : i1, i64
    %4 = llvm.lshr %c-18_i64, %1 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.srem %c4_i64, %c-2_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ugt" %1, %arg0 : i64
    %4 = llvm.select %3, %arg1, %1 : i1, i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "ule" %arg1, %c-45_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %arg2, %c13_i64, %3 : i1, i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.sdiv %arg1, %c45_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %c-1_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.ashr %arg0, %arg1 : i64
    %3 = llvm.icmp "sgt" %2, %c0_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.and %arg0, %c-44_i64 : i64
    %1 = llvm.icmp "slt" %c50_i64, %arg0 : i64
    %2 = llvm.udiv %arg1, %c-17_i64 : i64
    %3 = llvm.select %1, %arg0, %2 : i1, i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %c47_i64 = arith.constant 47 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %c47_i64, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.select %2, %0, %1 : i1, i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sdiv %0, %c-27_i64 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c0_i64 = arith.constant 0 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.and %c5_i64, %arg0 : i64
    %1 = llvm.and %c0_i64, %0 : i64
    %2 = llvm.xor %c14_i64, %arg1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.srem %c50_i64, %0 : i64
    %2 = llvm.ashr %0, %arg0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.udiv %c11_i64, %arg2 : i64
    %1 = llvm.urem %c26_i64, %0 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.ashr %c36_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg2 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.urem %c5_i64, %3 : i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.select %4, %c-35_i64, %1 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c-8_i64 = arith.constant -8 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %c-8_i64, %0 : i64
    %2 = llvm.udiv %1, %c9_i64 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "sle" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %4, %0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %c-21_i64, %3 : i64
    %5 = llvm.ashr %4, %arg1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %c25_i64, %0 : i64
    %2 = llvm.sdiv %arg0, %arg0 : i64
    %3 = llvm.select %arg1, %arg0, %1 : i1, i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.lshr %c47_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %c-34_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c50_i64 = arith.constant 50 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.lshr %c50_i64, %c15_i64 : i64
    %1 = llvm.urem %arg2, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.lshr %4, %c33_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.urem %arg1, %c10_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.udiv %arg1, %0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.ashr %c-13_i64, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.urem %arg1, %arg0 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "ugt" %c-5_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.or %arg0, %arg0 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.sdiv %c-22_i64, %c-35_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.select %arg1, %arg0, %0 : i1, i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.srem %c-47_i64, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.icmp "ne" %4, %c-31_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.udiv %c4_i64, %0 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-15_i64 = arith.constant -15 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c-16_i64 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.udiv %c-15_i64, %0 : i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.urem %arg0, %c11_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %2 = llvm.select %1, %c-24_i64, %c-16_i64 : i1, i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.udiv %c-28_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c4_i64 = arith.constant 4 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.srem %arg0, %c22_i64 : i64
    %1 = llvm.or %c4_i64, %0 : i64
    %2 = llvm.icmp "slt" %c-27_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %arg0, %arg0 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %0, %c24_i64 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.select %true, %c40_i64, %0 : i1, i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.sdiv %arg1, %arg2 : i64
    %5 = llvm.select %2, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %c14_i64, %arg1 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.select %2, %arg2, %arg2 : i1, i64
    %4 = llvm.icmp "sgt" %3, %c-16_i64 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.select %arg0, %arg1, %c37_i64 : i1, i64
    %1 = llvm.lshr %0, %c44_i64 : i64
    %2 = llvm.udiv %arg2, %1 : i64
    %3 = llvm.icmp "slt" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.sdiv %0, %0 : i64
    %4 = llvm.udiv %c36_i64, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.icmp "slt" %c-38_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.xor %3, %arg2 : i64
    %5 = llvm.srem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.ashr %c-38_i64, %c-4_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %c-13_i64, %arg0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %c-47_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.icmp "sle" %c-22_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.sdiv %0, %c-22_i64 : i64
    %3 = llvm.icmp "sle" %c-49_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    %5 = llvm.select %4, %c22_i64, %c6_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "ule" %c-9_i64, %c8_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %c50_i64, %1 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "sge" %c-29_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.and %arg0, %c0_i64 : i64
    %1 = llvm.xor %arg1, %arg1 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.lshr %c-6_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.or %c-1_i64, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.icmp "uge" %arg1, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.select %2, %arg0, %arg1 : i1, i64
    %4 = llvm.sdiv %c-24_i64, %arg1 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %c-26_i64, %c47_i64 : i1, i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ugt" %c-24_i64, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %c28_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.xor %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.urem %arg1, %arg0 : i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.select %false, %arg0, %arg1 : i1, i64
    %2 = llvm.select %false, %1, %arg0 : i1, i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.select %3, %arg2, %2 : i1, i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c11_i64 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.and %c41_i64, %arg1 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.ashr %c-24_i64, %arg2 : i64
    %3 = llvm.urem %arg0, %0 : i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    %5 = llvm.urem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.icmp "sgt" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c34_i64 = arith.constant 34 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %c14_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.or %3, %c34_i64 : i64
    %5 = llvm.udiv %4, %c46_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.urem %arg2, %c27_i64 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.select %3, %c26_i64, %2 : i1, i64
    %5 = llvm.or %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-25_i64 = arith.constant -25 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %c-29_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %4, %c-25_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c49_i64 = arith.constant 49 : i64
    %c33_i64 = arith.constant 33 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.xor %c33_i64, %c-26_i64 : i64
    %1 = llvm.icmp "eq" %c49_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %0, %0 : i64
    %4 = llvm.and %c-18_i64, %3 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %c14_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %c-4_i64 : i64
    %2 = llvm.icmp "sgt" %arg2, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %3, %c-2_i64 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.xor %arg1, %c-50_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %true = arith.constant true
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.xor %arg2, %arg1 : i64
    %2 = llvm.srem %1, %c-7_i64 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.select %true, %0, %c-15_i64 : i1, i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-10_i64 = arith.constant -10 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %c27_i64, %c-10_i64 : i1, i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "ule" %arg0, %c0_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "ult" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %true = arith.constant true
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.and %c4_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %true, %arg0, %c-36_i64 : i1, i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.udiv %c-29_i64, %c-20_i64 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c31_i64 = arith.constant 31 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.srem %c44_i64, %arg1 : i64
    %1 = llvm.icmp "ult" %arg1, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %arg0, %0, %2 : i1, i64
    %4 = llvm.sdiv %c31_i64, %c39_i64 : i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-11_i64 = arith.constant -11 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.udiv %c-11_i64, %c0_i64 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.icmp "sgt" %c-47_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c28_i64 = arith.constant 28 : i64
    %c-43_i64 = arith.constant -43 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sdiv %c-43_i64, %c44_i64 : i64
    %1 = llvm.udiv %arg0, %c28_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.and %arg1, %c16_i64 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "uge" %c-3_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.udiv %c-49_i64, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "sge" %arg1, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.ashr %c-40_i64, %arg0 : i64
    %1 = llvm.or %arg0, %c-13_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.or %c-22_i64, %2 : i64
    %4 = llvm.udiv %arg0, %2 : i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %3, %1 : i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c18_i64 = arith.constant 18 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.ashr %c18_i64, %c33_i64 : i64
    %1 = llvm.xor %c28_i64, %0 : i64
    %2 = llvm.or %0, %0 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "eq" %c11_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %arg2, %arg2 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.ashr %arg2, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.ashr %c28_i64, %arg1 : i64
    %1 = llvm.icmp "sge" %arg2, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %arg1, %c32_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.select %arg0, %0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %c47_i64 : i64
    %2 = llvm.srem %arg1, %arg0 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.ashr %3, %arg0 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "uge" %1, %c-2_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %2, %c11_i64, %arg1 : i1, i64
    %5 = llvm.ashr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-35_i64 = arith.constant -35 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "ult" %arg1, %arg2 : i64
    %1 = llvm.select %0, %c46_i64, %arg2 : i1, i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.srem %arg0, %arg1 : i64
    %4 = llvm.sdiv %3, %c-35_i64 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %arg0, %arg2 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.select %arg1, %2, %c49_i64 : i1, i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %c8_i64 = arith.constant 8 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %c50_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %c8_i64, %2 : i64
    %4 = llvm.select %arg2, %c-34_i64, %0 : i1, i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.srem %c-25_i64, %c-23_i64 : i64
    %1 = llvm.icmp "ugt" %c17_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "eq" %c-28_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-14_i64 = arith.constant -14 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.urem %1, %c9_i64 : i64
    %3 = llvm.or %2, %c-14_i64 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "eq" %arg0, %c-33_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.sdiv %2, %c30_i64 : i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.udiv %c-1_i64, %c-12_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.udiv %arg1, %arg2 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-8_i64 = arith.constant -8 : i64
    %true = arith.constant true
    %c46_i64 = arith.constant 46 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.and %c46_i64, %c22_i64 : i64
    %1 = llvm.select %true, %c-8_i64, %0 : i1, i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.or %0, %arg0 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "ne" %c44_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.ashr %4, %2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c18_i64 = arith.constant 18 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.and %c14_i64, %arg0 : i64
    %1 = llvm.srem %c18_i64, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.ashr %c-18_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.icmp "sge" %c-24_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c49_i64 = arith.constant 49 : i64
    %c42_i64 = arith.constant 42 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.sdiv %c-20_i64, %arg0 : i64
    %1 = llvm.or %c42_i64, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "ugt" %c49_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-39_i64 = arith.constant -39 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.lshr %c23_i64, %1 : i64
    %3 = llvm.udiv %2, %c-39_i64 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.and %4, %2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.srem %c-6_i64, %c-5_i64 : i64
    %1 = llvm.srem %0, %c3_i64 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "uge" %arg1, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c3_i64 = arith.constant 3 : i64
    %false = arith.constant false
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %c-34_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.urem %c3_i64, %c-13_i64 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %3, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.xor %arg0, %c-50_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %arg1 : i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c17_i64 = arith.constant 17 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c25_i64 = arith.constant 25 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "uge" %c8_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c25_i64, %1 : i64
    %3 = llvm.icmp "ule" %c-15_i64, %arg1 : i64
    %4 = llvm.select %3, %c17_i64, %c0_i64 : i1, i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %c8_i64 = arith.constant 8 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.or %c34_i64, %arg0 : i64
    %1 = llvm.udiv %c-24_i64, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %c-50_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "ule" %c8_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %c21_i64, %0 : i64
    %2 = llvm.sdiv %c-33_i64, %arg1 : i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %false = arith.constant false
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.select %false, %c49_i64, %0 : i1, i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.ashr %c26_i64, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.ashr %3, %3 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c36_i64 = arith.constant 36 : i64
    %c45_i64 = arith.constant 45 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.lshr %c-39_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.xor %arg2, %c36_i64 : i64
    %3 = llvm.lshr %arg2, %c24_i64 : i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    %5 = llvm.icmp "uge" %c45_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c4_i64 = arith.constant 4 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "eq" %c4_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %c-5_i64, %2 : i64
    %4 = llvm.srem %arg0, %arg1 : i64
    %5 = llvm.select %3, %4, %arg2 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %c28_i64 : i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.srem %3, %arg0 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.urem %arg0, %c-23_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.and %c-1_i64, %2 : i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.and %c25_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg0 : i1, i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.sdiv %c32_i64, %3 : i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "ne" %c-26_i64, %c44_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.sdiv %c-9_i64, %3 : i64
    %5 = llvm.icmp "ne" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %false = arith.constant false
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %4, %c-12_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c3_i64 = arith.constant 3 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.lshr %c3_i64, %c16_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.select %1, %c-23_i64, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c29_i64 = arith.constant 29 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.urem %c29_i64, %c-37_i64 : i64
    %1 = llvm.udiv %0, %c31_i64 : i64
    %2 = llvm.icmp "sgt" %c-13_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %c-46_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c19_i64 = arith.constant 19 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.select %1, %c-9_i64, %c19_i64 : i1, i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "eq" %arg0, %c30_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg1, %arg2 : i64
    %3 = llvm.icmp "ult" %c34_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.and %c49_i64, %arg2 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.or %arg2, %c27_i64 : i64
    %1 = llvm.sdiv %0, %c49_i64 : i64
    %2 = llvm.select %arg1, %0, %1 : i1, i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.and %3, %2 : i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.sdiv %c13_i64, %c32_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.sdiv %0, %0 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.lshr %3, %arg1 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c34_i64 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.srem %arg2, %arg2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %c-50_i64 = arith.constant -50 : i64
    %c-14_i64 = arith.constant -14 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ule" %c-14_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %c-21_i64, %arg0 : i64
    %4 = llvm.xor %c-50_i64, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %c-44_i64, %arg0 : i64
    %2 = llvm.icmp "sge" %c33_i64, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c34_i64 = arith.constant 34 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.udiv %c34_i64, %c20_i64 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %2, %arg1 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    %5 = llvm.select %4, %2, %c49_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.udiv %arg0, %c-16_i64 : i64
    %1 = llvm.ashr %0, %c-43_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %3, %3 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.sdiv %arg2, %2 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.srem %arg0, %c-13_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %true = arith.constant true
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.select %true, %c-12_i64, %arg2 : i1, i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.sdiv %c49_i64, %arg0 : i64
    %1 = llvm.xor %0, %c-11_i64 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.udiv %0, %0 : i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %arg2, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.select %2, %c47_i64, %arg2 : i1, i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.icmp "ugt" %c-29_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "sle" %arg2, %c-26_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.urem %3, %c-25_i64 : i64
    %5 = llvm.udiv %4, %c0_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg1, %c-41_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.srem %c5_i64, %3 : i64
    %5 = llvm.xor %c-46_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-8_i64 = arith.constant -8 : i64
    %c11_i64 = arith.constant 11 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ule" %c11_i64, %c-8_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.sdiv %3, %arg0 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c28_i64 = arith.constant 28 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.icmp "ule" %c28_i64, %c32_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %c-44_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.trunc %arg0 : i1 to i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    %4 = llvm.select %3, %c49_i64, %arg0 : i1, i64
    %5 = llvm.urem %c-23_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %c-4_i64 = arith.constant -4 : i64
    %c7_i64 = arith.constant 7 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "ugt" %c7_i64, %c-42_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg0, %c-24_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %c-4_i64, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %c-9_i64, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.icmp "ult" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.xor %arg0, %c36_i64 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.ashr %0, %arg1 : i64
    %4 = llvm.and %3, %arg2 : i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.urem %arg2, %3 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c39_i64 = arith.constant 39 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.xor %c-9_i64, %c20_i64 : i64
    %1 = llvm.ashr %0, %c38_i64 : i64
    %2 = llvm.sdiv %c39_i64, %1 : i64
    %3 = llvm.xor %1, %arg0 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %arg2 : i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    %3 = llvm.xor %arg1, %1 : i64
    %4 = llvm.ashr %c-3_i64, %3 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c35_i64 = arith.constant 35 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.or %c49_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %arg1, %c35_i64 : i64
    %4 = llvm.select %3, %c17_i64, %arg0 : i1, i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %c-42_i64 = arith.constant -42 : i64
    %c10_i64 = arith.constant 10 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.udiv %c10_i64, %c30_i64 : i64
    %1 = llvm.srem %c-42_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c12_i64 = arith.constant 12 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %0, %c15_i64 : i64
    %2 = llvm.and %c12_i64, %1 : i64
    %3 = llvm.icmp "ule" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.urem %0, %c9_i64 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.select %2, %1, %c0_i64 : i1, i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.udiv %arg1, %c-48_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.srem %c22_i64, %arg1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.icmp "sgt" %c47_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.select %arg1, %arg2, %arg2 : i1, i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %c-8_i64, %c-5_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c4_i64 = arith.constant 4 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.xor %c4_i64, %c-39_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "ugt" %c15_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.ashr %c-10_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %c-1_i64 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "uge" %arg0, %c17_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %3, %3 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.or %arg0, %c19_i64 : i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.select %2, %4, %1 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c-3_i64 = arith.constant -3 : i64
    %c44_i64 = arith.constant 44 : i64
    %false = arith.constant false
    %c43_i64 = arith.constant 43 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.and %c43_i64, %c35_i64 : i64
    %1 = llvm.urem %arg0, %c-3_i64 : i64
    %2 = llvm.select %false, %c44_i64, %1 : i1, i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.urem %3, %c12_i64 : i64
    %5 = llvm.urem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "uge" %c10_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %arg1 : i64
    %3 = llvm.icmp "ugt" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.udiv %arg0, %c48_i64 : i64
    %2 = llvm.urem %arg2, %c44_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.icmp "ne" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %c-14_i64, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.urem %c-26_i64, %arg2 : i64
    %1 = llvm.udiv %0, %c-20_i64 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    %5 = llvm.select %4, %1, %arg0 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.sdiv %c-29_i64, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.and %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.udiv %arg0, %c31_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.ashr %arg1, %arg2 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c18_i64 = arith.constant 18 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.srem %arg0, %c-31_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %c18_i64, %1 : i64
    %3 = llvm.icmp "sgt" %c-15_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.sdiv %arg0, %c-45_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ugt" %c-40_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.icmp "sgt" %arg1, %c9_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-36_i64 = arith.constant -36 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.udiv %c-5_i64, %c2_i64 : i64
    %1 = llvm.lshr %c-9_i64, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.ashr %3, %c-36_i64 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %0, %c3_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.lshr %0, %0 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %c-5_i64, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.udiv %c-19_i64, %c43_i64 : i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.select %arg0, %c42_i64, %arg1 : i1, i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.srem %arg1, %arg1 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %0, %c-13_i64 : i64
    %2 = llvm.xor %c42_i64, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.or %0, %arg1 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.and %4, %arg1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.sdiv %arg0, %c-34_i64 : i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %arg2, %c-6_i64 : i64
    %4 = llvm.urem %3, %c7_i64 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c-27_i64 = arith.constant -27 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.xor %c-27_i64, %2 : i64
    %4 = llvm.udiv %arg1, %c6_i64 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %arg1, %c30_i64 : i64
    %2 = llvm.sdiv %c8_i64, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.ashr %c46_i64, %arg1 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.ashr %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c-20_i64 = arith.constant -20 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.xor %c-29_i64, %c-32_i64 : i64
    %1 = llvm.sdiv %c6_i64, %0 : i64
    %2 = llvm.xor %c-20_i64, %arg0 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.xor %c-27_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.ashr %0, %arg0 : i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c4_i64 = arith.constant 4 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %c32_i64 : i64
    %2 = llvm.trunc %arg0 : i1 to i64
    %3 = llvm.icmp "sle" %2, %c35_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.select %1, %c4_i64, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.xor %c-23_i64, %c18_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.trunc %arg1 : i1 to i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg0 : i64
    %2 = llvm.sdiv %arg1, %arg0 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %c-48_i64 = arith.constant -48 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.and %c-48_i64, %2 : i64
    %4 = llvm.xor %3, %c-11_i64 : i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c-31_i64 = arith.constant -31 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %c29_i64, %c-31_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.srem %4, %c49_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "ne" %c21_i64, %arg2 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.icmp "slt" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.and %c-18_i64, %arg0 : i64
    %1 = llvm.xor %c-46_i64, %0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.select %false, %0, %arg1 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.urem %3, %3 : i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.udiv %c42_i64, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %arg0, %c-17_i64 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %true = arith.constant true
    %c-46_i64 = arith.constant -46 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.sdiv %c-46_i64, %c-5_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.lshr %c8_i64, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.urem %c-27_i64, %c-3_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.urem %c-43_i64, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.trunc %arg0 : i1 to i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.or %0, %c-3_i64 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %c47_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c-49_i64 : i64
    %2 = llvm.select %true, %arg0, %arg1 : i1, i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.urem %arg0, %c-22_i64 : i64
    %1 = llvm.lshr %c-38_i64, %0 : i64
    %2 = llvm.icmp "sle" %arg1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.select %4, %arg2, %0 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.udiv %c-15_i64, %0 : i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    %4 = llvm.select %3, %arg0, %1 : i1, i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %c-47_i64 : i64
    %2 = llvm.srem %arg2, %c34_i64 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c22_i64 = arith.constant 22 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "uge" %arg0, %c3_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.urem %c22_i64, %c33_i64 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.lshr %c44_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.and %arg1, %0 : i64
    %3 = llvm.urem %c32_i64, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "uge" %c-14_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c23_i64 = arith.constant 23 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %c37_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c23_i64 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.icmp "slt" %arg2, %c44_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-33_i64 = arith.constant -33 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.sdiv %1, %c22_i64 : i64
    %3 = llvm.icmp "sle" %2, %c-33_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.and %c-44_i64, %c-35_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "sgt" %c-33_i64, %c-46_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "slt" %4, %c-28_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.sdiv %arg0, %c40_i64 : i64
    %1 = llvm.udiv %c-48_i64, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %4, %c9_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %c-49_i64, %0 : i64
    %2 = llvm.or %c37_i64, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "ult" %arg0, %c13_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c-25_i64, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %c-50_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c9_i64 = arith.constant 9 : i64
    %c-13_i64 = arith.constant -13 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.udiv %c-32_i64, %c30_i64 : i64
    %1 = llvm.ashr %c-13_i64, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.xor %3, %arg0 : i64
    %5 = llvm.icmp "uge" %c9_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %true = arith.constant true
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.select %true, %c23_i64, %arg2 : i1, i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.srem %arg0, %c-9_i64 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.ashr %c34_i64, %c-14_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.xor %arg1, %arg2 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    %4 = llvm.select %3, %arg1, %2 : i1, i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "eq" %c-9_i64, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-10_i64 = arith.constant -10 : i64
    %c16_i64 = arith.constant 16 : i64
    %c30_i64 = arith.constant 30 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.sdiv %c30_i64, %c-36_i64 : i64
    %1 = llvm.urem %c16_i64, %0 : i64
    %2 = llvm.xor %c-10_i64, %arg0 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-20_i64 = arith.constant -20 : i64
    %c34_i64 = arith.constant 34 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.or %arg0, %c41_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.udiv %c34_i64, %c-20_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.urem %c14_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %c-42_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %c45_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "eq" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %c31_i64 = arith.constant 31 : i64
    %c-36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "eq" %c-36_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.select %3, %c31_i64, %arg0 : i1, i64
    %5 = llvm.ashr %4, %c-43_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %c-6_i64, %0 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.udiv %0, %arg0 : i64
    %4 = llvm.ashr %3, %1 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.or %3, %3 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-37_i64 = arith.constant -37 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "ugt" %c35_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %0, %arg0, %c-37_i64 : i1, i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.ashr %3, %arg1 : i64
    %5 = llvm.icmp "ult" %4, %c42_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %c35_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %c1_i64, %arg2 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.udiv %c-31_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ult" %0, %c1_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.srem %c38_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %4, %1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.xor %c5_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "ule" %c40_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ugt" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.udiv %arg0, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.select %false, %0, %3 : i1, i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %arg0, %c14_i64 : i64
    %1 = llvm.icmp "sge" %c-6_i64, %0 : i64
    %2 = llvm.select %1, %c-32_i64, %arg1 : i1, i64
    %3 = llvm.srem %c19_i64, %arg2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c4_i64 = arith.constant 4 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "sgt" %arg0, %c15_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg1, %c6_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "ne" %c4_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.sdiv %c26_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.lshr %2, %c-42_i64 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %c-43_i64, %0 : i64
    %2 = llvm.and %arg1, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.udiv %arg0, %c-40_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ne" %arg2, %0 : i64
    %4 = llvm.select %3, %c-48_i64, %c-36_i64 : i1, i64
    %5 = llvm.urem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c1_i64 = arith.constant 1 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %arg2, %arg2 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.sdiv %0, %c1_i64 : i64
    %4 = llvm.select %2, %c2_i64, %3 : i1, i64
    %5 = llvm.or %4, %c11_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.udiv %c-6_i64, %c37_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c-30_i64 = arith.constant -30 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.udiv %c-35_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c9_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ugt" %c-30_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.urem %3, %c-32_i64 : i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.select %arg2, %0, %c29_i64 : i1, i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.select %3, %c-46_i64, %0 : i1, i64
    %5 = llvm.icmp "sle" %c26_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ult" %arg1, %arg2 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.and %c-40_i64, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "ult" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c34_i64 = arith.constant 34 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.lshr %c4_i64, %arg0 : i64
    %1 = llvm.udiv %c34_i64, %0 : i64
    %2 = llvm.ashr %arg2, %c-44_i64 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.lshr %3, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.xor %c-45_i64, %c47_i64 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %c19_i64, %0 : i64
    %2 = llvm.select %arg0, %1, %0 : i1, i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %c-45_i64, %0 : i64
    %2 = llvm.icmp "ult" %arg1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.select %4, %arg0, %c36_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.urem %arg1, %arg1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.xor %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %false = arith.constant false
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %false, %c4_i64, %0 : i1, i64
    %2 = llvm.udiv %arg2, %1 : i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.xor %c36_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c-28_i64 = arith.constant -28 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %c-28_i64, %c31_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %arg0, %1, %3 : i1, i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.or %arg0, %c-33_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.ashr %c24_i64, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.srem %3, %arg2 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.lshr %c-3_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.udiv %3, %c-23_i64 : i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c-25_i64 = arith.constant -25 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.lshr %c13_i64, %arg0 : i64
    %1 = llvm.and %c-25_i64, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %false = arith.constant false
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.srem %c47_i64, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.sdiv %4, %c37_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "ugt" %c-9_i64, %arg0 : i64
    %1 = llvm.select %0, %c-29_i64, %arg0 : i1, i64
    %2 = llvm.sdiv %1, %c-44_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c29_i64 = arith.constant 29 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.lshr %arg0, %c6_i64 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %c-1_i64 : i64
    %4 = llvm.select %3, %arg2, %c8_i64 : i1, i64
    %5 = llvm.icmp "uge" %c29_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c36_i64 = arith.constant 36 : i64
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.ashr %c-50_i64, %arg0 : i64
    %1 = llvm.xor %0, %c29_i64 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "sgt" %c36_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %c-38_i64, %c26_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.ashr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "slt" %c5_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %0, %c-7_i64, %2 : i1, i64
    %4 = llvm.icmp "ne" %3, %arg1 : i64
    %5 = llvm.select %4, %c15_i64, %arg0 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-32_i64 = arith.constant -32 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.xor %c-28_i64, %arg2 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.ashr %3, %c-32_i64 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "ult" %c3_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.icmp "ne" %c-44_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "slt" %c14_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %c-13_i64 : i64
    %3 = llvm.or %1, %arg0 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-16_i64 = arith.constant -16 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.ashr %c-16_i64, %0 : i64
    %2 = llvm.sdiv %arg2, %c-9_i64 : i64
    %3 = llvm.sdiv %2, %c-18_i64 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %c41_i64 = arith.constant 41 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.udiv %c-27_i64, %c41_i64 : i64
    %2 = llvm.or %c-11_i64, %1 : i64
    %3 = llvm.icmp "ult" %2, %c-31_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.lshr %arg0, %c4_i64 : i64
    %1 = llvm.urem %c10_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %3, %3 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.select %true, %c16_i64, %0 : i1, i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-35_i64 = arith.constant -35 : i64
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %c-35_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.icmp "sgt" %c-7_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.or %arg1, %c1_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "eq" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c0_i64 = arith.constant 0 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.sdiv %c0_i64, %c36_i64 : i64
    %1 = llvm.xor %c1_i64, %0 : i64
    %2 = llvm.lshr %0, %0 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.or %arg0, %c-17_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.and %arg1, %arg1 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.or %0, %arg0 : i64
    %3 = llvm.and %c-22_i64, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.sdiv %c-32_i64, %c8_i64 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.select %0, %arg2, %3 : i1, i64
    %5 = llvm.icmp "slt" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-42_i64 = arith.constant -42 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %c21_i64 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.ashr %c-42_i64, %2 : i64
    %4 = llvm.lshr %c-42_i64, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %false = arith.constant false
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %false, %0, %arg1 : i1, i64
    %2 = llvm.xor %1, %c-22_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.zext %arg0 : i1 to i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-25_i64 = arith.constant -25 : i64
    %c-34_i64 = arith.constant -34 : i64
    %true = arith.constant true
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.select %true, %arg2, %c-12_i64 : i1, i64
    %1 = llvm.select %arg1, %c-34_i64, %0 : i1, i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "eq" %2, %c-25_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %arg1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.select %false, %c11_i64, %arg0 : i1, i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c-13_i64 = arith.constant -13 : i64
    %c-48_i64 = arith.constant -48 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.and %0, %c-48_i64 : i64
    %3 = llvm.select %1, %c-32_i64, %2 : i1, i64
    %4 = llvm.lshr %3, %c-13_i64 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.xor %c31_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %c42_i64 = arith.constant 42 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.srem %c-39_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c46_i64 : i64
    %2 = llvm.or %arg1, %0 : i64
    %3 = llvm.or %arg2, %c42_i64 : i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    %5 = llvm.xor %4, %c-27_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %arg0, %0, %2 : i1, i64
    %4 = llvm.and %3, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %true = arith.constant true
    %c-12_i64 = arith.constant -12 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.select %true, %c-12_i64, %c41_i64 : i1, i64
    %1 = llvm.srem %c34_i64, %arg2 : i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.select %3, %c-12_i64, %2 : i1, i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c-47_i64 = arith.constant -47 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %c23_i64, %c-47_i64 : i64
    %3 = llvm.sdiv %arg1, %c25_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-4_i64 = arith.constant -4 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.srem %c-26_i64, %c31_i64 : i64
    %1 = llvm.ashr %c-4_i64, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c30_i64 = arith.constant 30 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "sge" %c34_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.select %true, %1, %2 : i1, i64
    %4 = llvm.sdiv %c30_i64, %3 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %true, %arg2, %arg1 : i1, i64
    %4 = llvm.udiv %arg2, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %c-31_i64, %c-2_i64 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.udiv %2, %c33_i64 : i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.srem %arg0, %c3_i64 : i64
    %1 = llvm.sdiv %c-27_i64, %0 : i64
    %2 = llvm.sdiv %c27_i64, %1 : i64
    %3 = llvm.icmp "uge" %2, %c47_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "eq" %c4_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %c43_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c15_i64 = arith.constant 15 : i64
    %c18_i64 = arith.constant 18 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "ult" %c35_i64, %c-16_i64 : i64
    %1 = llvm.select %arg0, %c18_i64, %c15_i64 : i1, i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    %5 = llvm.xor %4, %c21_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %2, %c-34_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.or %4, %arg2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %c2_i64, %2 : i64
    %4 = llvm.and %3, %2 : i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "sle" %arg0, %c-18_i64 : i64
    %1 = llvm.lshr %arg1, %c-5_i64 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.xor %arg2, %arg2 : i64
    %4 = llvm.udiv %c25_i64, %3 : i64
    %5 = llvm.select %0, %2, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg1, %c6_i64 : i64
    %2 = llvm.udiv %arg2, %1 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.udiv %4, %c-16_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "sle" %c24_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %c-38_i64, %1 : i64
    %3 = llvm.icmp "uge" %c-32_i64, %c21_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "eq" %c-39_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "slt" %arg1, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %arg0, %c40_i64 : i64
    %1 = llvm.icmp "slt" %arg1, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.lshr %arg0, %c44_i64 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "ule" %c14_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ult" %arg1, %c48_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %true, %4, %arg0 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "sle" %c20_i64, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.and %c28_i64, %c34_i64 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sle" %2, %c34_i64 : i64
    %4 = llvm.lshr %2, %0 : i64
    %5 = llvm.select %3, %2, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg2, %arg2 : i1, i64
    %2 = llvm.icmp "ugt" %c47_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sext %0 : i1 to i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ugt" %arg1, %c-12_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.urem %arg1, %c-12_i64 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.select %arg1, %arg2, %1 : i1, i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c-18_i64 = arith.constant -18 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "eq" %0, %c-18_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %1, %c-46_i64 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.or %0, %c-30_i64 : i64
    %2 = llvm.icmp "sge" %0, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-27_i64 = arith.constant -27 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "slt" %c37_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %c-27_i64 : i1, i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.ashr %3, %arg2 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %c1_i64, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.or %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.select %arg0, %arg1, %c12_i64 : i1, i64
    %1 = llvm.icmp "slt" %arg2, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %c46_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %arg1, %0, %0 : i1, i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %c3_i64, %0 : i64
    %2 = llvm.xor %0, %arg1 : i64
    %3 = llvm.urem %arg1, %0 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.select %1, %4, %arg1 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-28_i64 = arith.constant -28 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c-28_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %c-40_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "ult" %c-22_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "ule" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.srem %c-2_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.ashr %3, %1 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.lshr %c7_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %c-22_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %arg1, %arg2, %c-41_i64 : i1, i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %c49_i64 = arith.constant 49 : i64
    %c28_i64 = arith.constant 28 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.sdiv %c-40_i64, %arg0 : i64
    %1 = llvm.srem %c49_i64, %c-15_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.sdiv %c28_i64, %3 : i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.lshr %c21_i64, %arg1 : i64
    %1 = llvm.select %arg2, %0, %arg0 : i1, i64
    %2 = llvm.lshr %1, %c27_i64 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.ashr %0, %arg1 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.urem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.sdiv %arg0, %c-46_i64 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.sdiv %c-38_i64, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "uge" %3, %arg1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.sdiv %c-34_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %c15_i64 = arith.constant 15 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.and %arg0, %c22_i64 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.select %1, %c-27_i64, %0 : i1, i64
    %3 = llvm.xor %c15_i64, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.ashr %c8_i64, %arg0 : i64
    %1 = llvm.or %arg1, %c-1_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.srem %0, %arg0 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.srem %2, %c12_i64 : i64
    %4 = llvm.urem %3, %c5_i64 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.urem %c-29_i64, %arg0 : i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %c-22_i64, %arg2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "sle" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg2, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %c-29_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %c48_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.urem %4, %1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.lshr %arg2, %arg1 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %arg2, %0 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %c48_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %3, %arg0 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-19_i64 = arith.constant -19 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %c15_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg1, %arg2 : i64
    %4 = llvm.xor %c-19_i64, %3 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-24_i64 = arith.constant -24 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.urem %c-24_i64, %c-4_i64 : i64
    %1 = llvm.icmp "slt" %0, %c-49_i64 : i64
    %2 = llvm.and %c13_i64, %arg0 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "uge" %arg0, %c21_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "uge" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %c30_i64 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.select %false, %1, %0 : i1, i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "eq" %c49_i64, %arg1 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %c48_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.lshr %c-46_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.udiv %c-1_i64, %c-29_i64 : i64
    %3 = llvm.and %2, %c30_i64 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.srem %4, %arg0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c-27_i64 = arith.constant -27 : i64
    %c-5_i64 = arith.constant -5 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "uge" %c-5_i64, %c21_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %c-27_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %3, %1 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.srem %c-40_i64, %3 : i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
