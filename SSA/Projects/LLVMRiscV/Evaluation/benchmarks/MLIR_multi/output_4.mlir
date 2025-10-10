module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.urem %arg2, %c11_i64 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.trunc %arg2 : i1 to i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.udiv %1, %c_9_i64 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.xor %1, %c8_i64 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c_35_i64, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.urem %c_29_i64, %arg0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "slt" %c_31_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.xor %arg2, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %c0_i64, %0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.and %c_5_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %c16_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %c37_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "uge" %c35_i64, %arg0 : i64
    %1 = llvm.sdiv %arg2, %arg0 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.select %0, %arg1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.xor %arg0, %c41_i64 : i64
    %1 = llvm.icmp "eq" %arg1, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg1, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.and %c30_i64, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.select %true, %0, %arg0 : i1, i64
    %2 = llvm.ashr %1, %c_22_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.srem %c_27_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sgt" %c_40_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %c_47_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.urem %arg0, %c32_i64 : i64
    %1 = llvm.urem %c28_i64, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %c9_i64 = arith.constant 9 : i64
    %c_35_i64 = arith.constant -35 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "sle" %0, %c_35_i64 : i64
    %2 = llvm.select %1, %c9_i64, %c_34_i64 : i1, i64
    %3 = llvm.lshr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.or %c_25_i64, %arg0 : i64
    %1 = llvm.ashr %c_6_i64, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.select %true, %c_44_i64, %arg0 : i1, i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.ashr %c_37_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %c_3_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %c12_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "ule" %c34_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    %3 = llvm.select %2, %arg2, %c47_i64 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.xor %c19_i64, %c_48_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %c25_i64 = arith.constant 25 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.lshr %c12_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %c25_i64, %c_13_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %arg0, %c_43_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %c8_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.xor %0, %c44_i64 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.xor %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.sdiv %c38_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "ne" %arg0, %c35_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg2 : i64
    %1 = llvm.icmp "uge" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.sdiv %arg0, %c_29_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.or %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %0, %c_42_i64 : i64
    %2 = llvm.sdiv %c_32_i64, %arg2 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c39_i64 : i64
    %2 = llvm.lshr %arg0, %c_14_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c_46_i64, %1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.udiv %c13_i64, %arg1 : i64
    %1 = llvm.select %arg0, %c43_i64, %0 : i1, i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "eq" %c20_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.and %1, %c18_i64 : i64
    %3 = llvm.icmp "ule" %c_24_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.or %arg1, %c_18_i64 : i64
    %1 = llvm.select %arg0, %c_42_i64, %0 : i1, i64
    %2 = llvm.and %0, %0 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "ult" %c_30_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %false = arith.constant false
    %c30_i64 = arith.constant 30 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.ashr %c30_i64, %c45_i64 : i64
    %1 = llvm.select %false, %c_7_i64, %arg1 : i1, i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c_3_i64 = arith.constant -3 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %c45_i64, %c_3_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %c_28_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %c14_i64, %c17_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.xor %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c_18_i64, %c48_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.srem %1, %c37_i64 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c_20_i64 = arith.constant -20 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.xor %arg1, %c17_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.srem %1, %c_20_i64 : i64
    %3 = llvm.lshr %2, %c_37_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg1, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %2, %c6_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c23_i64 = arith.constant 23 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.srem %c17_i64, %arg0 : i64
    %1 = llvm.sdiv %c23_i64, %c_2_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %c_4_i64, %0 : i64
    %2 = llvm.xor %c_19_i64, %1 : i64
    %3 = llvm.icmp "ule" %c_22_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.ashr %arg0, %c_5_i64 : i64
    %1 = llvm.sdiv %arg0, %c1_i64 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.sdiv %c_40_i64, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.urem %c4_i64, %1 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sge" %c48_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c49_i64 = arith.constant 49 : i64
    %c16_i64 = arith.constant 16 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.and %c16_i64, %c_46_i64 : i64
    %1 = llvm.select %false, %c49_i64, %0 : i1, i64
    %2 = llvm.or %arg0, %arg0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c31_i64 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "ule" %arg0, %c_44_i64 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.sdiv %1, %c27_i64 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.lshr %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.sdiv %c_10_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %2 = llvm.select %1, %c34_i64, %0 : i1, i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "ne" %arg0, %c_14_i64 : i64
    %1 = llvm.icmp "uge" %arg0, %c26_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %0, %2, %arg1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.srem %c39_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %arg1, %c40_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.and %c12_i64, %1 : i64
    %3 = llvm.icmp "uge" %c3_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.sdiv %c29_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.urem %arg1, %arg1 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.select %arg1, %c_8_i64, %arg0 : i1, i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %c32_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.or %c_39_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.srem %c_37_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %c28_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c_43_i64 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %arg1, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.ashr %c_14_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %c1_i64, %c48_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.sdiv %c_16_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "ule" %c_43_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %1, %c_45_i64 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.xor %arg0, %c_32_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.select %true, %arg0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.sdiv %c34_i64, %c47_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.select %arg0, %1, %1 : i1, i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c18_i64 = arith.constant 18 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.udiv %arg0, %c19_i64 : i64
    %1 = llvm.xor %c18_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.or %c_36_i64, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %c_45_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.ashr %c_2_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.select %2, %arg2, %arg1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.ashr %c_47_i64, %c_41_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.or %2, %c_29_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.or %arg1, %c_43_i64 : i64
    %1 = llvm.icmp "ne" %c25_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sdiv %c25_i64, %0 : i64
    %2 = llvm.srem %0, %arg1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c30_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %c43_i64 = arith.constant 43 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.ashr %0, %c43_i64 : i64
    %2 = llvm.or %c_30_i64, %0 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.lshr %c46_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.urem %c3_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %c24_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.srem %c39_i64, %arg0 : i64
    %1 = llvm.urem %c42_i64, %arg1 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %c14_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %c32_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.or %arg0, %c_50_i64 : i64
    %1 = llvm.ashr %c_43_i64, %arg2 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "eq" %2, %c16_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.lshr %1, %c_13_i64 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %c16_i64 = arith.constant 16 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.xor %c_6_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %c_27_i64 : i64
    %2 = llvm.xor %c16_i64, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.or %c3_i64, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %c13_i64, %arg2 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "eq" %2, %c20_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c_31_i64, %arg1 : i1, i64
    %2 = llvm.and %arg2, %c4_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "ugt" %arg0, %c22_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %c_7_i64, %0 : i1, i64
    %2 = llvm.udiv %arg1, %0 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %c_38_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %2, %c_46_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.select %arg1, %c24_i64, %arg0 : i1, i64
    %1 = llvm.ashr %c_49_i64, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.or %c_2_i64, %arg0 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.and %c_37_i64, %arg2 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.select %0, %2, %c4_i64 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.and %arg2, %arg1 : i64
    %1 = llvm.icmp "ne" %0, %c43_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg0, %arg1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %c_32_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %c36_i64, %arg0 : i64
    %2 = llvm.select %1, %0, %c_39_i64 : i1, i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.xor %c47_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c18_i64 = arith.constant 18 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.lshr %c18_i64, %c9_i64 : i64
    %1 = llvm.xor %c30_i64, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.udiv %c_17_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %c23_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %c46_i64, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.or %arg0, %c5_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %arg1 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %c22_i64 = arith.constant 22 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %c8_i64, %0 : i64
    %2 = llvm.sdiv %c22_i64, %1 : i64
    %3 = llvm.or %c_27_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.lshr %arg1, %0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.and %c22_i64, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.select %true, %arg0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c1_i64 = arith.constant 1 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.lshr %c_49_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sdiv %c1_i64, %c11_i64 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c4_i64 = arith.constant 4 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.select %arg0, %c4_i64, %c11_i64 : i1, i64
    %1 = llvm.icmp "ne" %c_17_i64, %c_46_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.sdiv %c_40_i64, %c_12_i64 : i64
    %1 = llvm.icmp "sle" %arg0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.xor %c_5_i64, %arg0 : i64
    %1 = llvm.udiv %c33_i64, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.srem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c_37_i64 = arith.constant -37 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.urem %c_37_i64, %0 : i64
    %2 = llvm.and %c16_i64, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %c_11_i64 : i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    %3 = llvm.select %2, %arg1, %0 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "eq" %c33_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.udiv %c12_i64, %c_1_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.ashr %arg1, %arg1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c_18_i64 = arith.constant -18 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.select %false, %c_18_i64, %c_44_i64 : i1, i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.select %1, %arg0, %arg1 : i1, i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.lshr %c43_i64, %c0_i64 : i64
    %2 = llvm.select %0, %arg2, %1 : i1, i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "ugt" %c_44_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.xor %c25_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.lshr %c_21_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "sge" %c49_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.and %arg0, %c_32_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %c35_i64 = arith.constant 35 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %c35_i64, %0 : i64
    %2 = llvm.and %1, %c_14_i64 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.sdiv %c_21_i64, %c17_i64 : i64
    %1 = llvm.icmp "slt" %arg0, %c_49_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.xor %c25_i64, %0 : i64
    %2 = llvm.and %arg2, %c_30_i64 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.urem %arg0, %c_35_i64 : i64
    %1 = llvm.icmp "ult" %c36_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c16_i64 = arith.constant 16 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "ule" %c0_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.srem %c16_i64, %1 : i64
    %3 = llvm.icmp "eq" %c_7_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.icmp "ugt" %arg1, %c30_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %c32_i64, %0 : i64
    %2 = llvm.udiv %c_8_i64, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %c33_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "slt" %c_35_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %true = arith.constant true
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "eq" %c0_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %true, %1, %1 : i1, i64
    %3 = llvm.xor %2, %c_48_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.ashr %1, %c26_i64 : i64
    %3 = llvm.xor %c_18_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.urem %c_28_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.or %c_8_i64, %arg2 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.select %false, %c_42_i64, %arg0 : i1, i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c49_i64 = arith.constant 49 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.ashr %arg0, %c45_i64 : i64
    %1 = llvm.or %0, %c49_i64 : i64
    %2 = llvm.srem %arg1, %c_14_i64 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.select %arg0, %0, %c_2_i64 : i1, i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.ashr %c_49_i64, %c_25_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.srem %arg1, %c_42_i64 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.urem %1, %c21_i64 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.and %arg1, %c_42_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.or %1, %arg2 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.ashr %c13_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %c46_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %c_14_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %c40_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "ule" %c_17_i64, %c_43_i64 : i64
    %1 = llvm.lshr %arg0, %c_41_i64 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.icmp "slt" %2, %c24_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.lshr %c38_i64, %c_18_i64 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "eq" %c_14_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %arg1, %c_13_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.and %arg0, %c_46_i64 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.icmp "ugt" %c_50_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.xor %arg1, %c39_i64 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %c_32_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ult" %c50_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %c18_i64 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %arg1, %c_11_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "uge" %c46_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "ult" %arg0, %c35_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %c_5_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c_44_i64 = arith.constant -44 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.and %c_44_i64, %c44_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c36_i64 = arith.constant 36 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.or %arg0, %c5_i64 : i64
    %1 = llvm.udiv %c36_i64, %c16_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "ne" %c_33_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.or %arg0, %c_49_i64 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.select %1, %arg1, %arg0 : i1, i64
    %3 = llvm.srem %c37_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %false = arith.constant false
    %c_37_i64 = arith.constant -37 : i64
    %true = arith.constant true
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.select %true, %arg0, %c43_i64 : i1, i64
    %1 = llvm.xor %c_37_i64, %0 : i64
    %2 = llvm.select %false, %arg0, %1 : i1, i64
    %3 = llvm.icmp "ult" %2, %c_15_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %c9_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.icmp "eq" %c9_i64, %0 : i64
    %2 = llvm.select %1, %c_15_i64, %c7_i64 : i1, i64
    %3 = llvm.srem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %arg1, %c_19_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.and %c_19_i64, %c1_i64 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg1, %arg0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.udiv %arg0, %c_35_i64 : i64
    %1 = llvm.xor %0, %c13_i64 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.select %arg0, %c45_i64, %arg1 : i1, i64
    %1 = llvm.lshr %c15_i64, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.udiv %c_45_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.sdiv %0, %c_35_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sge" %c_20_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %c10_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %c40_i64, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.lshr %c_48_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.srem %arg0, %c13_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ule" %1, %c_3_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %c21_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %c15_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "slt" %c4_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.lshr %1, %c_26_i64 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c34_i64 = arith.constant 34 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.srem %c34_i64, %c_15_i64 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %c32_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %c_15_i64, %arg1 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "sgt" %c11_i64, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.select %2, %arg2, %1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.lshr %c46_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.ashr %c_22_i64, %arg1 : i64
    %3 = llvm.select %1, %2, %c_8_i64 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %0, %c_37_i64 : i64
    %2 = llvm.urem %c_34_i64, %arg0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %c_12_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg0, %arg0 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %c_23_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %c23_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.urem %c_30_i64, %c45_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.udiv %c47_i64, %arg0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %c27_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.urem %c_22_i64, %c_44_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.or %c_10_i64, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.select %arg0, %arg1, %c1_i64 : i1, i64
    %1 = llvm.icmp "ult" %c46_i64, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.xor %c24_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.lshr %1, %c_21_i64 : i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %c_29_i64 : i64
    %2 = llvm.icmp "eq" %c_1_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c_43_i64 : i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.urem %c_30_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.xor %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.select %arg1, %c46_i64, %c_28_i64 : i1, i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.urem %c_35_i64, %c_19_i64 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %c_39_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %c_25_i64, %0 : i64
    %2 = llvm.icmp "sle" %c_19_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.udiv %arg2, %c_29_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "uge" %2, %c11_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.and %c19_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.select %arg1, %c36_i64, %1 : i1, i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg1, %arg2 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.srem %c17_i64, %1 : i64
    %3 = llvm.sdiv %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.srem %arg0, %c40_i64 : i64
    %1 = llvm.and %c_25_i64, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.xor %arg0, %c36_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %true = arith.constant true
    %c6_i64 = arith.constant 6 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.lshr %c6_i64, %c_49_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.select %true, %0, %1 : i1, i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.urem %arg0, %c_31_i64 : i64
    %1 = llvm.icmp "sle" %arg0, %c_38_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ne" %arg0, %c_11_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %arg1, %1, %arg2 : i1, i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.or %0, %c21_i64 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.icmp "sle" %c17_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "ule" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %arg2, %c42_i64 : i64
    %1 = llvm.icmp "ult" %arg1, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %c_32_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.lshr %c_2_i64, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %c19_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    %3 = llvm.and %2, %c_17_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "sgt" %c_35_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg0, %arg0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.or %c_33_i64, %0 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.sdiv %1, %c16_i64 : i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %c15_i64, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %0, %2, %arg1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.sdiv %c_13_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.srem %c_15_i64, %arg0 : i64
    %1 = llvm.sdiv %c32_i64, %arg1 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "sgt" %c_23_i64, %c_41_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.select %arg1, %c_27_i64, %0 : i1, i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %c49_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c_24_i64, %0 : i64
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    %3 = llvm.icmp "slt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c_27_i64 : i64
    %2 = llvm.xor %1, %c_30_i64 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ne" %c_6_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.urem %c3_i64, %arg1 : i64
    %1 = llvm.icmp "sgt" %c48_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.sdiv %c0_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %0, %c28_i64 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c28_i64 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.icmp "ugt" %2, %c_45_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %c_30_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.ashr %arg1, %c_8_i64 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sge" %c_31_i64, %c6_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.lshr %1, %c_23_i64 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "sge" %arg0, %c_36_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.select %false, %0, %arg1 : i1, i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.select %arg0, %1, %arg1 : i1, i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %true, %0, %arg0 : i1, i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.lshr %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c16_i64 : i64
    %2 = llvm.ashr %c_32_i64, %1 : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c28_i64 = arith.constant 28 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %c_47_i64, %0 : i64
    %2 = llvm.and %c28_i64, %c7_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %c42_i64, %arg0 : i64
    %1 = llvm.xor %c_45_i64, %0 : i64
    %2 = llvm.or %0, %arg0 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.ashr %c35_i64, %arg0 : i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    %3 = llvm.icmp "ne" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.select %false, %c35_i64, %0 : i1, i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.icmp "ugt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.or %arg0, %c_25_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.xor %0, %c15_i64 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.srem %c5_i64, %arg0 : i64
    %1 = llvm.ashr %c_31_i64, %arg0 : i64
    %2 = llvm.urem %1, %c22_i64 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.and %c_16_i64, %c_4_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.and %c_48_i64, %1 : i64
    %3 = llvm.and %2, %c39_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.ashr %c21_i64, %0 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c12_i64 = arith.constant 12 : i64
    %c15_i64 = arith.constant 15 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.select %arg0, %c_47_i64, %arg1 : i1, i64
    %1 = llvm.urem %c12_i64, %c27_i64 : i64
    %2 = llvm.urem %c15_i64, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.urem %c_11_i64, %c37_i64 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ule" %c26_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %c21_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.sdiv %0, %c_15_i64 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.urem %c_1_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.or %c47_i64, %0 : i64
    %2 = llvm.select %arg1, %c_49_i64, %c_38_i64 : i1, i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sdiv %arg0, %c28_i64 : i64
    %1 = llvm.lshr %c38_i64, %0 : i64
    %2 = llvm.icmp "sle" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %arg0 : i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.lshr %arg0, %c50_i64 : i64
    %1 = llvm.srem %c_34_i64, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "sgt" %c17_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.icmp "ule" %2, %c37_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.lshr %c47_i64, %c35_i64 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.icmp "sge" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.urem %c46_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %c_27_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.ashr %c41_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.icmp "eq" %c_38_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.sdiv %arg0, %c_19_i64 : i64
    %1 = llvm.ashr %c25_i64, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.sdiv %arg0, %c_3_i64 : i64
    %1 = llvm.icmp "eq" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.urem %arg0, %c_42_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.icmp "sge" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.ashr %arg0, %c7_i64 : i64
    %1 = llvm.xor %arg1, %c14_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.or %arg0, %arg1 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c42_i64 = arith.constant 42 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c15_i64, %0 : i64
    %2 = llvm.xor %c42_i64, %c1_i64 : i64
    %3 = llvm.select %1, %c_50_i64, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "sgt" %arg0, %c0_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.or %c23_i64, %1 : i64
    %3 = llvm.icmp "eq" %2, %c50_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.select %arg0, %c4_i64, %arg1 : i1, i64
    %1 = llvm.icmp "ne" %arg1, %c0_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "slt" %c_31_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c_14_i64, %1 : i64
    %3 = llvm.icmp "slt" %2, %c_3_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sdiv %c_10_i64, %c44_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.sdiv %arg0, %c_24_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.or %c_12_i64, %arg2 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.xor %arg2, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.xor %arg0, %c6_i64 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %c_29_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg1, %c31_i64 : i64
    %2 = llvm.select %1, %arg1, %arg0 : i1, i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %true = arith.constant true
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.select %true, %c_45_i64, %arg0 : i1, i64
    %1 = llvm.or %0, %c49_i64 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.or %arg0, %c48_i64 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c35_i64 = arith.constant 35 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.srem %c_4_i64, %arg0 : i64
    %1 = llvm.urem %0, %c35_i64 : i64
    %2 = llvm.udiv %1, %c5_i64 : i64
    %3 = llvm.urem %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %c_5_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.and %c18_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %false = arith.constant false
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.select %false, %arg0, %c_32_i64 : i1, i64
    %1 = llvm.sdiv %c21_i64, %arg0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.xor %0, %c1_i64 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %c32_i64 = arith.constant 32 : i64
    %c_15_i64 = arith.constant -15 : i64
    %true = arith.constant true
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.select %true, %c39_i64, %arg0 : i1, i64
    %1 = llvm.udiv %c_15_i64, %c32_i64 : i64
    %2 = llvm.srem %1, %c_38_i64 : i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %c_27_i64, %arg0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c_29_i64, %0 : i64
    %2 = llvm.urem %arg0, %0 : i64
    %3 = llvm.select %1, %arg0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.sdiv %c34_i64, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.srem %c_20_i64, %0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %c39_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.lshr %arg0, %c_46_i64 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.ashr %c_27_i64, %c_42_i64 : i64
    %2 = llvm.lshr %1, %c23_i64 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.urem %c_29_i64, %1 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.xor %arg2, %c37_i64 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.urem %c_12_i64, %c_12_i64 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.select %arg0, %1, %arg1 : i1, i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.lshr %0, %c2_i64 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.select %arg0, %c_19_i64, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %c_5_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.udiv %arg0, %c_47_i64 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.select %false, %1, %arg0 : i1, i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.udiv %c_33_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %c35_i64 = arith.constant 35 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.lshr %c35_i64, %c_8_i64 : i64
    %1 = llvm.ashr %arg0, %c_34_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "ugt" %c_22_i64, %c_7_i64 : i64
    %1 = llvm.ashr %c14_i64, %arg1 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.select %0, %c_43_i64, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %c21_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.urem %arg0, %arg1 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.udiv %c17_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.or %2, %c_42_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "sgt" %c37_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "slt" %c27_i64, %c_34_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.udiv %c_38_i64, %c39_i64 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "slt" %c23_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.urem %arg0, %c40_i64 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.lshr %c36_i64, %c45_i64 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "ugt" %c_21_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %c_49_i64, %1 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "ugt" %c17_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %c20_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.xor %c_16_i64, %1 : i64
    %3 = llvm.icmp "slt" %c7_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c44_i64, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c_14_i64 : i64
    %2 = llvm.udiv %c3_i64, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.lshr %c29_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %false = arith.constant false
    %c_28_i64 = arith.constant -28 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.select %arg0, %c_28_i64, %c_12_i64 : i1, i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %c_11_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.select %2, %1, %arg1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.ashr %c_11_i64, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %false = arith.constant false
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.select %false, %arg0, %c30_i64 : i1, i64
    %1 = llvm.urem %c_42_i64, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %c12_i64, %0 : i64
    %2 = llvm.xor %arg1, %0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c3_i64 = arith.constant 3 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.udiv %c3_i64, %c_45_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.ashr %c2_i64, %arg0 : i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "sge" %c18_i64, %c31_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.and %c39_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.or %arg1, %c24_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.select %arg0, %c0_i64, %arg1 : i1, i64
    %1 = llvm.and %arg2, %c_45_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %2, %c19_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.lshr %c41_i64, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ule" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "ugt" %arg0, %c4_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.and %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c31_i64 = arith.constant 31 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.ashr %c31_i64, %c20_i64 : i64
    %1 = llvm.ashr %arg0, %c15_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg2, %c34_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %1, %c19_i64 : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.srem %c_50_i64, %1 : i64
    %3 = llvm.sdiv %2, %c28_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "slt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.or %c_30_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.urem %c18_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.urem %arg1, %c16_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    %3 = llvm.select %2, %c_45_i64, %arg0 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.sdiv %arg0, %c_33_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "sle" %c_20_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c30_i64 = arith.constant 30 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.or %arg0, %c_14_i64 : i64
    %1 = llvm.icmp "slt" %c30_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %2, %c9_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_20_i64 = arith.constant -20 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.ashr %arg0, %c23_i64 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.xor %arg2, %c_20_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.xor %arg0, %c_36_i64 : i64
    %1 = llvm.icmp "ne" %c_36_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "sge" %c29_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.sdiv %arg1, %arg2 : i64
    %3 = llvm.select %1, %arg1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.or %c_49_i64, %arg0 : i64
    %1 = llvm.urem %c7_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %c47_i64, %arg0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %c4_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.lshr %c_43_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.select %true, %c0_i64, %arg0 : i1, i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c50_i64 = arith.constant 50 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %c50_i64, %c45_i64 : i64
    %2 = llvm.and %c21_i64, %1 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %0, %c_35_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "ult" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %c2_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sge" %c_33_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.udiv %c12_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.urem %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.srem %arg2, %arg1 : i64
    %3 = llvm.select %1, %arg1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.ashr %c_19_i64, %c16_i64 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.srem %c38_i64, %c0_i64 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.srem %arg0, %c47_i64 : i64
    %1 = llvm.and %c_25_i64, %arg1 : i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.udiv %c22_i64, %arg0 : i64
    %1 = llvm.udiv %c_26_i64, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.udiv %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.lshr %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.sdiv %c26_i64, %arg0 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.srem %1, %c_42_i64 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.or %c45_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.srem %c_47_i64, %c43_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "sge" %c26_i64, %1 : i64
    %3 = llvm.select %2, %arg0, %arg1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.xor %c_46_i64, %c_41_i64 : i64
    %1 = llvm.srem %c_38_i64, %0 : i64
    %2 = llvm.or %arg0, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c_34_i64 = arith.constant -34 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %c_34_i64, %0 : i64
    %2 = llvm.and %c22_i64, %arg0 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.udiv %arg1, %c_24_i64 : i64
    %2 = llvm.sdiv %arg2, %c_3_i64 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.xor %c_14_i64, %arg0 : i64
    %1 = llvm.and %0, %c_5_i64 : i64
    %2 = llvm.sdiv %arg1, %c_20_i64 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %arg0, %c_31_i64 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "slt" %arg0, %c34_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.sdiv %c23_i64, %0 : i64
    %3 = llvm.select %1, %2, %arg0 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.srem %c_6_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %arg1, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.select %arg0, %c_41_i64, %arg1 : i1, i64
    %1 = llvm.or %c_4_i64, %arg2 : i64
    %2 = llvm.select %arg0, %1, %arg1 : i1, i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.srem %c42_i64, %arg2 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.lshr %arg0, %c44_i64 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.urem %arg2, %c12_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.select %arg1, %c15_i64, %1 : i1, i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %c_25_i64, %0 : i64
    %2 = llvm.or %arg1, %0 : i64
    %3 = llvm.select %1, %2, %arg2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.ashr %c4_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.select %arg0, %arg1, %c46_i64 : i1, i64
    %1 = llvm.icmp "ult" %arg1, %arg1 : i64
    %2 = llvm.select %1, %0, %arg1 : i1, i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %false = arith.constant false
    %c23_i64 = arith.constant 23 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.lshr %c_4_i64, %arg0 : i64
    %1 = llvm.urem %c23_i64, %0 : i64
    %2 = llvm.select %false, %c4_i64, %0 : i1, i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.xor %arg0, %c23_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.or %c2_i64, %1 : i64
    %3 = llvm.icmp "sle" %c23_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %c_39_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.or %arg1, %c0_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c47_i64 = arith.constant 47 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.or %c_38_i64, %arg0 : i64
    %1 = llvm.urem %c_27_i64, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "uge" %c47_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.lshr %c35_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.select %1, %0, %c47_i64 : i1, i64
    %3 = llvm.icmp "slt" %c_28_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %c_18_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %2, %c29_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.ashr %c_2_i64, %0 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.lshr %c7_i64, %1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "uge" %c29_i64, %arg0 : i64
    %1 = llvm.xor %c37_i64, %arg0 : i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.icmp "ule" %c_47_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c43_i64 = arith.constant 43 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.select %arg0, %c_4_i64, %c_39_i64 : i1, i64
    %1 = llvm.icmp "ne" %c43_i64, %0 : i64
    %2 = llvm.select %1, %c1_i64, %arg1 : i1, i64
    %3 = llvm.icmp "sgt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.srem %c29_i64, %c15_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %arg1, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.srem %1, %c42_i64 : i64
    %3 = llvm.icmp "eq" %2, %c5_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "sgt" %c_26_i64, %c40_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.udiv %c24_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %c_32_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c8_i64 = arith.constant 8 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.lshr %c3_i64, %arg1 : i64
    %1 = llvm.select %arg0, %c8_i64, %0 : i1, i64
    %2 = llvm.urem %arg1, %c_31_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.and %c49_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %c_1_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.select %true, %arg1, %0 : i1, i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.or %arg0, %c9_i64 : i64
    %1 = llvm.icmp "ult" %arg1, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "eq" %arg0, %c50_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.urem %arg0, %c_10_i64 : i64
    %1 = llvm.xor %arg2, %c_4_i64 : i64
    %2 = llvm.select %arg1, %1, %arg2 : i1, i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.srem %c_21_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.lshr %c_43_i64, %1 : i64
    %3 = llvm.ashr %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.srem %arg0, %c_15_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.sdiv %c5_i64, %0 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %0, %c31_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.udiv %c_17_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %c2_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.lshr %c_8_i64, %1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.sdiv %c50_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.udiv %c38_i64, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %c_31_i64 = arith.constant -31 : i64
    %true = arith.constant true
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "ult" %c19_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.select %true, %c_31_i64, %c_38_i64 : i1, i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.and %c_12_i64, %c_46_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %c_3_i64, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg1, %arg0 : i1, i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "slt" %c1_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.udiv %c_12_i64, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.xor %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %c_16_i64, %1 : i64
    %3 = llvm.icmp "slt" %c_15_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.udiv %c_34_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.srem %1, %c_34_i64 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %arg0, %c20_i64 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %c17_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.and %c34_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %c13_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.and %arg0, %c34_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "ult" %c43_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c41_i64 = arith.constant 41 : i64
    %c27_i64 = arith.constant 27 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.sdiv %c27_i64, %c_26_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.or %c41_i64, %1 : i64
    %3 = llvm.icmp "eq" %c44_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.urem %arg0, %c_7_i64 : i64
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.ashr %2, %c_14_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c32_i64 = arith.constant 32 : i64
    %c29_i64 = arith.constant 29 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.sdiv %c29_i64, %c_44_i64 : i64
    %1 = llvm.xor %c32_i64, %0 : i64
    %2 = llvm.urem %c6_i64, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %arg1 : i64
    %2 = llvm.ashr %arg2, %c49_i64 : i64
    %3 = llvm.select %1, %arg0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "ult" %c36_i64, %c_39_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.sdiv %c_31_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "ule" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c19_i64 = arith.constant 19 : i64
    %c31_i64 = arith.constant 31 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c19_i64 : i64
    %2 = llvm.select %false, %1, %c26_i64 : i1, i64
    %3 = llvm.icmp "ugt" %c31_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.select %arg0, %arg1, %c16_i64 : i1, i64
    %1 = llvm.icmp "ult" %arg1, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %c45_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.sdiv %c_27_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.and %c_26_i64, %1 : i64
    %3 = llvm.icmp "ult" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.select %arg0, %0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %c23_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %0, %c11_i64 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.srem %c_7_i64, %arg0 : i64
    %1 = llvm.udiv %c_35_i64, %0 : i64
    %2 = llvm.icmp "ne" %1, %c22_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg2, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.or %c_21_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.or %c_28_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.sdiv %c35_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %c37_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.ashr %arg2, %arg2 : i64
    %1 = llvm.icmp "ne" %arg1, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.udiv %c_44_i64, %1 : i64
    %3 = llvm.icmp "uge" %2, %c_7_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.xor %arg0, %c25_i64 : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %c_23_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %c_36_i64, %c48_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "eq" %c17_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.select %false, %c_40_i64, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %c_27_i64, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.select %arg1, %arg2, %c16_i64 : i1, i64
    %1 = llvm.icmp "sgt" %0, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %false = arith.constant false
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.select %false, %c_17_i64, %arg0 : i1, i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %c45_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c_39_i64 = arith.constant -39 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.xor %c20_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.srem %c_39_i64, %c16_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.srem %arg1, %c_3_i64 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.or %c16_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.ashr %0, %c32_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c29_i64 = arith.constant 29 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.or %c36_i64, %arg0 : i64
    %1 = llvm.srem %0, %c38_i64 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.or %c29_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "slt" %arg0, %c0_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %c45_i64 : i64
    %3 = llvm.and %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.and %1, %c25_i64 : i64
    %3 = llvm.udiv %2, %c_7_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.select %arg1, %arg0, %c39_i64 : i1, i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c19_i64 = arith.constant 19 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.udiv %c19_i64, %c37_i64 : i64
    %1 = llvm.udiv %arg0, %c_5_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sgt" %c_43_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %c48_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %c12_i64 = arith.constant 12 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.select %arg0, %arg1, %c_37_i64 : i1, i64
    %1 = llvm.urem %0, %c12_i64 : i64
    %2 = llvm.ashr %1, %c_12_i64 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %arg2, %c_37_i64 : i1, i64
    %2 = llvm.select %0, %1, %c5_i64 : i1, i64
    %3 = llvm.icmp "sge" %c5_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.or %arg0, %c6_i64 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.srem %arg0, %arg2 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "sge" %arg0, %c14_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.ashr %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.lshr %arg0, %c40_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.ashr %c27_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg1, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.lshr %c_25_i64, %c24_i64 : i64
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.xor %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.sdiv %arg2, %c7_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.lshr %0, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %arg1, %c_29_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.lshr %1, %c12_i64 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.lshr %c_21_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c13_i64 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %c_17_i64 = arith.constant -17 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %c40_i64, %arg0 : i64
    %1 = llvm.srem %c_17_i64, %0 : i64
    %2 = llvm.or %c_18_i64, %arg1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.sdiv %c_20_i64, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.srem %c_16_i64, %c_44_i64 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.ashr %arg1, %arg1 : i64
    %3 = llvm.select %1, %arg1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %c34_i64 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.and %arg0, %c47_i64 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %2, %arg2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %true = arith.constant true
    %c35_i64 = arith.constant 35 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.select %arg1, %c2_i64, %arg0 : i1, i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %true, %c35_i64, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %c36_i64, %0 : i64
    %2 = llvm.lshr %c_44_i64, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.xor %0, %c25_i64 : i64
    %2 = llvm.and %arg1, %arg2 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %c25_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %c11_i64 = arith.constant 11 : i64
    %c44_i64 = arith.constant 44 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.xor %c44_i64, %c1_i64 : i64
    %1 = llvm.icmp "sgt" %c11_i64, %0 : i64
    %2 = llvm.select %arg0, %c_9_i64, %0 : i1, i64
    %3 = llvm.select %1, %2, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %0, %c_17_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %c38_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.sdiv %1, %c_10_i64 : i64
    %3 = llvm.icmp "uge" %c36_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c_20_i64 = arith.constant -20 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.udiv %arg0, %c8_i64 : i64
    %1 = llvm.xor %c_20_i64, %0 : i64
    %2 = llvm.select %arg1, %arg2, %c_41_i64 : i1, i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.xor %c_49_i64, %c_19_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sdiv %c2_i64, %arg0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "eq" %arg0, %c_41_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.srem %c_34_i64, %arg0 : i64
    %1 = llvm.ashr %c_26_i64, %0 : i64
    %2 = llvm.udiv %1, %c32_i64 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.urem %c_8_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c45_i64 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.xor %arg0, %c30_i64 : i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %c_11_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.and %2, %arg2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.icmp "slt" %c_10_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %c_7_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %0, %2, %arg1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %arg2, %arg0 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sle" %c6_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %false, %arg1, %1 : i1, i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "ult" %c_6_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %arg0, %c37_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.or %c43_i64, %arg0 : i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_4_i64 = arith.constant -4 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.and %c_4_i64, %c_27_i64 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c5_i64 = arith.constant 5 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.select %false, %c5_i64, %c_30_i64 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c_40_i64, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.lshr %2, %c34_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.srem %c27_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c_31_i64 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "sge" %c_45_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %arg0, %c_20_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.sdiv %arg0, %c35_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c_34_i64 = arith.constant -34 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.ashr %c_10_i64, %c_31_i64 : i64
    %1 = llvm.or %0, %c21_i64 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.xor %c_34_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.select %arg1, %c_42_i64, %arg0 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.and %c_4_i64, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c38_i64 = arith.constant 38 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.ashr %c38_i64, %c_8_i64 : i64
    %1 = llvm.ashr %0, %c_10_i64 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.lshr %arg1, %c47_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c_13_i64 = arith.constant -13 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.select %arg0, %arg1, %c29_i64 : i1, i64
    %1 = llvm.select %arg2, %arg1, %c_13_i64 : i1, i64
    %2 = llvm.sdiv %1, %c43_i64 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.udiv %c48_i64, %c_39_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.sdiv %c34_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "slt" %arg0, %c_42_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %arg0, %arg1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %0, %c40_i64 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "ult" %2, %c_43_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %false, %1, %1 : i1, i64
    %3 = llvm.select %true, %1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "ult" %c_13_i64, %c19_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "sle" %c34_i64, %c_23_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg0, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c37_i64 = arith.constant 37 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "sle" %arg0, %c49_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c37_i64, %c39_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c11_i64 = arith.constant 11 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.or %c_5_i64, %arg0 : i64
    %1 = llvm.lshr %c11_i64, %0 : i64
    %2 = llvm.sdiv %c_30_i64, %1 : i64
    %3 = llvm.icmp "ugt" %2, %c_49_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %c_13_i64 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.and %2, %c1_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "slt" %c17_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %c31_i64, %arg0 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.select %arg0, %1, %1 : i1, i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c38_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.and %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c1_i64 = arith.constant 1 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.sdiv %c1_i64, %c_8_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "sle" %c49_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %true = arith.constant true
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.and %c20_i64, %arg0 : i64
    %1 = llvm.select %true, %0, %c_25_i64 : i1, i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "sgt" %arg0, %c_27_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "uge" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "ult" %c40_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %c12_i64 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %arg0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg1, %arg1 : i1, i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %arg2, %c45_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.udiv %c_40_i64, %c7_i64 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.lshr %c15_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "sgt" %c37_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c4_i64, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.urem %arg0, %c_7_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.urem %arg0, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.urem %c41_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.or %1, %c_36_i64 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.xor %arg0, %c2_i64 : i64
    %1 = llvm.or %0, %c_10_i64 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.select %arg0, %c_42_i64, %1 : i1, i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %c_15_i64, %arg1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %arg2, %c_11_i64 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.select %arg0, %c_1_i64, %1 : i1, i64
    %3 = llvm.icmp "sle" %2, %c_19_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %arg1, %arg1 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.or %arg0, %c40_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %c36_i64, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sdiv %c_8_i64, %arg0 : i64
    %2 = llvm.select %true, %0, %1 : i1, i64
    %3 = llvm.icmp "ult" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "sgt" %arg0, %c28_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.urem %arg0, %c10_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %c_22_i64, %0 : i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "eq" %arg0, %c_37_i64 : i64
    %1 = llvm.select %arg1, %arg0, %c47_i64 : i1, i64
    %2 = llvm.ashr %arg2, %1 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c_3_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c2_i64 = arith.constant 2 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %c17_i64, %0 : i64
    %2 = llvm.udiv %c2_i64, %1 : i64
    %3 = llvm.icmp "sgt" %2, %c1_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "eq" %arg1, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.and %c6_i64, %0 : i64
    %2 = llvm.icmp "ugt" %c_22_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.udiv %c_11_i64, %c_38_i64 : i64
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %2 = llvm.ashr %1, %c_32_i64 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %c_25_i64, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %c_17_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "sge" %arg1, %c17_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "ult" %arg1, %c_23_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.xor %c43_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %arg1, %c3_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ult" %c_6_i64, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %arg0, %1, %arg2 : i1, i64
    %3 = llvm.sdiv %2, %c_7_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.srem %1, %c_5_i64 : i64
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.sdiv %c35_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.urem %c14_i64, %arg1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.srem %arg0, %c_49_i64 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sle" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.or %arg2, %c_45_i64 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.xor %arg0, %c_1_i64 : i64
    %1 = llvm.urem %c_32_i64, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.srem %arg0, %c43_i64 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "slt" %c_4_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.udiv %c_25_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "uge" %c9_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.udiv %c33_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.urem %c9_i64, %c_8_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.and %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %arg1, %arg2 : i1, i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.and %c_15_i64, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.xor %c31_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %c_15_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c14_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "ne" %c11_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.lshr %arg0, %c_35_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.xor %2, %c_32_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.icmp "slt" %c34_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.urem %c_21_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.lshr %c_40_i64, %c3_i64 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.urem %c7_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "sle" %c_23_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %c36_i64 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    %3 = llvm.icmp "sgt" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.select %1, %arg1, %c_9_i64 : i1, i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c33_i64, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %c_36_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.srem %c_20_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c11_i64 : i64
    %2 = llvm.srem %c_48_i64, %1 : i64
    %3 = llvm.icmp "eq" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "uge" %arg0, %c36_i64 : i64
    %1 = llvm.lshr %arg0, %arg2 : i64
    %2 = llvm.udiv %1, %c_5_i64 : i64
    %3 = llvm.select %0, %arg1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.urem %c_26_i64, %arg0 : i64
    %1 = llvm.ashr %c48_i64, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %c7_i64 = arith.constant 7 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.urem %c7_i64, %1 : i64
    %3 = llvm.icmp "ugt" %c_16_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg1, %c31_i64 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c1_i64 = arith.constant 1 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %arg0, %c14_i64 : i64
    %1 = llvm.and %c1_i64, %0 : i64
    %2 = llvm.udiv %1, %c17_i64 : i64
    %3 = llvm.icmp "ult" %c_6_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %c11_i64, %0 : i64
    %2 = llvm.urem %arg1, %arg2 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.xor %c2_i64, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.xor %c_27_i64, %1 : i64
    %3 = llvm.icmp "slt" %2, %c0_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %c_40_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.lshr %0, %arg0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %c_35_i64, %c19_i64 : i64
    %2 = llvm.select %arg1, %arg2, %1 : i1, i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.sdiv %c49_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %c49_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.ashr %c23_i64, %arg1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c25_i64 = arith.constant 25 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.srem %c_2_i64, %arg0 : i64
    %1 = llvm.lshr %c_21_i64, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.urem %c25_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "uge" %c30_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %arg1, %arg0 : i1, i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c41_i64 = arith.constant 41 : i64
    %c1_i64 = arith.constant 1 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.xor %c1_i64, %c_33_i64 : i64
    %1 = llvm.srem %c41_i64, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.xor %2, %c_8_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.and %arg0, %c_30_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c38_i64 = arith.constant 38 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "ult" %c42_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %c38_i64 : i64
    %2 = llvm.select %arg1, %arg2, %c3_i64 : i1, i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %c_27_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.or %c17_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %c17_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sle" %c_23_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c5_i64, %1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.srem %c5_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %c41_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %c33_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %c_26_i64, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %c28_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.lshr %c_21_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.srem %c_50_i64, %arg0 : i64
    %1 = llvm.or %c_28_i64, %0 : i64
    %2 = llvm.sdiv %c_37_i64, %1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %c46_i64 = arith.constant 46 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sdiv %c_6_i64, %arg0 : i64
    %2 = llvm.select %0, %c46_i64, %1 : i1, i64
    %3 = llvm.icmp "uge" %c_46_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c_48_i64, %arg0 : i1, i64
    %2 = llvm.lshr %1, %c33_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.ashr %c_15_i64, %0 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.urem %c19_i64, %c23_i64 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.or %c5_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.xor %c_19_i64, %c_42_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.srem %c_48_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.urem %c_18_i64, %arg2 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "sle" %arg0, %c_37_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %c49_i64, %1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c33_i64 = arith.constant 33 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "ne" %c33_i64, %c35_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.select %false, %arg2, %arg2 : i1, i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.urem %arg0, %c_2_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.and %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.or %c18_i64, %1 : i64
    %3 = llvm.icmp "ugt" %2, %c20_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %c_35_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %c12_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c32_i64 = arith.constant 32 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.ashr %c32_i64, %c_30_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.lshr %c15_i64, %c46_i64 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %c_26_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.ashr %arg0, %c46_i64 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.xor %1, %c_43_i64 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.or %c47_i64, %0 : i64
    %2 = llvm.udiv %arg1, %c_37_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.select %arg2, %c_31_i64, %c_28_i64 : i1, i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.srem %1, %c_23_i64 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "uge" %c40_i64, %arg0 : i64
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.ashr %1, %c_31_i64 : i64
    %3 = llvm.select %0, %2, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.srem %c1_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.srem %c_1_i64, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %true = arith.constant true
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.select %true, %0, %c27_i64 : i1, i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.sdiv %arg0, %c_11_i64 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.or %0, %c_28_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.or %arg0, %c30_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %c4_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.icmp "sgt" %c45_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c15_i64 : i64
    %2 = llvm.lshr %c_27_i64, %1 : i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %c27_i64, %0 : i64
    %2 = llvm.lshr %arg0, %arg0 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c21_i64 = arith.constant 21 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.udiv %c21_i64, %c9_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "uge" %c_41_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %c_5_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %c16_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.or %1, %c_43_i64 : i64
    %3 = llvm.lshr %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.icmp "sgt" %0, %arg2 : i64
    %2 = llvm.select %1, %c50_i64, %arg1 : i1, i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.and %c11_i64, %c_38_i64 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.lshr %c_45_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "sgt" %c_35_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %c11_i64, %1 : i64
    %3 = llvm.select %2, %arg1, %1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.icmp "ule" %arg1, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c32_i64, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "uge" %c_7_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %c19_i64, %0 : i64
    %2 = llvm.select %1, %0, %arg1 : i1, i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %c_33_i64, %c_13_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg1, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.and %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "ult" %c_26_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %c2_i64 : i64
    %3 = llvm.xor %2, %c2_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c16_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "sle" %c_9_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c16_i64 = arith.constant 16 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.lshr %c_6_i64, %arg0 : i64
    %1 = llvm.sdiv %c16_i64, %0 : i64
    %2 = llvm.ashr %c_19_i64, %1 : i64
    %3 = llvm.icmp "uge" %c49_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.or %arg0, %c_1_i64 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "sge" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %0, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "uge" %c39_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c_35_i64 = arith.constant -35 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "slt" %arg0, %c49_i64 : i64
    %1 = llvm.ashr %c_35_i64, %arg1 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "eq" %c47_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c4_i64, %arg0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %c40_i64, %0 : i64
    %2 = llvm.lshr %arg0, %c21_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.xor %arg0, %c32_i64 : i64
    %1 = llvm.icmp "eq" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c13_i64 = arith.constant 13 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.xor %c_38_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c13_i64 : i64
    %2 = llvm.sdiv %1, %c34_i64 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "ult" %c34_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "ule" %2, %c_34_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.xor %c_7_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c_48_i64, %1 : i64
    %3 = llvm.select %0, %2, %arg2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.srem %c_39_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %false = arith.constant false
    %c35_i64 = arith.constant 35 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.select %false, %c35_i64, %c_26_i64 : i1, i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.urem %c_47_i64, %1 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "ugt" %arg0, %c_28_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %c_7_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c15_i64 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.srem %c24_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c25_i64 = arith.constant 25 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.and %c46_i64, %arg0 : i64
    %1 = llvm.and %arg0, %c25_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.udiv %2, %c47_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.urem %c_15_i64, %c22_i64 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %2, %c4_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.or %arg0, %c_16_i64 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    %3 = llvm.lshr %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.udiv %arg0, %c_38_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %arg0, %c47_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "ne" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.urem %arg0, %c_1_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.sdiv %arg1, %0 : i64
    %3 = llvm.udiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ugt" %c19_i64, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.ashr %c_16_i64, %c_15_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %c34_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %c13_i64, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.ashr %c_5_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %c1_i64 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.srem %arg1, %0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "sge" %arg0, %c_23_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %c50_i64, %1 : i64
    %3 = llvm.lshr %2, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.icmp "ne" %2, %c_28_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c9_i64 = arith.constant 9 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.xor %c9_i64, %0 : i64
    %2 = llvm.udiv %c_8_i64, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.icmp "uge" %c16_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %c19_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.udiv %c_10_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %c37_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %arg1, %c25_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %c0_i64, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %c42_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "ult" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "sge" %c_25_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c_20_i64 = arith.constant -20 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.srem %c42_i64, %arg0 : i64
    %1 = llvm.select %true, %c_20_i64, %0 : i1, i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "ult" %arg1, %c36_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.icmp "ult" %arg1, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %false = arith.constant false
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.lshr %c38_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %false, %2, %c_35_i64 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.urem %c_30_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.udiv %arg1, %c_37_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c_34_i64 = arith.constant -34 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.or %c_45_i64, %arg0 : i64
    %1 = llvm.ashr %c_34_i64, %c43_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "sge" %c_35_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.sdiv %c25_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c_21_i64 : i64
    %2 = llvm.xor %arg0, %c_33_i64 : i64
    %3 = llvm.select %1, %2, %arg0 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %true = arith.constant true
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %c28_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.ashr %c_7_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "ne" %2, %c_49_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.and %c_28_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.udiv %2, %c15_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "ugt" %arg1, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %c45_i64, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %1, %c_1_i64 : i64
    %3 = llvm.icmp "ult" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %c_43_i64 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_20_i64 = arith.constant -20 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.xor %c_20_i64, %c30_i64 : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.select %arg1, %c12_i64, %1 : i1, i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c43_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %c_7_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %c_21_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.ashr %arg0, %arg1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.select %false, %c36_i64, %arg2 : i1, i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "slt" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "uge" %arg1, %arg2 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.srem %c_30_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %c4_i64, %0 : i64
    %2 = llvm.udiv %c_10_i64, %1 : i64
    %3 = llvm.sdiv %c_29_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.sdiv %c_32_i64, %arg0 : i64
    %1 = llvm.select %true, %arg1, %arg0 : i1, i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %c25_i64 = arith.constant 25 : i64
    %c13_i64 = arith.constant 13 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.select %arg0, %c13_i64, %c_49_i64 : i1, i64
    %1 = llvm.and %c25_i64, %c_25_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %c2_i64 = arith.constant 2 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "sle" %c2_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %2, %c_22_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "sge" %arg1, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "uge" %2, %c19_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.urem %c_30_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.srem %arg0, %arg1 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.and %c_37_i64, %c_17_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "uge" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %true = arith.constant true
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.select %true, %c43_i64, %1 : i1, i64
    %3 = llvm.or %c_49_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.xor %c42_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c_9_i64 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ugt" %arg0, %c_49_i64 : i64
    %1 = llvm.srem %c_1_i64, %arg0 : i64
    %2 = llvm.and %arg1, %arg1 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c15_i64 = arith.constant 15 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.sdiv %c15_i64, %c9_i64 : i64
    %1 = llvm.icmp "uge" %0, %c31_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %c31_i64, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %c_7_i64 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %arg0, %c49_i64 : i64
    %1 = llvm.icmp "ne" %c_9_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %c20_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %c7_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.and %c_15_i64, %arg1 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "sgt" %c10_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %c44_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c23_i64 = arith.constant 23 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.and %c23_i64, %c_10_i64 : i64
    %1 = llvm.urem %c_44_i64, %0 : i64
    %2 = llvm.udiv %arg0, %c_42_i64 : i64
    %3 = llvm.and %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.xor %c_12_i64, %arg2 : i64
    %2 = llvm.and %arg2, %1 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %false = arith.constant false
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.select %false, %c_50_i64, %arg0 : i1, i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.xor %c_9_i64, %0 : i64
    %2 = llvm.sdiv %arg2, %arg1 : i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.select %arg1, %c23_i64, %arg0 : i1, i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.select %arg1, %arg2, %1 : i1, i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.urem %arg1, %c30_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ult" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.and %1, %c_39_i64 : i64
    %3 = llvm.icmp "slt" %2, %arg2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.udiv %c_33_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.select %true, %c_29_i64, %arg0 : i1, i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "slt" %arg0, %c_17_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.and %c_27_i64, %c5_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.xor %c_48_i64, %arg1 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.select %arg0, %1, %c13_i64 : i1, i64
    %3 = llvm.srem %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %arg1, %arg1 : i64
    %2 = llvm.and %c15_i64, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.select %arg0, %c_39_i64, %arg1 : i1, i64
    %1 = llvm.icmp "eq" %0, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %c_43_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %arg2, %arg2 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.select %arg0, %arg1, %c_44_i64 : i1, i64
    %1 = llvm.icmp "slt" %0, %c36_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %2, %arg2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.select %arg1, %arg2, %c_48_i64 : i1, i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "slt" %0, %c31_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "sle" %arg1, %c_45_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "slt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "eq" %c21_i64, %c3_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.udiv %c35_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %c_18_i64 : i64
    %2 = llvm.and %1, %c41_i64 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.ashr %c_4_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %c10_i64 = arith.constant 10 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.and %c_2_i64, %c30_i64 : i64
    %1 = llvm.srem %0, %c_1_i64 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.xor %c10_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.ashr %c_28_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.srem %arg1, %arg1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "ule" %c_20_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %c10_i64 = arith.constant 10 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.xor %arg0, %c43_i64 : i64
    %1 = llvm.xor %c10_i64, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "ule" %2, %c_5_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.lshr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.urem %c16_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c_22_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %c_4_i64, %arg1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "ule" %2, %c_20_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.xor %c_2_i64, %c34_i64 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.urem %arg1, %c_42_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.xor %c41_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.select %arg1, %arg2, %1 : i1, i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.and %0, %c_41_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ne" %c34_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.select %arg1, %arg0, %c_41_i64 : i1, i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %2, %c33_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.ashr %c_41_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c36_i64 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %c47_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg1 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %c17_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "sge" %c_2_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c_33_i64 : i1, i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "ule" %c_44_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "slt" %arg2, %c_24_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %arg2, %0 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.urem %arg0, %c_41_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.and %c17_i64, %1 : i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %c46_i64, %arg2 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.select %arg0, %c_7_i64, %arg1 : i1, i64
    %1 = llvm.udiv %c23_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.or %arg0, %c_13_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.or %arg1, %c_49_i64 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.sdiv %c_35_i64, %c37_i64 : i64
    %1 = llvm.ashr %arg1, %c_21_i64 : i64
    %2 = llvm.select %arg0, %1, %arg1 : i1, i64
    %3 = llvm.srem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %c_32_i64 = arith.constant -32 : i64
    %true = arith.constant true
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "ult" %c_16_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.sdiv %1, %c_32_i64 : i64
    %3 = llvm.select %true, %2, %c_26_i64 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "ugt" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "ne" %c0_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.urem %1, %c28_i64 : i64
    %3 = llvm.ashr %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.ashr %arg1, %c_16_i64 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.select %2, %c_28_i64, %arg2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.sdiv %arg1, %c_21_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "uge" %0, %c_2_i64 : i64
    %2 = llvm.select %1, %arg1, %arg1 : i1, i64
    %3 = llvm.ashr %c_35_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg1, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.ashr %c_31_i64, %arg0 : i64
    %1 = llvm.ashr %0, %c2_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.urem %c_24_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.lshr %0, %0 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %c_12_i64 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.xor %c41_i64, %c_13_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.urem %c_20_i64, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.ashr %c_8_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %c_5_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg1, %arg1 : i1, i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.xor %arg0, %c_18_i64 : i64
    %1 = llvm.urem %c40_i64, %arg1 : i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c_3_i64 = arith.constant -3 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.sdiv %c_3_i64, %c40_i64 : i64
    %1 = llvm.lshr %0, %c13_i64 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.select %false, %c_49_i64, %1 : i1, i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.srem %c10_i64, %c_1_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.sdiv %arg2, %arg1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "slt" %c_35_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "eq" %c_21_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c37_i64 = arith.constant 37 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.udiv %c6_i64, %arg0 : i64
    %1 = llvm.srem %c37_i64, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.icmp "uge" %2, %c15_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "eq" %arg0, %c_31_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.select %1, %0, %c49_i64 : i1, i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.select %false, %c36_i64, %arg1 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.or %2, %arg2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %false = arith.constant false
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %c_40_i64, %0 : i64
    %2 = llvm.select %false, %arg0, %c_22_i64 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "ult" %arg0, %c41_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "sgt" %c38_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "ult" %arg0, %c_35_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.lshr %c5_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.icmp "ne" %c_2_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ult" %c_13_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %c36_i64, %c_19_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c_18_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.udiv %c_5_i64, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c17_i64 = arith.constant 17 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "ule" %c17_i64, %c33_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %c_7_i64, %arg0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.lshr %c_43_i64, %arg0 : i64
    %1 = llvm.srem %c10_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "ugt" %c25_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %c_48_i64, %1 : i64
    %3 = llvm.icmp "sge" %2, %c_2_i64 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %arg0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.srem %arg0, %c_1_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.select %arg1, %0, %0 : i1, i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.and %2, %c30_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.ashr %c_18_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %c_25_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.srem %c_35_i64, %0 : i64
    %2 = llvm.sdiv %1, %c8_i64 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.ashr %c_14_i64, %c_10_i64 : i64
    %1 = llvm.icmp "ule" %c30_i64, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "eq" %c25_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.lshr %c_38_i64, %arg0 : i64
    %1 = llvm.srem %c39_i64, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "ne" %c_24_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %c31_i64, %1 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.urem %arg0, %c19_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c_12_i64 = arith.constant -12 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %c_45_i64, %c20_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.ashr %c_12_i64, %1 : i64
    %3 = llvm.srem %c19_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c11_i64 = arith.constant 11 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.urem %c11_i64, %c_23_i64 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.udiv %c1_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %c35_i64 = arith.constant 35 : i64
    %c32_i64 = arith.constant 32 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.lshr %c32_i64, %c2_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.ashr %c35_i64, %1 : i64
    %3 = llvm.urem %c_14_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c5_i64 = arith.constant 5 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.select %0, %c_15_i64, %c5_i64 : i1, i64
    %2 = llvm.select %0, %c14_i64, %arg2 : i1, i64
    %3 = llvm.ashr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c_20_i64 = arith.constant -20 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.urem %c_20_i64, %c_43_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.srem %c_33_i64, %arg1 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c_15_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %false = arith.constant false
    %c_40_i64 = arith.constant -40 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "ne" %c_40_i64, %c_16_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %false, %arg0, %c_33_i64 : i1, i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c15_i64 = arith.constant 15 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.sdiv %c_50_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %c15_i64, %0 : i64
    %2 = llvm.select %false, %arg1, %arg1 : i1, i64
    %3 = llvm.select %1, %arg0, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.or %c_11_i64, %arg1 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.lshr %c28_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.or %c_34_i64, %0 : i64
    %2 = llvm.sdiv %arg2, %c_45_i64 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.and %c_6_i64, %arg0 : i64
    %1 = llvm.sdiv %c34_i64, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "uge" %arg0, %c_34_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %c_33_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %c31_i64, %c_12_i64 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.sdiv %0, %arg0 : i64
    %3 = llvm.select %1, %2, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.sdiv %arg0, %c_39_i64 : i64
    %1 = llvm.udiv %arg1, %c40_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.and %2, %0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %0, %c31_i64 : i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c34_i64 = arith.constant 34 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "eq" %arg0, %c_43_i64 : i64
    %1 = llvm.select %0, %c1_i64, %arg0 : i1, i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.icmp "sle" %c34_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.or %c31_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.urem %2, %c3_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.urem %arg0, %c_10_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %c19_i64 = arith.constant 19 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.sdiv %c30_i64, %arg0 : i64
    %1 = llvm.ashr %0, %c19_i64 : i64
    %2 = llvm.ashr %c_13_i64, %0 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.or %c_26_i64, %arg1 : i64
    %1 = llvm.udiv %0, %c27_i64 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.select %arg1, %0, %1 : i1, i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %c18_i64 = arith.constant 18 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.udiv %c14_i64, %0 : i64
    %2 = llvm.sdiv %c18_i64, %c_31_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.and %c_50_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.srem %c_49_i64, %1 : i64
    %3 = llvm.and %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.or %arg0, %c_15_i64 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.and %c3_i64, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.srem %arg2, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    return %3 : i1
  }
}
// -----
