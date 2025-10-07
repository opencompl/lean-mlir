module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.and %c_17_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %c11_i64 : i64
    %2 = llvm.lshr %0, %arg2 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.srem %c_48_i64, %arg0 : i64
    %1 = llvm.urem %c40_i64, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %arg1, %arg2 : i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.or %arg2, %arg2 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.sdiv %arg0, %c_19_i64 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.ashr %arg2, %c1_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.icmp "ugt" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.and %arg1, %c38_i64 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.ashr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c_49_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg0, %arg0 : i64
    %4 = llvm.udiv %3, %c7_i64 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.urem %0, %c7_i64 : i64
    %3 = llvm.xor %c32_i64, %2 : i64
    %4 = llvm.and %arg1, %3 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_18_i64 = arith.constant -18 : i64
    %c49_i64 = arith.constant 49 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.udiv %c19_i64, %c49_i64 : i64
    %2 = llvm.icmp "sgt" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.udiv %4, %c_18_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.and %arg2, %c21_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "eq" %c28_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.udiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c36_i64 = arith.constant 36 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg1, %c36_i64 : i1, i64
    %2 = llvm.select %0, %c23_i64, %1 : i1, i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %c9_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.udiv %c_4_i64, %c16_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %c_12_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %c33_i64 = arith.constant 33 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.and %c14_i64, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.select %1, %arg2, %0 : i1, i64
    %3 = llvm.icmp "eq" %c33_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %4, %c_30_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.icmp "sgt" %c_43_i64, %c33_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %c_40_i64 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.select %3, %1, %c12_i64 : i1, i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "ule" %c_46_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %c_8_i64, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.ashr %c_22_i64, %3 : i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.sdiv %3, %arg0 : i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %c_14_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c6_i64 = arith.constant 6 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.ashr %arg0, %c_44_i64 : i64
    %1 = llvm.udiv %c6_i64, %c26_i64 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.xor %arg0, %0 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.lshr %3, %2 : i64
    %5 = llvm.icmp "eq" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.xor %c_29_i64, %c_48_i64 : i64
    %1 = llvm.srem %c40_i64, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.or %2, %1 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.ashr %c_36_i64, %arg0 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.select %1, %arg1, %arg0 : i1, i64
    %3 = llvm.udiv %0, %c14_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.xor %4, %arg2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c_46_i64, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %c_33_i64, %arg2 : i64
    %3 = llvm.icmp "ugt" %c_22_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.icmp "sle" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %c30_i64 = arith.constant 30 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.or %c0_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.udiv %0, %c_26_i64 : i64
    %3 = llvm.srem %c30_i64, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.or %c30_i64, %2 : i64
    %4 = llvm.or %3, %c45_i64 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "uge" %arg1, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg2, %2 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.or %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.icmp "ne" %4, %c_16_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c34_i64 = arith.constant 34 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %c34_i64, %c40_i64 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "sge" %c45_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.urem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg2, %c10_i64 : i1, i64
    %2 = llvm.lshr %c46_i64, %arg1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "ugt" %c_50_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg1, %arg2 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.lshr %c7_i64, %arg1 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %c_28_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %c_27_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.urem %c50_i64, %arg0 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.icmp "eq" %c_39_i64, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.ashr %c_18_i64, %c4_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.sdiv %4, %arg2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.srem %arg0, %c_11_i64 : i64
    %1 = llvm.udiv %c_48_i64, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.srem %c50_i64, %1 : i64
    %4 = llvm.select %arg1, %3, %1 : i1, i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.or %c50_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "ult" %2, %c21_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %false = arith.constant false
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.select %false, %c_17_i64, %arg0 : i1, i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "eq" %c29_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sext %2 : i1 to i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %c_32_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %arg1, %arg0 : i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.urem %c3_i64, %arg0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %c15_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %c_28_i64 = arith.constant -28 : i64
    %true = arith.constant true
    %0 = llvm.icmp "ne" %arg1, %arg2 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.select %true, %arg0, %2 : i1, i64
    %4 = llvm.and %3, %c_23_i64 : i64
    %5 = llvm.and %c_28_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg1, %c42_i64 : i64
    %3 = llvm.icmp "eq" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c10_i64 = arith.constant 10 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c0_i64 = arith.constant 0 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.srem %c0_i64, %c_31_i64 : i64
    %1 = llvm.sdiv %c_9_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.icmp "sle" %arg1, %c10_i64 : i64
    %4 = llvm.select %3, %arg2, %c27_i64 : i1, i64
    %5 = llvm.select %2, %arg0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.and %1, %c_35_i64 : i64
    %3 = llvm.xor %0, %arg1 : i64
    %4 = llvm.urem %c_3_i64, %3 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %c43_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c48_i64 = arith.constant 48 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.urem %arg1, %c_31_i64 : i64
    %1 = llvm.and %c48_i64, %0 : i64
    %2 = llvm.icmp "slt" %arg2, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %arg0, %1, %3 : i1, i64
    %5 = llvm.icmp "ne" %4, %c5_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %arg2, %arg0 : i64
    %2 = llvm.select %1, %arg0, %c_49_i64 : i1, i64
    %3 = llvm.sdiv %0, %arg1 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "slt" %c_13_i64, %c18_i64 : i64
    %1 = llvm.and %c_41_i64, %arg1 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.srem %0, %c_6_i64 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "ule" %1, %c_45_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "slt" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %c9_i64 = arith.constant 9 : i64
    %c23_i64 = arith.constant 23 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %c23_i64, %0 : i64
    %2 = llvm.lshr %c9_i64, %1 : i64
    %3 = llvm.urem %2, %c_12_i64 : i64
    %4 = llvm.sdiv %arg0, %arg0 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sdiv %c_25_i64, %c20_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.xor %0, %arg0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.sdiv %3, %c9_i64 : i64
    %5 = llvm.icmp "ne" %c_28_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.sdiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %c_2_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %c10_i64, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %c12_i64, %0 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.udiv %arg0, %c10_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ule" %1, %c_1_i64 : i64
    %3 = llvm.lshr %arg1, %0 : i64
    %4 = llvm.select %2, %1, %3 : i1, i64
    %5 = llvm.icmp "sle" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "ne" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %false = arith.constant false
    %c_38_i64 = arith.constant -38 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.select %false, %c_38_i64, %c1_i64 : i1, i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.srem %0, %c13_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.urem %arg2, %0 : i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.urem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.urem %4, %1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %0, %c_18_i64 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.udiv %c23_i64, %arg0 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.or %arg0, %c7_i64 : i64
    %1 = llvm.select %arg1, %arg2, %0 : i1, i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.and %arg2, %c30_i64 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "ult" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.urem %arg1, %c_47_i64 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.udiv %2, %c9_i64 : i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.xor %c_13_i64, %arg1 : i64
    %3 = llvm.icmp "ult" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg2, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.icmp "ne" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.select %arg2, %c_43_i64, %arg0 : i1, i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.srem %c_18_i64, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.or %1, %c19_i64 : i64
    %3 = llvm.lshr %1, %1 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c42_i64 = arith.constant 42 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "slt" %arg1, %arg2 : i64
    %1 = llvm.select %0, %c_24_i64, %arg0 : i1, i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.or %arg2, %c42_i64 : i64
    %4 = llvm.or %3, %c7_i64 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.udiv %1, %c_25_i64 : i64
    %3 = llvm.lshr %0, %c24_i64 : i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "sle" %2, %c_36_i64 : i64
    %4 = llvm.select %3, %0, %2 : i1, i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %c34_i64, %1 : i64
    %3 = llvm.icmp "uge" %c_11_i64, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sdiv %c47_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.xor %c19_i64, %arg2 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.or %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.lshr %arg0, %c45_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %c17_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c40_i64 = arith.constant 40 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.or %arg0, %c_46_i64 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    %3 = llvm.select %1, %2, %c_41_i64 : i1, i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "ne" %c40_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %c18_i64 = arith.constant 18 : i64
    %c7_i64 = arith.constant 7 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sdiv %arg0, %c44_i64 : i64
    %1 = llvm.srem %arg1, %c7_i64 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.sdiv %c18_i64, %c_13_i64 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c21_i64 = arith.constant 21 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.srem %c21_i64, %c_2_i64 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %c_37_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %c49_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.and %arg0, %c_32_i64 : i64
    %1 = llvm.select %arg1, %arg0, %0 : i1, i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.and %0, %2 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.or %c_24_i64, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.urem %c37_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.xor %arg0, %c25_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %arg2, %c_24_i64 : i64
    %3 = llvm.icmp "ugt" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.ashr %1, %c11_i64 : i64
    %3 = llvm.select %arg2, %c9_i64, %c11_i64 : i1, i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.lshr %4, %0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c39_i64 = arith.constant 39 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.and %c39_i64, %c15_i64 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %c50_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "sle" %arg0, %c4_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg1, %c_48_i64 : i64
    %3 = llvm.or %1, %c_40_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.and %arg0, %c43_i64 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "uge" %4, %c_29_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg2, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "uge" %2, %c_10_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.lshr %c_9_i64, %c_5_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ule" %arg1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "sgt" %c_15_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "eq" %c_7_i64, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %c23_i64, %3 : i64
    %5 = llvm.select %0, %4, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.srem %c25_i64, %c_25_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %2, %arg0 : i64
    %4 = llvm.select %3, %arg1, %arg2 : i1, i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.sext %1 : i1 to i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.srem %c_32_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %arg1, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.select %false, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %c47_i64 = arith.constant 47 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.lshr %c47_i64, %c11_i64 : i64
    %1 = llvm.icmp "uge" %c_38_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.and %arg0, %c34_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "ne" %c7_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c_5_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.urem %3, %c_46_i64 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "sge" %arg0, %c_4_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "ult" %c_29_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %1, %c22_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c2_i64 = arith.constant 2 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.sdiv %c7_i64, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.xor %c2_i64, %2 : i64
    %4 = llvm.icmp "uge" %c38_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.lshr %arg0, %c_44_i64 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.or %c12_i64, %3 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "ult" %c30_i64, %c_37_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.or %arg0, %c26_i64 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "uge" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "sgt" %c11_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.sdiv %arg1, %c_21_i64 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.or %c_3_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "ult" %c11_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %4, %arg2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c28_i64 : i64
    %2 = llvm.sdiv %c_24_i64, %arg1 : i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.urem %3, %c_29_i64 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.or %c15_i64, %arg0 : i64
    %1 = llvm.xor %0, %c_28_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.urem %3, %c_10_i64 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "eq" %c49_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c32_i64 : i1, i64
    %2 = llvm.srem %arg1, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.icmp "sge" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.udiv %c_34_i64, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.sdiv %arg2, %c_38_i64 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c_10_i64 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c15_i64 = arith.constant 15 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %c_28_i64, %c_11_i64 : i64
    %1 = llvm.sdiv %0, %c15_i64 : i64
    %2 = llvm.icmp "ule" %0, %c33_i64 : i64
    %3 = llvm.select %2, %1, %arg0 : i1, i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "uge" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.lshr %c_35_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.urem %c1_i64, %3 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %c48_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %false = arith.constant false
    %c10_i64 = arith.constant 10 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ne" %c_11_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %c_13_i64 : i64
    %2 = llvm.select %0, %1, %c10_i64 : i1, i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.select %false, %c25_i64, %1 : i1, i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c21_i64 = arith.constant 21 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "ult" %c_23_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.sdiv %c0_i64, %1 : i64
    %3 = llvm.select %0, %c21_i64, %2 : i1, i64
    %4 = llvm.trunc %0 : i1 to i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %c_37_i64 = arith.constant -37 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.select %arg0, %c_26_i64, %arg1 : i1, i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.or %1, %c_37_i64 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.select %false, %c_43_i64, %2 : i1, i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.sdiv %c_2_i64, %c_14_i64 : i64
    %1 = llvm.lshr %c41_i64, %0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.xor %arg1, %arg2 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c0_i64 = arith.constant 0 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c0_i64 : i64
    %2 = llvm.urem %arg1, %arg2 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.udiv %3, %c10_i64 : i64
    %5 = llvm.or %c35_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %c_37_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.and %arg0, %c28_i64 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %arg0 : i64
    %4 = llvm.select %3, %c_7_i64, %2 : i1, i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.select %1, %0, %c_46_i64 : i1, i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.lshr %arg1, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.sdiv %1, %c12_i64 : i64
    %3 = llvm.icmp "sgt" %c_38_i64, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %true = arith.constant true
    %c_26_i64 = arith.constant -26 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.urem %c_26_i64, %c46_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %4, %c5_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %arg0, %c_35_i64 : i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.or %0, %0 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.urem %c32_i64, %1 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ule" %c_10_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %arg1, %arg2 : i64
    %4 = llvm.lshr %3, %2 : i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.and %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %c15_i64, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %2, %c44_i64 : i64
    %4 = llvm.lshr %0, %arg1 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "ugt" %c_21_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %c_47_i64 : i64
    %3 = llvm.select %0, %1, %c_47_i64 : i1, i64
    %4 = llvm.urem %c_31_i64, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c0_i64 = arith.constant 0 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.sdiv %c_36_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c0_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg1, %arg0 : i64
    %4 = llvm.select %3, %arg1, %c31_i64 : i1, i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.udiv %2, %c_23_i64 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.sdiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %c2_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.urem %4, %3 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.ashr %arg2, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "eq" %3, %c37_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.srem %c_8_i64, %c_4_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.and %3, %arg2 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.lshr %c26_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %0, %c_17_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "uge" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %c37_i64, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.udiv %3, %1 : i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.icmp "ule" %c26_i64, %c2_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.or %3, %0 : i64
    %5 = llvm.urem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c17_i64 = arith.constant 17 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c49_i64 = arith.constant 49 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.lshr %c49_i64, %c_37_i64 : i64
    %1 = llvm.sdiv %0, %c17_i64 : i64
    %2 = llvm.udiv %c_29_i64, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.lshr %3, %c38_i64 : i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.and %c45_i64, %arg1 : i64
    %2 = llvm.or %1, %c_28_i64 : i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.ashr %3, %c16_i64 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c5_i64 = arith.constant 5 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %c48_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %c5_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %arg1 : i64
    %4 = llvm.xor %c_45_i64, %arg2 : i64
    %5 = llvm.select %3, %c_25_i64, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %0, %c_27_i64 : i64
    %2 = llvm.lshr %0, %0 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "eq" %c_4_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %c_39_i64 = arith.constant -39 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.sdiv %c_10_i64, %c_8_i64 : i64
    %1 = llvm.sdiv %0, %c_39_i64 : i64
    %2 = llvm.lshr %c_32_i64, %arg0 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c_3_i64 = arith.constant -3 : i64
    %c_34_i64 = arith.constant -34 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.udiv %c_34_i64, %c32_i64 : i64
    %1 = llvm.xor %c_3_i64, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.icmp "ugt" %4, %c_26_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %c17_i64 = arith.constant 17 : i64
    %c10_i64 = arith.constant 10 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.icmp "uge" %c10_i64, %c32_i64 : i64
    %1 = llvm.ashr %c32_i64, %c17_i64 : i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.icmp "ule" %2, %2 : i64
    %4 = llvm.urem %arg0, %c_39_i64 : i64
    %5 = llvm.select %3, %4, %arg0 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %c30_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %false = arith.constant false
    %c0_i64 = arith.constant 0 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.select %false, %c0_i64, %c21_i64 : i1, i64
    %1 = llvm.lshr %c42_i64, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.trunc %arg0 : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c_43_i64 = arith.constant -43 : i64
    %c30_i64 = arith.constant 30 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.urem %c30_i64, %c_9_i64 : i64
    %1 = llvm.urem %c_43_i64, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.and %c_34_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.xor %arg2, %arg0 : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %c_10_i64, %0 : i64
    %2 = llvm.xor %c_39_i64, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.ashr %c_9_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %c_8_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c_15_i64, %c36_i64 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.icmp "ule" %c_46_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.srem %arg0, %c12_i64 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "eq" %c44_i64, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %c31_i64, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %true = arith.constant true
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.select %true, %3, %c_19_i64 : i1, i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %c_30_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %2, %c_29_i64 : i64
    %4 = llvm.xor %3, %c25_i64 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.sdiv %c47_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.udiv %c44_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.select %arg0, %arg1, %c_2_i64 : i1, i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.ashr %c_22_i64, %2 : i64
    %4 = llvm.sext %arg0 : i1 to i64
    %5 = llvm.udiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg1, %arg2 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %arg1, %arg0 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %c45_i64, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.lshr %arg0, %c22_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.select %arg0, %c4_i64, %arg1 : i1, i64
    %1 = llvm.and %arg1, %c_30_i64 : i64
    %2 = llvm.icmp "eq" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "sgt" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.trunc %arg0 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.udiv %arg2, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.srem %c10_i64, %1 : i64
    %3 = llvm.icmp "eq" %2, %c_31_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sgt" %c_28_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.srem %1, %1 : i64
    %5 = llvm.select %3, %c_21_i64, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %c25_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c23_i64 = arith.constant 23 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c44_i64 = arith.constant 44 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.ashr %c44_i64, %c_21_i64 : i64
    %1 = llvm.srem %c_6_i64, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.udiv %c23_i64, %2 : i64
    %4 = llvm.urem %3, %2 : i64
    %5 = llvm.or %c43_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.ashr %c_37_i64, %3 : i64
    %5 = llvm.icmp "ne" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "uge" %2, %c15_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.urem %1, %arg1 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "eq" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.xor %c28_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "slt" %c_19_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.trunc %arg1 : i1 to i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c_12_i64 = arith.constant -12 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.udiv %c26_i64, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "ugt" %c3_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.icmp "ne" %c_12_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c17_i64 = arith.constant 17 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.or %arg0, %c_10_i64 : i64
    %1 = llvm.xor %c17_i64, %0 : i64
    %2 = llvm.xor %c3_i64, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %c36_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %2, %c_6_i64 : i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.srem %arg2, %c_23_i64 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg1, %c_43_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %c29_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "ule" %c11_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.ashr %c1_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.udiv %2, %c43_i64 : i64
    %4 = llvm.icmp "uge" %3, %1 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %c7_i64 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.icmp "sle" %0, %c_46_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c16_i64 = arith.constant 16 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.select %1, %c16_i64, %c_33_i64 : i1, i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    %4 = llvm.select %3, %0, %2 : i1, i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c_6_i64 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "sge" %1, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.udiv %c_25_i64, %3 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.select %arg2, %arg0, %c_29_i64 : i1, i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.or %c_23_i64, %arg0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.lshr %c16_i64, %0 : i64
    %2 = llvm.udiv %c_7_i64, %1 : i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.or %0, %1 : i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.udiv %c33_i64, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.ashr %arg2, %arg2 : i64
    %3 = llvm.and %2, %c_14_i64 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c4_i64 = arith.constant 4 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "sle" %arg0, %c_49_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c4_i64, %c39_i64 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.udiv %4, %arg1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.urem %arg2, %arg1 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %c_32_i64, %0 : i64
    %2 = llvm.select %arg0, %1, %c1_i64 : i1, i64
    %3 = llvm.ashr %0, %1 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.select %true, %arg1, %arg2 : i1, i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %arg0, %c_27_i64 : i64
    %1 = llvm.xor %c_50_i64, %0 : i64
    %2 = llvm.xor %arg1, %arg0 : i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %c39_i64 = arith.constant 39 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "sle" %arg2, %c_33_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.sdiv %3, %c_49_i64 : i64
    %5 = llvm.or %c39_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %c48_i64, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.udiv %2, %arg0 : i64
    %5 = llvm.srem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.srem %0, %1 : i64
    %4 = llvm.and %c12_i64, %3 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c23_i64 = arith.constant 23 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.xor %c23_i64, %c_11_i64 : i64
    %1 = llvm.xor %0, %c_37_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.udiv %arg0, %arg0 : i64
    %4 = llvm.lshr %3, %2 : i64
    %5 = llvm.srem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c43_i64 = arith.constant 43 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %arg0, %c43_i64 : i64
    %2 = llvm.icmp "sgt" %1, %c32_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %c33_i64 = arith.constant 33 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "sge" %arg0, %c2_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %c_45_i64, %1 : i1, i64
    %3 = llvm.srem %c_8_i64, %2 : i64
    %4 = llvm.icmp "ugt" %c33_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.udiv %c_3_i64, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.srem %arg2, %c17_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.and %1, %0 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.ashr %1, %c_17_i64 : i64
    %3 = llvm.or %c_20_i64, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.and %c12_i64, %c_46_i64 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg1, %arg1 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.sdiv %arg0, %arg0 : i64
    %3 = llvm.select %1, %arg1, %2 : i1, i64
    %4 = llvm.trunc %arg2 : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.ashr %1, %c50_i64 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.sdiv %3, %1 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.urem %0, %2 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %c1_i64 = arith.constant 1 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "ne" %c14_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c_16_i64 : i1, i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "ule" %c1_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %c5_i64 : i64
    %2 = llvm.or %c22_i64, %arg0 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %c_26_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.xor %3, %0 : i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %true = arith.constant true
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.select %true, %arg0, %c_46_i64 : i1, i64
    %1 = llvm.icmp "ne" %c31_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.sext %1 : i1 to i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.or %arg0, %c_3_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %arg1, %arg2, %2 : i1, i64
    %4 = llvm.ashr %3, %arg0 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.lshr %arg1, %c8_i64 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.and %arg0, %c_42_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "ugt" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %3, %arg0 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %c_28_i64, %0 : i64
    %2 = llvm.or %arg1, %arg1 : i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.or %c49_i64, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "ugt" %c_28_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %c_21_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %3, %arg0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %c28_i64 = arith.constant 28 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "sgt" %c_43_i64, %arg2 : i64
    %3 = llvm.select %2, %c28_i64, %c_36_i64 : i1, i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg0, %c34_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %c28_i64 = arith.constant 28 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.ashr %arg0, %c_9_i64 : i64
    %1 = llvm.or %c_44_i64, %0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.xor %c28_i64, %c_30_i64 : i64
    %4 = llvm.sdiv %arg2, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "sgt" %arg0, %c20_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %true, %1, %1 : i1, i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.ashr %1, %arg1 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %c_50_i64 = arith.constant -50 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %c_50_i64, %c_17_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.lshr %arg0, %c12_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.ashr %arg1, %arg1 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.select %0, %2, %c46_i64 : i1, i64
    %4 = llvm.icmp "ne" %c_8_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.srem %c32_i64, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.select %3, %0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c49_i64 = arith.constant 49 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "sgt" %c49_i64, %c_18_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %c_14_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %3, %1 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %c5_i64 = arith.constant 5 : i64
    %c_33_i64 = arith.constant -33 : i64
    %true = arith.constant true
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.select %true, %arg0, %c0_i64 : i1, i64
    %1 = llvm.select %arg2, %0, %c_33_i64 : i1, i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.lshr %c5_i64, %c_50_i64 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.or %arg0, %c24_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "ult" %c_15_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %3, %c_29_i64 : i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c36_i64 = arith.constant 36 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.sdiv %arg0, %c18_i64 : i64
    %1 = llvm.icmp "sle" %c_5_i64, %arg0 : i64
    %2 = llvm.select %1, %c36_i64, %c27_i64 : i1, i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %c_50_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "uge" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c10_i64 = arith.constant 10 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.urem %c10_i64, %c42_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.udiv %4, %c35_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c9_i64 = arith.constant 9 : i64
    %c13_i64 = arith.constant 13 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.and %c8_i64, %arg0 : i64
    %1 = llvm.ashr %c13_i64, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "ugt" %c9_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.srem %c_19_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.urem %1, %c28_i64 : i64
    %3 = llvm.or %arg0, %0 : i64
    %4 = llvm.sdiv %3, %arg1 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.ashr %c21_i64, %arg1 : i64
    %1 = llvm.icmp "sgt" %c0_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.select %arg0, %arg1, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "ule" %c_43_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %c_2_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.srem %4, %c5_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "ule" %c_20_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %c_30_i64, %arg1 : i64
    %3 = llvm.ashr %c_29_i64, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.ashr %c_19_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "ule" %c_31_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.urem %4, %c25_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c29_i64 = arith.constant 29 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.srem %c13_i64, %arg0 : i64
    %1 = llvm.ashr %c29_i64, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.udiv %c3_i64, %arg1 : i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.urem %1, %c10_i64 : i64
    %3 = llvm.xor %2, %c_48_i64 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "slt" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.sdiv %3, %c22_i64 : i64
    %5 = llvm.select %true, %c_28_i64, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "sgt" %c_5_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.select %0, %1, %c_29_i64 : i1, i64
    %3 = llvm.icmp "ult" %arg0, %c15_i64 : i64
    %4 = llvm.select %3, %arg2, %2 : i1, i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg1, %c32_i64 : i1, i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "eq" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %c44_i64 = arith.constant 44 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %c11_i64, %0 : i64
    %2 = llvm.xor %1, %c44_i64 : i64
    %3 = llvm.icmp "ugt" %2, %c_45_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.lshr %c_11_i64, %3 : i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %c_46_i64 = arith.constant -46 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.xor %0, %c_46_i64 : i64
    %3 = llvm.icmp "ne" %c_47_i64, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %1, %2, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "sgt" %c50_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "sge" %c19_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.ashr %arg0, %c_29_i64 : i64
    %1 = llvm.and %c_50_i64, %0 : i64
    %2 = llvm.urem %1, %c_23_i64 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.lshr %c_46_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.ashr %c_49_i64, %arg0 : i64
    %1 = llvm.xor %arg1, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %c_39_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %1, %arg1, %arg2 : i1, i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c19_i64 = arith.constant 19 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %c19_i64, %2 : i64
    %4 = llvm.lshr %c_28_i64, %arg0 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.srem %c20_i64, %1 : i64
    %3 = llvm.urem %arg1, %c19_i64 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %c12_i64, %arg1 : i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c32_i64 = arith.constant 32 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.srem %arg0, %c_35_i64 : i64
    %1 = llvm.ashr %c32_i64, %arg1 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.select %arg2, %c14_i64, %c14_i64 : i1, i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.ashr %c17_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg2, %c_50_i64, %arg1 : i1, i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.or %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c26_i64 = arith.constant 26 : i64
    %c1_i64 = arith.constant 1 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.udiv %c1_i64, %c_26_i64 : i64
    %1 = llvm.srem %arg0, %c26_i64 : i64
    %2 = llvm.udiv %c12_i64, %1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.srem %c43_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "sgt" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %c29_i64 = arith.constant 29 : i64
    %c11_i64 = arith.constant 11 : i64
    %c44_i64 = arith.constant 44 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.lshr %c_36_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %c44_i64, %c11_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.urem %c29_i64, %c_27_i64 : i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.urem %c21_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %true = arith.constant true
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.or %2, %c_50_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.udiv %1, %c_21_i64 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.xor %c29_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.lshr %1, %0 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %arg2, %c25_i64 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %c14_i64 : i64
    %2 = llvm.urem %c_28_i64, %c_21_i64 : i64
    %3 = llvm.ashr %arg1, %1 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.xor %c_44_i64, %1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.sdiv %3, %c4_i64 : i64
    %5 = llvm.lshr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "ugt" %arg0, %c_48_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %3, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c39_i64 = arith.constant 39 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.and %c39_i64, %c_15_i64 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "ult" %4, %c25_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.icmp "slt" %4, %c27_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.udiv %2, %c_20_i64 : i64
    %4 = llvm.sdiv %3, %arg0 : i64
    %5 = llvm.icmp "ne" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "ne" %c9_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg1, %arg1 : i64
    %3 = llvm.icmp "sgt" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c13_i64 = arith.constant 13 : i64
    %true = arith.constant true
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.select %true, %0, %arg0 : i1, i64
    %2 = llvm.and %c13_i64, %c_48_i64 : i64
    %3 = llvm.sdiv %c26_i64, %arg1 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %c_15_i64, %c49_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "slt" %arg0, %c25_i64 : i64
    %1 = llvm.select %0, %arg1, %c_36_i64 : i1, i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %4, %c_37_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %arg1, %c26_i64, %c_15_i64 : i1, i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c31_i64 = arith.constant 31 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.urem %arg0, %c3_i64 : i64
    %1 = llvm.icmp "ne" %0, %c37_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %c31_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c16_i64, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %c_5_i64 : i64
    %4 = llvm.select %3, %c_27_i64, %c_28_i64 : i1, i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %true = arith.constant true
    %c_42_i64 = arith.constant -42 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.select %true, %c_42_i64, %c37_i64 : i1, i64
    %1 = llvm.icmp "sle" %arg0, %c_39_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c2_i64 = arith.constant 2 : i64
    %c9_i64 = arith.constant 9 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "sge" %c_1_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c9_i64 : i1, i64
    %2 = llvm.icmp "uge" %c2_i64, %c34_i64 : i64
    %3 = llvm.select %2, %1, %arg0 : i1, i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c23_i64 = arith.constant 23 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.lshr %arg0, %c_43_i64 : i64
    %1 = llvm.icmp "eq" %c23_i64, %0 : i64
    %2 = llvm.select %1, %arg1, %arg1 : i1, i64
    %3 = llvm.urem %arg1, %arg1 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "ule" %c19_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ugt" %arg0, %c43_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.ashr %arg0, %c35_i64 : i64
    %1 = llvm.and %0, %c_37_i64 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "ult" %c_32_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "ule" %3, %arg0 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "sgt" %c_4_i64, %c10_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "uge" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %2, %arg1, %c_15_i64 : i1, i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c18_i64 = arith.constant 18 : i64
    %c27_i64 = arith.constant 27 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %c27_i64, %c48_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "ult" %c18_i64, %c25_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "sge" %c_38_i64, %c39_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %arg1 : i64
    %3 = llvm.lshr %2, %1 : i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.udiv %arg0, %c29_i64 : i64
    %1 = llvm.udiv %c2_i64, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %c21_i64 = arith.constant 21 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "ugt" %c21_i64, %c20_i64 : i64
    %1 = llvm.urem %c_47_i64, %arg0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.udiv %arg0, %arg0 : i64
    %5 = llvm.select %0, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %arg1, %arg2, %c12_i64 : i1, i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %0, %c3_i64 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.xor %arg0, %0 : i64
    %4 = llvm.udiv %3, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c47_i64 = arith.constant 47 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %c26_i64, %0 : i64
    %2 = llvm.and %c47_i64, %1 : i64
    %3 = llvm.urem %1, %arg1 : i64
    %4 = llvm.ashr %3, %c13_i64 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "ule" %arg1, %arg2 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.sdiv %c37_i64, %c_8_i64 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "ne" %arg0, %c_37_i64 : i64
    %1 = llvm.select %0, %c_47_i64, %arg1 : i1, i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.and %arg1, %c7_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.urem %c_21_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.srem %c_36_i64, %1 : i64
    %3 = llvm.icmp "ult" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.srem %c_8_i64, %c11_i64 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.udiv %3, %arg1 : i64
    %5 = llvm.or %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.or %arg0, %c46_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c13_i64 = arith.constant 13 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.xor %c13_i64, %c_14_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sge" %1, %c7_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.icmp "ule" %c_38_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.udiv %c46_i64, %arg2 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %c45_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c45_i64 = arith.constant 45 : i64
    %false = arith.constant false
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.select %false, %0, %arg2 : i1, i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "ule" %c45_i64, %c37_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg1, %1 : i64
    %3 = llvm.and %arg0, %arg2 : i64
    %4 = llvm.select %2, %3, %c_40_i64 : i1, i64
    %5 = llvm.icmp "ult" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.trunc %arg0 : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c2_i64 = arith.constant 2 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c4_i64 : i64
    %2 = llvm.urem %0, %c2_i64 : i64
    %3 = llvm.or %2, %c39_i64 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c13_i64 = arith.constant 13 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.ashr %c13_i64, %c3_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.select %false, %arg0, %arg1 : i1, i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c9_i64 = arith.constant 9 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.select %arg0, %arg1, %c_22_i64 : i1, i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "uge" %2, %c9_i64 : i64
    %4 = llvm.select %3, %arg1, %c_33_i64 : i1, i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %false = arith.constant false
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.srem %c_25_i64, %arg2 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.and %3, %c38_i64 : i64
    %5 = llvm.select %1, %2, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.select %true, %arg1, %c_49_i64 : i1, i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c34_i64 = arith.constant 34 : i64
    %c7_i64 = arith.constant 7 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %c7_i64, %0 : i64
    %2 = llvm.icmp "sgt" %c14_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "sle" %c34_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i1) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.select %arg2, %0, %1 : i1, i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.and %3, %3 : i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.srem %1, %c_15_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "sle" %c47_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.or %c_27_i64, %arg2 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %c_37_i64, %c20_i64 : i64
    %1 = llvm.ashr %c_6_i64, %0 : i64
    %2 = llvm.or %arg0, %0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.select %arg1, %arg2, %c_28_i64 : i1, i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %c19_i64, %c_2_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.and %1, %arg0 : i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.udiv %c19_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.sdiv %0, %arg1 : i64
    %3 = llvm.srem %c27_i64, %0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "sle" %c_12_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "uge" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %arg2, %arg1 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.udiv %arg2, %2 : i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.ashr %c_7_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.sdiv %c_27_i64, %0 : i64
    %4 = llvm.srem %3, %c_36_i64 : i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.srem %arg0, %c39_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.xor %c_9_i64, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.and %c_40_i64, %arg0 : i64
    %1 = llvm.srem %0, %c_29_i64 : i64
    %2 = llvm.and %0, %arg0 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %false = arith.constant false
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.and %arg2, %c12_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.ashr %arg0, %0 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.ashr %c_39_i64, %1 : i64
    %3 = llvm.select %true, %2, %arg2 : i1, i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.or %c_26_i64, %arg1 : i64
    %3 = llvm.urem %arg1, %0 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sdiv %0, %c_31_i64 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.select %arg1, %0, %c21_i64 : i1, i64
    %5 = llvm.select %3, %4, %0 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %false, %3, %c45_i64 : i1, i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %4, %arg2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.srem %arg0, %c_2_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %arg0, %c_45_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c23_i64 = arith.constant 23 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %c_24_i64, %c23_i64 : i64
    %3 = llvm.ashr %c_30_i64, %c18_i64 : i64
    %4 = llvm.select %2, %c_6_i64, %3 : i1, i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "ugt" %arg1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %c_43_i64, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.select %2, %3, %1 : i1, i64
    %5 = llvm.select %2, %4, %3 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "slt" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.ashr %arg2, %c_31_i64 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.urem %c_15_i64, %c_1_i64 : i64
    %4 = llvm.or %3, %1 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.udiv %c_13_i64, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %arg0 : i64
    %5 = llvm.select %4, %0, %arg0 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %c_11_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %c_9_i64, %2 : i64
    %4 = llvm.lshr %arg0, %arg1 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.select %arg0, %c_26_i64, %c10_i64 : i1, i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %4, %c35_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.select %arg0, %c_1_i64, %arg1 : i1, i64
    %1 = llvm.and %0, %c_41_i64 : i64
    %2 = llvm.lshr %arg2, %0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.ashr %3, %c35_i64 : i64
    %5 = llvm.udiv %c_38_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %c19_i64 = arith.constant 19 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.select %arg0, %c23_i64, %arg1 : i1, i64
    %1 = llvm.or %c19_i64, %0 : i64
    %2 = llvm.ashr %0, %c_22_i64 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.or %3, %arg2 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c27_i64 = arith.constant 27 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.lshr %c27_i64, %c19_i64 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %c_5_i64, %2 : i64
    %4 = llvm.xor %c7_i64, %c_10_i64 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %c_40_i64, %arg0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.udiv %2, %1 : i64
    %4 = llvm.srem %3, %arg1 : i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "eq" %c4_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %arg0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c_39_i64 = arith.constant -39 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %c_14_i64, %0 : i64
    %2 = llvm.icmp "ult" %arg1, %c29_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %c_39_i64, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.and %arg1, %c35_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.srem %arg2, %arg1 : i64
    %3 = llvm.icmp "eq" %c11_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "eq" %c3_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c22_i64 = arith.constant 22 : i64
    %c32_i64 = arith.constant 32 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "sge" %c32_i64, %c_2_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %c22_i64, %1 : i64
    %3 = llvm.or %2, %c2_i64 : i64
    %4 = llvm.select %arg0, %2, %3 : i1, i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %0, %c10_i64 : i64
    %4 = llvm.select %arg0, %3, %2 : i1, i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c_43_i64, %c_29_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.lshr %arg2, %1 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %false = arith.constant false
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.select %false, %arg1, %c31_i64 : i1, i64
    %1 = llvm.srem %arg1, %c_22_i64 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %3, %c5_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.and %c_13_i64, %c_16_i64 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %2, %c13_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.or %1, %arg0 : i64
    %4 = llvm.ashr %3, %arg2 : i64
    %5 = llvm.select %2, %0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.sdiv %3, %arg0 : i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c30_i64 = arith.constant 30 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.select %1, %arg0, %c28_i64 : i1, i64
    %3 = llvm.udiv %c30_i64, %c_21_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "sle" %4, %c32_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.select %false, %arg0, %c23_i64 : i1, i64
    %3 = llvm.select %1, %arg2, %2 : i1, i64
    %4 = llvm.sext %1 : i1 to i64
    %5 = llvm.srem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.and %c50_i64, %arg0 : i64
    %1 = llvm.xor %0, %c43_i64 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_18_i64 = arith.constant -18 : i64
    %c_34_i64 = arith.constant -34 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.and %c_34_i64, %c_29_i64 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %0, %c_18_i64 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.or %arg0, %c_23_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.and %arg1, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "slt" %3, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %c44_i64, %0 : i64
    %2 = llvm.sdiv %1, %c_29_i64 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.lshr %3, %arg2 : i64
    %5 = llvm.lshr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c_40_i64 = arith.constant -40 : i64
    %c27_i64 = arith.constant 27 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %c_20_i64, %0 : i64
    %2 = llvm.and %1, %c27_i64 : i64
    %3 = llvm.urem %2, %c_40_i64 : i64
    %4 = llvm.or %3, %c22_i64 : i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.lshr %arg0, %arg1 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.or %0, %c_38_i64 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.or %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.xor %arg0, %c_50_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %2 = llvm.select %1, %arg1, %arg0 : i1, i64
    %3 = llvm.udiv %arg1, %arg2 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %0, %arg1, %c_26_i64 : i1, i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.zext %0 : i1 to i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.select %0, %c0_i64, %1 : i1, i64
    %3 = llvm.or %c_22_i64, %1 : i64
    %4 = llvm.ashr %3, %1 : i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %c_34_i64, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %arg2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg1, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c34_i64 = arith.constant 34 : i64
    %c12_i64 = arith.constant 12 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.or %arg0, %c1_i64 : i64
    %1 = llvm.and %c12_i64, %c34_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %c11_i64, %1 : i64
    %5 = llvm.ashr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.ashr %arg0, %c28_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ule" %arg1, %1 : i64
    %3 = llvm.select %2, %arg2, %arg1 : i1, i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %arg1, %arg1 : i1, i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.lshr %3, %2 : i64
    %5 = llvm.icmp "ne" %c_20_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.ashr %c_14_i64, %c37_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    %5 = llvm.select %4, %arg1, %arg1 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.udiv %1, %c13_i64 : i64
    %3 = llvm.xor %arg2, %c_11_i64 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.udiv %c41_i64, %3 : i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.or %c35_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.urem %c_29_i64, %0 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.select %3, %arg2, %c_17_i64 : i1, i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.ashr %arg0, %c_48_i64 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %c_48_i64, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.icmp "slt" %c_44_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.ashr %c36_i64, %0 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.lshr %arg2, %c50_i64 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.or %c_11_i64, %arg0 : i64
    %1 = llvm.xor %0, %c_18_i64 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.lshr %2, %c_9_i64 : i64
    %4 = llvm.zext %arg1 : i1 to i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c9_i64 = arith.constant 9 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.udiv %c9_i64, %c37_i64 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    %3 = llvm.select %2, %c_28_i64, %1 : i1, i64
    %4 = llvm.select %arg0, %3, %arg2 : i1, i64
    %5 = llvm.icmp "eq" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c_40_i64 = arith.constant -40 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.xor %c43_i64, %arg0 : i64
    %1 = llvm.and %c_4_i64, %c_40_i64 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sgt" %4, %c3_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_20_i64 = arith.constant -20 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sdiv %c_20_i64, %0 : i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.lshr %arg1, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %arg1, %c20_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %3, %arg0 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.sdiv %arg0, %c_18_i64 : i64
    %1 = llvm.sdiv %c37_i64, %0 : i64
    %2 = llvm.or %0, %arg1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %arg0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.sdiv %3, %arg1 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_20_i64 = arith.constant -20 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.srem %c_5_i64, %2 : i64
    %4 = llvm.ashr %c_35_i64, %c_20_i64 : i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.ashr %c_36_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.and %arg1, %arg2 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %c17_i64 = arith.constant 17 : i64
    %c_36_i64 = arith.constant -36 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ult" %0, %c17_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.lshr %c_36_i64, %3 : i64
    %5 = llvm.and %4, %c_14_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %c_37_i64, %arg1 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c50_i64 = arith.constant 50 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c50_i64 : i64
    %2 = llvm.srem %c29_i64, %1 : i64
    %3 = llvm.or %0, %arg1 : i64
    %4 = llvm.and %c4_i64, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %c6_i64 = arith.constant 6 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %arg0, %c_27_i64 : i64
    %1 = llvm.and %arg1, %c_25_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.srem %c6_i64, %2 : i64
    %4 = llvm.udiv %3, %arg0 : i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c28_i64 = arith.constant 28 : i64
    %c_40_i64 = arith.constant -40 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.udiv %c_40_i64, %c46_i64 : i64
    %1 = llvm.xor %0, %c28_i64 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.udiv %c10_i64, %0 : i64
    %5 = llvm.select %3, %2, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "eq" %c18_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c_41_i64 = arith.constant -41 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.select %true, %c_41_i64, %c_47_i64 : i1, i64
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.sdiv %arg0, %c_39_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.icmp "ugt" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %c49_i64 = arith.constant 49 : i64
    %true = arith.constant true
    %c1_i64 = arith.constant 1 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.ashr %c1_i64, %c37_i64 : i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.and %c49_i64, %0 : i64
    %3 = llvm.lshr %2, %c_17_i64 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "sge" %arg2, %0 : i64
    %2 = llvm.select %1, %arg2, %arg2 : i1, i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c_35_i64 = arith.constant -35 : i64
    %true = arith.constant true
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.xor %c34_i64, %arg0 : i64
    %1 = llvm.select %true, %0, %arg1 : i1, i64
    %2 = llvm.icmp "ne" %c_20_i64, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "ult" %c_35_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %c_20_i64, %0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.icmp "sle" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.select %1, %c29_i64, %0 : i1, i64
    %3 = llvm.xor %0, %arg0 : i64
    %4 = llvm.select %false, %2, %3 : i1, i64
    %5 = llvm.xor %4, %3 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c6_i64 = arith.constant 6 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %c6_i64, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.select %arg0, %c7_i64, %2 : i1, i64
    %4 = llvm.sdiv %arg1, %c_46_i64 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "eq" %c_49_i64, %c43_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.or %3, %c_29_i64 : i64
    %5 = llvm.icmp "eq" %c_36_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.sdiv %0, %arg1 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.icmp "ule" %4, %c_31_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %0, %1 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.select %arg0, %c_15_i64, %arg1 : i1, i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.select %arg0, %arg1, %c23_i64 : i1, i64
    %1 = llvm.icmp "sgt" %0, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ult" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %arg2, %1 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.and %c12_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.sdiv %3, %arg1 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.and %c21_i64, %c_46_i64 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.srem %arg2, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "eq" %4, %c_47_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c5_i64 = arith.constant 5 : i64
    %c24_i64 = arith.constant 24 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "sgt" %c8_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c24_i64, %1 : i64
    %3 = llvm.lshr %c5_i64, %c_34_i64 : i64
    %4 = llvm.select %arg1, %arg0, %3 : i1, i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.xor %c_40_i64, %c20_i64 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.sdiv %0, %arg1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.or %arg2, %3 : i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.srem %arg2, %arg2 : i64
    %2 = llvm.srem %0, %c1_i64 : i64
    %3 = llvm.srem %2, %c_18_i64 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.or %1, %c_13_i64 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c_17_i64, %c_9_i64 : i1, i64
    %2 = llvm.icmp "slt" %c15_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %1, %arg0 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c5_i64 = arith.constant 5 : i64
    %c34_i64 = arith.constant 34 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.srem %c34_i64, %c6_i64 : i64
    %1 = llvm.and %0, %c5_i64 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %c19_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sge" %0, %c_2_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.srem %arg1, %arg2 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %3, %c40_i64 : i64
    %5 = llvm.or %c49_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.lshr %arg0, %c_2_i64 : i64
    %1 = llvm.xor %0, %c_28_i64 : i64
    %2 = llvm.ashr %c_44_i64, %arg0 : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.udiv %c_32_i64, %arg0 : i64
    %1 = llvm.srem %0, %c_42_i64 : i64
    %2 = llvm.icmp "ugt" %c_31_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %0 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %c22_i64, %0 : i64
    %2 = llvm.icmp "slt" %arg1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "sgt" %arg0, %c13_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.zext %0 : i1 to i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.sdiv %arg0, %arg2 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "ule" %c_14_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %4, %c_31_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c3_i64 = arith.constant 3 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ult" %c3_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %c_21_i64, %0 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.srem %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.urem %1, %c_23_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c7_i64 = arith.constant 7 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.sdiv %1, %c8_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.ashr %c7_i64, %3 : i64
    %5 = llvm.urem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "ule" %c_21_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %c26_i64 = arith.constant 26 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.sdiv %c_14_i64, %arg1 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %c26_i64, %c_6_i64 : i64
    %5 = llvm.select %arg0, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.lshr %c42_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c_33_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.ashr %arg1, %2 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c9_i64 = arith.constant 9 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.or %arg0, %c_37_i64 : i64
    %1 = llvm.and %0, %c_36_i64 : i64
    %2 = llvm.udiv %c9_i64, %1 : i64
    %3 = llvm.ashr %2, %c_26_i64 : i64
    %4 = llvm.select %arg1, %arg2, %c_33_i64 : i1, i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sle" %c6_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "uge" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %arg1, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.and %3, %arg0 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.udiv %c38_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %4, %arg2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.urem %c14_i64, %arg0 : i64
    %1 = llvm.or %c_2_i64, %0 : i64
    %2 = llvm.srem %arg0, %c2_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.icmp "uge" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %c36_i64 : i64
    %2 = llvm.icmp "slt" %c_35_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %c19_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.lshr %c19_i64, %3 : i64
    %5 = llvm.udiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    %4 = llvm.and %c_38_i64, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %c45_i64 = arith.constant 45 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "uge" %0, %c45_i64 : i64
    %2 = llvm.and %arg0, %0 : i64
    %3 = llvm.sdiv %2, %c_29_i64 : i64
    %4 = llvm.udiv %arg1, %arg2 : i64
    %5 = llvm.select %1, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.sdiv %c0_i64, %c_3_i64 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ult" %c9_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %c_50_i64, %arg2 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.select %0, %1, %c_8_i64 : i1, i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.urem %arg2, %c49_i64 : i64
    %1 = llvm.udiv %c_35_i64, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "uge" %0, %c32_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.and %c39_i64, %1 : i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %c_46_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_18_i64 = arith.constant -18 : i64
    %c30_i64 = arith.constant 30 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.lshr %c_15_i64, %arg1 : i64
    %1 = llvm.and %arg2, %c30_i64 : i64
    %2 = llvm.and %1, %c_18_i64 : i64
    %3 = llvm.select %arg0, %0, %2 : i1, i64
    %4 = llvm.srem %c_31_i64, %3 : i64
    %5 = llvm.lshr %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.select %2, %arg0, %arg1 : i1, i64
    %4 = llvm.sext %2 : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.xor %c0_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %4, %arg2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.lshr %arg0, %c_24_i64 : i64
    %1 = llvm.icmp "uge" %arg1, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %c21_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %4, %arg0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %c22_i64 = arith.constant 22 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %c33_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %c22_i64, %c_13_i64 : i64
    %4 = llvm.udiv %3, %2 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.ashr %0, %c27_i64 : i64
    %3 = llvm.lshr %2, %arg2 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.sdiv %c_24_i64, %arg0 : i64
    %1 = llvm.and %arg1, %c29_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.ashr %0, %arg0 : i64
    %4 = llvm.select %2, %3, %arg0 : i1, i64
    %5 = llvm.icmp "sge" %c_28_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "eq" %c10_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %c27_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %arg0, %c29_i64 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "sge" %3, %arg0 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.lshr %arg1, %c_23_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "sge" %c5_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg1, %c_44_i64 : i64
    %3 = llvm.lshr %arg1, %arg2 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "slt" %arg2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.sdiv %arg2, %c4_i64 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %c47_i64 = arith.constant 47 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "sgt" %c47_i64, %c0_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %c_34_i64 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.trunc %0 : i1 to i64
    %5 = llvm.udiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.srem %c_37_i64, %c16_i64 : i64
    %1 = llvm.and %c_14_i64, %0 : i64
    %2 = llvm.icmp "sgt" %0, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sdiv %arg2, %arg2 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %c49_i64 : i64
    %2 = llvm.icmp "uge" %c_21_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg2, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %c_33_i64, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.icmp "sle" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.urem %c15_i64, %1 : i64
    %3 = llvm.icmp "sgt" %2, %c_19_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "ule" %0, %c_14_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.srem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "eq" %2, %c_21_i64 : i64
    %4 = llvm.select %3, %1, %arg1 : i1, i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c20_i64 = arith.constant 20 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.select %arg0, %c20_i64, %c_33_i64 : i1, i64
    %1 = llvm.udiv %c_47_i64, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.ashr %c_10_i64, %c_10_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.sdiv %c_15_i64, %arg0 : i64
    %4 = llvm.and %3, %arg1 : i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "ule" %c_1_i64, %c_6_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.lshr %c41_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %c47_i64, %0 : i64
    %2 = llvm.icmp "ule" %arg1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %arg0, %3, %arg2 : i1, i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c38_i64 = arith.constant 38 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %c_38_i64, %0 : i64
    %2 = llvm.urem %arg1, %c10_i64 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.select %1, %c38_i64, %3 : i1, i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "uge" %c_13_i64, %arg0 : i64
    %1 = llvm.and %c13_i64, %arg0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.select %0, %2, %2 : i1, i64
    %4 = llvm.sdiv %2, %2 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.icmp "ne" %arg0, %c7_i64 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.select %0, %c_35_i64, %1 : i1, i64
    %3 = llvm.sext %0 : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "eq" %c_29_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %c_3_i64, %arg1 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %c41_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.ashr %c_30_i64, %c_31_i64 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %c_41_i64, %arg0 : i64
    %4 = llvm.xor %3, %2 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %arg1, %c_48_i64 : i64
    %4 = llvm.and %3, %0 : i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.select %arg0, %arg1, %c_50_i64 : i1, i64
    %1 = llvm.and %arg2, %0 : i64
    %2 = llvm.xor %1, %c_28_i64 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.srem %3, %c_8_i64 : i64
    %5 = llvm.icmp "sgt" %4, %c_30_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %arg2, %c_47_i64 : i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c44_i64 = arith.constant 44 : i64
    %c35_i64 = arith.constant 35 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.sdiv %c8_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.or %c_43_i64, %0 : i64
    %3 = llvm.lshr %c44_i64, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.or %c35_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.udiv %c_16_i64, %arg0 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.icmp "uge" %arg0, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.srem %c11_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.icmp "eq" %3, %c11_i64 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.select %arg1, %arg0, %c36_i64 : i1, i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.or %c20_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.xor %arg2, %c_46_i64 : i64
    %3 = llvm.urem %2, %c_23_i64 : i64
    %4 = llvm.select %1, %arg0, %3 : i1, i64
    %5 = llvm.icmp "ugt" %4, %c44_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.select %arg0, %arg1, %c_14_i64 : i1, i64
    %1 = llvm.icmp "ule" %arg1, %arg1 : i64
    %2 = llvm.select %1, %arg1, %arg1 : i1, i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %c_38_i64 : i64
    %2 = llvm.icmp "sge" %0, %c_20_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "slt" %c_30_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.sdiv %c39_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.lshr %2, %arg2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %true = arith.constant true
    %c7_i64 = arith.constant 7 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.sdiv %arg0, %c11_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.select %true, %c7_i64, %2 : i1, i64
    %4 = llvm.sdiv %1, %c8_i64 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c33_i64 = arith.constant 33 : i64
    %c1_i64 = arith.constant 1 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.and %c1_i64, %c12_i64 : i64
    %1 = llvm.or %c33_i64, %0 : i64
    %2 = llvm.lshr %1, %c22_i64 : i64
    %3 = llvm.icmp "sgt" %2, %c1_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sgt" %c_37_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    %5 = llvm.select %4, %c0_i64, %c36_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %c_18_i64, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.udiv %c44_i64, %2 : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_4_i64 = arith.constant -4 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.and %c_21_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.urem %1, %c_4_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.urem %1, %0 : i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c40_i64 = arith.constant 40 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.or %0, %c45_i64 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.udiv %c40_i64, %arg2 : i64
    %4 = llvm.or %3, %c33_i64 : i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.sdiv %0, %0 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "eq" %arg0, %c_17_i64 : i64
    %1 = llvm.srem %arg1, %c38_i64 : i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.select %0, %arg0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.ashr %arg0, %c_22_i64 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "ult" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %c_6_i64, %0 : i64
    %2 = llvm.ashr %0, %arg1 : i64
    %3 = llvm.icmp "ne" %2, %c29_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.udiv %arg1, %arg0 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.udiv %3, %0 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.srem %arg0, %c6_i64 : i64
    %1 = llvm.select %arg2, %c_5_i64, %arg1 : i1, i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "ult" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.sdiv %c4_i64, %arg1 : i64
    %2 = llvm.icmp "ule" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "sgt" %c20_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.ashr %c_26_i64, %c35_i64 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.icmp "ult" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.urem %c_24_i64, %c14_i64 : i64
    %1 = llvm.srem %c_3_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c_14_i64 = arith.constant -14 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.or %c_36_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c_14_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "sge" %3, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %c_26_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %false = arith.constant false
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.or %3, %c25_i64 : i64
    %5 = llvm.ashr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %2, %c3_i64 : i64
    %4 = llvm.icmp "slt" %3, %arg2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.xor %arg1, %arg1 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %c29_i64, %0 : i64
    %2 = llvm.lshr %0, %arg1 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.srem %arg1, %c37_i64 : i64
    %5 = llvm.udiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.urem %c14_i64, %2 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %c_25_i64, %arg0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %4, %1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %c_26_i64, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.udiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c50_i64 = arith.constant 50 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.and %c50_i64, %c24_i64 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %arg1, %c46_i64 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.zext %arg2 : i1 to i64
    %1 = llvm.icmp "uge" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %4, %c35_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.or %c_42_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c30_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %c40_i64 = arith.constant 40 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.urem %c_35_i64, %c13_i64 : i64
    %1 = llvm.icmp "sgt" %c40_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.and %c_8_i64, %3 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.sdiv %c_50_i64, %arg1 : i64
    %1 = llvm.icmp "slt" %arg0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.srem %c_27_i64, %c_37_i64 : i64
    %1 = llvm.icmp "uge" %c_3_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %arg0, %0 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "ult" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "sge" %0, %c31_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %c_13_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %c_2_i64 = arith.constant -2 : i64
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.select %true, %arg0, %1 : i1, i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.ashr %c_2_i64, %3 : i64
    %5 = llvm.icmp "sle" %c_38_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.select %arg0, %c44_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ugt" %arg1, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.or %c_13_i64, %3 : i64
    %5 = llvm.srem %4, %c16_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c19_i64 = arith.constant 19 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.udiv %c9_i64, %arg0 : i64
    %1 = llvm.ashr %c19_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %c49_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.ashr %arg0, %c_1_i64 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %c10_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %c_29_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "uge" %0, %c10_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.and %3, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %c_25_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %c45_i64, %1 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.urem %4, %c_28_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %c5_i64 = arith.constant 5 : i64
    %c_3_i64 = arith.constant -3 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %c_15_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %c_3_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %c5_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %c_17_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c49_i64 = arith.constant 49 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %c32_i64 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.sdiv %c49_i64, %c_43_i64 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c_20_i64 = arith.constant -20 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.urem %c_20_i64, %c19_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ult" %2, %c_43_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c_8_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %1, %1 : i64
    %5 = llvm.udiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.srem %c9_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c42_i64 = arith.constant 42 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "eq" %c_22_i64, %c_28_i64 : i64
    %1 = llvm.lshr %c_25_i64, %c_31_i64 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.select %0, %3, %3 : i1, i64
    %5 = llvm.icmp "eq" %c42_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.lshr %c48_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.urem %0, %c14_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %c23_i64 = arith.constant 23 : i64
    %true = arith.constant true
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.select %true, %c6_i64, %arg0 : i1, i64
    %1 = llvm.icmp "sgt" %arg1, %c23_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %arg0, %c_19_i64 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.urem %arg0, %c43_i64 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c18_i64 = arith.constant 18 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.sdiv %c_28_i64, %arg0 : i64
    %1 = llvm.or %c18_i64, %0 : i64
    %2 = llvm.icmp "ugt" %c2_i64, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "uge" %arg1, %arg2 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.xor %arg1, %arg0 : i64
    %4 = llvm.urem %c9_i64, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c16_i64 = arith.constant 16 : i64
    %c0_i64 = arith.constant 0 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.lshr %c33_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c0_i64, %c16_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %c25_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c_31_i64 = arith.constant -31 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.lshr %c_31_i64, %c_43_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.or %arg0, %arg1 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.xor %4, %arg0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %true = arith.constant true
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.select %true, %c_33_i64, %arg0 : i1, i64
    %1 = llvm.sdiv %arg1, %arg1 : i64
    %2 = llvm.urem %c48_i64, %1 : i64
    %3 = llvm.xor %arg2, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %c31_i64, %1 : i64
    %3 = llvm.urem %arg2, %2 : i64
    %4 = llvm.ashr %3, %1 : i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %false = arith.constant false
    %c37_i64 = arith.constant 37 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.udiv %c37_i64, %c35_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.or %3, %c_38_i64 : i64
    %5 = llvm.srem %4, %2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.select %arg2, %c15_i64, %3 : i1, i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %3, %1 : i64
    %5 = llvm.icmp "sle" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.srem %arg1, %c_41_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.urem %0, %c31_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.srem %c_22_i64, %arg2 : i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.lshr %c30_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg1 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.select %2, %arg2, %1 : i1, i64
    %4 = llvm.sdiv %c_15_i64, %3 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.ashr %c_10_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c34_i64 = arith.constant 34 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %c44_i64, %c34_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %c38_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %c10_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %c49_i64, %2 : i64
    %4 = llvm.ashr %3, %2 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %c45_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %false = arith.constant false
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.select %false, %arg0, %c_35_i64 : i1, i64
    %1 = llvm.urem %c_48_i64, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.icmp "sge" %0, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %false = arith.constant false
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.select %false, %arg0, %c41_i64 : i1, i64
    %3 = llvm.srem %arg2, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c1_i64 = arith.constant 1 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c16_i64 = arith.constant 16 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.and %arg2, %arg2 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.icmp "eq" %c_3_i64, %c16_i64 : i64
    %3 = llvm.select %2, %c_42_i64, %c1_i64 : i1, i64
    %4 = llvm.select %arg0, %1, %3 : i1, i64
    %5 = llvm.xor %4, %c28_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.select %3, %1, %arg1 : i1, i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.xor %c_17_i64, %1 : i64
    %3 = llvm.udiv %2, %c_22_i64 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.srem %c_32_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.ashr %c_5_i64, %c6_i64 : i64
    %1 = llvm.or %c41_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %true = arith.constant true
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.urem %arg2, %arg1 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.select %arg0, %0, %2 : i1, i64
    %4 = llvm.select %true, %1, %c30_i64 : i1, i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c39_i64 = arith.constant 39 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %arg1, %c_26_i64 : i64
    %1 = llvm.lshr %arg2, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.urem %c39_i64, %c_48_i64 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.select %true, %arg1, %arg0 : i1, i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "ult" %arg1, %c_41_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.and %c_48_i64, %arg1 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.and %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg2, %c49_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %3, %c43_i64 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %c36_i64, %c27_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %false = arith.constant false
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.urem %c29_i64, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.udiv %c_50_i64, %1 : i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %c_5_i64, %arg1 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.select %1, %c_41_i64, %2 : i1, i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.icmp "ne" %4, %c12_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.ashr %arg1, %c_2_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.xor %c0_i64, %arg0 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.ashr %4, %arg2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %2 = llvm.select %1, %arg0, %arg1 : i1, i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.select %arg2, %2, %3 : i1, i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.xor %c10_i64, %c49_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.ashr %3, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %c17_i64, %0 : i64
    %2 = llvm.xor %arg0, %arg0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "sge" %3, %c0_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %4, %1 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.lshr %2, %1 : i64
    %4 = llvm.icmp "ule" %3, %2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c41_i64 = arith.constant 41 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.lshr %c2_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %c41_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %arg1, %c_15_i64 : i64
    %4 = llvm.and %3, %c18_i64 : i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %c26_i64 = arith.constant 26 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.icmp "ule" %c26_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c27_i64 = arith.constant 27 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.xor %c27_i64, %c26_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.ashr %0, %c39_i64 : i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "ult" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c38_i64 = arith.constant 38 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.and %c_25_i64, %arg0 : i64
    %1 = llvm.srem %c_44_i64, %0 : i64
    %2 = llvm.icmp "ult" %arg1, %arg2 : i64
    %3 = llvm.select %2, %c38_i64, %c40_i64 : i1, i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %arg0, %c32_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.urem %c17_i64, %2 : i64
    %4 = llvm.udiv %arg1, %2 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %true = arith.constant true
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.select %true, %arg0, %1 : i1, i64
    %3 = llvm.icmp "uge" %2, %c26_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c38_i64 = arith.constant 38 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.and %c22_i64, %arg1 : i64
    %1 = llvm.select %arg2, %c38_i64, %c19_i64 : i1, i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ult" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %c47_i64 = arith.constant 47 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.sdiv %c_8_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %c47_i64 : i64
    %2 = llvm.select %1, %arg1, %arg0 : i1, i64
    %3 = llvm.or %arg2, %arg0 : i64
    %4 = llvm.srem %3, %c_15_i64 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_18_i64 = arith.constant -18 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.udiv %c_40_i64, %arg0 : i64
    %1 = llvm.xor %arg1, %c_18_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.trunc %arg2 : i1 to i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.srem %arg0, %c_9_i64 : i64
    %1 = llvm.icmp "slt" %c_13_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %arg1, %arg1 : i64
    %4 = llvm.ashr %3, %c23_i64 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c8_i64 = arith.constant 8 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.and %arg0, %c_23_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "ule" %arg1, %c8_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %3, %c_41_i64 : i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c_23_i64 = arith.constant -23 : i64
    %true = arith.constant true
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.select %true, %arg2, %c_23_i64 : i1, i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.icmp "sgt" %c32_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c13_i64 = arith.constant 13 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.srem %c_18_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %c21_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %c13_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %c_44_i64, %0 : i64
    %2 = llvm.ashr %c35_i64, %arg1 : i64
    %3 = llvm.icmp "ne" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.sdiv %c35_i64, %arg0 : i64
    %1 = llvm.sdiv %c_14_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %c_20_i64, %0 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.urem %arg1, %1 : i64
    %4 = llvm.urem %c47_i64, %arg2 : i64
    %5 = llvm.select %2, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.urem %c_5_i64, %1 : i64
    %3 = llvm.srem %0, %0 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c38_i64 = arith.constant 38 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.xor %c_46_i64, %arg1 : i64
    %1 = llvm.or %0, %c25_i64 : i64
    %2 = llvm.select %arg0, %c38_i64, %1 : i1, i64
    %3 = llvm.or %0, %0 : i64
    %4 = llvm.ashr %3, %arg2 : i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.udiv %4, %c_38_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c47_i64 = arith.constant 47 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.sdiv %c7_i64, %arg0 : i64
    %1 = llvm.and %c_10_i64, %0 : i64
    %2 = llvm.icmp "ule" %0, %c47_i64 : i64
    %3 = llvm.select %2, %0, %arg0 : i1, i64
    %4 = llvm.udiv %3, %c22_i64 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c_45_i64 = arith.constant -45 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "ule" %c_45_i64, %c44_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %3, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c5_i64 = arith.constant 5 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.or %c_41_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.select %1, %2, %c5_i64 : i1, i64
    %4 = llvm.lshr %3, %c_1_i64 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %true = arith.constant true
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.sdiv %c23_i64, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.trunc %true : i1 to i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %arg1 : i64
    %2 = llvm.select %true, %1, %c_20_i64 : i1, i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "ult" %arg0, %c_9_i64 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.select %0, %2, %1 : i1, i64
    %4 = llvm.trunc %arg2 : i1 to i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %c_41_i64, %1 : i64
    %3 = llvm.lshr %arg1, %arg0 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.icmp "ult" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "sgt" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %c_26_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c10_i64 = arith.constant 10 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.and %c_9_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "ule" %2, %c10_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "eq" %4, %c23_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.sdiv %0, %c_47_i64 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %0, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.or %c9_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "ult" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.ashr %3, %3 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.xor %c_29_i64, %1 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.urem %3, %1 : i64
    %5 = llvm.select %false, %0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.urem %arg2, %0 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %c14_i64, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.icmp "uge" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.select %arg0, %c7_i64, %arg1 : i1, i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ugt" %c_26_i64, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.xor %c29_i64, %arg2 : i64
    %3 = llvm.or %arg2, %arg0 : i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    %5 = llvm.icmp "ule" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.urem %2, %c_8_i64 : i64
    %4 = llvm.or %3, %1 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "sge" %1, %c_10_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.lshr %c46_i64, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %c15_i64 = arith.constant 15 : i64
    %c5_i64 = arith.constant 5 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "sgt" %c5_i64, %c_48_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %2 = llvm.select %1, %c_40_i64, %arg1 : i1, i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.icmp "sle" %c15_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.srem %c19_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.lshr %0, %c1_i64 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ne" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %1, %arg2, %2 : i1, i64
    %4 = llvm.and %c19_i64, %0 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.and %arg0, %c13_i64 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.ashr %c_20_i64, %1 : i64
    %3 = llvm.lshr %1, %arg2 : i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %c49_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.or %arg0, %c_3_i64 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.icmp "sge" %c46_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %true = arith.constant true
    %c_7_i64 = arith.constant -7 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.sdiv %c_7_i64, %c_12_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.or %2, %c45_i64 : i64
    %4 = llvm.srem %0, %arg0 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.xor %arg2, %arg1 : i64
    %3 = llvm.or %arg2, %2 : i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ult" %c22_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %c23_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %true = arith.constant true
    %c43_i64 = arith.constant 43 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.select %arg1, %arg0, %c_25_i64 : i1, i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.select %2, %c43_i64, %1 : i1, i64
    %4 = llvm.sext %true : i1 to i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.srem %c_4_i64, %arg0 : i64
    %1 = llvm.sdiv %c22_i64, %arg2 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %true = arith.constant true
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.udiv %c_8_i64, %arg0 : i64
    %3 = llvm.select %true, %2, %arg0 : i1, i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.icmp "ne" %c_9_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.select %arg1, %1, %c_4_i64 : i1, i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.srem %3, %arg2 : i64
    %5 = llvm.icmp "slt" %4, %c46_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.srem %c_31_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.xor %arg0, %1 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "sge" %c_24_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c32_i64 = arith.constant 32 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.udiv %c32_i64, %c49_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.icmp "ule" %c37_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %arg2 : i1 to i64
    %1 = llvm.icmp "sle" %arg1, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.select %true, %2, %3 : i1, i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.srem %arg0, %c27_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.lshr %c22_i64, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c42_i64 = arith.constant 42 : i64
    %c49_i64 = arith.constant 49 : i64
    %c7_i64 = arith.constant 7 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.lshr %c7_i64, %c18_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.lshr %c42_i64, %c27_i64 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.lshr %c49_i64, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.urem %c_1_i64, %c_4_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sle" %0, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %c42_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %arg1, %arg1 : i64
    %3 = llvm.urem %c14_i64, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.udiv %arg0, %c9_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %arg2, %arg0 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %c32_i64, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %c37_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.or %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.srem %1, %c_22_i64 : i64
    %3 = llvm.icmp "slt" %c45_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.select %arg2, %1, %c_41_i64 : i1, i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.lshr %c_19_i64, %arg0 : i64
    %1 = llvm.srem %c30_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.and %arg2, %c_13_i64 : i64
    %2 = llvm.icmp "ult" %arg2, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %c45_i64, %0 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "ule" %0, %c18_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %c13_i64, %0 : i64
    %2 = llvm.xor %0, %c_37_i64 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.and %3, %c35_i64 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.and %arg0, %c34_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.urem %c_11_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.and %arg2, %c_38_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.udiv %c6_i64, %arg0 : i64
    %3 = llvm.sdiv %arg0, %0 : i64
    %4 = llvm.urem %3, %3 : i64
    %5 = llvm.select %1, %2, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.and %c_23_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.icmp "eq" %1, %c_33_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %3, %c13_i64 : i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c13_i64 = arith.constant 13 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.or %c9_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %c13_i64, %c_14_i64 : i64
    %2 = llvm.select %1, %c_15_i64, %c_49_i64 : i1, i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.lshr %3, %c10_i64 : i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.and %c_40_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c_28_i64 = arith.constant -28 : i64
    %true = arith.constant true
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.select %true, %c49_i64, %arg0 : i1, i64
    %1 = llvm.srem %c_28_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %c46_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %arg1, %arg2 : i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c31_i64, %arg1 : i1, i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.ashr %3, %arg2 : i64
    %5 = llvm.select %0, %c27_i64, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.xor %c34_i64, %c12_i64 : i64
    %1 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %2, %arg1, %1 : i1, i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg1, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %3, %1 : i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c10_i64 = arith.constant 10 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.or %0, %c_8_i64 : i64
    %2 = llvm.ashr %1, %c10_i64 : i64
    %3 = llvm.lshr %2, %c_3_i64 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.udiv %c18_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %c_16_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %c_26_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %c_47_i64 = arith.constant -47 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.lshr %c_47_i64, %c_38_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.select %true, %1, %0 : i1, i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.or %0, %c_49_i64 : i64
    %2 = llvm.lshr %arg2, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c32_i64 = arith.constant 32 : i64
    %c_20_i64 = arith.constant -20 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.srem %c22_i64, %arg0 : i64
    %1 = llvm.udiv %c_20_i64, %0 : i64
    %2 = llvm.srem %1, %c_4_i64 : i64
    %3 = llvm.or %0, %c30_i64 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "ne" %c32_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %c42_i64 = arith.constant 42 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.udiv %c42_i64, %c49_i64 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.ashr %c_5_i64, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sdiv %c33_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c_37_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.udiv %c_4_i64, %c4_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.xor %c_34_i64, %1 : i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %c26_i64 = arith.constant 26 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %c32_i64, %arg0 : i64
    %1 = llvm.udiv %c_22_i64, %arg1 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.sdiv %c26_i64, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "ule" %c_4_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %c_44_i64, %arg2 : i1, i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c34_i64 = arith.constant 34 : i64
    %c46_i64 = arith.constant 46 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ult" %c_49_i64, %c_27_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %c34_i64, %c39_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "slt" %c46_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.and %c27_i64, %arg0 : i64
    %1 = llvm.ashr %c_26_i64, %arg1 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.urem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.select %false, %c_3_i64, %2 : i1, i64
    %4 = llvm.trunc %0 : i1 to i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.srem %arg0, %c_19_i64 : i64
    %1 = llvm.icmp "sgt" %arg1, %c43_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ugt" %c_44_i64, %3 : i64
    %5 = llvm.select %4, %arg2, %0 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.select %true, %c_7_i64, %arg0 : i1, i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.ashr %c_7_i64, %0 : i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.lshr %c_20_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.lshr %c45_i64, %1 : i64
    %3 = llvm.and %arg0, %arg1 : i64
    %4 = llvm.xor %3, %arg1 : i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.select %false, %2, %3 : i1, i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %c10_i64 = arith.constant 10 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.xor %c_20_i64, %c10_i64 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %4, %c_14_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "ule" %c_36_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.or %3, %arg2 : i64
    %5 = llvm.or %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %c19_i64 = arith.constant 19 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c19_i64 : i64
    %2 = llvm.srem %1, %c_24_i64 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.select %3, %arg1, %arg1 : i1, i64
    %5 = llvm.ashr %c1_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "eq" %c47_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.select %0, %1, %arg2 : i1, i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.urem %c11_i64, %arg0 : i64
    %5 = llvm.urem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.srem %c_25_i64, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "slt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.select %arg0, %c_44_i64, %1 : i1, i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.or %c20_i64, %arg1 : i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.srem %0, %c29_i64 : i64
    %2 = llvm.icmp "uge" %1, %c2_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %c15_i64 = arith.constant 15 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "ule" %c15_i64, %c12_i64 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.icmp "sgt" %c_24_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "eq" %c_11_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %3, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.select %1, %c37_i64, %arg0 : i1, i64
    %3 = llvm.icmp "sge" %arg2, %arg1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.urem %arg1, %0 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c_40_i64 = arith.constant -40 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.ashr %c_40_i64, %c18_i64 : i64
    %1 = llvm.sdiv %0, %c_50_i64 : i64
    %2 = llvm.select %arg0, %1, %c11_i64 : i1, i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.ashr %3, %arg1 : i64
    %5 = llvm.icmp "eq" %4, %2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %true = arith.constant true
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.select %true, %arg0, %c29_i64 : i1, i64
    %3 = llvm.icmp "sgt" %c42_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg0, %c_3_i64 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "sle" %c33_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.srem %3, %c_36_i64 : i64
    %5 = llvm.icmp "ugt" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %3, %c_10_i64 : i64
    %5 = llvm.or %4, %3 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c0_i64 = arith.constant 0 : i64
    %false = arith.constant false
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.xor %c0_i64, %2 : i64
    %4 = llvm.ashr %arg1, %1 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c_7_i64 = arith.constant -7 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %arg0, %c_7_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.or %2, %c_18_i64 : i64
    %4 = llvm.or %3, %c_44_i64 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_20_i64 = arith.constant -20 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.and %1, %c_20_i64 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ult" %0, %c_5_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %c_24_i64 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.udiv %c39_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %2, %c_50_i64 : i64
    %4 = llvm.icmp "sle" %c45_i64, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.and %c7_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c19_i64 = arith.constant 19 : i64
    %c24_i64 = arith.constant 24 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.udiv %c24_i64, %c34_i64 : i64
    %1 = llvm.lshr %0, %c24_i64 : i64
    %2 = llvm.icmp "ult" %c19_i64, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %3, %c_31_i64 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.or %arg0, %c35_i64 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "sge" %arg0, %c_45_i64 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.lshr %c5_i64, %2 : i64
    %4 = llvm.icmp "sgt" %3, %arg0 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c22_i64 = arith.constant 22 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.srem %arg0, %c30_i64 : i64
    %1 = llvm.and %0, %c22_i64 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %c_21_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %c22_i64 = arith.constant 22 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.sdiv %c22_i64, %c9_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.ashr %0, %1 : i64
    %4 = llvm.udiv %3, %c_50_i64 : i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.lshr %c_43_i64, %arg0 : i64
    %1 = llvm.and %0, %c45_i64 : i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.xor %arg1, %arg1 : i64
    %5 = llvm.icmp "eq" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.srem %arg0, %c28_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "slt" %c_39_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sext %2 : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.sdiv %c_10_i64, %c_43_i64 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.srem %arg0, %0 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.xor %arg0, %c31_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg1, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %true = arith.constant true
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.select %true, %c_28_i64, %arg0 : i1, i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %c27_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.srem %arg0, %c12_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "eq" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sgt" %c6_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.sdiv %c29_i64, %3 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %arg1 : i64
    %3 = llvm.and %arg2, %0 : i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    %5 = llvm.icmp "ugt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.xor %arg0, %c30_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.trunc %2 : i1 to i64
    %5 = llvm.srem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.sdiv %c_8_i64, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ne" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %c_33_i64, %c6_i64 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.urem %c_38_i64, %c27_i64 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.lshr %arg2, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.xor %3, %c43_i64 : i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %c1_i64 = arith.constant 1 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.and %c_20_i64, %arg0 : i64
    %1 = llvm.urem %arg2, %arg0 : i64
    %2 = llvm.udiv %c1_i64, %c_1_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.lshr %c_26_i64, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "uge" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %arg0, %c_28_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.urem %c_26_i64, %1 : i64
    %3 = llvm.and %arg1, %1 : i64
    %4 = llvm.xor %3, %arg0 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.ashr %arg1, %c43_i64 : i64
    %1 = llvm.select %true, %arg2, %0 : i1, i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.srem %arg1, %3 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.sdiv %c26_i64, %1 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ult" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "ugt" %c30_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg2, %arg2 : i64
    %3 = llvm.select %0, %arg1, %2 : i1, i64
    %4 = llvm.urem %c_13_i64, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.srem %3, %arg0 : i64
    %5 = llvm.icmp "sgt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "ult" %c_34_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %arg2 : i64
    %3 = llvm.icmp "uge" %arg1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.udiv %4, %c13_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.udiv %c_7_i64, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.or %c47_i64, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.ashr %3, %c_9_i64 : i64
    %5 = llvm.icmp "ugt" %c_5_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c26_i64 = arith.constant 26 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.xor %c26_i64, %1 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "ugt" %4, %c_48_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %c_10_i64, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.ashr %c0_i64, %3 : i64
    %5 = llvm.srem %4, %c41_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c_21_i64 = arith.constant -21 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %c_21_i64, %0 : i64
    %2 = llvm.sdiv %c31_i64, %1 : i64
    %3 = llvm.ashr %c_23_i64, %2 : i64
    %4 = llvm.urem %3, %2 : i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %c10_i64 = arith.constant 10 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.xor %c10_i64, %c14_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "ne" %3, %c_49_i64 : i64
    %5 = llvm.select %4, %0, %2 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c8_i64 = arith.constant 8 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %c_37_i64, %0 : i64
    %2 = llvm.icmp "uge" %c8_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %c_21_i64, %arg1 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.urem %c7_i64, %c_23_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.srem %c_22_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.urem %arg1, %c_46_i64 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sdiv %c29_i64, %0 : i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.udiv %arg0, %0 : i64
    %4 = llvm.lshr %3, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.or %arg0, %c7_i64 : i64
    %1 = llvm.icmp "sgt" %c_41_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ne" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.and %arg0, %c_1_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.icmp "ne" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.and %c8_i64, %arg0 : i64
    %1 = llvm.ashr %c_32_i64, %0 : i64
    %2 = llvm.xor %0, %c9_i64 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.or %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "sge" %c_44_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.icmp "ule" %c_43_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.urem %c_33_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %c_19_i64 : i64
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.or %3, %c35_i64 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %c_6_i64 = arith.constant -6 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.udiv %c_6_i64, %c_18_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sge" %1, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "uge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.and %arg0, %c_2_i64 : i64
    %1 = llvm.icmp "ne" %0, %c_49_i64 : i64
    %2 = llvm.icmp "uge" %c_5_i64, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %1, %0, %3 : i1, i64
    %5 = llvm.icmp "eq" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.srem %arg1, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "sle" %arg2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.or %arg2, %c_50_i64 : i64
    %2 = llvm.icmp "ne" %1, %c_43_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "ugt" %c41_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %true, %1, %arg0 : i1, i64
    %3 = llvm.trunc %0 : i1 to i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.urem %c_6_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c28_i64 = arith.constant 28 : i64
    %true = arith.constant true
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.and %c17_i64, %arg0 : i64
    %1 = llvm.select %true, %arg2, %c28_i64 : i1, i64
    %2 = llvm.or %c22_i64, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c38_i64, %1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.lshr %c_21_i64, %c34_i64 : i64
    %1 = llvm.urem %c_21_i64, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %c31_i64 = arith.constant 31 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.ashr %c_15_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.xor %c_14_i64, %arg1 : i64
    %3 = llvm.srem %c31_i64, %2 : i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.srem %arg0, %c6_i64 : i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.udiv %c2_i64, %1 : i64
    %3 = llvm.icmp "sgt" %2, %c_9_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.trunc %arg2 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sle" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.sext %arg2 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.srem %c15_i64, %arg1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c29_i64 = arith.constant 29 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %c29_i64, %0 : i64
    %2 = llvm.sdiv %c_2_i64, %1 : i64
    %3 = llvm.udiv %1, %arg0 : i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.ashr %3, %arg1 : i64
    %5 = llvm.srem %4, %arg2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.or %0, %0 : i64
    %3 = llvm.or %2, %1 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "uge" %c22_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %c_26_i64, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.srem %1, %2 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.sdiv %arg0, %c47_i64 : i64
    %1 = llvm.xor %c_19_i64, %arg0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ugt" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %arg2, %c_39_i64 : i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %c12_i64 = arith.constant 12 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "slt" %arg0, %c_24_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %c12_i64, %1 : i64
    %3 = llvm.xor %c_6_i64, %arg0 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.select %2, %arg0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.select %4, %c41_i64, %c_9_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.ashr %0, %c42_i64 : i64
    %3 = llvm.srem %2, %c28_i64 : i64
    %4 = llvm.select %1, %2, %3 : i1, i64
    %5 = llvm.lshr %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c38_i64 = arith.constant 38 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "sge" %c38_i64, %c36_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c8_i64, %1 : i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c4_i64 = arith.constant 4 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.lshr %arg0, %c_35_i64 : i64
    %1 = llvm.srem %c7_i64, %0 : i64
    %2 = llvm.srem %c4_i64, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.srem %3, %c_2_i64 : i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c47_i64 = arith.constant 47 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.sdiv %arg0, %c_30_i64 : i64
    %1 = llvm.and %c47_i64, %0 : i64
    %2 = llvm.icmp "sle" %1, %c23_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.or %c10_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.xor %c_40_i64, %1 : i64
    %3 = llvm.icmp "sle" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.sdiv %arg0, %c_46_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.or %4, %2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.xor %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.select %arg0, %c4_i64, %arg1 : i1, i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ult" %c43_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %arg2, %c2_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c36_i64 = arith.constant 36 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %c_35_i64, %arg0 : i64
    %1 = llvm.and %arg1, %c36_i64 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.srem %2, %c_43_i64 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.icmp "uge" %4, %c_35_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ult" %1, %c_22_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %2, %3, %3 : i1, i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.trunc %false : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.and %0, %c2_i64 : i64
    %3 = llvm.icmp "uge" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %c12_i64 = arith.constant 12 : i64
    %c24_i64 = arith.constant 24 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.xor %c_13_i64, %c8_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %c24_i64, %2 : i64
    %4 = llvm.lshr %c12_i64, %3 : i64
    %5 = llvm.srem %4, %c_24_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.lshr %1, %c19_i64 : i64
    %3 = llvm.icmp "sge" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c27_i64 = arith.constant 27 : i64
    %false = arith.constant false
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.select %false, %arg0, %c1_i64 : i1, i64
    %1 = llvm.sdiv %c27_i64, %arg1 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.lshr %3, %c15_i64 : i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %arg2, %arg2 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.or %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %c21_i64 = arith.constant 21 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.udiv %arg0, %c34_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.srem %c21_i64, %1 : i64
    %3 = llvm.urem %c_36_i64, %2 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %arg0, %arg2 : i64
    %2 = llvm.select %1, %arg0, %c16_i64 : i1, i64
    %3 = llvm.and %c_24_i64, %c_8_i64 : i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    %5 = llvm.udiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.or %arg0, %c48_i64 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c_42_i64 = arith.constant -42 : i64
    %true = arith.constant true
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %c_42_i64 : i64
    %2 = llvm.select %true, %c28_i64, %1 : i1, i64
    %3 = llvm.sdiv %arg1, %c5_i64 : i64
    %4 = llvm.or %3, %1 : i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.sdiv %c49_i64, %arg1 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.srem %4, %c_19_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.and %c43_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %c_50_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "sle" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.srem %c11_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.or %arg0, %arg1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.srem %c29_i64, %arg0 : i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ne" %c_49_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.icmp "eq" %1, %c_25_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.trunc %0 : i1 to i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.and %c_37_i64, %0 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.sdiv %c_27_i64, %2 : i64
    %4 = llvm.urem %3, %1 : i64
    %5 = llvm.and %4, %2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c13_i64 : i1, i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.icmp "ne" %1, %arg2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %c_50_i64, %c_26_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.or %c4_i64, %1 : i64
    %3 = llvm.icmp "sle" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "slt" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "ult" %arg0, %c_5_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg0, %arg0 : i64
    %3 = llvm.udiv %arg1, %1 : i64
    %4 = llvm.select %2, %1, %3 : i1, i64
    %5 = llvm.icmp "sge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.xor %c_38_i64, %0 : i64
    %2 = llvm.icmp "ult" %arg1, %c17_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "eq" %c_15_i64, %c20_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.and %arg2, %c_13_i64 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c4_i64 = arith.constant 4 : i64
    %c_34_i64 = arith.constant -34 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %c4_i64, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.or %c_34_i64, %3 : i64
    %5 = llvm.icmp "sgt" %4, %c41_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %c48_i64 = arith.constant 48 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.urem %arg1, %c_17_i64 : i64
    %1 = llvm.sdiv %0, %c48_i64 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "eq" %2, %arg0 : i64
    %4 = llvm.srem %arg2, %0 : i64
    %5 = llvm.select %3, %4, %c_26_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sext %1 : i1 to i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.trunc %arg0 : i1 to i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %c7_i64, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.or %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.urem %arg0, %c22_i64 : i64
    %1 = llvm.select %arg1, %arg0, %0 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.urem %c28_i64, %2 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.icmp "slt" %1, %c_23_i64 : i64
    %3 = llvm.select %2, %c_19_i64, %c16_i64 : i1, i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    %5 = llvm.icmp "sgt" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.xor %c19_i64, %c_19_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.trunc %arg0 : i1 to i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c_8_i64 = arith.constant -8 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %c_8_i64, %0 : i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    %3 = llvm.and %2, %c41_i64 : i64
    %4 = llvm.lshr %3, %arg2 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.ashr %c_38_i64, %3 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.urem %c7_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %arg1, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.icmp "uge" %c38_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %c4_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %c2_i64, %2 : i64
    %4 = llvm.select %1, %arg0, %3 : i1, i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c14_i64 = arith.constant 14 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.udiv %arg0, %c_4_i64 : i64
    %1 = llvm.icmp "sgt" %arg1, %arg1 : i64
    %2 = llvm.select %1, %c14_i64, %c44_i64 : i1, i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.select %arg0, %0, %c_18_i64 : i1, i64
    %4 = llvm.urem %3, %1 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c8_i64 = arith.constant 8 : i64
    %c26_i64 = arith.constant 26 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.udiv %c26_i64, %c_2_i64 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %2, %c35_i64 : i64
    %4 = llvm.xor %3, %0 : i64
    %5 = llvm.icmp "slt" %c8_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.icmp "ne" %arg2, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.lshr %c_1_i64, %arg1 : i64
    %5 = llvm.select %arg0, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c18_i64 = arith.constant 18 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.ashr %c_17_i64, %c37_i64 : i64
    %1 = llvm.udiv %arg0, %c18_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %arg2, %c30_i64 : i64
    %4 = llvm.urem %arg1, %3 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.select %arg1, %c1_i64, %arg2 : i1, i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %c_39_i64, %arg2 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.icmp "slt" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.and %c39_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %arg1, %arg2 : i64
    %2 = llvm.xor %0, %c_10_i64 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.or %3, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.ashr %arg1, %c_24_i64 : i64
    %3 = llvm.icmp "sle" %2, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ne" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %arg0, %c_8_i64 : i64
    %1 = llvm.sdiv %c45_i64, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %0, %3 : i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.lshr %c13_i64, %c1_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    %5 = llvm.icmp "ne" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.udiv %arg0, %c7_i64 : i64
    %2 = llvm.or %arg2, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.select %false, %c32_i64, %2 : i1, i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %c2_i64, %arg1 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %c2_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.sdiv %c33_i64, %3 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c_34_i64 = arith.constant -34 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.select %arg0, %c_46_i64, %0 : i1, i64
    %2 = llvm.icmp "slt" %1, %c_34_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %c42_i64, %arg2 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.sdiv %arg2, %c_19_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %c_20_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "eq" %c_36_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "ule" %arg1, %1 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.select %0, %2, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c10_i64 = arith.constant 10 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.and %c3_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %c10_i64, %0 : i64
    %2 = llvm.urem %arg2, %c9_i64 : i64
    %3 = llvm.select %1, %arg1, %2 : i1, i64
    %4 = llvm.icmp "ule" %3, %arg0 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %c_28_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.lshr %c_24_i64, %2 : i64
    %4 = llvm.or %3, %c_18_i64 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.xor %arg0, %c_18_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sdiv %arg1, %arg2 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "eq" %c_41_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c24_i64 = arith.constant 24 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.urem %arg1, %c24_i64 : i64
    %3 = llvm.udiv %c_43_i64, %2 : i64
    %4 = llvm.udiv %3, %c2_i64 : i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "uge" %arg1, %1 : i64
    %3 = llvm.select %2, %0, %arg1 : i1, i64
    %4 = llvm.lshr %3, %0 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c7_i64 = arith.constant 7 : i64
    %c9_i64 = arith.constant 9 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.lshr %c36_i64, %arg0 : i64
    %1 = llvm.sdiv %c9_i64, %arg2 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.lshr %c7_i64, %c_9_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %0, %c_23_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.xor %c_14_i64, %3 : i64
    %5 = llvm.icmp "ult" %4, %c_2_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.icmp "uge" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c39_i64 : i64
    %2 = llvm.select %false, %arg1, %arg2 : i1, i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.urem %2, %c_14_i64 : i64
    %5 = llvm.xor %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.or %arg0, %c_29_i64 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %arg2, %0 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.ashr %c_33_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c_13_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c_9_i64, %c_14_i64 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c12_i64 = arith.constant 12 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.select %arg0, %c_44_i64, %c28_i64 : i1, i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.and %c12_i64, %c18_i64 : i64
    %5 = llvm.icmp "ult" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.and %arg0, %c24_i64 : i64
    %4 = llvm.lshr %3, %arg1 : i64
    %5 = llvm.icmp "ult" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.select %arg0, %c_26_i64, %c35_i64 : i1, i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %arg1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %c_39_i64 = arith.constant -39 : i64
    %c35_i64 = arith.constant 35 : i64
    %c23_i64 = arith.constant 23 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.srem %c23_i64, %c2_i64 : i64
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %2 = llvm.sdiv %1, %c35_i64 : i64
    %3 = llvm.srem %c_39_i64, %c_38_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.xor %arg0, %arg1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_4_i64 = arith.constant -4 : i64
    %c29_i64 = arith.constant 29 : i64
    %c25_i64 = arith.constant 25 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c_4_i64, %arg0 : i1, i64
    %2 = llvm.urem %c18_i64, %1 : i64
    %3 = llvm.udiv %c25_i64, %2 : i64
    %4 = llvm.icmp "sgt" %c29_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c23_i64 = arith.constant 23 : i64
    %false = arith.constant false
    %c35_i64 = arith.constant 35 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.select %false, %c35_i64, %c22_i64 : i1, i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.sdiv %c5_i64, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ne" %c23_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.lshr %c18_i64, %c11_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.or %1, %0 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.select %0, %c2_i64, %1 : i1, i64
    %3 = llvm.srem %arg1, %arg1 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "sle" %c12_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "ne" %arg1, %c44_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg0, %c_42_i64 : i64
    %3 = llvm.select %0, %arg1, %2 : i1, i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.icmp "ne" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "sgt" %4, %c_22_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c41_i64 = arith.constant 41 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sdiv %c41_i64, %c31_i64 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %2, %c49_i64 : i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.icmp "sle" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.sdiv %c13_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %c_2_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.srem %3, %0 : i64
    %5 = llvm.icmp "sge" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %c31_i64, %arg1 : i64
    %2 = llvm.udiv %0, %c_2_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.ashr %4, %c21_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.or %1, %1 : i64
    %4 = llvm.select %true, %2, %3 : i1, i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c17_i64 = arith.constant 17 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "slt" %c17_i64, %c_47_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %c_17_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %c_48_i64, %3 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %c_35_i64, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.or %3, %2 : i64
    %5 = llvm.lshr %c_38_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "eq" %c38_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.sdiv %c_19_i64, %3 : i64
    %5 = llvm.urem %c_23_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.srem %3, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c20_i64 = arith.constant 20 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.xor %c40_i64, %arg0 : i64
    %1 = llvm.udiv %c20_i64, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.sdiv %c19_i64, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.select %arg0, %c_4_i64, %arg1 : i1, i64
    %1 = llvm.ashr %c_21_i64, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "sgt" %arg2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.urem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg0, %arg1 : i1, i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.sdiv %arg1, %2 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %0 : i1, i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.sdiv %c_42_i64, %arg0 : i64
    %4 = llvm.ashr %3, %2 : i64
    %5 = llvm.icmp "sgt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.sdiv %c_33_i64, %c_44_i64 : i64
    %4 = llvm.lshr %3, %3 : i64
    %5 = llvm.lshr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %c_35_i64, %2 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg2, %arg2 : i1, i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %4, %c38_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %arg1, %arg0 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c_10_i64, %1 : i64
    %3 = llvm.ashr %c26_i64, %2 : i64
    %4 = llvm.zext %arg1 : i1 to i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.urem %c_1_i64, %c30_i64 : i64
    %1 = llvm.ashr %c42_i64, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %3, %1 : i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.or %2, %c_14_i64 : i64
    %4 = llvm.icmp "ult" %3, %2 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "ne" %c_33_i64, %c_45_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %arg1 : i64
    %3 = llvm.icmp "ult" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sle" %c_27_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.xor %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %arg1, %c33_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.and %3, %3 : i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %true = arith.constant true
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.and %arg0, %c_37_i64 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.select %true, %1, %arg1 : i1, i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.icmp "eq" %4, %c6_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %1 : i1 to i64
    %4 = llvm.urem %3, %c17_i64 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "sge" %arg0, %c11_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.sdiv %c_35_i64, %1 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.urem %arg0, %c_23_i64 : i64
    %1 = llvm.srem %arg1, %arg1 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.or %c_8_i64, %2 : i64
    %4 = llvm.and %3, %c_18_i64 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.udiv %arg1, %c_35_i64 : i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c37_i64 = arith.constant 37 : i64
    %c24_i64 = arith.constant 24 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.lshr %c24_i64, %c_22_i64 : i64
    %1 = llvm.sdiv %c37_i64, %0 : i64
    %2 = llvm.and %c_37_i64, %arg0 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.udiv %arg0, %c_29_i64 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ule" %arg2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.or %c_29_i64, %arg0 : i64
    %1 = llvm.select %arg1, %c44_i64, %0 : i1, i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.lshr %3, %arg0 : i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "ule" %c29_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %c33_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %3, %arg0 : i64
    %5 = llvm.icmp "ule" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.urem %c7_i64, %arg0 : i64
    %2 = llvm.select %0, %arg2, %1 : i1, i64
    %3 = llvm.lshr %c_26_i64, %arg2 : i64
    %4 = llvm.and %arg2, %3 : i64
    %5 = llvm.icmp "slt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c_24_i64 = arith.constant -24 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %arg1, %c_24_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.select %arg2, %c_32_i64, %c40_i64 : i1, i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg2, %c_16_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.udiv %c25_i64, %arg2 : i64
    %4 = llvm.select %2, %3, %arg2 : i1, i64
    %5 = llvm.and %c40_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "eq" %c_34_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    %3 = llvm.and %arg0, %1 : i64
    %4 = llvm.or %arg2, %3 : i64
    %5 = llvm.select %2, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.and %c16_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.urem %1, %c5_i64 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "sle" %c_15_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.urem %c_3_i64, %0 : i64
    %2 = llvm.or %arg2, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    %3 = llvm.urem %c_23_i64, %0 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.srem %arg0, %c_11_i64 : i64
    %1 = llvm.ashr %0, %c17_i64 : i64
    %2 = llvm.or %arg1, %arg1 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %c_8_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c_40_i64 = arith.constant -40 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.srem %c_40_i64, %c_21_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    %3 = llvm.icmp "sle" %2, %c38_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "ule" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.ashr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c29_i64 = arith.constant 29 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "sgt" %c_3_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.select %0, %c29_i64, %c13_i64 : i1, i64
    %5 = llvm.select %0, %3, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.udiv %1, %c_25_i64 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.icmp "sle" %c5_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %c24_i64, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.udiv %c_15_i64, %0 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.icmp "sge" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %0, %c26_i64 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.urem %c_12_i64, %c28_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.icmp "sgt" %arg1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %c_17_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg2, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.icmp "ugt" %4, %c25_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.udiv %c_5_i64, %c18_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.xor %2, %0 : i64
    %4 = llvm.or %3, %c32_i64 : i64
    %5 = llvm.sdiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %c_26_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.sdiv %c_11_i64, %arg2 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.lshr %arg0, %arg2 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.urem %c_12_i64, %arg1 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.icmp "ult" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c9_i64 = arith.constant 9 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "sle" %c9_i64, %c29_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.or %2, %1 : i64
    %4 = llvm.and %c_1_i64, %3 : i64
    %5 = llvm.icmp "sge" %4, %arg0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %c25_i64 = arith.constant 25 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.sdiv %c25_i64, %c_10_i64 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.udiv %c49_i64, %2 : i64
    %4 = llvm.xor %arg2, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.xor %arg1, %c27_i64 : i64
    %1 = llvm.urem %arg2, %c_5_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.or %2, %c43_i64 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c34_i64 = arith.constant 34 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.urem %c_4_i64, %c_17_i64 : i64
    %1 = llvm.and %0, %c_1_i64 : i64
    %2 = llvm.urem %c34_i64, %1 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.or %2, %c_44_i64 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "sle" %arg0, %c9_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %3, %c_27_i64 : i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c30_i64 = arith.constant 30 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.or %c30_i64, %arg2 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.select %arg0, %4, %c20_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %c46_i64 = arith.constant 46 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.srem %c46_i64, %c_48_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.and %c_13_i64, %arg1 : i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c27_i64 = arith.constant 27 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.lshr %c27_i64, %c38_i64 : i64
    %1 = llvm.udiv %c_22_i64, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.xor %0, %c12_i64 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.srem %arg2, %arg0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.lshr %c26_i64, %c_43_i64 : i64
    %5 = llvm.icmp "ugt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.or %c10_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %arg1, %0 : i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c5_i64 = arith.constant 5 : i64
    %c11_i64 = arith.constant 11 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.urem %arg1, %c_39_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.ashr %1, %c50_i64 : i64
    %3 = llvm.or %c11_i64, %2 : i64
    %4 = llvm.icmp "eq" %c5_i64, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "slt" %arg0, %c40_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.lshr %arg1, %arg2 : i64
    %5 = llvm.icmp "sle" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.xor %c_45_i64, %c25_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.sdiv %arg1, %0 : i64
    %3 = llvm.select %1, %arg0, %2 : i1, i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.icmp "ult" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.xor %c49_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sdiv %c48_i64, %1 : i64
    %3 = llvm.icmp "slt" %c_47_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.urem %c_40_i64, %arg1 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.icmp "uge" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.or %0, %c40_i64 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sge" %4, %c44_i64 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.or %c_49_i64, %arg1 : i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.srem %c_12_i64, %arg2 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.icmp "sge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "eq" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %3, %3 : i64
    %5 = llvm.icmp "ugt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %arg2, %c_47_i64 : i1, i64
    %2 = llvm.urem %c35_i64, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.lshr %3, %arg2 : i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "ne" %c40_i64, %c_1_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.srem %0, %arg2 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.urem %2, %arg2 : i64
    %4 = llvm.icmp "ne" %c_30_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "sge" %c_13_i64, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.or %c0_i64, %arg1 : i64
    %5 = llvm.srem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c39_i64 = arith.constant 39 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.sdiv %c_11_i64, %c_30_i64 : i64
    %1 = llvm.and %c39_i64, %0 : i64
    %2 = llvm.lshr %arg0, %arg0 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.and %c42_i64, %3 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.ashr %0, %c_19_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.urem %3, %c_9_i64 : i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %c_16_i64 = arith.constant -16 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "sge" %c_45_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %c_16_i64, %3 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %arg1, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.select %arg2, %arg0, %c_16_i64 : i1, i64
    %5 = llvm.icmp "slt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c40_i64 = arith.constant 40 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ugt" %c_6_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %c40_i64, %c32_i64 : i1, i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.or %3, %arg2 : i64
    %5 = llvm.or %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %c39_i64 = arith.constant 39 : i64
    %c9_i64 = arith.constant 9 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %c9_i64, %c35_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %c_6_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.xor %3, %2 : i64
    %5 = llvm.icmp "slt" %c39_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.sdiv %c2_i64, %1 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.or %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %arg2 : i64
    %3 = llvm.icmp "ult" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.udiv %0, %arg0 : i64
    %3 = llvm.urem %c19_i64, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "ugt" %4, %3 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.icmp "uge" %c18_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.lshr %c_27_i64, %c_30_i64 : i64
    %5 = llvm.icmp "ne" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.or %arg0, %c_12_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %1 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c_12_i64 = arith.constant -12 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.xor %c7_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "ult" %c_12_i64, %c42_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sge" %c7_i64, %c6_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.udiv %arg1, %arg2 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.srem %arg0, %c1_i64 : i64
    %1 = llvm.icmp "sle" %arg1, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.and %2, %c_29_i64 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.xor %c16_i64, %arg0 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.select %1, %c_29_i64, %0 : i1, i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.or %arg2, %arg1 : i64
    %5 = llvm.ashr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %c28_i64 : i64
    %2 = llvm.urem %c_22_i64, %1 : i64
    %3 = llvm.icmp "eq" %arg2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "eq" %arg0, %c_50_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.icmp "slt" %c_16_i64, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.icmp "eq" %4, %arg2 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.urem %c_45_i64, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "sge" %c17_i64, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.select %arg0, %c_29_i64, %c_21_i64 : i1, i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.icmp "ne" %c_46_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.ashr %arg2, %arg1 : i64
    %1 = llvm.lshr %arg2, %0 : i64
    %2 = llvm.udiv %1, %c17_i64 : i64
    %3 = llvm.icmp "ult" %arg2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.select %arg0, %arg1, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c11_i64 = arith.constant 11 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.srem %arg0, %c30_i64 : i64
    %1 = llvm.icmp "eq" %0, %c26_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %c11_i64, %2 : i64
    %4 = llvm.udiv %3, %0 : i64
    %5 = llvm.and %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c50_i64 = arith.constant 50 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.and %c50_i64, %c47_i64 : i64
    %1 = llvm.srem %c44_i64, %arg0 : i64
    %2 = llvm.srem %arg1, %arg2 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.urem %arg0, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.urem %3, %arg0 : i64
    %5 = llvm.lshr %4, %arg2 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %c50_i64, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %2, %c21_i64 : i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    %5 = llvm.trunc %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "sle" %c33_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %arg1, %1, %arg2 : i1, i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.ashr %arg2, %2 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.sdiv %arg0, %c23_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.lshr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c_1_i64, %1 : i64
    %3 = llvm.trunc %0 : i1 to i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.urem %4, %c_2_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.ashr %c14_i64, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.ashr %c49_i64, %1 : i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.udiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c13_i64 = arith.constant 13 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "uge" %c_23_i64, %c_38_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %0, %c13_i64, %1 : i1, i64
    %3 = llvm.srem %2, %c_19_i64 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.and %c5_i64, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.and %arg1, %c_34_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.urem %arg0, %c_8_i64 : i64
    %4 = llvm.xor %arg2, %3 : i64
    %5 = llvm.udiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "slt" %c_46_i64, %c_5_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.select %0, %arg2, %arg1 : i1, i64
    %3 = llvm.sdiv %arg1, %c_19_i64 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ult" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.srem %arg1, %c5_i64 : i64
    %2 = llvm.udiv %arg2, %arg1 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "slt" %c_39_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.and %arg0, %arg0 : i64
    %4 = llvm.select %2, %arg1, %3 : i1, i64
    %5 = llvm.lshr %c_41_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %c_34_i64 = arith.constant -34 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "eq" %arg0, %c27_i64 : i64
    %1 = llvm.and %c_34_i64, %arg0 : i64
    %2 = llvm.urem %1, %c_8_i64 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.or %arg0, %3 : i64
    %5 = llvm.icmp "sge" %c_34_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c_44_i64 = arith.constant -44 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.srem %arg0, %c0_i64 : i64
    %1 = llvm.lshr %arg1, %c_44_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.select %false, %1, %2 : i1, i64
    %4 = llvm.lshr %3, %arg2 : i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
