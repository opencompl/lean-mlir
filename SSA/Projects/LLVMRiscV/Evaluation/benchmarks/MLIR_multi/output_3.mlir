module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.and %c_22_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.trunc %c15_i64 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.and %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i32 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %c_41_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %c20_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.urem %arg0, %c_14_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %c45_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %c50_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.xor %c_39_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.and %0, %c50_i64 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg2 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %c41_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %c_25_i64, %arg0 : i1, i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.select %true, %arg0, %c39_i64 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.select %arg0, %c_25_i64, %arg1 : i1, i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.lshr %c28_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c24_i64 = arith.constant 24 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.trunc %c_39_i64 : i64 to i1
    %1 = llvm.select %0, %arg0, %c24_i64 : i1, i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.and %arg0, %c_44_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %arg0, %c_26_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i32) -> i64 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.zext %arg2 : i32 to i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.xor %c13_i64, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ult" %arg0, %c43_i64 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.udiv %1, %c46_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %c_50_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c0_i64 = arith.constant 0 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.ashr %arg0, %c_50_i64 : i64
    %1 = llvm.or %c0_i64, %0 : i64
    %2 = llvm.icmp "eq" %1, %c_14_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.or %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %arg2, %arg1 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    %0 = llvm.sext %arg0 : i32 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.srem %arg0, %c_4_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_25_i64 = arith.constant -25 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.xor %arg0, %c23_i64 : i64
    %1 = llvm.xor %c_25_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c39_i64 = arith.constant 39 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.or %c11_i64, %arg0 : i64
    %1 = llvm.and %c39_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i32 {
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.select %arg0, %c_46_i64, %0 : i1, i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.or %arg0, %c24_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %c_47_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "slt" %c_50_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.xor %0, %c13_i64 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.or %arg0, %c_29_i64 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.udiv %arg0, %c_43_i64 : i64
    %1 = llvm.or %c_33_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.ashr %arg0, %c8_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.and %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %c13_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c7_i64 = arith.constant 7 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "ult" %c7_i64, %c_46_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.lshr %c12_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.udiv %c_37_i64, %c_39_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c14_i64 = arith.constant 14 : i64
    %false = arith.constant false
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.select %false, %c_2_i64, %arg0 : i1, i64
    %1 = llvm.srem %c14_i64, %0 : i64
    %2 = llvm.or %c_41_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %arg0, %c42_i64 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %c_15_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.or %arg0, %c11_i64 : i64
    %1 = llvm.ashr %c11_i64, %arg1 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg1 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c47_i64 = arith.constant 47 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.xor %c8_i64, %arg0 : i64
    %1 = llvm.srem %c47_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.sdiv %c38_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %false = arith.constant false
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.sdiv %c_35_i64, %arg0 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.urem %c35_i64, %c40_i64 : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.icmp "sle" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %c_41_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg1 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "eq" %arg0, %c9_i64 : i64
    %1 = llvm.srem %c36_i64, %arg1 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_49_i64 = arith.constant -49 : i64
    %false = arith.constant false
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.select %false, %arg0, %c_38_i64 : i1, i64
    %1 = llvm.sdiv %0, %c_49_i64 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i32 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.urem %c43_i64, %arg0 : i64
    %1 = llvm.or %c9_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %c4_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.urem %c_49_i64, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.xor %c4_i64, %arg0 : i64
    %1 = llvm.urem %0, %c_12_i64 : i64
    %2 = llvm.lshr %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %c31_i64, %0 : i64
    %2 = llvm.icmp "ult" %1, %c_22_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.or %c_7_i64, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.ashr %c_36_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.urem %c49_i64, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.and %c17_i64, %arg0 : i64
    %1 = llvm.and %arg1, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.udiv %c_45_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %c_21_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.srem %1, %c32_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.trunc %1 : i64 to i32
    return %2 : i32
  }
}
// -----
