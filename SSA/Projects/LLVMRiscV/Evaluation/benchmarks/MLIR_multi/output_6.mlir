module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c30_i64 = arith.constant 30 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.trunc %c31_i64 : i64 to i1
    %1 = llvm.lshr %c24_i64, %arg0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.select %0, %c_27_i64, %2 : i1, i64
    %4 = llvm.srem %3, %2 : i64
    %5 = llvm.icmp "sgt" %c30_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.udiv %c50_i64, %arg1 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.select %true, %arg2, %arg1 : i1, i64
    %4 = llvm.udiv %arg2, %3 : i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_38_i64 = arith.constant -38 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "sgt" %arg0, %c2_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.and %3, %c_38_i64 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_31_i64 = arith.constant -31 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c49_i64 = arith.constant 49 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.or %c_28_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c_27_i64 : i64
    %2 = llvm.or %c49_i64, %1 : i64
    %3 = llvm.and %arg0, %c_31_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c30_i64 = arith.constant 30 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.and %2, %c28_i64 : i64
    %4 = llvm.or %3, %c30_i64 : i64
    %5 = llvm.xor %4, %c46_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.udiv %c_6_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.udiv %c_26_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.select %true, %0, %arg0 : i1, i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c_38_i64 = arith.constant -38 : i64
    %false = arith.constant false
    %c_37_i64 = arith.constant -37 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.urem %arg0, %c0_i64 : i64
    %1 = llvm.sdiv %c_37_i64, %0 : i64
    %2 = llvm.select %false, %1, %1 : i1, i64
    %3 = llvm.urem %arg1, %c41_i64 : i64
    %4 = llvm.urem %c_38_i64, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.trunc %c46_i64 : i64 to i1
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.urem %c_48_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.select %3, %arg0, %arg0 : i1, i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_9_i64 = arith.constant -9 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.xor %c30_i64, %c_9_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.or %3, %0 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i32 {
    %c_18_i64 = arith.constant -18 : i64
    %c47_i64 = arith.constant 47 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.xor %arg1, %c_18_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.udiv %c_21_i64, %2 : i64
    %4 = llvm.ashr %c47_i64, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.lshr %arg0, %c_4_i64 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.select %arg1, %2, %c15_i64 : i1, i64
    %4 = llvm.xor %3, %0 : i64
    %5 = llvm.and %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.sdiv %arg1, %arg1 : i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.select %false, %1, %3 : i1, i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.srem %c_50_i64, %c32_i64 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.sext %arg1 : i32 to i64
    %3 = llvm.select %1, %arg0, %2 : i1, i64
    %4 = llvm.srem %3, %arg0 : i64
    %5 = llvm.icmp "eq" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c27_i64 = arith.constant 27 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.trunc %c5_i64 : i64 to i1
    %1 = llvm.select %0, %arg0, %c25_i64 : i1, i64
    %2 = llvm.udiv %c27_i64, %1 : i64
    %3 = llvm.and %c_49_i64, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c_9_i64 = arith.constant -9 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c15_i64 = arith.constant 15 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.lshr %c15_i64, %c_5_i64 : i64
    %2 = llvm.select %0, %c_43_i64, %1 : i1, i64
    %3 = llvm.and %c_9_i64, %2 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.xor %c38_i64, %arg0 : i64
    %1 = llvm.or %arg2, %0 : i64
    %2 = llvm.srem %1, %c31_i64 : i64
    %3 = llvm.icmp "ult" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "sge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.or %arg1, %arg2 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.srem %c_23_i64, %arg0 : i64
    %1 = llvm.urem %c_3_i64, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.xor %3, %2 : i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.or %c_33_i64, %arg0 : i64
    %1 = llvm.ashr %c_5_i64, %0 : i64
    %2 = llvm.ashr %1, %c_17_i64 : i64
    %3 = llvm.icmp "sle" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i32 {
    %c20_i64 = arith.constant 20 : i64
    %c_12_i32 = arith.constant -12 : i32
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.lshr %arg0, %c0_i64 : i64
    %1 = llvm.sext %c_12_i32 : i32 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.select %arg1, %1, %c20_i64 : i1, i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.ashr %arg0, %c4_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.urem %arg0, %0 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.trunc %c_9_i64 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.and %arg1, %arg2 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %false = arith.constant false
    %c_15_i64 = arith.constant -15 : i64
    %c7_i64 = arith.constant 7 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sdiv %c7_i64, %c20_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.select %false, %0, %c_8_i64 : i1, i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.srem %c_15_i64, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i32 {
    %c_36_i32 = arith.constant -36 : i32
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.sext %c_36_i32 : i32 to i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.udiv %c_15_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.urem %c7_i64, %arg2 : i64
    %4 = llvm.xor %3, %c_27_i64 : i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i32 = arith.constant 31 : i32
    %c45_i64 = arith.constant 45 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.or %arg0, %c2_i64 : i64
    %2 = llvm.udiv %arg1, %c45_i64 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.sext %c31_i32 : i32 to i64
    %5 = llvm.icmp "sgt" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.or %c14_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.udiv %2, %1 : i64
    %4 = llvm.srem %c_23_i64, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sdiv %c_26_i64, %c27_i64 : i64
    %1 = llvm.sdiv %c39_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.sdiv %arg0, %arg1 : i64
    %5 = llvm.or %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i32 {
    %c13_i64 = arith.constant 13 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.sdiv %c_32_i64, %c10_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.select %arg1, %arg0, %c_15_i64 : i1, i64
    %4 = llvm.select %2, %3, %c13_i64 : i1, i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "sge" %c3_i64, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.xor %4, %0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.xor %arg0, %c_22_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i32 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.sdiv %c_2_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i32 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %arg0, %0, %3 : i1, i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i32 {
    %c_38_i64 = arith.constant -38 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.udiv %c41_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg0 : i1, i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.srem %3, %c_38_i64 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.lshr %c12_i64, %c28_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.trunc %arg0 : i64 to i1
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.and %c50_i64, %c_24_i64 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg0, %arg1, %0 : i1, i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.sdiv %c46_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.or %arg0, %0 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.urem %c_3_i64, %c_26_i64 : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %arg0, %0 : i64
    %5 = llvm.icmp "sge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64) -> i32 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sext %arg0 : i32 to i64
    %1 = llvm.trunc %arg1 : i64 to i1
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %c31_i64, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i1 {
    %0 = llvm.sext %arg0 : i32 to i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.xor %2, %0 : i64
    %4 = llvm.sdiv %3, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %c14_i64, %0 : i64
    %2 = llvm.srem %0, %arg0 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.lshr %3, %1 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "ult" %arg0, %c15_i64 : i64
    %1 = llvm.select %0, %c_33_i64, %arg0 : i1, i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.icmp "sgt" %4, %arg1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c12_i64 = arith.constant 12 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.urem %c_16_i64, %0 : i64
    %2 = llvm.or %c12_i64, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.and %c_47_i64, %1 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.xor %arg2, %c_38_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.select %arg1, %1, %2 : i1, i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.xor %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %arg0, %c10_i64 : i64
    %4 = llvm.sdiv %3, %3 : i64
    %5 = llvm.or %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64) -> i32 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.lshr %1, %c49_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.xor %c50_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.sdiv %arg0, %0 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i32 {
    %c33_i64 = arith.constant 33 : i64
    %true = arith.constant true
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.urem %arg2, %arg2 : i64
    %1 = llvm.select %arg1, %c37_i64, %0 : i1, i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.or %c33_i64, %1 : i64
    %4 = llvm.select %true, %2, %3 : i1, i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c_20_i64 = arith.constant -20 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.srem %c_46_i64, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.xor %arg2, %c_20_i64 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %c5_i64, %0 : i64
    %2 = llvm.trunc %arg1 : i64 to i1
    %3 = llvm.select %2, %1, %1 : i1, i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.xor %c_21_i64, %arg0 : i64
    %1 = llvm.udiv %c_16_i64, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_41_i64 = arith.constant -41 : i64
    %c3_i64 = arith.constant 3 : i64
    %c_39_i64 = arith.constant -39 : i64
    %c14_i64 = arith.constant 14 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.trunc %c28_i64 : i64 to i1
    %1 = llvm.select %0, %arg0, %c3_i64 : i1, i64
    %2 = llvm.ashr %c14_i64, %1 : i64
    %3 = llvm.lshr %c_39_i64, %2 : i64
    %4 = llvm.ashr %3, %c_41_i64 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %true = arith.constant true
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.select %true, %c14_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %arg2, %0, %0 : i1, i64
    %4 = llvm.udiv %3, %c12_i64 : i64
    %5 = llvm.xor %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c15_i64 = arith.constant 15 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "sle" %c41_i64, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.sdiv %1, %c15_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.ashr %c_24_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.udiv %c_3_i64, %arg2 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c32_i64 = arith.constant 32 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.urem %c5_i64, %2 : i64
    %4 = llvm.sdiv %c32_i64, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.lshr %3, %3 : i64
    %5 = llvm.or %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i64 {
    %true = arith.constant true
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i32 {
    %c_21_i64 = arith.constant -21 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %0, %c11_i64 : i64
    %2 = llvm.icmp "ule" %1, %c_21_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c13_i64 = arith.constant 13 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.and %c13_i64, %c34_i64 : i64
    %1 = llvm.trunc %arg0 : i64 to i1
    %2 = llvm.lshr %c_40_i64, %0 : i64
    %3 = llvm.select %1, %2, %2 : i1, i64
    %4 = llvm.lshr %arg0, %3 : i64
    %5 = llvm.icmp "ne" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32, %arg2: i64) -> i32 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i32 to i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.urem %2, %c44_i64 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c_32_i64 = arith.constant -32 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "slt" %arg1, %arg1 : i64
    %1 = llvm.select %0, %arg1, %c_32_i64 : i1, i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.ashr %c2_i64, %2 : i64
    %4 = llvm.lshr %c_1_i64, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.urem %c_5_i64, %c_37_i64 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.ashr %c3_i64, %1 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.ashr %c3_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.and %c6_i64, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.or %arg1, %arg2 : i64
    %5 = llvm.srem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32) -> i32 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.sdiv %arg0, %c19_i64 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32, %arg2: i64) -> i32 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.zext %arg1 : i32 to i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.select %1, %arg2, %c34_i64 : i1, i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sdiv %c31_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.lshr %c_40_i64, %arg1 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.ashr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i32 {
    %c29_i64 = arith.constant 29 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.and %c29_i64, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %arg0, %c38_i64, %3 : i1, i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.or %c45_i64, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %c_36_i64, %arg2 : i64
    %2 = llvm.ashr %arg2, %arg0 : i64
    %3 = llvm.select %1, %2, %c7_i64 : i1, i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %c_13_i64 : i64
    %2 = llvm.ashr %c_14_i64, %c_37_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.and %c18_i64, %1 : i64
    %3 = llvm.and %0, %arg1 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.and %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.and %c_39_i64, %arg0 : i64
    %1 = llvm.lshr %c19_i64, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.urem %c_42_i64, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.sdiv %arg0, %c_45_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.ashr %2, %c48_i64 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.icmp "sge" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %c50_i64, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.ashr %c_31_i64, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.trunc %c5_i64 : i64 to i1
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.sdiv %c10_i64, %arg0 : i64
    %4 = llvm.select %2, %c_17_i64, %3 : i1, i64
    %5 = llvm.icmp "uge" %4, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %false = arith.constant false
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.or %arg1, %c_32_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.select %true, %0, %arg0 : i1, i64
    %3 = llvm.select %false, %1, %2 : i1, i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.srem %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.xor %c_50_i64, %arg2 : i64
    %3 = llvm.urem %c_25_i64, %0 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "ugt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.select %arg1, %c_12_i64, %arg0 : i1, i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %3, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i32 {
    %c_27_i64 = arith.constant -27 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.select %arg0, %c_37_i64, %c_21_i64 : i1, i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.lshr %3, %c_27_i64 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c_35_i64 = arith.constant -35 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "sgt" %arg0, %c48_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.urem %arg2, %c_35_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.zext %0 : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.and %c_35_i64, %c15_i64 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.zext %arg0 : i32 to i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "sge" %c9_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.and %c_5_i64, %1 : i64
    %3 = llvm.xor %c_27_i64, %arg1 : i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.icmp "ule" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.lshr %2, %c42_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.lshr %c28_i64, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.icmp "slt" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_34_i32 = arith.constant -34 : i32
    %0 = llvm.sext %c_34_i32 : i32 to i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.select %3, %0, %arg0 : i1, i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
